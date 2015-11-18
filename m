From: ilu@linutronix.de (Philipp Rosenberger)
Date: Wed, 18 Nov 2015 14:19:49 +0100
Subject: Incomplete DM814x support in 4.3
Message-ID: <564C7AF5.9070209@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have seen with pleasure that some support for DM814x was integrated to the kernel. But it seems incomplete I get various errors when I try to boot the kernel on a DM814x/AM387x based board.

[    0.000000] IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for timer1_mux_ck!
[    0.000000] ti_clk_get_reg_addr: clk-provider not found for timer2_mux_ck!
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at /home/ilu/projects/lenze/linux/arch/arm/mach-omap2/timer.c:344 omap_dm_timer_init_one+0x1a4/0x2ec()
[    0.000000] Cannot set timer parent clock, no PLL clock driver?
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.3.0-dirty #47
[    0.000000] Hardware name: Generic ti814x (Flattened Device Tree)
[    0.000000] [<c0017894>] (unwind_backtrace) from [<c0013c04>] (show_stack+0x10/0x14)
[    0.000000] [<c0013c04>] (show_stack) from [<c02cf6bc>] (dump_stack+0x84/0x9c)
[    0.000000] [<c02cf6bc>] (dump_stack) from [<c003e994>] (warn_slowpath_common+0x7c/0xb8)
[    0.000000] [<c003e994>] (warn_slowpath_common) from [<c003ea00>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c003ea00>] (warn_slowpath_fmt) from [<c07a5e34>] (omap_dm_timer_init_one+0x1a4/0x2ec)
[    0.000000] [<c07a5e34>] (omap_dm_timer_init_one) from [<c07a5fc0>] (omap2_gp_clockevent_init+0x44/0xcc)
[    0.000000] [<c07a5fc0>] (omap2_gp_clockevent_init) from [<c07a65c0>] (omap3_gptimer_timer_init+0x20/0x3c)
[    0.000000] [<c07a65c0>] (omap3_gptimer_timer_init) from [<c079ab08>] (start_kernel+0x25c/0x400)
[    0.000000] [<c079ab08>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] ---[ end trace cb88537fdc8fa200 ]---
[    0.000000] timer->fclk: 'devosc_ck'
[    0.000000] src: 'devosc_ck'
[    0.000000] OMAP clockevent source: timer2 at 20000000 Hz
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: CPU: 0 PID: 0 at /home/ilu/projects/customer/linux/arch/arm/mach-omap2/timer.c:344 omap_dm_timer_init_one+0x1a4/0x2ec()
[    0.000000] Cannot set timer parent clock, no PLL clock driver?
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.3.0-dirty #47
[    0.000000] Hardware name: Generic ti814x (Flattened Device Tree)
[    0.000000] [<c0017894>] (unwind_backtrace) from [<c0013c04>] (show_stack+0x10/0x14)
[    0.000000] [<c0013c04>] (show_stack) from [<c02cf6bc>] (dump_stack+0x84/0x9c)
[    0.000000] [<c02cf6bc>] (dump_stack) from [<c003e994>] (warn_slowpath_common+0x7c/0xb8)
[    0.000000] [<c003e994>] (warn_slowpath_common) from [<c003ea00>] (warn_slowpath_fmt+0x30/0x40)
[    0.000000] [<c003ea00>] (warn_slowpath_fmt) from [<c07a5e34>] (omap_dm_timer_init_one+0x1a4/0x2ec)
[    0.000000] [<c07a5e34>] (omap_dm_timer_init_one) from [<c07a6084>] (omap2_gptimer_clocksource_init+0x3c/0xcc)
[    0.000000] [<c07a6084>] (omap2_gptimer_clocksource_init) from [<c079ab08>] (start_kernel+0x25c/0x400)
[    0.000000] [<c079ab08>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] ---[ end trace cb88537fdc8fa201 ]---

