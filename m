From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 30 Apr 2014 11:24:18 +0100
Subject: [PATCH v3 5/6] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAM4voa=Po9r5MpxyjQKcYhyES1UjfVaqbP_PnKCbsw5LtEkpZg@mail.gmail.com>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
 <1398528348-21214-6-git-send-email-a.kesavan@samsung.com>
 <20140428174456.GE31782@e102568-lin.cambridge.arm.com>
 <CAM4voa=mhcZO9v7nDdrcz+T8RVN-Av3eERVErCX52k1ftUcKcQ@mail.gmail.com>
 <alpine.LFD.2.11.1404291435450.980@knanqh.ubzr>
 <CAM4voa=Po9r5MpxyjQKcYhyES1UjfVaqbP_PnKCbsw5LtEkpZg@mail.gmail.com>
Message-ID: <20140430102418.GB3986@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 04:01:24AM +0100, Abhilash Kesavan wrote:
> Hi Nicolas,
> 
> On Wed, Apr 30, 2014 at 12:19 AM, Nicolas Pitre
> <nicolas.pitre@linaro.org> wrote:
> > On Tue, 29 Apr 2014, Abhilash Kesavan wrote:
> >
> >> >> +/*
> >> >> + * Enable cluster-level coherency, in preparation for turning on the MMU.
> >> >> + */
> >> >> +static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
> >> >> +{
> >> >> +       asm volatile ("\n"
> >> >> +       "cmp    r0, #1\n"
> >> >> +       "bxne   lr\n"
> >> >> +       "b      cci_enable_port_for_self");
> >> >> +}
> >> >
> >> > How many times are we going to duplicate this function before we decide
> >> > to move it to a common header ?
> >> I see this being used in arch/arm/mach-vexpress/tc2_pm.c (where I
> >> copied it from for exynos) and arch/arm/mach-vexpress/dcscb.c. A
> >> common function named "mcpm_default_power_up_setup" in the mcpm header
> >> would be acceptable ?
> >
> > Not necessarily.
> >
> > First of all, this can't be a static inline as we need a pointer to it.
> > And moving this to a header would create multiple instances of the same
> > function in a multiplatform build for example.
> >
> > Furthermore, this can't be called "default_power_up_setup" as this is
> > specific to systems with a CCI.

On some SoCs the argument to cmp might not be #1, or the constant required
might not even be the same on all CPUs.  Some SoCs might need to do other
setup too, such as invalidating a cluster-level cache that doesn't power
up into a clean state.

So, the above function is going to be common but it's not really generic.

For such a tiny function, I agree that factoring it may not be that
beneficial.

Cheers
---Dave
