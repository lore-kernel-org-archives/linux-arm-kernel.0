From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 04 Dec 2009 17:18:16 +0000
Subject: [RFC PATCH 01/10] PCMCIA: soc_common: convert to a stand alone
	module
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <4B194458.6040403@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

This one is causing me some build problems.

As things currently stand I can't build the pxa2xx support for pcmcia
with a stargate2 as a module.  It's fine if built in.
Note by this I meant building with the whole pcmcia subsytem as modules.

As module get a load of undefined symbols:
ERROR: "soc_pcmcia_request_irqs" [drivers/pcmcia/pxa2xx_stargate2.ko] undefined!
ERROR: "soc_pcmcia_free_irqs" [drivers/pcmcia/pxa2xx_stargate2.ko] undefined!
ERROR: "soc_pcmcia_enable_irqs" [drivers/pcmcia/pxa2xx_stargate2.ko] undefined!
ERROR: "soc_pcmcia_disable_irqs" [drivers/pcmcia/pxa2xx_stargate2.ko] undefined!
ERROR: "soc_pcmcia_add_one" [drivers/pcmcia/pxa2xx_base.ko] undefined!
ERROR: "soc_common_pcmcia_get_timing" [drivers/pcmcia/pxa2xx_base.ko] undefined!
ERROR: "soc_pcmcia_remove_one" [drivers/pcmcia/pxa2xx_base.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Relevant bits of .config

# Bus support
#
# CONFIG_PCI_SYSCALL is not set
# CONFIG_ARCH_SUPPORTS_MSI is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y

#
# PC-card bridges
#
CONFIG_PCMCIA_SOC_COMMON=y
CONFIG_PCMCIA_PXA2XX=m
# CONFIG_PCMCIA_DEBUG is not set

I think the fix is:

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 518b5ef..a02a135 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -200,7 +200,7 @@ config PCMCIA_BCM63XX
        depends on BCM63XX && PCMCIA
 
 config PCMCIA_SOC_COMMON
-       bool
+       tristate
 
 config PCMCIA_SA1100
        tristate "SA1100 support"


> Convert soc_common.c to be a stand alone module, rather than wrapping
> it up into the individual SoC specific base modules.  In doing this,
> we need to add init/exit functions for soc_common to register/remove
> the cpufreq notifier.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/pcmcia/Kconfig      |    6 ++++++
>  drivers/pcmcia/Makefile     |   10 ++++------
>  drivers/pcmcia/soc_common.c |   16 +++++++---------
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 17f38a7..0b82493 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -196,9 +196,13 @@ config PCMCIA_BCM63XX
>  	tristate "bcm63xx pcmcia support"
>  	depends on BCM63XX && PCMCIA
>  
> +config PCMCIA_SOC_COMMON
> +	bool
> +
>  config PCMCIA_SA1100
>  	tristate "SA1100 support"
>  	depends on ARM && ARCH_SA1100 && PCMCIA
> +	select PCMCIA_SOC_COMMON
>  	help
>  	  Say Y here to include support for SA11x0-based PCMCIA or CF
>  	  sockets, found on HP iPAQs, Yopy, and other StrongARM(R)/
> @@ -209,6 +213,7 @@ config PCMCIA_SA1100
>  config PCMCIA_SA1111
>  	tristate "SA1111 support"
>  	depends on ARM && ARCH_SA1100 && SA1111 && PCMCIA
> +	select PCMCIA_SOC_COMMON
>  	help
>  	  Say Y  here to include support for SA1111-based PCMCIA or CF
>  	  sockets, found on the Jornada 720, Graphicsmaster and other
> @@ -222,6 +227,7 @@ config PCMCIA_PXA2XX
>  	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
>  		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
>  		    || ARCH_VIPER || ARCH_PXA_ESERIES || MACH_STARGATE2)
> +	select PCMCIA_SOC_COMMON
>  	help
>  	  Say Y here to include support for the PXA2xx PCMCIA controller
>  
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index a03a38a..3829383 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -22,8 +22,9 @@ obj-$(CONFIG_I82365)				+= i82365.o
>  obj-$(CONFIG_I82092)				+= i82092.o
>  obj-$(CONFIG_TCIC)				+= tcic.o
>  obj-$(CONFIG_PCMCIA_M8XX)			+= m8xx_pcmcia.o
> -obj-$(CONFIG_PCMCIA_SA1100)			+= sa11xx_core.o sa1100_cs.o
> -obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_core.o sa1111_cs.o
> +obj-$(CONFIG_PCMCIA_SOC_COMMON)			+= soc_common.o
> +obj-$(CONFIG_PCMCIA_SA1100)			+= sa11xx_base.o sa1100_cs.o
> +obj-$(CONFIG_PCMCIA_SA1111)			+= sa11xx_base.o sa1111_cs.o
>  obj-$(CONFIG_M32R_PCC)				+= m32r_pcc.o
>  obj-$(CONFIG_M32R_CFC)				+= m32r_cfc.o
>  obj-$(CONFIG_PCMCIA_AU1X00)			+= au1x00_ss.o
> @@ -35,9 +36,6 @@ obj-$(CONFIG_BFIN_CFPCMCIA)			+= bfin_cf_pcmcia.o
>  obj-$(CONFIG_AT91_CF)				+= at91_cf.o
>  obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
>  
> -sa11xx_core-y					+= soc_common.o sa11xx_base.o
> -pxa2xx_core-y					+= soc_common.o pxa2xx_base.o
> -
>  au1x00_ss-y					+= au1000_generic.o
>  au1x00_ss-$(CONFIG_MIPS_PB1000)			+= au1000_pb1x00.o
>  au1x00_ss-$(CONFIG_MIPS_PB1100)			+= au1000_pb1x00.o
> @@ -77,4 +75,4 @@ pxa2xx-obj-$(CONFIG_MACH_PALMLD)		+= pxa2xx_palmld.o
>  pxa2xx-obj-$(CONFIG_MACH_E740)			+= pxa2xx_e740.o
>  pxa2xx-obj-$(CONFIG_MACH_STARGATE2)		+= pxa2xx_stargate2.o
>  
> -obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_core.o $(pxa2xx-obj-y)
> +obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
> diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
> index 163cf98..38c5484 100644
> --- a/drivers/pcmcia/soc_common.c
> +++ b/drivers/pcmcia/soc_common.c
> @@ -608,15 +608,14 @@ static int soc_pcmcia_cpufreq_register(void)
>  				"notifier for PCMCIA (%d)\n", ret);
>  	return ret;
>  }
> +fs_initcall(soc_pcmcia_cpufreq_register);
>  
>  static void soc_pcmcia_cpufreq_unregister(void)
>  {
>  	cpufreq_unregister_notifier(&soc_pcmcia_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
>  }
> +module_exit(soc_pcmcia_cpufreq_unregister);
>  
> -#else
> -static int soc_pcmcia_cpufreq_register(void) { return 0; }
> -static void soc_pcmcia_cpufreq_unregister(void) {}
>  #endif
>  
>  int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
> @@ -667,9 +666,6 @@ int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops
>  			goto out_err_5;
>  		}
>  
> -		if (list_empty(&soc_pcmcia_sockets))
> -			soc_pcmcia_cpufreq_register();
> -
>  		list_add(&skt->node, &soc_pcmcia_sockets);
>  
>  		/*
> @@ -742,6 +738,7 @@ int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops
>  	mutex_unlock(&soc_pcmcia_sockets_lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL(soc_common_drv_pcmcia_probe);
>  
>  int soc_common_drv_pcmcia_remove(struct device *dev)
>  {
> @@ -772,9 +769,6 @@ int soc_common_drv_pcmcia_remove(struct device *dev)
>  		release_resource(&skt->res_io);
>  		release_resource(&skt->res_skt);
>  	}
> -	if (list_empty(&soc_pcmcia_sockets))
> -		soc_pcmcia_cpufreq_unregister();
> -
>  	mutex_unlock(&soc_pcmcia_sockets_lock);
>  
>  	kfree(sinfo);
> @@ -782,3 +776,7 @@ int soc_common_drv_pcmcia_remove(struct device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);
> +
> +MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
> +MODULE_DESCRIPTION("Linux PCMCIA Card Services: Common SoC support");
> +MODULE_LICENSE("Dual MPL/GPL");