End in the end it panics with this:
[    0.379442] platform ocp: Cannot lookup hwmod 'l3_main'
[    0.387920] platform 48032000.gpio: Cannot lookup hwmod 'gpio1'
[    0.394638] omap_gpio 48032000.gpio: Could not get gpio dbck. Disable debounce
[    0.402220] omap_gpio 48032000.gpio: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
[    0.411448] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa032034
[    0.419419] pgd = c0004000
[    0.422292] [fa032034] *pgd=48011452(bad)
[    0.426528] Internal error: : 1028 [#1] SMP ARM
[    0.431282] Modules linked in:
[    0.434525] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.3.0-dirty #47
[    0.442493] Hardware name: Generic ti814x (Flattened Device Tree)
[    0.448853] task: ce038d40 ti: ce03a000 task.ti: ce03a000
[    0.454511] PC is at omap_gpio_probe+0x1ec/0x604
[    0.459352] LR is at 0x0
[    0.462050] pc : [<c030a9ac>]    lr : [<00000000>]    psr: 60000113
[    0.462050] sp : ce03bce8  ip : fa032034  fp : 00000000
[    0.474043] r10: c030a3a4  r9 : cfb80c64  r8 : c05ad510
[    0.479509] r7 : ce0ecc10  r6 : ce0ecc00  r5 : ce0c3890  r4 : ce0e5a10
[    0.486316] r3 : c0864964  r2 : fa032000  r1 : 00000020  r0 : ffffffff
[    0.493124] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.500558] Control: 10c5387d  Table: 80004019  DAC: 00000051
[    0.506560] Process swapper/0 (pid: 1, stack limit = 0xce03a218)
[    0.512830] Stack: (0xce03bce8 to 0xce03c000)
[    0.517410] bce0:                   c086463c ce0ecc10 ce0ecc10 fffffdfb c086463c c086463c
[    0.525924] bd00: 00000000 00000000 00000000 c03672dc c0367298 c1089698 ce0ecc10 00000000
[    0.534438] bd20: c086463c c036580c 00000000 ce03bd58 c03659a0 00000001 c1089654 c0363dd0
[    0.542952] bd40: ce0822d4 ce0c2294 ce0ecc10 ce0ecc44 c086d0e0 c0365594 ce0ecc10 00000001
[    0.551467] bd60: c086dae8 ce0ecc18 ce0ecc10 c086d0e0 ce0e9810 c0364ca4 ce0ecc18 ce0ecc10
[    0.559979] bd80: 00000000 c03630f8 00000000 00000000 00000000 00000001 ce0ecc00 ce0ecc10
[    0.568493] bda0: 00000000 cfb80cb4 00000000 ce0e9810 00000000 c043a5a4 00000000 cfb80c64
[    0.577006] bdc0: c07ebf5c 00000001 c07f3d78 c043a6c4 00000000 60000193 ce038d40 c057dd74
[    0.585520] bde0: 00000001 00000001 c07f3d78 c008ebbc 60000113 c087fe80 c07ebf5c cfb80c64
[    0.594033] be00: cfb806b8 c07ebf5c 00000001 c07f3d78 ce0e9810 00000000 00000000 c043a720
[    0.602547] be20: 00000001 60000193 ce038d40 c057dd74 00000001 00000001 c07f3d78 c008ebbc
[    0.611062] be40: a0000113 c087fe80 c07ebf5c cfb806b8 cfb804d4 c07ebf5c 00000001 c07f3d78
[    0.619575] be60: ce0e9c10 00000000 00000000 c043a720 00000001 60000193 ce038d40 c057dd74
[    0.628089] be80: 00000001 c07ebf5c 00000000 c008ebbc 60000113 c087fe80 c07f3d78 cfb804d4
[    0.636602] bea0: cfb7f8b8 c07f3d78 c07ebf5c 00000000 00000001 c07e3858 00000071 c043a8a0
[    0.645116] bec0: 00000001 c0438900 c06d3834 c07f3d78 c08082b0 ce0e69c0 c089c000 c079d6a4
[    0.653630] bee0: 00000000 c07ad22c c08082b0 c07ace4c c07e1e1c c079d6c0 00000000 c00098a4
[    0.662144] bf00: ce038d40 c083fd28 ce039280 00000000 ce038d00 00000004 00000006 00000000
[    0.670657] bf20: cfdffb8b c05a1bb8 00000071 c005de6c 00000001 00000000 c076c860 cfdffb95
[    0.679171] bf40: 00000003 00000003 c07f9834 c07f9940 c07f9948 00000003 c089c000 c089c000
[    0.687684] bf60: c07e3840 00000000 c07e3858 c079aebc 00000003 00000003 00000000 c079a594
[    0.696196] bf80: c05777dc 00000000 c05777dc 00000000 00000000 00000000 00000000 00000000
[    0.704710] bfa0: 00000000 c05777e4 00000000 c000f570 00000000 00000000 00000000 00000000
[    0.713223] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.721736] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 f3af5f7f ffdefffe
[    0.730261] [<c030a9ac>] (omap_gpio_probe) from [<c03672dc>] (platform_drv_probe+0x44/0xa4)
[    0.738956] [<c03672dc>] (platform_drv_probe) from [<c036580c>] (driver_probe_device+0x1f0/0x2b8)
[    0.748184] [<c036580c>] (driver_probe_device) from [<c0363dd0>] (bus_for_each_drv+0x58/0x8c)
[    0.757054] [<c0363dd0>] (bus_for_each_drv) from [<c0365594>] (__device_attach+0xa4/0x108)
[    0.765656] [<c0365594>] (__device_attach) from [<c0364ca4>] (bus_probe_device+0x88/0x90)
[    0.774167] [<c0364ca4>] (bus_probe_device) from [<c03630f8>] (device_add+0x3b4/0x55c)
[    0.782421] [<c03630f8>] (device_add) from [<c043a5a4>] (of_platform_device_create_pdata+0x80/0xb8)
[    0.791831] [<c043a5a4>] (of_platform_device_create_pdata) from [<c043a6c4>] (of_platform_bus_create+0xdc/0x18c)
[    0.802402] [<c043a6c4>] (of_platform_bus_create) from [<c043a720>] (of_platform_bus_create+0x138/0x18c)
[    0.812257] Code: e1d3c1b4 1a00007b e5d3e034 e082c00c (e59c6000) 
[    0.818631] ---[ end trace cb88537fdc8fa202 ]---
[    0.823591] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.823591] 
[    0.833188] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

I searched for 'l3_main' in the hwmods for dm814x but it is not defined in there.

I didn't find a driver in the tree which is compatible with "ti,dm814-pllss" so no driver for pll handling.

Is there some work in progress to bring the missing parts into the kernel?

Best regards
Philipp Rosenberger
