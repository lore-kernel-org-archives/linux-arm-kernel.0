From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 28 Sep 2011 15:43:09 +0800
Subject: [PATCH v3 4/6] arm/imx6q: add smp and cpu hotplug support
In-Reply-To: <20110926110634.GR31404@pengutronix.de>
References: <1317021651-17359-1-git-send-email-shawn.guo@linaro.org>
	<1317021651-17359-5-git-send-email-shawn.guo@linaro.org>
	<20110926110634.GR31404@pengutronix.de>
Message-ID: <20110928074307.GA18785@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 01:06:34PM +0200, Sascha Hauer wrote:
> On Mon, Sep 26, 2011 at 03:20:49PM +0800, Shawn Guo wrote:
> > It adds smp and cpu hotplug support for imx6q.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-imx/Kconfig               |    1 +
> >  arch/arm/mach-imx/Makefile              |    4 ++
> >  arch/arm/mach-imx/head-v7.S             |   71 ++++++++++++++++++++++++++
> >  arch/arm/mach-imx/hotplug.c             |   44 ++++++++++++++++
> >  arch/arm/mach-imx/localtimer.c          |   35 +++++++++++++
> >  arch/arm/mach-imx/platsmp.c             |   85 +++++++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/common.h |    5 ++
> >  7 files changed, 245 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-imx/head-v7.S
> >  create mode 100644 arch/arm/mach-imx/hotplug.c
> >  create mode 100644 arch/arm/mach-imx/localtimer.c
> >  create mode 100644 arch/arm/mach-imx/platsmp.c
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index af73b3e..6ec758d 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -623,6 +623,7 @@ config SOC_IMX6Q
> >  	bool "i.MX6 Quad support"
> >  	select ARM_GIC
> >  	select CPU_V7
> > +	select HAVE_ARM_SCU
> >  	select HAVE_IMX_GPC
> >  	select HAVE_IMX_MMDC
> >  	select HAVE_IMX_SRC
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index 8c21fda..d46b2e7 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -66,4 +66,8 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
> >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> >  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
> >  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> > +obj-$(CONFIG_CPU_V7) += head-v7.o
> 
> Can we have a
> 
> AFLAGS_head-v7.o :=-Wa,-march=armv7-a
> 
> here?
> 
> Then you only have to adjust some Kconfig variables and can compile
> i.MX3 and i.MX6 together. I just gave it a test and it works on i.MX3, I
> don't have a i.MX6 platform to test on though.
> 
> The following patch could be a starting point. I merged the imx-features
> branch into it so it probably won't apply cleanly on your series.
> 
> 8<----------------------------------------
> 
> 
> From 010a61373355e6cba6856272e3fd8e22e8ee3ccd Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Mon, 26 Sep 2011 13:04:08 +0200
> Subject: [PATCH] merge i.MX3 and i.MX6
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/Makefile          |    3 +--
>  arch/arm/mach-imx/Kconfig  |    7 +++----
>  arch/arm/mach-imx/Makefile |    1 +
>  arch/arm/mm/Kconfig        |    4 ++--
>  arch/arm/plat-mxc/Kconfig  |   14 ++++++--------
>  5 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 89be85d..42ab385 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -155,9 +155,8 @@ machine-$(CONFIG_ARCH_MMP)		:= mmp
>  machine-$(CONFIG_ARCH_MSM)		:= msm
>  machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
>  machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
> -machine-$(CONFIG_ARCH_MX3)		:= imx
> +machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
>  machine-$(CONFIG_ARCH_MX5)		:= mx5
> -machine-$(CONFIG_ARCH_MX6)		:= imx
>  machine-$(CONFIG_ARCH_MXS)		:= mxs
>  machine-$(CONFIG_ARCH_NETX)		:= netx
>  machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3852f45..27355cb 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -74,6 +74,7 @@ config SOC_IMX31
>  	select ARCH_MXC_AUDMUX_V2
>  	select ARCH_MX31
>  	select MXC_AVIC
> +	select SMP_ON_UP if SMP
>  
>  config SOC_IMX35
>  	bool
> @@ -83,6 +84,7 @@ config SOC_IMX35
>  	select HAVE_EPIT
>  	select ARCH_MX35
>  	select MXC_AVIC
> +	select SMP_ON_UP if SMP
>  
>  
>  if ARCH_IMX_V4_V5
> @@ -351,7 +353,7 @@ config MACH_IMX27IPCAM
>  
>  endif
>  
> -if ARCH_MX3
> +if ARCH_IMX_V6_V7
>  
>  comment "MX31 platforms:"
>  
> @@ -601,9 +603,6 @@ config MACH_VPR200
>  	  Include support for VPR200 platform. This includes specific
>  	  configurations for the board and its peripherals.
>  
> -endif
> -
> -if ARCH_MX6
>  comment "i.MX6 family:"
>  
>  config SOC_IMX6Q
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index aa1cf0c..b9dffe5 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_DEBUG_LL) += lluart.o
>  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
>  obj-$(CONFIG_HAVE_IMX_MMDC) += mmdc.o
>  obj-$(CONFIG_HAVE_IMX_SRC) += src.o
> +AFLAGS_head-v7.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_CPU_V7) += head-v7.o
>  obj-$(CONFIG_SMP) += platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index c3ce146..9ab5be0 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -819,10 +819,10 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
>  config CACHE_L2X0
>  	bool "Enable the L2x0 outer cache controller"
>  	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
> -		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
> +		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
>  		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
>  		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
> -		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_MX6
> +		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX
>  	default y
>  	select OUTER_CACHE
>  	select OUTER_CACHE_SYNC
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index 82b0d92..43efc3c 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -16,10 +16,13 @@ config ARCH_IMX_V4_V5
>  	  This enables support for systems based on the Freescale i.MX ARMv4
>  	  and ARMv5 SoCs
>  
> -config ARCH_MX3
> -	bool "MX3-based"

Then the following ARCH_MX3 references need to be removed properly.
I will take care of them.

  arch/arm/mach-imx/Makefile.boot:17:zreladdr-$(CONFIG_ARCH_MX3)  += 0x80008000
  arch/arm/mach-imx/Makefile.boot:18:params_phys-$(CONFIG_ARCH_MX3)       := 0x80000100
  arch/arm/mach-imx/Makefile.boot:19:initrd_phys-$(CONFIG_ARCH_MX3)       := 0x80800000
  arch/arm/plat-mxc/Kconfig:9:    default ARCH_MX3
  arch/arm/plat-mxc/include/mach/memory.h:25:# if defined CONFIG_ARCH_MX3

Regards,
Shawn

> +config ARCH_IMX_V6_V7
> +	bool "i.MX3, i.MX6"
> +	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
>  	help
> -	  This enables support for systems based on the Freescale i.MX3 family
> +	  This enables support for systems based on the Freescale i.MX3 and i.MX6
> +	  family.
>  
>  config ARCH_MX5
>  	bool "i.MX50, i.MX51, i.MX53"
> @@ -29,11 +32,6 @@ config ARCH_MX5
>  	  This enables support for machines using Freescale's i.MX50 and i.MX51
>  	  processors.
>  
> -config ARCH_MX6
> -	bool "i.MX6"
> -	help
> -	  This enables support for systems based on the Freescale i.MX6 family
> -
>  endchoice
>  
>  source "arch/arm/mach-imx/Kconfig"
> -- 
