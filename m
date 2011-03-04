From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2011 11:11:38 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110304081916.GB29521@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303121153.GJ29521@pengutronix.de>
	<20110303162513.GS22310@pengutronix.de>
	<20110303180026.GC18351@pengutronix.de>
	<20110303201009.GT22310@pengutronix.de>
	<20110304081916.GB29521@pengutronix.de>
Message-ID: <20110304101138.GV22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 09:19:16AM +0100, Sascha Hauer wrote:
> On Thu, Mar 03, 2011 at 09:10:09PM +0100, Uwe Kleine-K?nig wrote:
> > Right, it's not sensible to do this selection, but the fact that it is
> > possible makes me feel it's ugly. I thought a bit more about that I and
> > another reason for not using SOC_IMXxy for Kconfig is that it might be
> > natural to group i.MX50 and i.MX53 together because they share the same
> > PHYS_OFFSET. So there are three possibilities:
> > 
> >  1) group them using a symbol named SOC_IMX50_IMX53
> >  2) select both SOC_IMX50 and SOC_IMX53 independant of the machines
> >     enabled.
> >  3) don't allow to build both SoCs into a single image without
> >     IMX_MULTI_ARCHITECTURE
> > 
> > 2) is similar to my first suggestion---it might make things more
> > complicated than necessary at runtime. 3) is a limitation that shouldn't
> > be needed. So 1) is the best? Then I prefer to have a completly
> > different naming scheme for the grouping.
> > 
> > Does this make sense?
> 
> Lets give it a try. How does the following look like? Note I also skipped
> The explicit IMX_MULTI_ARCHITECTURE switch and depend on
> ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR directly instead.
ok

