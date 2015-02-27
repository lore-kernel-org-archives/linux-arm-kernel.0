From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 27 Feb 2015 17:48:51 +0100
Subject: [PATCHv2 05/15] ARM: mvebu: add stdout-path to all armada-*.dts
In-Reply-To: <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
References: <1424451874-25375-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1424451874-25375-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <54EB4E9B.6010001@free-electrons.com>
 <CAL_JsqJZJMkH953hq0_sOvEEu9o4pXxs0sdP5=7c2EXXNSyA9A@mail.gmail.com>
Message-ID: <20150227174851.390d9f58@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob, Mark,

On Mon, 23 Feb 2015 10:50:26 -0600, Rob Herring wrote:
> On Mon, Feb 23, 2015 at 10:00 AM, Gregory CLEMENT

> Not exactly, stdout-path allows for removing "console" from the
> command line. earlyprintk is a debug/developer option, so it should
> not be in a default command line IMO.
> 
> So bootargs should be removed entirely.

Unfortunately, this doesn't seem to work at all:

 - Setting /chosen/stdout-path = &uart0; and still console=ttyS0,115200
   in /chosen/bootargs works fine. I see a call to
   add_preferred_console fairly early in the boot:

[    0.000000] Kernel command line: loglevel=8 ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs console=ttyS0,115200 earlyprintk
[    0.000000] ------> name=ttyS, idx=0, options=115200, brl_options=(null)
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)

   But of course, this is not the case we're interested in. Note that
   the line "------>" is printed in __add_preferred_console().

 - Setting just /chosen/stdout-path = &uart0; and removing
   completely /chosen/bootargs, there are no kernel messages displayed
   at all. Fortunately, my userspace hooks up on ttyS0, so I can run
   "dmesg" and see when add_preferred_console gets called, and with
   what arguments. It gets called much, much later, i.e only when the
   serial port itself is initialized:

[    0.484951] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.486822] ------> name=ttyS, idx=0, options=(null), brl_options=(null)
[    0.506838] f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 21, base_baud = 12500000) is a 16550A
[    9.106098] console [ttyS0] enabled

   So it gets the right port name, the right idx, just the options are
   null. It shouldn't be an issue since the serial port is already
   initialized by the bootloader.

 - So I tried something like stdout-path = "serial0 at 12000:115200n8";
   and here the result is even more interesting: it simply crashes the
   kernel! So some random data in DT makes the stuff crash.

[    0.000000]  ==> of_alias_scan: serial0 at 12000:115200n8
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000c
[    0.000000] pgd = c0004000
[    0.000000] [0000000c] *pgd=00000000
[    0.000000] Internal error: Oops: 5 [#1] SMP ARM
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rc1-00016-g0d60469-dirty #466
[    0.000000] Hardware name: Marvell Armada 39x (Device Tree)
[    0.000000] task: c088b468 ti: c0886000 task.ti: c0886000
[    0.000000] PC is at of_alias_scan+0xa4/0x2bc
[    0.000000] LR is at of_find_node_opts_by_path+0xac/0x230
[    0.000000] pc : [<c03b62b4>]    lr : [<c03b4b68>]    psr: 600001d3
[    0.000000] sp : c0887f38  ip : 00000000  fp : c08e05a4
[    0.000000] r10: 80000200  r9 : c05df908  r8 : c06aec30
[    0.000000] r7 : c088c3a4  r6 : c0890728  r5 : c253dba0  r4 : c08eb334
[    0.000000] r3 : 00000000  r2 : c253dbae  r1 : 00000000  r0 : c0630594
[    0.000000] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.000000] Control: 10c5387d  Table: 0000404a  DAC: 00000015
[    0.000000] Process swapper (pid: 0, stack limit = 0xc0886220)
[    0.000000] Stack: (0xc0887f38 to 0xc0888000)
[    0.000000] 7f20:                                                       00000000 0002f7ff
[    0.000000] 7f40: 00001000 00002370 00000001 c0888408 c06b8a2c c0890728 c088c3a4 ef7fce40
[    0.000000] 7f60: c05df908 80000200 c08e05a4 c06942bc ffffffff 10c5387d c08c2e00 c0887fd4
[    0.000000] 7f80: 00000000 00000000 00000000 c0053f98 c05de48c c0887fb4 00000000 00000000
[    0.000000] 7fa0: c08c2cc0 c0888400 ffffffff c08c2cc0 00000000 00000000 00000000 c0691960
[    0.000000] 7fc0: 00000000 00000000 00000000 00000000 00000000 c06c3a78 c08c2f54 c0888480
[    0.000000] 7fe0: c06c3a74 c088c4b4 0000406a 414fc091 00000000 00008074 00000000 00000000
[    0.000000] [<c03b62b4>] (of_alias_scan) from [<c06942bc>] (setup_arch+0x6bc/0x8b8)
[    0.000000] [<c06942bc>] (setup_arch) from [<c0691960>] (start_kernel+0xa0/0x3a0)
[    0.000000] [<c0691960>] (start_kernel) from [<00008074>] (0x8074)
[    0.000000] Code: e594300c e3000594 e5942010 e34c0063 (e593100c) 
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!

It is worth mentioning that this also happens with

     stdout-path = "uart0:115200n8";

which was explicitly suggested by Mark in his e-mail. uart0 is an alias
to the proper DT node, since stdout-path = &uart0; works almost fine.

This is all on v4.0-rc1. Seems like this stdout-path feature is not
quite working in all situations yet.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
