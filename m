From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 13:08:28 -0400
Subject: [PATCH 6/9] ARM: kirkwood: use devicetree for SPI on dreamplug
In-Reply-To: <1339324322-29388-7-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-7-git-send-email-andrew@lunn.ch>
Message-ID: <20120610170828.GX14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31:58PM +0200, Andrew Lunn wrote:
> From: Michael Walle <michael@walle.cc>
> 
> Use the device tree for the SPI driver and partition layout.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  arch/arm/boot/dts/kirkwood-dreamplug.dts |   29 +++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dreamplug.c |   41 ------------------------------
>  2 files changed, 29 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> index a5376b8..d74d1ae 100644
> --- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
> +++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> @@ -20,5 +20,34 @@
>  			clock-frequency = <200000000>;
>  			status = "ok";
>  		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +
> +			m25p40 at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "mx25l1606e";
> +				reg = <0>;
> +				spi-max-frequency = <50000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +
> +				partition at 100000 {
> +					reg = <0x100000 0x10000>;
> +					label = "u-boot env";
> +				};
> +
> +				partition at 180000 {
> +					reg = <0x180000 0x10000>;
> +					label = "dtb";
> +				};
> +			};
> +		};
>  	};
> +
>  };
> diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-kirkwood/board-dreamplug.c
> index 55e357a..eb0e4d5 100644
> --- a/arch/arm/mach-kirkwood/board-dreamplug.c
> +++ b/arch/arm/mach-kirkwood/board-dreamplug.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/partitions.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mv643xx_eth.h>
>  #include <linux/of.h>
> @@ -36,42 +35,6 @@
>  #include "common.h"
>  #include "mpp.h"
>  
> -struct mtd_partition dreamplug_partitions[] = {
> -	{
> -		.name	= "u-boot",
> -		.size	= SZ_512K,
> -		.offset = 0,
> -	},
> -	{
> -		.name	= "u-boot env",
> -		.size	= SZ_64K,
> -		.offset = SZ_512K + SZ_512K,
> -	},
> -	{
> -		.name	= "dtb",
> -		.size	= SZ_64K,
> -		.offset = SZ_512K + SZ_512K + SZ_512K,
> -	},
> -};
> -
> -static const struct flash_platform_data dreamplug_spi_slave_data = {
> -	.type		= "mx25l1606e",
> -	.name		= "spi_flash",
> -	.parts		= dreamplug_partitions,
> -	.nr_parts	= ARRAY_SIZE(dreamplug_partitions),
> -};
> -
> -static struct spi_board_info __initdata dreamplug_spi_slave_info[] = {
> -	{
> -		.modalias	= "m25p80",
> -		.platform_data	= &dreamplug_spi_slave_data,
> -		.irq		= -1,
> -		.max_speed_hz	= 50000000,
> -		.bus_num	= 0,
> -		.chip_select	= 0,
> -	},
> -};
> -
>  static struct mv643xx_eth_platform_data dreamplug_ge00_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
>  };
> @@ -137,10 +100,6 @@ void __init dreamplug_init(void)
>  	 */
>  	kirkwood_mpp_conf(dreamplug_mpp_config);
>  
> -	spi_register_board_info(dreamplug_spi_slave_info,
> -				ARRAY_SIZE(dreamplug_spi_slave_info));
> -	kirkwood_spi_init();
> -
>  	kirkwood_ehci_init();
>  	kirkwood_ge00_init(&dreamplug_ge00_data);
>  	kirkwood_ge01_init(&dreamplug_ge01_data);
> -- 
> 1.7.10
> 
