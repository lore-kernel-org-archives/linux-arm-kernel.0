From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Nov 2014 20:22:54 +0100
Subject: [PATCH v3] ARM: fix multiplatform allmodcompile
In-Reply-To: <1415641951-19753-1-git-send-email-linus.walleij@linaro.org>
References: <1415641951-19753-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2103753.zV3InADiDC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 November 2014 18:52:31 Linus Walleij wrote:
> 
> "ARM: integrator: make the Integrator multiplatform"
> broke allmodconfig like this:
> 
> >> arch/arm/include/asm/cmpxchg.h:114:2: error: #error
> "SMP is not supported on this platform"
> (etc)
> 
> This is due to the fact that as we turned on multiplatform
> for the Integrator, this enabled a lot of non-applicable
> CPU's to be selected for its multiplatform images, due to
> a lot of "depends on ARCH_INTEGRATOR" restrictions in
> arch/arm/mm/Kconfig for the different ARM CPU types.
> 
> Fix this by restricting the CPU selections to respective
> multiplatform config, which now becomes a subset of the
> possible Integrator configurations, or alternatively the
> non-multiplatform config plus ARCH_INTEGRATOR, i.e.:
> 
> if (!ARCH_MULTIPLATFORM || ARCH_MULTI_Vx) &&
>    (ARCH_INTEGRATOR || ARCH_FOO ...)
> 
> Since the Integrator has been converted to multiplatform,
> this will often take the short form:
> 
> if (ARCH_MULTI_Vx && ARCH_INTEGRATOR)
> 
> If no other non-multiplatform platforms are elegible.
> 
> Reported-by: Build bot for Mark Brown <broonie@kernel.org>
> Reported-by: Kbuild test robot <fengguang.wu@intel.com>
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next branch, thanks!

I still have one small question:

> # ARMv7
> config CPU_V7
-       bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB ||MACH_REALVIEW_PBX
>+       bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
>        select CPU_32v6K
>        select CPU_32v7
>        select CPU_ABRT_EV7


This lists ARMv7 as available for integrator, but in your platform Kconfig
you have

config ARCH_INTEGRATOR
        bool "ARM Ltd. Integrator family" if (ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6)

which doesn't list ARMv7. Do you know which one is correct? According the the
official documentation for Integrator, no ARMv7 tile exists, but the original
commit that added ARMv7 had 'depends on ARCH_INTEGRATOR', so I assume that
Catalin had at least one specimen at the time. Do any of those still exist?

	Arnd
