From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Oct 2012 20:57:20 +0200
Subject: [PATCH 2/4] ARM: EXYNOS: Kconfig: Sort out dependencies between
 options
In-Reply-To: <01d401cdb11a$e4bcfff0$ae36ffd0$%kim@samsung.com>
References: <1349701345-2681-1-git-send-email-t.figa@samsung.com>
 <1349701345-2681-3-git-send-email-t.figa@samsung.com>
 <01d401cdb11a$e4bcfff0$ae36ffd0$%kim@samsung.com>
Message-ID: <1691918.APMT3BR0tg@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of October 2012 21:35:32 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > This patch modifies the dependencies between Exynos-related Kconfig
> > options to represent the real dependencies between code units more
> > closely.
> > 
> > Originally it was possible to enable ARCH_EXYNOS{4,5} without any
> > SOC_EXYNOS_{4,5}.* enabled, which could end with compilation or link
> > errors. Now ARCH_EXYNOS{4,5} is only selected when there is a
> > SOC_EXYNOS_{4,5}.* enabled, which requires it.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/Kconfig | 15 ++++++---------
> >  drivers/devfreq/Kconfig      |  2 +-
> >  drivers/mmc/host/sdhci-s3c.c |  2 +-
> >  drivers/tty/serial/samsung.c |  3 +--
> >  4 files changed, 9 insertions(+), 13 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig
> > b/arch/arm/mach-exynos/Kconfig index 05dcd07..9f91892 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -12,15 +12,14 @@ if ARCH_EXYNOS
> > 
> >  menu "SAMSUNG EXYNOS SoCs Support"
> >  
> >  config ARCH_EXYNOS4
> > 
> > -	bool "SAMSUNG EXYNOS4"
> > -	default y
> > +	def_bool n
> > 
> >  	select HAVE_SMP
> >  	select MIGHT_HAVE_CACHE_L2X0
> >  	help
> >  	
> >  	  Samsung EXYNOS4 SoCs based systems
> >  
> >  config ARCH_EXYNOS5
> > 
> > -	bool "SAMSUNG EXYNOS5"
> > +	def_bool n
> > 
> >  	select HAVE_SMP
> >  	help
> >  	
> >  	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
> > 
> > @@ -30,7 +29,7 @@ comment "EXYNOS SoCs"
> > 
> >  config SOC_EXYNOS4210
> >  
> >  	bool "SAMSUNG EXYNOS4210"
> >  	default y
> > 
> > -	depends on ARCH_EXYNOS4
> > +	select ARCH_EXYNOS4
> > 
> >  	select SAMSUNG_DMADEV
> >  	select ARM_CPU_SUSPEND if PM
> >  	select S5P_PM if PM
> > 
> > @@ -42,7 +41,7 @@ config SOC_EXYNOS4210
> > 
> >  config SOC_EXYNOS4212
> >  
> >  	bool "SAMSUNG EXYNOS4212"
> >  	default y
> > 
> > -	depends on ARCH_EXYNOS4
> > +	select ARCH_EXYNOS4
> > 
> >  	select SAMSUNG_DMADEV
> >  	select S5P_PM if PM
> >  	select S5P_SLEEP if PM
> > 
> > @@ -51,6 +50,7 @@ config SOC_EXYNOS4212
> > 
> >  config SOC_EXYNOS4412
> >  
> >  	bool "SAMSUNG EXYNOS4412"
> > 
> > +	select ARCH_EXYNOS4
> > 
> >  	default y
> >  	depends on ARCH_EXYNOS4
> >  	select SAMSUNG_DMADEV
> > 
> > @@ -60,7 +60,7 @@ config SOC_EXYNOS4412
> > 
> >  config SOC_EXYNOS5250
> >  
> >  	bool "SAMSUNG EXYNOS5250"
> >  	default y
> > 
> > -	depends on ARCH_EXYNOS5
> > +	select ARCH_EXYNOS5
> > 
> >  	select SAMSUNG_DMADEV
> >  	select S5P_PM if PM
> >  	select S5P_SLEEP if PM
> > 
> > @@ -176,8 +176,6 @@ config EXYNOS_SETUP_SPI
> 
> Basically, I agree with your approach. Its CONFIG_ARCH_EXYNOSx depends
> on selecting own SOC.
> 
> BTW, I'm thinking, which one selecting is better to us board? Or SoC?...

IMHO board selecting SoC selecting arch seems to represent reality the 
best, because a board is based on particular SoC, which is based on 
particular arch (family).

> >  # machine support
> > 
> > -if ARCH_EXYNOS4
> > -
> 
> Well, according to removing above, we can select following exynos4210
> boards on other stuff. Of course, when select board, regarding soc is
> selected though. So I'm thinking I said as above.

Sorry, I'm not sure what you mean.

> >  comment "EXYNOS4210 Boards"
> >  
> >  config MACH_SMDKC210
> > 
> > @@ -397,7 +395,6 @@ config MACH_SMDK4412
> > 
> >  	select MACH_SMDK4212
> >  	help
> >  	
> >  	  Machine support for Samsung SMDK4412
> > 
> > -endif
> > 
> >  comment "Flattened Device Tree based board for EXYNOS SoCs"
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 8545069..c559609 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -67,7 +67,7 @@ comment "DEVFREQ Drivers"
> > 
> >  config ARM_EXYNOS4_BUS_DEVFREQ
> >  
> >  	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
> > 
> > -	depends on SOC_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412
> > +	depends on ARCH_EXYNOS4
> 
> I don't think so, because it depends on SoC not architecture. In
> addition, we don't know ARM_EXYNOS4_BUS_DEVFREQ is available on
> upcoming exynos4...

Hmm, good point, but wouldn't this apply as well to any Makefile option 
using CONFIG_ARCH_EXYNOS4 at the moment? (e.g. clock-exynos4.o, dev-
audio.o, etc.)

Best regards,
Tomasz Figa
