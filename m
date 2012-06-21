From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 09:44:27 +0800
Subject: [PATCH v2] ARM: dts: imx6q-sabrelite: add ecspi1 pinctrl support
In-Reply-To: <1340174510-20280-1-git-send-email-jason77.wang@gmail.com>
References: <1340174510-20280-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20120621014425.GB3377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 02:41:50PM +0800, Hui Wang wrote:
> Imx6q sabrelite board uses ecspi1 to connect a spi flash sst25vf016b,
> we need to add pinctrl information for it in the dts, otherwise the
> ecspi1 driver can't work and the connected flash is wrongly
> detected as a mr25h256 flash like this:
> 
> m25p80 spi32766.0: found mr25h256, expected sst25vf016b
> m25p80 spi32766.0: mr25h256 (32 Kbytes)
> 
> Cc: Richard Zhao <richard.zhao@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
> In the v2, i moved gpio pinctrl declaration from the ${soc}.dtsi to the
> ${board).dts, since the gpio assignment is board specific.
> 
> This patch is based on the richard.zhao's patch:
> http://permalink.gmane.org/gmane.linux.usb.general/65761
> 
>  arch/arm/boot/dts/imx6q-sabrelite.dts | 5 ++++-
>  arch/arm/boot/dts/imx6q.dtsi          | 8 ++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 

Looks good.  Will apply after prerequisite patch gets applied.  Thanks.

Regards,
Shawn

> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 5bba0d1..f7d91ad 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -27,6 +27,8 @@
>  				ecspi at 02008000 { /* eCSPI1 */
>  					fsl,spi-num-chipselects = <1>;
>  					cs-gpios = <&gpio3 19 0>;
> +					pinctrl-names = "default";
> +					pinctrl-0 = <&pinctrl_ecspi1_1>;
>  					status = "okay";
>  
>  					flash: m25p80 at 0 {
> @@ -48,7 +50,8 @@
>  				gpios {
>  					pinctrl_gpio_hog: gpiohog {
>  						fsl,pins = <1044 0x80000000	/* MX6Q_PAD_GPIO_17__GPIO_7_12 */
> -							   144  0x80000000>;	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
> +							    144  0x80000000	/* MX6Q_PAD_EIM_D22__GPIO_3_22 */
> +							    121  0x80000000>;	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */
>  					};
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index ccc8a5f..9fb1683 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -540,6 +540,14 @@
>  							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
>  					};
>  				};
> +
> +				ecspi1 {
> +					pinctrl_ecspi1_1: ecspi1grp-1 {
> +						fsl,pins = <101 0x100b1		/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
> +							    109 0x100b1		/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
> +							    94  0x100b1>;	/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
> +					};
> +				};
>  			};
>  
>  			dcic at 020e4000 { /* DCIC1 */
> -- 
> 1.7.11
> 
