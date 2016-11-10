From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Nov 2016 15:07:06 +0100
Subject: [PATCH v3 1/2] ARM: EXYNOS: Remove static mapping of SCU SFR
In-Reply-To: <a43af947-6002-bc65-f73b-02d57a78d6cb@samsung.com>
References: <1478693755-11953-1-git-send-email-pankaj.dubey@samsung.com>
 <5066943.nydi3GQ3KP@wuerfel>
 <a43af947-6002-bc65-f73b-02d57a78d6cb@samsung.com>
Message-ID: <3268366.06J2EThgp2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 10, 2016 6:07:54 PM CET pankaj.dubey wrote:
> On Thursday 10 November 2016 05:24 PM, Arnd Bergmann wrote:
> > On Wednesday, November 9, 2016 5:45:54 PM CET Pankaj Dubey wrote:
> 
> Sorry, I missed this part and did not check with CONFIG_SMP disabled.
> 
> > arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
> > pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to `exynos_scu_enable'
> > arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
> > suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to `exynos_scu_enable'
> > 
> > Please fix. I have applied a patch locally (see below), but don't know
> > if that is the best solution. As we seem to duplicate that code across
> > several platforms, I wonder why we don't just put it into the core scu
> > implementation.
> > 
> 
> When I checked scu_enable declaration it is defined in
> arch/arm/include/asm/smp_scu.h as:
> 
> #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
> void scu_enable(void __iomem *scu_base);
> #else
> static inline void scu_enable(void __iomem *scu_base) {}
> #endif
> 
> So if CONFIG_SMP is disable then there is no sense of exynos_scu_enable
> as well. So wow about using below patch?
> 
> --------------------------------------------------------
> 
> Subject: [PATCH] ARM: exynos: fix build fail due to exynos_scu_enable
> 
> Build failed if we disable CONFIG_SMP as shown below:
> 
> arch/arm/mach-exynos/pm.o: In function `exynos_enter_aftr':
> pm.c:(.text.exynos_enter_aftr+0xec): undefined reference to
> `exynos_scu_enable'
> arch/arm/mach-exynos/suspend.o: In function `exynos_pm_resume':
> suspend.c:(.text.exynos_pm_resume+0x78): undefined reference to
> `exynos_scu_enable'
> 
> Since scu_enable is defined only in case CONFIG_SMP and CONFIG_HAVE_ARM_SCU
> lets move exynos_scu_enable also under these two macros.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
> index fb12d11..03fdb79 100644
> --- a/arch/arm/mach-exynos/common.h
> +++ b/arch/arm/mach-exynos/common.h
> @@ -156,7 +156,12 @@ extern void exynos_cpu_restore_register(void);
>  extern void exynos_pm_central_suspend(void);
>  extern int exynos_pm_central_resume(void);
>  extern void exynos_enter_aftr(void);
> +#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
>  extern int exynos_scu_enable(void);
> +#else
> +static inline void exynos_scu_enable(void) {}
> +#endif

Yes, I think that would work, but you can drop the CONFIG_HAVE_ARM_SCU
check because of

menuconfig ARCH_EXYNOS
        ....
        select HAVE_ARM_SCU if SMP
        ...

> Of-course your idea to move it in core SCU file is also good that we
> lots of duplication in different architecture can be avoided.
> 
> In that case I can think of following patch:
> 
> [PATCH] ARM: scu: use SCU device node to enable SCU
> 
> Many platforms are duplicating code for enabling SCU, lets add
> common code to enable SCU using SCU device node so the duplication in
> each platform can be avoided.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

That looks good too. I also checked the other callers of
scu_enable(), and we have only three classes here:

a) of_iomap: berlin, exynos, mvebu, realview, rockchip, socfpga, sti, ux500, vexpress
b) ioremap(scu_a9_get_base()): bcm63xx, bcm, hisi, zx
c) iotable_init, scu_a9_get_base(): imx, omap4, tegra, zynq
d) ioremap(constant): shmobile, spear13xx

I checked that none of the ones in category c) actually use the address early,
so we can easily change four into b).

I also think that we need to keep both a) and b) because the output of
scu_a9_get_base() might be incorrect in some chips, and not all dtb
files have an SCU in them.

If we make the common SCU setup check DT first and then fall back to
scu_a9_get_base(), that means we have covered almost all cases, unless
I'm missing a problem with that approach. It would be nice to
check spear13xx and the Cortex-A9 based mach-shmobile variants
(emev2, r8a7779, and sh73a0) to see if they could also share
that implementation.

	Arnd
