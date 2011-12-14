From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Dec 2011 11:36:55 +0000
Subject: [PATCH v4 2/5] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <20111213201137.GA31437@huya.qualcomm.com>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
 <1323798993-8727-3-git-send-email-dave.martin@linaro.org>
 <20111213201137.GA31437@huya.qualcomm.com>
Message-ID: <20111214113655.GA2568@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 12:11:37PM -0800, David Brown wrote:
> On Tue, Dec 13, 2011 at 05:56:30PM +0000, Dave Martin wrote:
> > Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> > bothersome to maintain and likely to lead to merge conflicts.
> 
> > diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
> > index ebde97f..e6beaff 100644
> > --- a/arch/arm/mach-msm/Kconfig
> > +++ b/arch/arm/mach-msm/Kconfig
> > @@ -67,6 +67,7 @@ config MSM_SOC_REV_A
> >  	bool
> >  config  ARCH_MSM_SCORPIONMP
> >  	bool
> > +	select HAVE_SMP
> >  
> >  config  ARCH_MSM_ARM11
> >  	bool
> 
> The ARCH_MSM_SCORPIONMP config's only purpose was to enable SMP higher
> up.  We might as well eliminate ARCH_MSM_SCORPIONMP entirely, and just
> select HAVE_SMP in ARCH_MSM8X60 and ARCH_MSM8960.

First and foremost, I'm just refactoring with this series.  I've
included other trivial changes suggested by other people where the
effect is clear and straightforward.


Removing ARCH_MSM_SCORPIONMP is not quite trivial, though:

arch/arm/mach-msm/timer.c:
#ifdef CONFIG_ARCH_MSM_SCORPIONMP
	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
#endif

This suggests that ARCH_MSM_SCORPIONMP may mean more than just
"HAVE_SMP".

Also,

arch/arm/Kconfig:config HAVE_SMP
	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP

...and

arch/arm/Kconfig:config LOCAL_TIMERS
	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)


Now, we could list the affected MSM boards longhand in those
dependencies, but that's just reintroducing some of the exact kind of
kconfig clunkiness I'm trying to remove: those lists are obviously
liable to grow over time.

Configs like this also look like they may be incompatible with the
single kernel binary goal: if any of the boards supported by the kernel
have the ARM SCU and/or TWD unit, surely we should be able to enable the
support in the kernel?


If you can see a nice way to resolve those issues though, feel free to
propose a patch and I'll append it to the series.

> 
> Also, be sure to run ./scripts/get_maintainer.pl on your patch so that
> the proper people get addressed by the message.  Otherwise, people
> might miss patches.

Argh, my metadata for that series was mangled -- I put together a long
CC list based on but it never got used :(

Thanks for highlighting that... I'll repost.  This probably explains why
I didn't get much feedback.

Cheers
---Dave
