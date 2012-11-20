From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Nov 2012 22:22:28 +0800
Subject: [PATCH] MXS: imx23-olinuxino: Add i2c support
In-Reply-To: <1353190860-19003-1-git-send-email-f.koliqi@gmail.com>
References: <1353190860-19003-1-git-send-email-f.koliqi@gmail.com>
Message-ID: <20121120142226.GC4882@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 17, 2012 at 05:21:00PM -0500, Fadil Berisha wrote:
> From: Fadil Berisha <f.koliqi@gmail.com>
> 
Please make subject look like "ARM: ..."

> imx23-olinuxino board has i2c interface exposed on UEXT connector. This patch 
> add i2c support. Test is done with module MOD-IO2 attached on UEXT connector.
> 
> Signed-off-by: Fadil Berisha <f.koliqi@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |    6 +++++
>  arch/arm/boot/dts/imx23.dtsi          |   43 +++++++++++++++++++++++++++++++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index 384d8b6..764d994 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -50,6 +50,12 @@
>  		};
>  
>  		apbx at 80040000 {
> +			i2c0: i2c at 80058000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&i2c1_pins_a>;
> +				status = "okay";
> +			};
> +
>  			duart: serial at 80070000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&duart_pins_a>;
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 6d31aa3..04f8bd1 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -279,6 +279,39 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				i2c0_pins_a: i2c0 at 0 {
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
> +				i2c1_pins_a: i2c1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x1171 /* MX23_PAD_LCD_ENABLE__I2C_SCL */
> +						0x1181 /* MX23_PAD_LCD_HSYNC__I2C_SDA  */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				i2c2_pins_a: i2c2 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2031 /* MX23_PAD_SSP1_DATA1__I2C_SCL  */
> +						0x2041 /* MX23_PAD_SSP1_DATA2__I2C_SDA  */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

As i.MX23 only has one I2C while the I2C instance has 3 pinmux settings.
I would expect something like below instead of the above.

				i2c_pins_a: i2c at 0 {
					reg = <0>;
					...
				};

				i2c_pins_b: i2c at 1 {
					reg = <1>;
					...
				};

				i2c_pins_c: i2c at 2 {
					reg = <2>;
					...
				};

Shawn

>  			};
>  
>  			digctl at 8001c000 {
> @@ -337,7 +370,7 @@
>  				reg = <0x80038000 0x2000>;
>  				status = "disabled";
>  			};
> -                };
> +		};
>  
>  		apbx at 80040000 {
>  			compatible = "simple-bus";
> @@ -387,8 +420,14 @@
>  				status = "disabled";
>  			};
>  
> -			i2c at 80058000 {
> +			i2c0: i2c at 80058000 {
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
