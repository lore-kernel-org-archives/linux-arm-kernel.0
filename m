From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Oct 2012 21:00:16 +0200
Subject: [PATCH 3/4] ARM: EXYNOS: Kconfig: Group EXYNOS{4212,
 4412} into EXYNOS4X12
In-Reply-To: <01d501cdb11b$ce824690$6b86d3b0$%kim@samsung.com>
References: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
 <1349701345-2681-4-git-send-email-t.figa@samsung.com>
 <01d501cdb11b$ce824690$6b86d3b0$%kim@samsung.com>
Message-ID: <1764393.vamHTeItqs@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of October 2012 21:42:04 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > This patch adds CONFIG_EXYNOS4X12, which is automatically selected
> > whenever there is at least one SoC from Exynos4x12 line enabled. All
> > the shared dependencies of EXYNOS{4212,4412} are moved to this new
> > option.
> > 
> > This fixes build with Exynos4412 enabled and Exynos4212 and Exynos4210
> > disabled and also allows to simplify conditional compilation in
> > several
> > places.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/Kconfig  | 15 +++++++++------
> >  arch/arm/mach-exynos/Makefile |  2 +-
> >  arch/arm/mach-exynos/common.h |  2 +-
> >  drivers/cpufreq/Kconfig.arm   |  2 +-
> >  4 files changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig
> > b/arch/arm/mach-exynos/Kconfig index 9f91892..6ea95f0 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -38,22 +38,25 @@ config SOC_EXYNOS4210
> > 
> >  	help
> >  	
> >  	  Enable EXYNOS4210 CPU support
> > 
> > -config SOC_EXYNOS4212
> > -	bool "SAMSUNG EXYNOS4212"
> > -	default y
> > +config SOC_EXYNOS4X12
> > +	def_bool n
> > 
> >  	select ARCH_EXYNOS4
> >  	select SAMSUNG_DMADEV
> > 
> > +	select ARM_CPU_SUSPEND if PM
> > 
> >  	select S5P_PM if PM
> >  	select S5P_SLEEP if PM
> > 
> > +
> > +config SOC_EXYNOS4212
> > +	bool "SAMSUNG EXYNOS4212"
> > +	select SOC_EXYNOS4X12
> > +	default y
> > 
> >  	help
> >  	
> >  	  Enable EXYNOS4212 SoC support
> >  
> >  config SOC_EXYNOS4412
> >  
> >  	bool "SAMSUNG EXYNOS4412"
> > 
> > -	select ARCH_EXYNOS4
> > +	select SOC_EXYNOS4X12
> > 
> >  	default y
> > 
> > -	depends on ARCH_EXYNOS4
> > -	select SAMSUNG_DMADEV
> > 
> >  	help
> >  	
> >  	  Enable EXYNOS4412 SoC support
> > 
> > diff --git a/arch/arm/mach-exynos/Makefile
> > b/arch/arm/mach-exynos/Makefile index ceeb8c9..f88fcb6 100644
> > --- a/arch/arm/mach-exynos/Makefile
> > +++ b/arch/arm/mach-exynos/Makefile
> > @@ -16,7 +16,7 @@ obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
> > 
> >  obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
> >  obj-$(CONFIG_ARCH_EXYNOS5)	+= clock-exynos5.o
> >  obj-$(CONFIG_SOC_EXYNOS4210)	+= clock-exynos4210.o
> > 
> > -obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
> > +obj-$(CONFIG_SOC_EXYNOS4X12)	+= clock-exynos4212.o
> > 
> >  obj-$(CONFIG_PM)		+= pm.o
> >  obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
> > 
> > diff --git a/arch/arm/mach-exynos/common.h
> > b/arch/arm/mach-exynos/common.h index 054c786..a8cb3e6 100644
> > --- a/arch/arm/mach-exynos/common.h
> > +++ b/arch/arm/mach-exynos/common.h
> > @@ -52,7 +52,7 @@ void exynos4210_register_clocks(void);
> > 
> >  #define exynos4210_register_clocks()
> >  #endif
> > 
> > -#ifdef CONFIG_SOC_EXYNOS4212
> > +#ifdef CONFIG_SOC_EXYNOS4X12
> > 
> >  void exynos4212_register_clocks(void);
> >  
> >  #else
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index ca4ede3..d0ff91a 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -66,7 +66,7 @@ config ARM_EXYNOS4210_CPUFREQ
> > 
> >  	  SoC (S5PV310 or S5PC210).
> >  
> >  config ARM_EXYNOS4X12_CPUFREQ
> > 
> > -	def_bool (SOC_EXYNOS4212 || SOC_EXYNOS4412)
> > +	def_bool SOC_EXYNOS4X12
> > 
> >  	help
> >  	
> >  	  This adds the CPUFreq driver for Samsung EXYNOS4X12
> >  	  SoC (EXYNOS4212 or EXYNOS4412).
> > 
> > --
> > 1.7.12
> 
> Well, do we _really_ need to define CONFIG_SOC_EXYNOS4X12 for supporting
> common part of exynos4212 and exynos4412? In my opinion, it will cause
> confusion rather than reducing code size. Let's just use its own name
> for SoC.

There are files that must be compiled if any of these SoCs is enabled, for 
example clock-exynos4212.o (it contains clocks for both of them regardless 
of the misleading name).

This common Kconfig entry would be used in Makefiles for such cases.

Best regards,
Tomasz Figa
