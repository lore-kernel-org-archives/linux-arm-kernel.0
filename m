From: s.peter@mpl.ch (Stefan Peter)
Date: Thu, 27 Dec 2012 23:57:51 +0100
Subject: [PATCH v2 13/20] arm: kirkwood: mplcec4: use Device Tree to probe
 SDIO
In-Reply-To: <1356101359-6054-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1356101359-6054-14-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <50DCD26F.7010403@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.12.2012 15:49, Thomas Petazzoni wrote:
> Now that the mvsdio driver has a Device Tree binding, and the SDIO
> controller is declared in kirkwood.dtsi, migrate the mplcec4 board to
> use the Device Tree to probe the SDIO controller and to mux the pins
> of the SDIO interface correctly.
> 
> This patch has not been tested, it remains to be tested by a person
> having access to the hardware.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Stefan Peter <s.peter@mpl.ch>
> ---
> Changes since v1:
>  * Remove the useless header inclusion from board-mplcec4.c, now
>    that the SDIO interface is probed from the Device Tree.
>  * Reference the pmx_sdio muxing option from the DT node describing
>    the SDIO interface, in order to get proper muxing of this
>    interface.
> ---
>  arch/arm/boot/dts/kirkwood-mplcec4.dts |   11 +++++++++--
>  arch/arm/mach-kirkwood/board-mplcec4.c |    7 -------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index 262c654..662dfd8 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -20,12 +20,11 @@
>  		pinctrl: pinctrl at 10000 {
>  
>  			pinctrl-0 = < &pmx_nand &pmx_uart0
> -				      &pmx_led_health &pmx_sdio
> +				      &pmx_led_health
>  				      &pmx_sata0 &pmx_sata1
>  				      &pmx_led_user1o
>  				      &pmx_led_user1g &pmx_led_user0o
>  				      &pmx_led_user0g &pmx_led_misc
> -				      &pmx_sdio_cd
>  				    >;
>  			pinctrl-names = "default";
>  
> @@ -133,6 +132,14 @@
>  			status = "okay";
>  
>  		};
> +
> +		mvsdio at 90000 {
> +			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +			cd-gpios = <&gpio1 15 0>;
> +			/* No WP GPIO */
> +		};
>  	};
>  
>  	gpio-leds {
> diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
> index 56bfe5a..73a0332 100644
> --- a/arch/arm/mach-kirkwood/board-mplcec4.c
> +++ b/arch/arm/mach-kirkwood/board-mplcec4.c
> @@ -12,7 +12,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/mv643xx_eth.h>
> -#include <linux/platform_data/mmc-mvsdio.h>
>  #include "common.h"
>  #include "mpp.h"
>  
> @@ -24,11 +23,6 @@ static struct mv643xx_eth_platform_data mplcec4_ge01_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(2),
>  };
>  
> -static struct mvsdio_platform_data mplcec4_mvsdio_data = {
> -	.gpio_card_detect = 47,	/* MPP47 used as SD card detect */
> -};
> -
> -
>  void __init mplcec4_init(void)
>  {
>  	/*
> @@ -36,7 +30,6 @@ void __init mplcec4_init(void)
>  	 */
>  	kirkwood_ge00_init(&mplcec4_ge00_data);
>  	kirkwood_ge01_init(&mplcec4_ge01_data);
> -	kirkwood_sdio_init(&mplcec4_mvsdio_data);
>  	kirkwood_pcie_init(KW_PCIE0);
>  }
>  
> 

Requires "Fixes for 3.8-rc1" and "ARM: Kirkwood: Fix missing clk for USB
device" from Andrew Lunn. With these patches,

Tested-by: Stefan Peter <s.peter@mpl.ch>


-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
