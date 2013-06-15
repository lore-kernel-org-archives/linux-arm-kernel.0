From: minghuadev@gmail.com (minghua d)
Date: Sat, 15 Jun 2013 13:12:10 -0700
Subject: alignment handler fault when irq enabled with CONFIG_PREEMPT
Message-ID: <CAH3QiXmFSVeSmuKvJRTWFAZkakKgoS3-Zb8+p_StcVgZVRHyFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, We are seeing a kernel oops caused by alignment handler.
It's a NXP LPC3250 based system with ARM 926 EJS processor.

Are there any known issues or fixed issues in either kernel or silicon
that could cause this? Any hint how to further debug this?

Below is a detailed account of the problem and tests.


Thanks.
-Minghua


To have the problem happen it needs three conditions:
[1] An udp app that opens 16 ports, keeps receiving and dropping packets.
[2] A shell that grep dmesg for "Oops" once every second in a loop.
[3] Large volume of packets sent to 16 udp ports through ethernet.

Once the setup is running, the shell sub-processes in the loop will
see random segment faults at a rate of 2 to 3 faults per minute.
Sometimes the rate is much higher or much lower. The fault happens
mostly in "__copy_from_user" and "file_read_actor", but also at:
    __copy_to_user_std
    __get_user_4
    __copy_from_user
    __strnlen_use

When it runs for about a few minutes upto an hour, eventually it crashes
due to an oops in alignment handler. I have been tracking this crash.
It appears to be consistent and reproducible with kernel 2.6.39 and 2.6.27.
Have not tried kernel 3.x due to build issues.

The specific chunk of code that triggers the oops is in "do_alignment()":
    fs = get_fs();
    set_fs(KERNEL_DS);
    fault = __get_user(instr, (u32 *)instrptr);
    set_fs(fs);

The oops will not happen if one of the three conditions is taken out;
or if disable irq around the above "__get_user()" and around subsequent
data featching code in alighment handler; or if !CONFIG_PREEMPT.

There is an interesting work-around by doing "__get_user()" again if there
is a fault at the first attempt. I interpret this as the paging tables are
correct but momentarily loaded incorrectly. The code goes like this:
    fs = get_fs();
    set_fs(KERNEL_DS);
    fault = __get_user(instr, (u32 *)instrptr);
+   if (fault) fault = __get_user(instr, (u32 *)instrptr);
    set_fs(fs);

The sequence of events in the test is like:
    A packet is received and processed by softirq.
    In ip/udp stack it does unaligned access causing alighment exception.
    Alignment handler fetches the instruction.
    The next packet is transferred by DMA from Eth to memory, using
bus bandwidth.
    An interrupt kicks in thus the instruction fetching faults.

I'm guessing a few reasons:
    __get_user() cannot be interrupted;
    __get_user() is corrupted if DMA occupies too much bus bandwidth;
    address space switching/flushing is corrupted by interrupts or DMA;
    other MMU issues or caching issues;
    not a logic error in software or hardware, but just noises.

Below is the dump of two consecutive faults in alignment handler. The kernel
is modified in "__do_kernel_fault()" like the following code to help debug:
    __show_regs(regs);
    WARN_ON(1);
    printk("Pre-fixup pc %pS va %pS\n", (void*)(regs->ARM_pc), (void*)addr);
    printk("Pre-fixup pc %lx va %lx\n",regs->ARM_pc, addr);
    //decode pgd/pud/pmd, follwing the logic in show_pte(), using values from
    //  "pgd = cpu_get_pgd()", and from "pgd = init_mm.pgd".


----first fault: fetching instruction:

