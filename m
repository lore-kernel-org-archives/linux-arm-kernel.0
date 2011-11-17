From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:30:27 +0000
Subject: [PATCH 18/41] ARM: restart: ixp4xx: use new restart hook
In-Reply-To: <E1RN6nE-0001Xl-8i@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6nE-0001Xl-8i@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117173027.GE9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:46:04PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-ixp4xx/avila-setup.c           |    2 ++
>  arch/arm/mach-ixp4xx/common.c                |   20 ++++++++++++++++++++
>  arch/arm/mach-ixp4xx/coyote-setup.c          |    2 ++
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         |    1 +
>  arch/arm/mach-ixp4xx/fsg-setup.c             |    1 +
>  arch/arm/mach-ixp4xx/gateway7001-setup.c     |    1 +
>  arch/arm/mach-ixp4xx/goramo_mlr.c            |    1 +
>  arch/arm/mach-ixp4xx/gtwx5715-setup.c        |    1 +
>  arch/arm/mach-ixp4xx/include/mach/platform.h |    1 +
>  arch/arm/mach-ixp4xx/include/mach/system.h   |   21 ---------------------
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         |    1 +
>  arch/arm/mach-ixp4xx/nas100d-setup.c         |    1 +
>  arch/arm/mach-ixp4xx/nslu2-setup.c           |    1 +
>  arch/arm/mach-ixp4xx/omixp-setup.c           |    3 +++
>  arch/arm/mach-ixp4xx/vulcan-setup.c          |    1 +
>  arch/arm/mach-ixp4xx/wg302v2-setup.c         |    1 +
>  16 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp4xx/avila-setup.c b/arch/arm/mach-ixp4xx/avila-setup.c
> index 37609a2..a7277ad 100644
> --- a/arch/arm/mach-ixp4xx/avila-setup.c
> +++ b/arch/arm/mach-ixp4xx/avila-setup.c
> @@ -172,6 +172,7 @@ MACHINE_START(AVILA, "Gateworks Avila Network Platform")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  
>   /*
> @@ -190,6 +191,7 @@ MACHINE_START(LOFT, "Giant Shoulder Inc Loft board")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
> index 0777257..4a02619 100644
> --- a/arch/arm/mach-ixp4xx/common.c
> +++ b/arch/arm/mach-ixp4xx/common.c
> @@ -500,3 +500,23 @@ static void __init ixp4xx_clockevent_init(void)
>  
>  	clockevents_register_device(&clockevent_ixp4xx);
>  }
> +
> +void ixp4xx_restart(char mode, const char *cmd)
> +{
> +	if ( 1 && mode == 's') {
> +		/* Jump into ROM at address 0 */
> +		soft_restart(0);
> +	} else {
> +		/* Use on-chip reset capability */
> +
> +		/* set the "key" register to enable access to
> +		 * "timer" and "enable" registers
> +		 */
> +		*IXP4XX_OSWK = IXP4XX_WDT_KEY;
> +
> +		/* write 0 to the timer register for an immediate reset */
> +		*IXP4XX_OSWT = 0;
> +
> +		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
> +	}
> +}
> diff --git a/arch/arm/mach-ixp4xx/coyote-setup.c b/arch/arm/mach-ixp4xx/coyote-setup.c
> index 81dfec3..a74f86c 100644
> --- a/arch/arm/mach-ixp4xx/coyote-setup.c
> +++ b/arch/arm/mach-ixp4xx/coyote-setup.c
> @@ -117,6 +117,7 @@ MACHINE_START(ADI_COYOTE, "ADI Engineering Coyote")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> @@ -132,6 +133,7 @@ MACHINE_START(IXDPG425, "Intel IXDPG425")
>  	.timer		= &ixp4xx_timer,
>  	.atag_offset	= 0x100,
>  	.init_machine	= coyote_init,
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
> index 8837fbc..67be177 100644
> --- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
> +++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
> @@ -286,4 +286,5 @@ MACHINE_START(DSMG600, "D-Link DSM-G600 RevA")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp4xx/fsg-setup.c b/arch/arm/mach-ixp4xx/fsg-setup.c
> index 2887c35..6d58182 100644
> --- a/arch/arm/mach-ixp4xx/fsg-setup.c
> +++ b/arch/arm/mach-ixp4xx/fsg-setup.c
> @@ -277,5 +277,6 @@ MACHINE_START(FSG, "Freecom FSG-3")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  
> diff --git a/arch/arm/mach-ixp4xx/gateway7001-setup.c b/arch/arm/mach-ixp4xx/gateway7001-setup.c
> index d69d1b0..7ecf9b2 100644
> --- a/arch/arm/mach-ixp4xx/gateway7001-setup.c
> +++ b/arch/arm/mach-ixp4xx/gateway7001-setup.c
> @@ -104,5 +104,6 @@ MACHINE_START(GATEWAY7001, "Gateway 7001 AP")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
> index bf6678d..c0e3d69 100644
> --- a/arch/arm/mach-ixp4xx/goramo_mlr.c
> +++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
> @@ -504,4 +504,5 @@ MACHINE_START(GORAMO_MLR, "MultiLink")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp4xx/gtwx5715-setup.c b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
> index aa029fc..a23f893 100644
> --- a/arch/arm/mach-ixp4xx/gtwx5715-setup.c
> +++ b/arch/arm/mach-ixp4xx/gtwx5715-setup.c
> @@ -172,6 +172,7 @@ MACHINE_START(GTWX5715, "Gemtek GTWX5715 (Linksys WRV54G)")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  
>  
> diff --git a/arch/arm/mach-ixp4xx/include/mach/platform.h b/arch/arm/mach-ixp4xx/include/mach/platform.h
> index e824c02..df9250b 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/platform.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/platform.h
> @@ -125,6 +125,7 @@ extern void ixp4xx_init_irq(void);
>  extern void ixp4xx_sys_init(void);
>  extern void ixp4xx_timer_init(void);
>  extern struct sys_timer ixp4xx_timer;
> +extern void ixp4xx_restart(char, const char *);
>  extern void ixp4xx_pci_preinit(void);
>  struct pci_sys_data;
>  extern int ixp4xx_setup(int nr, struct pci_sys_data *sys);
> diff --git a/arch/arm/mach-ixp4xx/include/mach/system.h b/arch/arm/mach-ixp4xx/include/mach/system.h
> index 24337d9..72db2bb 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/system.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/system.h
> @@ -8,9 +8,6 @@
>   * published by the Free Software Foundation.
>   *
>   */
> -
> -#include <mach/hardware.h>
> -
>  static inline void arch_idle(void)
>  {
>  	/* ixp4xx does not implement the XScale PWRMODE register,
> @@ -21,24 +18,6 @@ static inline void arch_idle(void)
>  #endif
>  }
>  
> -
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	if ( 1 && mode == 's') {
> -		/* Jump into ROM at address 0 */
> -		soft_restart(0);
> -	} else {
> -		/* Use on-chip reset capability */
> -
> -		/* set the "key" register to enable access to
> -		 * "timer" and "enable" registers
> -		 */
> -		*IXP4XX_OSWK = IXP4XX_WDT_KEY;
> -
> -		/* write 0 to the timer register for an immediate reset */
> -		*IXP4XX_OSWT = 0;
> -
> -		*IXP4XX_OSWE = IXP4XX_WDT_RESET_ENABLE | IXP4XX_WDT_COUNT_ENABLE;
> -	}
>  }
> -
> diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
> index f235f82..8a38b39 100644
> --- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
> +++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
> @@ -261,6 +261,7 @@ MACHINE_START(IXDP425, "Intel IXDP425 Development Platform")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
> index de716fa..1010eb7 100644
> --- a/arch/arm/mach-ixp4xx/nas100d-setup.c
> +++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
> @@ -321,4 +321,5 @@ MACHINE_START(NAS100D, "Iomega NAS 100d")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp4xx/nslu2-setup.c b/arch/arm/mach-ixp4xx/nslu2-setup.c
> index ac81ccb..aa355c3 100644
> --- a/arch/arm/mach-ixp4xx/nslu2-setup.c
> +++ b/arch/arm/mach-ixp4xx/nslu2-setup.c
> @@ -307,4 +307,5 @@ MACHINE_START(NSLU2, "Linksys NSLU2")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
> index 3b6a81a..0940869 100644
> --- a/arch/arm/mach-ixp4xx/omixp-setup.c
> +++ b/arch/arm/mach-ixp4xx/omixp-setup.c
> @@ -246,6 +246,7 @@ MACHINE_START(DEVIXP, "Omicron DEVIXP")
>  	.init_irq	= ixp4xx_init_irq,
>  	.timer          = &ixp4xx_timer,
>  	.init_machine	= omixp_init,
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> @@ -259,6 +260,7 @@ MACHINE_START(MICCPT, "Omicron MICCPT")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
>  
> @@ -269,5 +271,6 @@ MACHINE_START(MIC256, "Omicron MIC256")
>  	.init_irq	= ixp4xx_init_irq,
>  	.timer          = &ixp4xx_timer,
>  	.init_machine	= omixp_init,
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
> diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
> index 27e469e..9dec206 100644
> --- a/arch/arm/mach-ixp4xx/vulcan-setup.c
> +++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
> @@ -244,4 +244,5 @@ MACHINE_START(ARCOM_VULCAN, "Arcom/Eurotech Vulcan")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp4xx/wg302v2-setup.c b/arch/arm/mach-ixp4xx/wg302v2-setup.c
> index b14144b..5ac0f0a 100644
> --- a/arch/arm/mach-ixp4xx/wg302v2-setup.c
> +++ b/arch/arm/mach-ixp4xx/wg302v2-setup.c
> @@ -105,5 +105,6 @@ MACHINE_START(WG302V2, "Netgear WG302 v2 / WAG302 v2")
>  #if defined(CONFIG_PCI)
>  	.dma_zone_size	= SZ_64M,
>  #endif
> +	.restart	= ixp4xx_restart,
>  MACHINE_END
>  #endif
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
