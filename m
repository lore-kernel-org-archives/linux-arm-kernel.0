From: fernando.endo@phiinnovations.com (Fernando Endo)
Date: Tue, 27 Sep 2011 09:54:18 -0300
Subject: Porting linux to Stellaris Cortex-M3
In-Reply-To: <CAAJ0-p7YwKR9B6BfoHcRqrNPVvpd49XrPsDCN7UF=-5jAf8XnQ@mail.gmail.com>
References: <CAH8SYHDRT7OpLr0sx75rMyy4OV59JZGoRv_cr2+-+2yy3tfU9g@mail.gmail.com>
	<CAAJ0-p7YwKR9B6BfoHcRqrNPVvpd49XrPsDCN7UF=-5jAf8XnQ@mail.gmail.com>
Message-ID: <CAH8SYHBFgkp47vf97qC_pseBOKNMrqVMj9sddjzUg1xjWpg6xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh sorry for sendig again, I forgot to include the lists


2011/9/27 Maxin John <arm.maxinbjohn@gmail.com>:
>
> We hit this bug if we are scheduling when we should not be. ie : if we
> call schedule() or sleep() from a driver while in an interrupt handler
> or holding a spin-lock, that will trigger this bug. This is because of
> a bug present in any of the kernel drivers.

Do we call schedule() or sleep() explicitly on a kernel driver, or are
there 'hidden' calls inside some function?
As I had to implement the basic drivers (clock, timer, irq and uart)
so far, I didn't call them explicitly.

>?Please share the detailed logs.

This is the log that I got with printascii bypassing printk:

<5>Linux version 2.6.33-arm1 (fernando at fernando-POS-MIG31AG) (gcc
version 4.5.2 (Sourcery G++ Lite 2011.03-41) ) #127 Tue Sep 27
09:14:21 BRT 2011
CPU: ARMv7-M Processor [412fc230] revision 0 (ARMv?(11)M)
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: Stellaris LM3S9B96
<7>On node 0 totalpages: 2048
<7>free_area_init_node: node 0, pgdat 600de1e0, node_mem_map 600f6000
<7> ?DMA zone: 16 pages used for memmap
<7> ?DMA zone: 0 pages reserved
<7> ?DMA zone: 2032 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off. ?Total pages: 2032
<5>Kernel command line: init=/bin/busybox console=ttyS mem=8M
<6>PID hash table entries: 32 (order: -5, 128 bytes)
<6>Dentry cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
<6>Memory: 8MB = 8MB total
<5>Memory: 7168k/7168k available, 1024k reserved, 0K highmem
<5>Virtual kernel memory layout:
? ?vector ?: 0x00000000 - 0x00001000 ? ( ? 4 kB)
? ?fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
? ?vmalloc : 0x00000000 - 0xffffffff ? (4095 MB)
? ?lowmem ?: 0x60000000 - 0x60800000 ? ( ? 8 MB)
? ?modules : 0x60000000 - 0x60800000 ? ( ? 8 MB)
? ? ?.init : 0x60008000 - 0x6002f000 ? ( 156 kB)
? ? ?.text : 0x6002f000 - 0x600cb000 ? ( 624 kB)
? ? ?.data : 0x600d6000 - 0x600deb40 ? ( ?35 kB)
<6>Hierarchical RCU implementation.
<6>NR_IRQS:54
<6>console [ttyS0] enabled
<6>Calibrating delay loop... <c>3.82 BogoMIPS (lpj=19136)
Mount-cache hash table entries: 512
<6>Switching to clocksource timer3
<6>ttyS0 at MMIO 0x4000c000 (irq = 5) is a LM3S9B96 UARTx Port
<6>Freeing init memory: 156K
<3>BUG: scheduling while atomic: init/1/0xffff0003
[<60032b6d>] (unwind_backtrace+0x1/0x88) from [<600a1379>] (dump_stack+0xd/0x10)
[<600a1379>] (dump_stack+0xd/0x10) from [<60034ea5>] (__schedule_bug+0x35/0x40)
[<60034ea5>] (__schedule_bug+0x35/0x40) from [<600a17b1>] (schedule+0x2d1/0x2f4)
[<600a17b1>] (schedule+0x2d1/0x2f4) from [<6002f791>] (ret_slow_syscall+0x1/0xc)
<4>ptrace: can't handle thumb mode
<3>BUG: scheduling while atomic: init/1/0x60408008
[<60032b6d>] (unwind_backtrace+0x1/0x88) from [<600a1379>] (dump_stack+0xd/0x10)
[<600a1379>] (dump_stack+0xd/0x10) from [<60034ea5>] (__schedule_bug+0x35/0x40)
[<60034ea5>] (__schedule_bug+0x35/0x40) from [<600a17b1>] (schedule+0x2d1/0x2f4)
[<600a17b1>] (schedule+0x2d1/0x2f4) from [<6002f791>] (ret_slow_syscall+0x1/0xc)

Unhandled exception: IPSR = 00000003 LR = fffffff1
CPU: 0 ? ?Not tainted ?(2.6.33-arm1 #127)
PC is at account_user_time+0x4/0x60
LR is at account_process_tick+0x4d/0x58
pc : [<60038168>] ? ?lr : [<60038389>] ? ?psr: 01000223
sp : 60418038 ?ip : 000002cc ?fp : 00000000
r10: 01000000 ?r9 : 604d1f36 ?r8 : 00000013
r7 : 6041803c ?r6 : 068e7780 ?r5 : 00000001 ?r4 : ffafdad5
r3 : ffafdad5 ?r2 : 00000001 ?r1 : 00000001 ?r0 : ffafdad5

Att,
Fernando Akira Endo
