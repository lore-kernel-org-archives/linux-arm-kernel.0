From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:30:03 +0000
Subject: [PATCH 17/41] ARM: restart: ixp23xx: use new restart hook
In-Reply-To: <E1RN6mt-0001Xh-QL@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6mt-0001Xh-QL@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117173002.GD9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:45:43PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> In doing so, we split out the ixdp2351 restart code into its own
> platform file.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-ixp23xx/core.c                  |    6 ++++++
>  arch/arm/mach-ixp23xx/espresso.c              |    1 +
>  arch/arm/mach-ixp23xx/include/mach/platform.h |    1 +
>  arch/arm/mach-ixp23xx/include/mach/system.h   |   13 -------------
>  arch/arm/mach-ixp23xx/ixdp2351.c              |   12 ++++++++++++
>  arch/arm/mach-ixp23xx/roadrunner.c            |    1 +
>  6 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
> index a1bee33..0923bb9 100644
> --- a/arch/arm/mach-ixp23xx/core.c
> +++ b/arch/arm/mach-ixp23xx/core.c
> @@ -444,3 +444,9 @@ void __init ixp23xx_sys_init(void)
>  	*IXP23XX_EXP_UNIT_FUSE |= 0xf;
>  	platform_add_devices(ixp23xx_devices, ARRAY_SIZE(ixp23xx_devices));
>  }
> +
> +void ixp23xx_restart(char mode, const char *cmd)
> +{
> +	/* Use on-chip reset capability */
> +	*IXP23XX_RESET0 |= IXP23XX_RST_ALL;
> +}
> diff --git a/arch/arm/mach-ixp23xx/espresso.c b/arch/arm/mach-ixp23xx/espresso.c
> index 30dd316..8f2487e 100644
> --- a/arch/arm/mach-ixp23xx/espresso.c
> +++ b/arch/arm/mach-ixp23xx/espresso.c
> @@ -90,4 +90,5 @@ MACHINE_START(ESPRESSO, "IP Fabrics Double Espresso")
>  	.timer		= &ixp23xx_timer,
>  	.atag_offset	= 0x100,
>  	.init_machine	= espresso_init,
> +	.restart	= ixp23xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp23xx/include/mach/platform.h b/arch/arm/mach-ixp23xx/include/mach/platform.h
> index db9d941..50de558 100644
> --- a/arch/arm/mach-ixp23xx/include/mach/platform.h
> +++ b/arch/arm/mach-ixp23xx/include/mach/platform.h
> @@ -34,6 +34,7 @@ struct pci_sys_data;
>  void ixp23xx_map_io(void);
>  void ixp23xx_init_irq(void);
>  void ixp23xx_sys_init(void);
> +void ixp23xx_restart(char, const char *);
>  int ixp23xx_pci_setup(int, struct pci_sys_data *);
>  void ixp23xx_pci_preinit(void);
>  struct pci_bus *ixp23xx_pci_scan_bus(int, struct pci_sys_data*);
> diff --git a/arch/arm/mach-ixp23xx/include/mach/system.h b/arch/arm/mach-ixp23xx/include/mach/system.h
> index 8920ff2..7a1b96a 100644
> --- a/arch/arm/mach-ixp23xx/include/mach/system.h
> +++ b/arch/arm/mach-ixp23xx/include/mach/system.h
> @@ -7,10 +7,6 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -
> -#include <mach/hardware.h>
> -#include <asm/mach-types.h>
> -
>  static inline void arch_idle(void)
>  {
>  #if 0
> @@ -21,13 +17,4 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/* First try machine specific support */
> -	if (machine_is_ixdp2351()) {
> -		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_MAGIC;
> -		(void) *IXDP2351_CPLD_RESET1_REG;
> -		*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_ENABLE;
> -	}
> -
> -	/* Use on-chip reset capability */
> -	*IXP23XX_RESET0 |= IXP23XX_RST_ALL;
>  }
> diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
> index b3a57e0..5d5dd3e 100644
> --- a/arch/arm/mach-ixp23xx/ixdp2351.c
> +++ b/arch/arm/mach-ixp23xx/ixdp2351.c
> @@ -326,6 +326,17 @@ static void __init ixdp2351_init(void)
>  	ixp23xx_sys_init();
>  }
>  
> +static void ixdp2351_restart(char mode, const char *cmd)
> +{
> +	/* First try machine specific support */
> +
> +	*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_MAGIC;
> +	(void) *IXDP2351_CPLD_RESET1_REG;
> +	*IXDP2351_CPLD_RESET1_REG = IXDP2351_CPLD_RESET1_ENABLE;
> +
> +	ixp23xx_restart(mode, cmd);
> +}
> +
>  MACHINE_START(IXDP2351, "Intel IXDP2351 Development Platform")
>  	/* Maintainer: MontaVista Software, Inc. */
>  	.map_io		= ixdp2351_map_io,
> @@ -333,4 +344,5 @@ MACHINE_START(IXDP2351, "Intel IXDP2351 Development Platform")
>  	.timer		= &ixp23xx_timer,
>  	.atag_offset	= 0x100,
>  	.init_machine	= ixdp2351_init,
> +	.restart	= ixdp2351_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-ixp23xx/roadrunner.c b/arch/arm/mach-ixp23xx/roadrunner.c
> index 8f4dcbb..377283f 100644
> --- a/arch/arm/mach-ixp23xx/roadrunner.c
> +++ b/arch/arm/mach-ixp23xx/roadrunner.c
> @@ -177,4 +177,5 @@ MACHINE_START(ROADRUNNER, "ADI Engineering RoadRunner Development Platform")
>  	.timer		= &ixp23xx_timer,
>  	.atag_offset	= 0x100,
>  	.init_machine	= roadrunner_init,
> +	.restart	= ixp23xx_restart,
>  MACHINE_END
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
