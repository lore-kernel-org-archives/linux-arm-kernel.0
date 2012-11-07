From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Nov 2012 16:06:12 -0700
Subject: struct sys_timer .suspend/.resume ignored for ARCH_SA1100/ARCH_PXA?
Message-ID: <509AE964.8070009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, Kevin,

In commit 9e4559d "[ARM] 4258/2: Support for dynticks in idle loop" in
2007, Kevin applied the following change:

> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c

> -#ifdef CONFIG_PM
> +#if defined(CONFIG_PM) && !defined(CONFIG_GENERIC_CLOCKEVENTS)
>  static int timer_suspend(struct sys_device *dev, pm_message_t state)

This means that for any architecture that enables GENERIC_CLOCKEVENTS,
the .suspend/.resume fields of struct sys_timer will be ignored, since
timer_suspend()/timer_resume() won't be filled into
arch/arm/kernel/time.c's struct syscore_ops timer_syscore_ops.

Later, in commit 3e238be "[ARM] sa1100: add clock event support" in
2008, Russell modified ARCH_SA1100 to select GENERIC_CLOCKEVENTS. I
believe this means that sa1100_timer_suspend()/resume() haven't been
used since.

A similar issue exists for ARCH_PXA.

Should sa1100_timer_suspend(), sa1100_timer_resume(),
pxa_timer_suspend(), pxa_timer_suspend() simply be deleted since they
are dead code, or should they be revived somehow; is the ifdef from
Kevin's change incorrect?


As background, I'm working on a patch series that will remove all fields
from struct sys_timer except for .init, and will then replace the ARM
machine descriptor's .timer struct pointer with a .init_timer function
pointer. This will allow machines, on an opt-in basis, to call into a
central function in drivers/clocksource to initialize the required
timer, as determined by searching device tree for a known device type,
in much the same way as has been proposed to use a single implementation
for for the machine descriptor's .init_irq. As part of this, I've been
looking at moving any use of struct sys_timer .suspend/.resume into e.g.
struct clock_event_device .suspend/.resume, and found this issue.

Thanks for any hints.
