From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 23:28:10 +0800
Subject: [PATCH] ARM: dts: imx6q-sabrelite: add ecspi1 pinctrl support
In-Reply-To: <1340096887-24156-1-git-send-email-jason77.wang@gmail.com>
References: <1340096887-24156-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20120619152808.GI21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2012 at 05:08:07PM +0800, Hui Wang wrote:
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
>  arch/arm/boot/dts/imx6q-sabrelite.dts | 2 ++
>  arch/arm/boot/dts/imx6q.dtsi          | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index e0ec929..83a8f62 100644
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
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 8c90cba..ae8e7f2 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -538,6 +538,15 @@
>  							    1517 0x17059>;	/* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
>  					};
>  				};
> +
> +				ecspi1 {
> +					pinctrl_ecspi1_1: ecspi1grp-1 {
> +						fsl,pins = <101 0x100b1		/* MX6Q_PAD_EIM_D17__ECSPI1_MISO */
> +							    109 0x100b1		/* MX6Q_PAD_EIM_D18__ECSPI1_MOSI */
> +							    94  0x100b1		/* MX6Q_PAD_EIM_D16__ECSPI1_SCLK */
> +							    121 0x100b1>;	/* MX6Q_PAD_EIM_D19__GPIO_3_19 */

Which gpio is used is really a board specific setting and should not
be defined in <soc>.dtsi.  Before gpio_request can automatically
configure the requested pin into gpio mode by talking to pinctrl system,
we may want to use "hog" feature to configure pins into gpio mode,
which means defining a pinctrl state for pin controller node itself,
then at pinctrl subsystem init time, pinctrl core will configure these
"hog" pins properly.  The following is an example using that feature.

http://permalink.gmane.org/gmane.linux.usb.general/65761

Regards,
Shawn

> +					};
> +				};
>  			};
>  
>  			dcic at 020e4000 { /* DCIC1 */
> -- 
> 1.7.11
> 
