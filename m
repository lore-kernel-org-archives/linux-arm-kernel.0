From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 15:47:23 -0700
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120504223933.GX5613@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
Message-ID: <20120504224723.GY5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120504 15:43]:
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -400,7 +400,8 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
> >  
> >  /* OMAP3/4 non-CORE DPLL clkops */
> >  
> > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> > +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
> > +				defined(CONFIG_ARCH_OMAP5)
> >  
> 
> How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> Then this becomes just:
> 
> #ifdef CONFIG_SOC_OMAP3PLUS
> 
> > --- a/arch/arm/mach-omap2/cminst44xx.h
> > +++ b/arch/arm/mach-omap2/cminst44xx.h
> > @@ -19,7 +19,7 @@ extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
> >  
> >  extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
> >  
> > -# ifdef CONFIG_ARCH_OMAP4
> > +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
> >  extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
> >  					 u16 clkctrl_offs);
> 
> And this would be:
> 
> #ifdef CONFIG_SOC_OMAP4PLUS

Something like this might do the trick (untested):

--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -28,10 +28,14 @@ config ARCH_OMAP2
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
 
+bool SOC_OMAP3PLUS
+	bool
+
 config ARCH_OMAP3
 	bool "TI OMAP3"
 	depends on ARCH_OMAP2PLUS
 	default y
+	select SOC_OMAP3PLUS
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARCH_HAS_OPP
@@ -40,10 +44,15 @@ config ARCH_OMAP3
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
 
+bool SOC_OMAP4PLUS
+	bool
+
 config ARCH_OMAP4
 	bool "TI OMAP4"
 	default y
 	depends on ARCH_OMAP2PLUS
+	select SOC_OMAP3PLUS
+	select SOC_OMAP4PLUS
 	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
