From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 09:30:22 +0800
Subject: [PATCH] ARM: imx23-olinuxino: Add i2c support
In-Reply-To: <1358273796-421-1-git-send-email-f.koliqi@gmail.com>
References: <1358273796-421-1-git-send-email-f.koliqi@gmail.com>
Message-ID: <20130117013020.GB26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 01:16:36PM -0500, Fadil Berisha wrote:
> From: Fadil Berisha <f.koliqi@gmail.com>
> 
> mx23-olinuxino board has i2c interface exposed on UEXT connector. This patch
> add i2c support. Test is done with module MOD-IO2 attached on UEXT connector.
> 
> Signed-off-by: Fadil Berisha <f.koliqi@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> V2: 
> Reworked as per Shawn's request. I2C instance has 3 pinmux settings
> 
>  arch/arm/boot/dts/imx23-olinuxino.dts |    6 +++++
>  arch/arm/boot/dts/imx23.dtsi          |   41 ++++++++++++++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index e7484e4..a43141a 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -68,6 +68,12 @@
>  		};
>  
>  		apbx at 80040000 {
> +			i2c0: i2c at 80058000 {

I guess the label "i2c0:" is being copied from imx28 dts, which is
unnecessary for imx23, since we only have one i2c in total here.  Or
at least to have the label be "i2c" to align with pinctrl label below.

> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c_pins_b>;
> +			status = "okay";
> +			};

Bad indent?

> +
>  			duart: serial at 80070000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&duart_pins_a>;
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 65415c5..6954b69 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -292,6 +292,39 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <1>;
>  				};
> +
> +				i2c_pins_a: i2c at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x01e0 /* MX23_PAD_I2C_SCL__I2C_SCL */
> +						0x01f0 /* MX23_PAD_I2C_SDA__I2C_SDA */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				i2c_pins_b: i2c at 1 {
> +					reg = <1>;
> +					fsl,pinmux-ids = <
> +						0x1171 /* MX23_PAD_LCD_ENABLE__I2C_SCL */
> +						0x1181 /* MX23_PAD_LCD_HSYNC__I2C_SDA  */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				i2c_pins_c: i2c at 2 {
> +					reg = <2>;
> +					fsl,pinmux-ids = <
> +						0x2031 /* MX23_PAD_SSP1_DATA1__I2C_SCL  */
> +						0x2041 /* MX23_PAD_SSP1_DATA2__I2C_SDA  */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
>  			};
>  
>  			digctl at 8001c000 {
> @@ -400,8 +433,14 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 80058000 {
> +			i2c0: i2c at 80058000 {

Ditto on the label.

Shawn

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx28-i2c";
>  				reg = <0x80058000 0x2000>;
> +				interrupts = <27 26>;
> +				clock-frequency = <100000>;
> +				fsl,i2c-dma-channel = <3>;
>  				status = "disabled";
>  			};
>  
> -- 
> 1.7.10
> 
