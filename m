From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Dec 2012 17:31:37 +0100
Subject: [PATCH 13/18] arm: kirkwood: mplcec4: use Device Tree to probe
 SDIO
In-Reply-To: <1355841243-3254-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1355841243-3254-14-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121218163137.GK3392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 03:33:58PM +0100, Thomas Petazzoni wrote:
> Now that the mvsdio driver has a Device Tree binding, and the SDIO
> controller is declared in kirkwood.dtsi, migrate the mplcec4 board to
> use the Device Tree to probe the SDIO controller.
> 
> This patch has not been tested, it remains to be tested by a person
> having access to the hardware.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Stefan Peter <s.peter@mpl.ch>
> ---
>  arch/arm/boot/dts/kirkwood-mplcec4.dts |    6 ++++++
>  arch/arm/mach-kirkwood/board-mplcec4.c |    6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> index 262c654..ed10977 100644
> --- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
> @@ -133,6 +133,12 @@
>  			status = "okay";
>  
>  		};
> +
> +		mvsdio at 90000 {
> +			status = "okay";
> +			cd-gpios = <&gpio1 15 0>;
> +			/* No WP GPIO */
> +		};
>  	};

Hi Thomas

kirkwood-mplcec4.dts contains:

                pinctrl: pinctrl at 10000 {

                        pinctrl-0 = < &pmx_nand &pmx_uart0
                                      &pmx_led_health &pmx_sdio
                                      &pmx_sata0 &pmx_sata1
                                      &pmx_led_user1o
                                      &pmx_led_user1g &pmx_led_user0o
                                      &pmx_led_user0g &pmx_led_misc
                                      &pmx_sdio_cd
                                    >;
                        pinctrl-names = "default";

Should &pmx_sdio and &pmx_sdio_cd be moved out of here and into the
mvsdio at 90000 node?

>  
>  	gpio-leds {
> diff --git a/arch/arm/mach-kirkwood/board-mplcec4.c b/arch/arm/mach-kirkwood/board-mplcec4.c
> index 56bfe5a..183ff8a 100644
> --- a/arch/arm/mach-kirkwood/board-mplcec4.c
> +++ b/arch/arm/mach-kirkwood/board-mplcec4.c
> @@ -24,11 +24,6 @@ static struct mv643xx_eth_platform_data mplcec4_ge01_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(2),
>  };

There is another header file which can be removed.

Thanks
	Andrew
