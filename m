From: wsteinwender@pcs.com (Wolfgang Steinwender)
Date: Wed, 20 May 2015 14:41:59 +0200
Subject: Problems with device tree PMC clocks and threadirqs on at91
Message-ID: <555C8117.9010508@pcs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm using a custom board with AT91SAM9G35. Booting with parameter
threadirqs fails with kernel oops.

In time_init(), the PMC is initialized. An IRQ is requested. The
IRQ is threaded and wake_up_process(kthreadd_task) is called.
But kthreadd_task is only initialized some time after time_init().

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.1.0-rc4 #2
Hardware name: Atmel AT91SAM9
task: c04d6e90 ti: c04d2000 task.ti: c04d2000
PC is at wake_up_process+0xc/0x48
LR is at kthread_create_on_node+0x88/0x128
pc : [<c0034838>]    lr : [<c002e494>]    psr: a00000d3
sp : c04d3e78  ip : c04d3e90  fp : c04d3e8c
r10: 00000000  r9 : c7801640  r8 : c7801640
r7 : c003ee6c  r6 : ffffffff  r5 : c04d3e90  r4 : c78025e0
r3 : c04eccfc  r2 : c78025f4  r1 : c04d9880  r0 : 00000000
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 20004000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc04d2190)
Stack: (0xc04d3e78 to 0xc04d4000)
3e60:                                                       c78025e0 c04d3e90
3e80: c04d3ec8 c04d3e90 c002e494 c003483c 00000000 c04d3e94 c04d3e94 c7801090
3ea0: c7801088 00040080 c7804a00 c7801640 00000010 c78023e0 c7804a00 c04d3efc
3ec0: c04d3ed0 c003fb7c c002e420 c045a704 00000010 c047c18c 00040080 c023ff14
3ee0: 00000010 00000000 c78023e0 c7804a00 c04d3f2c c04d3f00 c003ffa4 c003f8a0
3f00: 00040080 fefffc00 c78023e0 c7ee5d70 c03d9274 00000010 c04e5734 00000001
3f20: c04d3f5c c04d3f30 c04c29cc c003fecc c047c18c c78023e0 c023e808 00000001
3f40: c7ee5d70 c7802400 c7802420 00000000 c04d3f6c c04d3f60 c04c2ae0 c04c2918
3f60: c04d3fa4 c04d3f70 c04c2720 c04c2adc 00000000 00000000 00000000 c04cc994
3f80: 00000000 ffffffff c04ec1c0 c04cc0dc 41069265 c04d4000 c04d3fb4 c04d3fa8
3fa0: c04af364 c04c2630 c04d3ff4 c04d3fb8 c04adcbc c04af348 ffffffff ffffffff
3fc0: c04ad868 00000000 00000000 c04cc994 c04ec300 c04d4018 c04cc990 c04d7ba0
3fe0: 20004000 204cbacc 00000000 c04d3ff8 20008048 c04adab8 00000000 00000000
Backtrace:
[<c003482c>] (wake_up_process) from [<c002e494>] (kthread_create_on_node+0x88/0x128)
  r5:c04d3e90 r4:c78025e0
[<c002e410>] (kthread_create_on_node) from [<c003fb7c>] (__setup_irq+0x2ec/0x4d4)
  r10:c7804a00 r8:c78023e0 r7:00000010 r6:c7801640 r5:c7804a00 r4:00040080
[<c003f890>] (__setup_irq) from [<c003ffa4>] (request_threaded_irq+0xe8/0x15c)
  r10:c7804a00 r8:c78023e0 r7:00000000 r6:00000010 r5:c023ff14 r4:00040080
[<c003febc>] (request_threaded_irq) from [<c04c29cc>] (of_at91_pmc_setup+0xc4/0x154)
  r10:00000001 r9:c04e5734 r8:00000010 r7:c03d9274 r6:c7ee5d70 r5:c78023e0
  r4:fefffc00 r3:00040080
[<c04c2908>] (of_at91_pmc_setup) from [<c04c2ae0>] (of_at91sam9x5_pmc_setup+0x14/0x1c)
  r8:00000000 r7:c7802420 r6:c7802400 r5:c7ee5d70 r4:00000001
[<c04c2acc>] (of_at91sam9x5_pmc_setup) from [<c04c2720>] (of_clk_init+0x100/0x190)
[<c04c2620>] (of_clk_init) from [<c04af364>] (time_init+0x2c/0x38)
  r10:c04d4000 r9:41069265 r8:c04cc0dc r7:c04ec1c0 r6:ffffffff r5:00000000
  r4:c04cc994
[<c04af338>] (time_init) from [<c04adcbc>] (start_kernel+0x214/0x340)
[<c04adaa8>] (start_kernel) from [<20008048>] (0x20008048)
  r10:204cbacc r8:20004000 r7:c04d7ba0 r6:c04cc990 r5:c04d4018 r4:c04ec300
Code: e89da800 e1a0c00d e92dd830 e24cb004 (e5903000)
---[ end trace cb88537fdc8fa200 ]---

Some more information:
- Log is for 4.1-rc4, also happens on 3.18.11 and linux-at91 master
- device tree: at91sam9g35ek.dtb, appended to the kernel
- Maybe this is not arm related, there is a similar issue on MIPS
   (threaded IRQ requested before kthreadd_task is set):
   https://lkml.org/lkml/2014/10/18/31

Solutions I can think of:
- Make all IRQs requested that early in the boot process IRQF_NO_THREAD.
   Helps with pmc_setup(), but more changes required for other clocks
   (e.g. in clk-main.c).
- If kthreadd_task is not set, do not allow IRQ threads
   (in irq_setup_forced_threading()).
- Do not wake up kthreadd_task in kthread_create_on_node() if kthreadd_task
   is NULL. Why is wake_up_process() required?

Did I miss something?
Any suggestions?


Regards,
W. Steinwender
