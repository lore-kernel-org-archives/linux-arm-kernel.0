From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 26 Aug 2013 15:51:10 +0200
Subject: [GIT PULL 3/3] 2nd Round Samsung mach-exynos for v3.12
In-Reply-To: <200c01cea252$c67a87e0$536f97a0$@org>
References: <1f7701cea1f1$431f2d30$c95d8790$%kim@samsung.com>
 <4070794.XxjluIqBpK@amdc1032> <200c01cea252$c67a87e0$536f97a0$@org>
Message-ID: <2232237.1RKpjrnbve@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 26, 2013 08:52:44 PM Kukjin Kim wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> > > > is incorrect as noted a month ago in:
> > > >
> > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-
> > July/186355.html
> > > >
> > > > [ Because of the deficiency in the core cpuidle core (device-
> > >state_count
> > > >   not being used by governors' code) only sysfs entries for C1 state
> > will be
> > > >   disabled and EXYNOS cpuidle driver will still attempt to use C1
> > state.
> > > >
> > > > also non-working device->state_count is planned to be removed by:
> > > >
> > > > http://permalink.gmane.org/gmane.linux.power-management.general/37390
> > > I looked at your patch series and it seems reasonable. I will repost
> > > this patch on top of yours.
> > 
> > If you correctly use driver's state_count (instead of device's) there will
> > be
> > no dependency on my patch series and the new patch can be applied
> > immediately.
> > 
> > > But I suggest to keep this patch temporary till your patch series gets
> > merged.
> > 
> > The current patch (the one Kukjin merged) is incorrect as it just doesn't
> > do what it advertises. I see no reason to keep it.
> > 
> Well, I don't think so, because if the patch is missing, following kernel
> panic happens on exynos5440 platform.
> 
> Unable to handle kernel paging request at virtual address f8180608
> pgd = c0003000
> [f8180608] *pgd=80000080007003, *pmd=af7fb003, *pte=00000000
> Internal error: Oops: a07 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.11.0-0-generic
> #1~d20130819t044008~3372c79
> task: c0529d80 ti: c051e000 task.ti: c051e000
> PC is at exynos4_enter_lowpower+0x18/0x130
> LR is at cpuidle_enter_state+0x3c/0xe8
> pc : []    lr : []    psr: 200f0093
> sp : c051ff68  ip : 00000018  fp : 00000000
> r10: 00000000  r9 : 412fc0f3  r8 : 00000000
> r7 : c052c9cc  r6 : 00000001  r5 : 00000000  r4 : d5c3cc94
> r3 : f8180000  r2 : 0000ff3e  r1 : c052c980  r0 : c052cc98
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 30c5387d  Table: af139b00  DAC: fffffffd
> Process swapper (pid: 0, stack limit = 0xc051e230)
> Stack: (0xc051ff68 to 0xc0520000)
> ff60:                   d5c3cc94 00000000 c052cc98 c02c1310 d5c3cc94
> 00000000
> ff80: c0550288 c052c980 c058898c c052cc98 00000001 c052c980 c058898c
> c02c1458
> ffa0: c051e000 c0550288 c0550288 00000001 c05260dc c001b2cc 000001fe
> c00573e4
> ffc0: ffffffff c04f07d8 ffffffff ffffffff c04f0290 00000000 00000000
> c05134d8
> ffe0: 30c7387d c0526064 c05134d4 c052b5b4 80007000 80008080 00000000
> 00000000
> [] (exynos4_enter_lowpower+0x18/0x130) from []
> (cpuidle_enter_state+0x3c/0xe8)
> [] (cpuidle_enter_state+0x3c/0xe8) from [] (cpuidle_idle_call+0x9c/0x140)
> [] (cpuidle_idle_call+0x9c/0x140) from [] (arch_cpu_idle+0x8/0x38)
> [] (arch_cpu_idle+0x8/0x38) from [] (cpu_startup_entry+0x4c/0x114)
> [] (cpu_startup_entry+0x4c/0x114) from [] (start_kernel+0x324/0x37c)
> Code: 0a000043 e3a03000 e30f2f3e e34f3818 (e5832608) 
> ---[ end trace 617b9e1a4ff91d2f ]---
> Kernel panic - not syncing: Attempted to kill the idle task!

1) samsung-mach-exynos kernel (from your pull request) doesn't have neither
   exynos5440_defconfig nor EXYNOS5440 enabled in exynos_defconfig so could
   you please tell me what kernel version and kernel config are you using to
   get the above panic?

   Could you also see what does exynos4_enter_lowpower+0x18 map to in your
   source code?

2) dev->state_count is used only for managing sysfs entries (and clearing
   dev->states_usage) in the cpuidle core.

$ git grep state_count drivers/cpuidle/

drivers/cpuidle/cpuidle-calxeda.c:      .state_count = 2,
drivers/cpuidle/cpuidle-kirkwood.c:     .state_count = KIRKWOOD_MAX_STATES,
drivers/cpuidle/cpuidle-zynq.c: .state_count = ZYNQ_MAX_STATES,
drivers/cpuidle/cpuidle.c:      for (i = drv->state_count - 1; i >= CPUIDLE_DRIVER_STATE_START; i--)
drivers/cpuidle/cpuidle.c:      if (!dev->state_count)
drivers/cpuidle/cpuidle.c:              dev->state_count = drv->state_count;
drivers/cpuidle/cpuidle.c:      for (i = 0; i < dev->state_count; i++) {
drivers/cpuidle/driver.c:       for (i = drv->state_count - 1; i >= 0 ; i--) {
drivers/cpuidle/driver.c:       if (!drv || !drv->state_count)
drivers/cpuidle/governors/ladder.c:     if (last_idx < drv->state_count - 1 &&
drivers/cpuidle/governors/ladder.c:     for (i = 0; i < drv->state_count; i++) {
drivers/cpuidle/governors/ladder.c:             if (i < drv->state_count - 1)
drivers/cpuidle/governors/menu.c:       for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
drivers/cpuidle/sysfs.c:        for (i = 0; i < device->state_count; i++) {
drivers/cpuidle/sysfs.c:        for (i = 0; i < device->state_count; i++)

With the current code I fail to see how it is possible that dev->state_count
smaller than drv->state_count affects anything besides sysfs cpuidle entries
in the practice.

IOW I worry that the current patch may be just masking some other issue.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
