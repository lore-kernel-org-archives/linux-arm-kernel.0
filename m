From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Oct 2012 21:28:42 +0200
Subject: [PATCH 4/4] ARM: EXYNOS: Kconfig: Remove dependencies on
 particular SoCs from DT machines
In-Reply-To: <020a01cdb122$2d888ae0$8899a0a0$%kim@samsung.com>
References: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
 <1349701345-2681-5-git-send-email-t.figa@samsung.com>
 <020a01cdb122$2d888ae0$8899a0a0$%kim@samsung.com>
Message-ID: <16893010.3V1YKccvQL@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of October 2012 22:27:41 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > MACH_EXYNOS{4,5}_DT are used for whole SoC lines, so they should
> > depend
> > on ARCH_EXYNOS{4,5} rather than on particular SoCs.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/Kconfig | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig
> > b/arch/arm/mach-exynos/Kconfig index 6ea95f0..2e82ce7 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -404,7 +404,6 @@ comment "Flattened Device Tree based board for
> > EXYNOS SoCs"
> > 
> >  config MACH_EXYNOS4_DT
> >  
> >  	bool "Samsung Exynos4 Machine using device tree"
> >  	depends on ARCH_EXYNOS4
> > 
> > -	select SOC_EXYNOS4210
> > 
> >  	select USE_OF
> >  	select ARM_AMBA
> >  	select HAVE_SAMSUNG_KEYPAD if INPUT_KEYBOARD
> > 
> > @@ -419,7 +418,6 @@ config MACH_EXYNOS4_DT
> > 
> >  config MACH_EXYNOS5_DT
> >  
> >  	bool "SAMSUNG EXYNOS5 Machine using device tree"
> >  	depends on ARCH_EXYNOS5
> > 
> > -	select SOC_EXYNOS5250
> > 
> >  	select USE_OF
> >  	select ARM_AMBA
> >  	help
> > 
> > --
> > 1.7.12
> 
> Hmm...your comment is correct, but we need to think again its selecting
> order, between ARCH name, SoC and board. In addition, in case of
> MACH_XXX_DT depending on SoC is rather to be supposed...

With device tree the situation is a bit different than with boards, 
because mach-exynos4-dt does not limit the scope to a single SoC, but 
rather to the whole Exynos4 arch/family.

Making MACH_EXYNOS4_DT select all SOC_EXYNOS4* would remove the ability to 
enable/disable support for particular Exynos4 SoCs, so in my opinion it is 
not a good option.

Selecting ARCH_EXYNOS4 is not enough for the kernel to work, because at 
least one SoC must be enabled.

So I think that letting the user select the SoCs he want to be supported 
and making MACH_EXYNOS4_DT depend on at least one of Exynos4 SoCs (which 
is implied by ARCH_EXYNOS4 enabled) is the most reasonable variant.

Btw. Maybe this could go in pair with something like

 static char const *exynos4_dt_compat[] __initdata = {
+#ifdef CONFIG_SOC_EXYNOS4210
 	"samsung,exynos4210",
+#endif
/* and so on for any Exynos4 SoCs added in future... */
 	NULL
 };

to make the kernel reject booting DT-enabled boards with unsupported SoCs. 
What do you think?

Best regards,
Tomasz Figa
