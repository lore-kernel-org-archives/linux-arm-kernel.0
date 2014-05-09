From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 09 May 2014 17:29:16 +0200
Subject: [PATCH V5 18/20] ARM: exynos: cpuidle: Pass the AFTR callback to
 the platform_data
In-Reply-To: <536CC3C6.6070804@samsung.com>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
 <201405091256.54755.arnd@arndb.de> <536CC3C6.6070804@samsung.com>
Message-ID: <4219390.KDI5Wbxd3T@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Friday, May 09, 2014 02:02:14 PM Tomasz Figa wrote:
> Hi Arnd,
> 
> On 09.05.2014 12:56, Arnd Bergmann wrote:
> > On Friday 11 April 2014, Daniel Lezcano wrote:
> >> No more dependency on the arch code. The platform_data field is used to set the
> >> PM callback as the other cpuidle drivers.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> >> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > 
> > This has just shown up in linux-next and broken randconfig builds.

Could you please give some more details about these issues?

If this is a build breakage for CONFIG_PM_SLEEP=n && CONFIG_CPU_IDLE=y
configuration then this is not a new problem introduced by the current
patchset (please see below).

> >> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> >> index fe8dac8..d22f0e4 100644
> >> --- a/arch/arm/mach-exynos/exynos.c
> >> +++ b/arch/arm/mach-exynos/exynos.c
> >> @@ -221,8 +221,9 @@ void exynos_restart(enum reboot_mode mode, const char *cmd)
> >>  }
> >>  
> >>  static struct platform_device exynos_cpuidle = {
> >> -       .name           = "exynos_cpuidle",
> >> -       .id             = -1,
> >> +       .name              = "exynos_cpuidle",
> >> +       .dev.platform_data = exynos_enter_aftr,
> >> +       .id                = -1,
> >>  };
> >>  
> > 
> > This is wrong on many levels, can we please do this properly?
> > 
> > * The exynos_enter_aftr function is compiled conditionally, so you can't just
> >   reference it from generic code, or you get a link error.
> 
> +1

Even without Daniel's patchset we are getting a link error for
CONFIG_PM_SLEEP=n && CONFIG_CPU_IDLE=y configuration.

In arch/arm/mach-exynos/Makefile we have:

...
obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
...
obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
...

and since cpuidle.c is referencing exynos_cpu_resume() from sleep.S
the build results in:

arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO: return_address should use unwind tables" [-Wcpp]
arch/arm/mach-exynos/built-in.o: In function `exynos4_enter_core0_aftr':
/home/bzolnier/linux-sprc/arch/arm/mach-exynos/cpuidle.c:141: undefined reference to `cpu_suspend'
arch/arm/mach-exynos/built-in.o: In function `exynos4_enter_lowpower':
/home/bzolnier/linux-sprc/arch/arm/mach-exynos/cpuidle.c:176: undefined reference to `exynos_cpu_resume'
make: *** [vmlinux] Error 1

linkage errors.

[ The other error for the current code is for cpu_suspend() which is
  also (indirectly) dependent on CONFIG_PM_SLEEP. ]

> > * 'static struct platform_device ...' has been deprecated for at least a decade,
> >   stop doing that. For any platform devices that get registered, there is
> >   platform_device_register_simple().
> 
> +0.5
> 
> The missing 0.5 is because you can't pass platform data using
> platform_device_register_simple(). There is
> platform_device_register_resndata(), though.

Agreed but this can be fixed trivially (even in in the incremental
patch).

> > * There shouldn't need to be a platform_device to start with, this should all
> >   come from DT. We can't do this on arm64 anyway, so any code that may be
> >   shared between arm32 and arm64 should have proper abstractions.
> 
> -1
> 
> Exynos cpuidle is not a device on the SoC, so I don't think there is any
> way to represent it in DT. The only thing I could see this is matching
> root node with a central SoC driver that instantiates specific
> subdevices, such as cpufreq and cpuidle, but I don't see any available
> infrastructure for this.

Moreover this code is not going to be shared between arm32 and arm64 in
the near future (if ever) and doing things by using platform device
has such benefit that the current code can be changed without a problem
when the need arise.  With DT there is no such flexibility and it also
takes some time to design DT bindings properly.

The build problems should be fixed but if indeed they are not a new ones
then the patchset should be brought back (Kukjin has dropped it entirely
for now).  This is important work which serves as a base for more cpuidle
improvements from both Daniel and me therefore it would be great to have
it merged in v3.16 and not delay it unnecessarily.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