> 8<---------------------------------------
> 
> ARM i.MX: Allow to compile armv4 and armv5 based i.MX SoCs in a single kernel
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig |  109 +++++++++++++++++++++++++++++++++++----------
>  arch/arm/plat-mxc/Kconfig |   17 +------
>  2 files changed, 88 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 5eec099..932084c 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,8 +1,28 @@
> +if ARCH_IMX
> +
>  config IMX_HAVE_DMA_V1
>  	bool
>  
> +# obsolete: The MACH_MX/ARCH_MX should go away once the users
> +# are moved to the corresponding SOC_IMX_* in the tree
> +config MACH_MX21
> +	bool
> +
> +config MACH_MX27
> +	bool
> +
> +config ARCH_MX25
> +	bool
> +
> +config ARCH_MX2
> +	bool
> +
> +config ARCH_MX1
> +	bool
> +
>  config SOC_IMX1
>  	bool
> +	select ARCH_MX1
>  	select CPU_ARM920T
>  	select IMX_HAVE_DMA_V1
>  	select IMX_HAVE_IOMUX_V1
> @@ -10,6 +30,8 @@ config SOC_IMX1
>  
>  config SOC_IMX21
>  	bool
> +	select MACH_MX21
> +	select ARCH_MX2
>  	select CPU_ARM926T
>  	select ARCH_MXC_AUDMUX_V1
>  	select IMX_HAVE_DMA_V1
> @@ -18,6 +40,7 @@ config SOC_IMX21
>  
>  config SOC_IMX25
>  	bool
> +	select ARCH_MX25
>  	select CPU_ARM926T
>  	select ARCH_MXC_AUDMUX_V2
>  	select ARCH_MXC_IOMUX_V3
> @@ -25,13 +48,68 @@ config SOC_IMX25
>  
>  config SOC_IMX27
>  	bool
> +	select ARCH_MX2
> +	select MACH_MX27
>  	select CPU_ARM926T
>  	select ARCH_MXC_AUDMUX_V1
>  	select IMX_HAVE_DMA_V1
>  	select IMX_HAVE_IOMUX_V1
>  	select MXC_AVIC
>  
> -if ARCH_MX1
> +config ARCH_ALLOW_IMX1
> +	bool
> +
> +config ARCH_ALLOW_IMX21
> +	bool
> +
> +config ARCH_ALLOW_IMX25
> +	bool
> +
> +config ARCH_ALLOW_IMX27
> +	bool
> +
> +if ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR
> +config ARCH_IMX_MULTI_IMX1
> +	select ARCH_ALLOW_IMX1
> +	bool "i.MX1 support"
> +
> +config ARCH_IMX_MULTI_IMX21
> +	select ARCH_ALLOW_IMX21
> +	bool "i.MX21 support"
> +
> +config ARCH_IMX_MULTI_IMX25
> +	select ARCH_ALLOW_IMX25
> +	bool "i.MX25 support"
> +
> +config ARCH_IMX_MULTI_OMX27
> +	select ARCH_ALLOW_IMX27
> +	bool "i.MX27 support"
> +endif
> +
> +if !(ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR)
> +comment "enable ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR to get"
> +comment "support for multiple i.MX Families"
> +choice
> +	prompt "Select i.MX CPU"
> +config ARCH_IMX_ONLY_IMX1
> +	select ARCH_ALLOW_IMX1
> +	bool "i.MX1 support"
> +
> +config ARCH_IMX_ONLY_IMX21
> +	select ARCH_ALLOW_IMX21
> +	bool "i.MX21 support"
> +
> +config ARCH_IMX_ONLY_IMX25
> +	select ARCH_ALLOW_IMX25
> +	bool "i.MX25 support"
> +
> +config ARCH_IMX_ONLY_IMX27
> +	select ARCH_ALLOW_IMX27
> +	bool "i.MX27 support"
> +endchoice
> +endif
> +
> +if ARCH_ALLOW_IMX1
>  
>  comment "MX1 platforms:"
>  config MACH_MXLADS
> @@ -39,6 +117,7 @@ config MACH_MXLADS
>  
>  config ARCH_MX1ADS
>  	bool "MX1ADS platform"
> +	select SOC_IMX1
>  	select MACH_MXLADS
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
> @@ -48,32 +127,13 @@ config ARCH_MX1ADS
>  config MACH_SCB9328
>  	bool "Synertronixx scb9328"
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select SOC_IMX1
>  	help
>  	  Say Y here if you are using a Synertronixx scb9328 board
>  
>  endif
>  
> -if ARCH_MX2
> -
> -choice
> -	prompt "CPUs:"
> -	default MACH_MX21
> -
> -config MACH_MX21
> -	bool "i.MX21 support"
> -	help
> -	  This enables support for Freescale's MX2 based i.MX21 processor.
> -
> -config MACH_MX27
> -	bool "i.MX27 support"
> -	help
> -	  This enables support for Freescale's MX2 based i.MX27 processor.
> -
> -endchoice
> -
> -endif
> -
> -if MACH_MX21
> +if ARCH_ALLOW_IMX21
>  
>  comment "MX21 platforms:"
>  
> @@ -90,7 +150,7 @@ config MACH_MX21ADS
>  
>  endif
>  
> -if ARCH_MX25
> +if ARCH_ALLOW_IMX25
>  
>  comment "MX25 platforms:"
>  
> @@ -138,7 +198,7 @@ endchoice
>  
>  endif
>  
> -if MACH_MX27
> +if ARCH_ALLOW_IMX27
>  
>  comment "MX27 platforms:"
>  
> @@ -313,3 +373,4 @@ config MACH_IMX27IPCAM
>  	  configurations for the board and its peripherals.
>  
>  endif
> +endif
> diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
> index b0cb425..5625e78 100644
> --- a/arch/arm/plat-mxc/Kconfig
> +++ b/arch/arm/plat-mxc/Kconfig
> @@ -8,21 +8,10 @@ choice
>  	prompt "Freescale CPU family:"
>  	default ARCH_MX3
>  
> -config ARCH_MX1
> -	bool "MX1-based"
> -	select SOC_IMX1
> +config ARCH_IMX
> +	bool "i.MX1, i.MX21, i.MX25, i.MX27 based"
>  	help
> -	  This enables support for systems based on the Freescale i.MX1 family
> -
> -config ARCH_MX2
> -	bool "MX2-based"
> -	help
> -	  This enables support for systems based on the Freescale i.MX2 family
> -
> -config ARCH_MX25
> -	bool "MX25-based"
> -	help
> -	  This enables support for systems based on the Freescale i.MX25 family
> +	  This enables support for systems based on the Freescale i.MX1/2 family
>  
>  config ARCH_MX3
>  	bool "MX3-based"
Looks fine.  I will test it when I'm done with my 'move mx3 to mach-imx'
patch.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