CPU: 0    Tainted: G        W    (2.6.39.2 #479)
PC is at do_alignment+0x78/0x3e4
LR is at do_alignment+0x28/0x3e4
pc : [<c003163c>]    lr : [<c00315ec>]    psr: 40000013
sp : c3ac7c60  ip : bf000000  fp : c02b11a8
r10: 00000001  r9 : c02c52d0  r8 : c3b73042
r7 : c01e590c  r6 : c3ac7d40  r5 : c3ac7d40  r4 : 00000001
r3 : 00000017  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 83a5c000  DAC: 00000015
------------[ cut here ]------------
WARNING: at arch/arm/mm/fault.c:580 __do_kernel_fault+0x60/0x238()
Modules linked in: DaliPeer DaliGpio DaliMem DaliI2c DaliSpi
[<c002e4a0>] (unwind_backtrace+0x0/0xe4) from [<c003d7fc>]
(warn_slowpath_common+0x4c/0x64)
[<c003d7fc>] (warn_slowpath_common+0x4c/0x64) from [<c003d830>]
(warn_slowpath_null+0x1c/0x24)
[<c003d830>] (warn_slowpath_null+0x1c/0x24) from [<c002f840>]
(__do_kernel_fault+0x60/0x238)
[<c002f840>] (__do_kernel_fault+0x60/0x238) from [<c002fc88>]
(do_bad_area+0x70/0x7c)
[<c002fc88>] (do_bad_area+0x70/0x7c) from [<c002fca0>] (do_sect_fault+0xc/0x18)
[<c002fca0>] (do_sect_fault+0xc/0x18) from [<c001e348>]
(do_DataAbort+0xb8/0x138)
[<c001e348>] (do_DataAbort+0xb8/0x138) from [<c0028fdc>] (__dabt_svc+0x5c/0x80)
Exception stack(0xc3ac7c18 to 0xc3ac7c60)
7c00:                                                       00000000 00000000
7c20: 00000000 00000017 00000001 c3ac7d40 c3ac7d40 c01e590c c3b73042 c02c52d0
7c40: 00000001 c02b11a8 bf000000 c3ac7c60 c00315ec c003163c 40000013 ffffffff
[<c0028fdc>] (__dabt_svc+0x5c/0x80) from [<c003163c>] (do_alignment+0x78/0x3e4)
[<c003163c>] (do_alignment+0x78/0x3e4) from [<c001e348>]
(do_DataAbort+0xb8/0x138)
[<c001e348>] (do_DataAbort+0xb8/0x138) from [<c0028fdc>] (__dabt_svc+0x5c/0x80)
Exception stack(0xc3ac7d40 to 0xc3ac7d88)
7d40: c28903e0 00000007 c3ac6000 c3b73036 c02d1414 c28903e0 c3ac6008 c3ac3260
7d60: c3ac7f5c c3ac7edc 0047f7a2 0000251c c3ac7d78 c3ac7d88 c01e2564 c01e590c
7d80: 40000013 ffffffff
[<c0028fdc>] (__dabt_svc+0x5c/0x80) from [<c01e590c>] (udp_recvmsg+0x35c/0x52c)
[<c01e590c>] (udp_recvmsg+0x35c/0x52c) from [<c01ea7d8>]
(inet_recvmsg+0x44/0x58)
[<c01ea7d8>] (inet_recvmsg+0x44/0x58) from [<c01940f4>] (sock_recvmsg+0x9c/0xc4)
[<c01940f4>] (sock_recvmsg+0x9c/0xc4) from [<c0194964>] (sys_recvfrom+0x84/0xe0)
[<c0194964>] (sys_recvfrom+0x84/0xe0) from [<c0029440>]
(ret_fast_syscall+0x0/0x2c)
---[ end trace 65f8ea860415c06c ]---

    Pre-fixup  pc do_alignment+0x78/0x3e4    va udp_recvmsg+0x35c/0x52c
    Pre-fixup  pc c003163c    va c01e590c

    cpu table
     pgd table: c3a5c000  addr 0xc01e590c  index 0x00000600
     pgd entry: c3a5f000  8000041e 8010041e
     pud entry: c3a5f000
     pmd entry: c3a5f000  8010041e  index 1 (section index, 0 or 1)
      pmd sect entry =     8010041e
      base addr bit 31..20 80100000
            sbz bit 19..12 00000000
            ap  bit 11..10 00000400
         domain bit  8..5  00000000
            1cb bit  4..2  0000001c
           sect bit  1..0  00000002
    addr offset bit 19..12 000e5000

    init mm
     pgd table: c0004000  addr 0xc01e590c  index 0x00000600
     pgd entry: c0007000  8000041e 8010041e
     pud entry: c0007000
     pmd entry: c0007000  8010041e  index 1 (0 or 1)
      pmd sect entry =     8010041e
      base addr bit 31..20 80100000
            sbz bit 19..12 00000000
            ap  bit 11..10 00000400
         domain bit  8..5  00000000
            1cb bit  4..2  0000001c
           sect bit  1..0  00000002
    addr offset bit 19..12 000e5000


----second fault: due to failure in fetching instruction

CPU: 0    Tainted: G        W    (2.6.39.2 #479)
PC is at udp_recvmsg+0x35c/0x52c
LR is at dma_ptr_unlock+0x1c/0x48
pc : [<c01e590c>]    lr : [<c01e2564>]    psr: 40000013
sp : c3ac7d88  ip : c3ac7d78  fp : 0000251c
r10: 0047f7a2  r9 : c3ac7edc  r8 : c3ac7f5c
r7 : c3ac3260  r6 : c3ac6008  r5 : c28903e0  r4 : c02d1414
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 83a5c000  DAC: 00000015
------------[ cut here ]------------
WARNING: at arch/arm/mm/alignment.c:822 do_alignment+0xc4/0x3e4()
[<c002e4a0>] (unwind_backtrace+0x0/0xe4) from [<c003d7fc>]
(warn_slowpath_common+0x4c/0x64)
[<c003d7fc>] (warn_slowpath_common+0x4c/0x64) from [<c003d830>]
(warn_slowpath_null+0x1c/0x24)
[<c003d830>] (warn_slowpath_null+0x1c/0x24) from [<c0031688>]
(do_alignment+0xc4/0x3e4)
[<c0031688>] (do_alignment+0xc4/0x3e4) from [<c001e348>]
(do_DataAbort+0xb8/0x138)
[<c001e348>] (do_DataAbort+0xb8/0x138) from [<c0028fdc>] (__dabt_svc+0x5c/0x80)
Exception stack(0xc3ac7d40 to 0xc3ac7d88)
7d40: c28903e0 00000007 c3ac6000 c3b73036 c02d1414 c28903e0 c3ac6008 c3ac3260
7d60: c3ac7f5c c3ac7edc 0047f7a2 0000251c c3ac7d78 c3ac7d88 c01e2564 c01e590c
7d80: 40000013 ffffffff
[<c0028fdc>] (__dabt_svc+0x5c/0x80) from [<c01e590c>] (udp_recvmsg+0x35c/0x52c)
[<c01e590c>] (udp_recvmsg+0x35c/0x52c) from [<c01ea7d8>]
(inet_recvmsg+0x44/0x58)
[<c01ea7d8>] (inet_recvmsg+0x44/0x58) from [<c01940f4>] (sock_recvmsg+0x9c/0xc4)
[<c01940f4>] (sock_recvmsg+0x9c/0xc4) from [<c0194964>] (sys_recvfrom+0x84/0xe0)
[<c0194964>] (sys_recvfrom+0x84/0xe0) from [<c0029440>]
(ret_fast_syscall+0x0/0x2c)
---[ end trace 65f8ea860415c06d ]---

    cpu table
     pgd table: c3a5c000  addr 0xc01e590c  index 0x00000600
     pgd entry: c3a5f000  8000041e 8010041e
     pud entry: c3a5f000
     pmd entry: c3a5f000  8010041e  index 1 (section index, 0 or 1)
      pmd sect entry =     8010041e
      base addr bit 31..20 80100000
            sbz bit 19..12 00000000
            ap  bit 11..10 00000400
         domain bit  8..5  00000000
            1cb bit  4..2  0000001c
           sect bit  1..0  00000002
    addr offset bit 19..12 000e5000

    init mm
     pgd table: c0004000  addr 0xc01e590c  index 0x00000600
     pgd entry: c0007000  8000041e 8010041e
     pud entry: c0007000
     pmd entry: c0007000  8010041e  index 1 (0 or 1)
      pmd sect entry =     8010041e
      base addr bit 31..20 80100000
            sbz bit 19..12 00000000
            ap  bit 11..10 00000400
         domain bit  8..5  00000000
            1cb bit  4..2  0000001c
           sect bit  1..0  00000002
    addr offset bit 19..12 000e5000
