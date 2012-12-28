From: michael@walle.cc (Michael Walle)
Date: Fri, 28 Dec 2012 20:16:59 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Convert LSXL to restart-poweroff
 driver.
In-Reply-To: <1356697512-3950-5-git-send-email-andrew@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-5-git-send-email-andrew@lunn.ch>
Message-ID: <201212282016.59894.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag 28 Dezember 2012, 13:25:12 schrieb Andrew Lunn:
> Add a device tree node and remove the C code.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi |    4 ++++
>  arch/arm/mach-kirkwood/Kconfig       |    1 +
>  arch/arm/mach-kirkwood/board-lsxl.c  |   16 ----------------
>  3 files changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> b/arch/arm/boot/dts/kirkwood-lsxl.dtsi index 37d45c4..996c7fe 100644
> --- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> @@ -172,6 +172,10 @@
>  		alarm-gpios = <&gpio1 8 0>;
>  	};
> 
> +	restart_poweroff {
> +		compatible = "restart-poweroff";
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/arch/arm/mach-kirkwood/Kconfig
> b/arch/arm/mach-kirkwood/Kconfig index bb4de9c..432bee0 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -119,6 +119,7 @@ config MACH_GOFLEXNET_DT
>  config MACH_LSXL_DT
>  	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
>  	select ARCH_KIRKWOOD_DT
> +	select POWER_RESET_RESTART
>  	help
>  	  Say 'Y' here if you want your kernel to support the
>  	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
> diff --git a/arch/arm/mach-kirkwood/board-lsxl.c
> b/arch/arm/mach-kirkwood/board-lsxl.c index 4ec8b7a..3483952 100644
> --- a/arch/arm/mach-kirkwood/board-lsxl.c
> +++ b/arch/arm/mach-kirkwood/board-lsxl.c
> @@ -25,19 +25,6 @@ static struct mv643xx_eth_platform_data lsxl_ge01_data =
> { .phy_addr	= MV643XX_ETH_PHY_ADDR(8),
>  };
> 
> -/*
> - * On the LS-XHL/LS-CHLv2, the shutdown process is following:
> - * - Userland monitors key events until the power switch goes to off
> position - * - The board reboots
> - * - U-boot starts and goes into an idle mode waiting for the user
> - *   to move the switch to ON position
> - *
> - */
> -static void lsxl_power_off(void)
> -{
> -	kirkwood_restart('h', NULL);
> -}
> -
>  void __init lsxl_init(void)
>  {
>  	/*
> @@ -46,7 +33,4 @@ void __init lsxl_init(void)
> 
>  	kirkwood_ge00_init(&lsxl_ge00_data);
>  	kirkwood_ge01_init(&lsxl_ge01_data);
> -
> -	/* register power-off method */
> -	pm_power_off = lsxl_power_off;
>  }

Tested-by: Michael Walle <michael@walle.cc>

Sort of, device_shutdown() is blocking on my board (seems to be some kind of 
issue with orion-ehci), but that has nothing to do with this patch :)
