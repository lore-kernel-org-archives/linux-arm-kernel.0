From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Fri, 12 Jun 2015 11:30:20 +0200
Subject: [BUG] usb/at91: usb hub does not work
In-Reply-To: <Pine.LNX.4.44L0.1506110952460.1465-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1506110952460.1465-100000@iolanthe.rowland.org>
Message-ID: <557AA6AC.1090308@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11.6.2015 15:53, Alan Stern wrote:
> On Thu, 11 Jun 2015, Ji?? Prchal wrote:
>
>> Hi all,
>> I discovered some bug when I change kernel from 3.18.13 to 3.18.14. I have board with usb hub CY7C65632 on it.
>> In .13 it works fine but in .14 it repeats this message:
>> [   19.170000] usb 2-3: new full-speed USB device number 56 using at91_ohci
>> and devices connected to usb through hub doesn't appear at all.
>
>> Any idea?
>
> Try using git bisect to find the commit which caused this problem to
> start.

This is result:
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[ae74ea64ccdb8b99ee2618b58020263d5b1d9b22] clk: at91: usb: propagate rate modification to the parent clk

Compilation has some warnings:
   CC      drivers/clk/at91/clk-usb.o
drivers/clk/at91/clk-usb.c:157:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/at91/clk-usb.c:157:2: warning: (near initialization for ?at91sam9x5_usb_ops.determine_rate?) [enabled by 
default]
drivers/clk/at91/clk-usb.c:195:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/at91/clk-usb.c:195:2: warning: (near initialization for ?at91sam9n12_usb_ops.determine_rate?) [enabled by 
default]

