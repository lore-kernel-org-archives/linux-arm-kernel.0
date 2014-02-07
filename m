From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Feb 2014 20:37:21 -0500
Subject: [PATCH 15/21] ARM: MVEBU: Let kirkwood use the system
 controller for restart
In-Reply-To: <1391730137-14814-16-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-16-git-send-email-andrew@lunn.ch>
Message-ID: <20140207013721.GP8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 12:42:11AM +0100, Andrew Lunn wrote:
> The mvebu system controller already supports restarting orion
> systems. Make use of it, rather than the kirkwood specific code.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood.dtsi |  5 +++++

Please separate these into two patches.

thx,

Jason.

>  arch/arm/mach-mvebu/kirkwood.c  | 20 ++------------------
>  2 files changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 1d8129ac2672..6c4028e410fa 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -145,6 +145,11 @@
>  			reg = <0x20000 0x80>, <0x1500 0x20>;
>  		};
>  
> +		system-controller at 20000 {
> +			compatible = "marvell,orion-system-controller";
> +			reg = <0x20000 0x120>;
> +		};
> +
>  		bridge_intc: bridge-interrupt-ctrl at 20110 {
>  			compatible = "marvell,orion-bridge-intc";
>  			interrupt-controller;
> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> index 56e83035bc97..af77923a3483 100644
> --- a/arch/arm/mach-mvebu/kirkwood.c
> +++ b/arch/arm/mach-mvebu/kirkwood.c
> @@ -27,6 +27,7 @@
>  #include <plat/common.h>
>  #include <plat/pcie.h>
>  #include "kirkwood-pm.h"
> +#include "common.h"
>  
>  static struct resource kirkwood_cpufreq_resources[] = {
>  	[0] = {
> @@ -68,23 +69,6 @@ static void __init kirkwood_cpuidle_init(void)
>  	platform_device_register(&kirkwood_cpuidle);
>  }
>  
> -/* Temporary here since mach-mvebu has a function we can use */
> -static void kirkwood_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	/*
> -	 * Enable soft reset to assert RSTOUTn.
> -	 */
> -	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> -
> -	/*
> -	 * Assert soft reset.
> -	 */
> -	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> -
> -	while (1)
> -		;
> -}
> -
>  #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
>  #define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
>  
> @@ -203,6 +187,6 @@ static const char * const kirkwood_dt_board_compat[] = {
>  DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
>  	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
>  	.init_machine	= kirkwood_dt_init,
> -	.restart	= kirkwood_restart,
> +	.restart	= mvebu_restart,
>  	.dt_compat	= kirkwood_dt_board_compat,
>  MACHINE_END
> -- 
> 1.8.5.3
> 