And kernel hangs up with this:
[    4.480000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.480000] ehci-atmel: EHCI Atmel driver
[    4.490000] Unable to handle kernel paging request at virtual address 1c9c3800
[    4.500000] pgd = c0004000
[    4.500000] [1c9c3800] *pgd=00000000
[    4.500000] Internal error: Oops: 805 [#1] PREEMPT ARM
[    4.500000] Modules linked in:
[    4.500000] CPU: 0 PID: 1 Comm: swapper Tainted: G        W      3.18.13_cpm9g25+ #10
[    4.500000] task: c7821b00 ti: c7828000 task.ti: c7828000
[    4.500000] PC is at at91sam9x5_clk_usb_determine_rate+0xb8/0x120
[    4.500000] LR is at at91sam9x5_clk_usb_determine_rate+0xb4/0x120
[    4.500000] pc : [<c0392f3c>]    lr : [<c0392f38>]    psr: a0000013
[    4.500000] sp : c7829d28  ip : c7829d28  fp : c7829d64
[    4.500000] r10: c7802ae0  r9 : c7806400  r8 : 02dc6c00
[    4.500000] r7 : 00000000  r6 : 00000001  r5 : ffffffff  r4 : 02dc6c00
[    4.500000] r3 : 17d78400  r2 : 1c9c3800  r1 : 14fb1800  r0 : c7802860
[    4.500000] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    4.500000] Control: 0005317f  Table: 20004000  DAC: 00000017
[    4.500000] Process swapper (pid: 1, stack limit = 0xc78281b8)
[    4.500000] Stack: (0xc7829d28 to 0xc782a000)
[    4.500000] 9d20:                   00000000 17d78400 14fb1800 17d78400 c7a26400 c7806580
[    4.500000] 9d40: c7806480 c0731fb8 c7a26400 00000026 00000000 c06a7dd0 c7829d8c c7829d68
[    4.500000] 9d60: c038d574 c0392e94 c7806480 1c9c3800 c7806580 02dc6c00 c0731fb8 c7a26400
[    4.500000] 9d80: c7829da4 c7829d90 c038ded8 c038d50c c79a5400 c79a5410 c7829dcc c7829da8
[    4.500000] 9da0: c033e620 c038de8c c033e458 c79a5410 ffffffed c06ec394 00000000 c0696f58
[    4.500000] 9dc0: c7829dec c7829dd0 c02bd9e4 c033e468 c02bd98c c79a5410 00000000 c06ec394
[    4.500000] 9de0: c7829e0c c7829df0 c02bbe80 c02bd99c c79a5410 c79a5444 c06ec394 c02bbfcc
[    4.500000] 9e00: c7829e2c c7829e10 c02bc044 c02bbdd0 c02bbfcc 00000000 c7829e30 c06ec394
[    4.500000] 9e20: c7829e54 c7829e30 c02ba428 c02bbfdc c78687ec c799b490 c06ec394 c79e4d00
[    4.500000] 9e40: 00000000 c06e4038 c7829e64 c7829e58 c02bb984 c02ba3d4 c7829e8c c7829e68
[    4.500000] 9e60: c02bb5f8 c02bb96c c05d0c60 c7829e78 c06ec394 c06cd5d8 c06cd5d8 c06ff700
[    4.500000] 9e80: c7829ea4 c7829e90 c02bca48 c02bb528 00000000 c06cd5d8 c7829eb4 c7829ea8
[    4.500000] 9ea0: c02bd840 c02bc9ac c7829ecc c7829eb8 c0696f94 c02bd7f8 00000000 c7a31dc0
[    4.500000] 9ec0: c7829f54 c7829ed0 c0008acc c0696f68 00000000 c0042664 00000000 c0034c1c
[    4.500000] 9ee0: c7ffc978 c7ffc900 c7829f0c c7829ef8 c0034c1c c0034ba4 c7ffc975 00000000
[    4.500000] 9f00: c7829f54 c7829f10 c0034e48 c06745f4 c7829f2c c060ba60 00000006 00000006
[    4.500000] 9f20: 0000007b 1aadfd66 c7829f54 00000006 c06a7dc4 c06c0df4 c06ff700 0000007b
[    4.500000] 9f40: 00000000 c06a7dd0 c7829f94 c7829f58 c0674de4 c00089c8 00000006 00000006
[    4.500000] 9f60: c06745e4 c003bb38 c7829f94 c7829f78 00000000 c04989a0 00000000 00000000
[    4.500000] 9f80: 00000000 00000000 c7829fac c7829f98 c04989b8 c0674d00 c7828000 00000000
[    4.500000] 9fa0: 00000000 c7829fb0 c0009790 c04989b0 00000000 00000000 00000000 00000000
[    4.500000] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.500000] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 a8210092 a39c4870
[    4.500000] [<c0392f3c>] (at91sam9x5_clk_usb_determine_rate) from [<c038d574>] (clk_calc_new_rates+0x78/0x174)
[    4.500000] [<c038d574>] (clk_calc_new_rates) from [<c038ded8>] (clk_set_rate+0x5c/0xa4)
[    4.500000] [<c038ded8>] (clk_set_rate) from [<c033e620>] (ehci_atmel_drv_probe+0x1c8/0x308)
[    4.500000] [<c033e620>] (ehci_atmel_drv_probe) from [<c02bd9e4>] (platform_drv_probe+0x58/0xa0)
[    4.500000] [<c02bd9e4>] (platform_drv_probe) from [<c02bbe80>] (driver_probe_device+0xc0/0x20c)
[    4.500000] [<c02bbe80>] (driver_probe_device) from [<c02bc044>] (__driver_attach+0x78/0x9c)
[    4.500000] [<c02bc044>] (__driver_attach) from [<c02ba428>] (bus_for_each_dev+0x64/0xa0)
[    4.500000] [<c02ba428>] (bus_for_each_dev) from [<c02bb984>] (driver_attach+0x28/0x30)
[    4.500000] [<c02bb984>] (driver_attach) from [<c02bb5f8>] (bus_add_driver+0xe0/0x1e4)
[    4.500000] [<c02bb5f8>] (bus_add_driver) from [<c02bca48>] (driver_register+0xac/0xf0)
[    4.500000] [<c02bca48>] (driver_register) from [<c02bd840>] (__platform_driver_register+0x58/0x6c)
[    4.500000] [<c02bd840>] (__platform_driver_register) from [<c0696f94>] (ehci_atmel_init+0x3c/0x58)
[    4.500000] [<c0696f94>] (ehci_atmel_init) from [<c0008acc>] (do_one_initcall+0x114/0x204)
[    4.500000] [<c0008acc>] (do_one_initcall) from [<c0674de4>] (kernel_init_freeable+0xf4/0x1bc)
[    4.500000] [<c0674de4>] (kernel_init_freeable) from [<c04989b8>] (kernel_init+0x18/0xf4)
[    4.500000] [<c04989b8>] (kernel_init) from [<c0009790>] (ret_from_fork+0x14/0x20)
[    4.500000] Code: e50b1034 e50b3038 ebffe315 e59b2008 (e5820000)
[    4.920000] ---[ end trace f24b6c88ae00fa9b ]---
[    4.920000] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.920000]
[    4.920000] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Jiri
