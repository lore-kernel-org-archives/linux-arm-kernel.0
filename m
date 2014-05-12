From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 12 May 2014 22:18:15 +0800
Subject: [PATCH 1/2] ARM: dts: imx28-evk: Restructure device tree file
In-Reply-To: <1399837157-28080-1-git-send-email-festevam@gmail.com>
References: <1399837157-28080-1-git-send-email-festevam@gmail.com>
Message-ID: <20140512141814.GE8330@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 04:39:16PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Use the device tree format as used on other imx dts files. 
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28-evk.dts | 520 ++++++++++++++++++++--------------------

No.  When we made such changes for existing IMX dts files, arm-soc folks
complained it's a big churn on dts files.  So let the existing files be
it, and do that for the new files.

Shawn

>  1 file changed, 256 insertions(+), 264 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
> index e4cc44c..f9278f5 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -20,260 +20,22 @@
>  		reg = <0x40000000 0x08000000>;
>  	};
>  
> -	apb at 80000000 {
> -		apbh at 80000000 {
> -			gpmi-nand at 8000c000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
> -					     &gpmi_pins_evk>;
> -				status = "okay";
> -			};
> -
> -			ssp0: ssp at 80010000 {
> -				compatible = "fsl,imx28-mmc";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&mmc0_8bit_pins_a
> -					&mmc0_cd_cfg &mmc0_sck_cfg>;
> -				bus-width = <8>;
> -				wp-gpios = <&gpio2 12 0>;
> -				vmmc-supply = <&reg_vddio_sd0>;
> -				status = "okay";
> -			};
> -
> -			ssp1: ssp at 80012000 {
> -				compatible = "fsl,imx28-mmc";
> -				bus-width = <8>;
> -				wp-gpios = <&gpio0 28 0>;
> -			};
> -
> -			ssp2: ssp at 80014000 {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				compatible = "fsl,imx28-spi";
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&spi2_pins_a>;
> -				status = "okay";
> -
> -				flash: m25p80 at 0 {
> -					#address-cells = <1>;
> -					#size-cells = <1>;
> -					compatible = "sst,sst25vf016b";
> -					spi-max-frequency = <40000000>;
> -					reg = <0>;
> -				};
> -			};
> -
> -			pinctrl at 80018000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&hog_pins_a>;
> -
> -				hog_pins_a: hog at 0 {
> -					reg = <0>;
> -					fsl,pinmux-ids = <
> -						MX28_PAD_SSP1_CMD__GPIO_2_13
> -						MX28_PAD_SSP1_DATA3__GPIO_2_15
> -						MX28_PAD_ENET0_RX_CLK__GPIO_4_13
> -						MX28_PAD_SSP1_SCK__GPIO_2_12
> -						MX28_PAD_PWM3__GPIO_3_28
> -						MX28_PAD_LCD_RESET__GPIO_3_30
> -						MX28_PAD_AUART2_RX__GPIO_3_8
> -						MX28_PAD_AUART2_TX__GPIO_3_9
> -					>;
> -					fsl,drive-strength = <MXS_DRIVE_4mA>;
> -					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -					fsl,pull-up = <MXS_PULL_DISABLE>;
> -				};
> -
> -				led_pin_gpio3_5: led_gpio3_5 at 0 {
> -					reg = <0>;
> -					fsl,pinmux-ids = <
> -						MX28_PAD_AUART1_TX__GPIO_3_5
> -					>;
> -					fsl,drive-strength = <MXS_DRIVE_4mA>;
> -					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -					fsl,pull-up = <MXS_PULL_DISABLE>;
> -				};
> -
> -				gpmi_pins_evk: gpmi-nand-evk at 0 {
> -					reg = <0>;
> -					fsl,pinmux-ids = <
> -						MX28_PAD_GPMI_CE1N__GPMI_CE1N
> -						MX28_PAD_GPMI_RDY1__GPMI_READY1
> -					>;
> -					fsl,drive-strength = <MXS_DRIVE_4mA>;
> -					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -					fsl,pull-up = <MXS_PULL_DISABLE>;
> -				};
> -
> -				lcdif_pins_evk: lcdif-evk at 0 {
> -					reg = <0>;
> -					fsl,pinmux-ids = <
> -						MX28_PAD_LCD_RD_E__LCD_VSYNC
> -						MX28_PAD_LCD_WR_RWN__LCD_HSYNC
> -						MX28_PAD_LCD_RS__LCD_DOTCLK
> -						MX28_PAD_LCD_CS__LCD_ENABLE
> -					>;
> -					fsl,drive-strength = <MXS_DRIVE_4mA>;
> -					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> -					fsl,pull-up = <MXS_PULL_DISABLE>;
> -				};
> -			};
> -
> -			lcdif at 80030000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&lcdif_24bit_pins_a
> -					     &lcdif_pins_evk>;
> -				lcd-supply = <&reg_lcd_3v3>;
> -				display = <&display>;
> -				status = "okay";
> -
> -				display: display {
> -					bits-per-pixel = <32>;
> -					bus-width = <24>;
> -
> -					display-timings {
> -						native-mode = <&timing0>;
> -						timing0: timing0 {
> -							clock-frequency = <33500000>;
> -							hactive = <800>;
> -							vactive = <480>;
> -							hback-porch = <89>;
> -							hfront-porch = <164>;
> -							vback-porch = <23>;
> -							vfront-porch = <10>;
> -							hsync-len = <10>;
> -							vsync-len = <10>;
> -							hsync-active = <0>;
> -							vsync-active = <0>;
> -							de-active = <1>;
> -							pixelclk-active = <0>;
> -						};
> -					};
> -				};
> -			};
> -
> -			can0: can at 80032000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&can0_pins_a>;
> -				xceiver-supply = <&reg_can_3v3>;
> -				status = "okay";
> -			};
> -
> -			can1: can at 80034000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&can1_pins_a>;
> -				xceiver-supply = <&reg_can_3v3>;
> -				status = "okay";
> -			};
> -		};
> -
> -		apbx at 80040000 {
> -			saif0: saif at 80042000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&saif0_pins_a>;
> -				status = "okay";
> -			};
> -
> -			saif1: saif at 80046000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&saif1_pins_a>;
> -				fsl,saif-master = <&saif0>;
> -				status = "okay";
> -			};
> -
> -			lradc at 80050000 {
> -				fsl,lradc-touchscreen-wires = <4>;
> -				status = "okay";
> -				fsl,lradc-touchscreen-wires = <4>;
> -				fsl,ave-ctrl = <4>;
> -				fsl,ave-delay = <2>;
> -				fsl,settling = <10>;
> -			};
> -
> -			i2c0: i2c at 80058000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&i2c0_pins_a>;
> -				clock-frequency = <400000>;
> -				status = "okay";
> -
> -				sgtl5000: codec at 0a {
> -					compatible = "fsl,sgtl5000";
> -					reg = <0x0a>;
> -					VDDA-supply = <&reg_3p3v>;
> -					VDDIO-supply = <&reg_3p3v>;
> -					clocks = <&saif0>;
> -				};
> -
> -				at24 at 51 {
> -					compatible = "at24,24c32";
> -					pagesize = <32>;
> -					reg = <0x51>;
> -				};
> -			};
> -
> -			pwm: pwm at 80064000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&pwm2_pins_a>;
> -				status = "okay";
> -			};
> -
> -			duart: serial at 80074000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&duart_pins_a>;
> -				status = "okay";
> -			};
> -
> -			auart0: serial at 8006a000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&auart0_pins_a>;
> -				fsl,uart-has-rtscts;
> -				status = "okay";
> -			};
> -
> -			auart3: serial at 80070000 {
> -				pinctrl-names = "default";
> -				pinctrl-0 = <&auart3_pins_a>;
> -				status = "okay";
> -			};
> -
> -			usbphy0: usbphy at 8007c000 {
> -				status = "okay";
> -			};
> -
> -			usbphy1: usbphy at 8007e000 {
> -				status = "okay";
> -			};
> -		};
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 2 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
>  	};
>  
> -	ahb at 80080000 {
> -		usb0: usb at 80080000 {
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&usb0_id_pins_a>;
> -			vbus-supply = <&reg_usb0_vbus>;
> -			status = "okay";
> -		};
> -
> -		usb1: usb at 80090000 {
> -			vbus-supply = <&reg_usb1_vbus>;
> -			status = "okay";
> -		};
> -
> -		mac0: ethernet at 800f0000 {
> -			phy-mode = "rmii";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&mac0_pins_a>;
> -			phy-supply = <&reg_fec_3v3>;
> -			phy-reset-gpios = <&gpio4 13 0>;
> -			phy-reset-duration = <100>;
> -			status = "okay";
> -		};
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pin_gpio3_5>;
>  
> -		mac1: ethernet at 800f4000 {
> -			phy-mode = "rmii";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&mac1_pins_a>;
> -			status = "okay";
> +		user {
> +			label = "Heartbeat";
> +			gpios = <&gpio3 5 0>;
> +			linux,default-trigger = "heartbeat";
>  		};
>  	};
>  
> @@ -358,23 +120,253 @@
>  		saif-controllers = <&saif0 &saif1>;
>  		audio-codec = <&sgtl5000>;
>  	};
> +};
>  
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&led_pin_gpio3_5>;
> +&auart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&auart0_pins_a>;
> +	fsl,uart-has-rtscts;
> +	status = "okay";
> +};
>  
> -		user {
> -			label = "Heartbeat";
> -			gpios = <&gpio3 5 0>;
> -			linux,default-trigger = "heartbeat";
> +&auart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&auart3_pins_a>;
> +	status = "okay";
> +};
> +
> +&can0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can0_pins_a>;
> +	xceiver-supply = <&reg_can_3v3>;
> +	status = "okay";
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&can1_pins_a>;
> +	xceiver-supply = <&reg_can_3v3>;
> +	status = "okay";
> +};
> +
> +&duart {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&duart_pins_a>;
> +	status = "okay";
> +};
> +
> +&gpmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
> +		     &gpmi_pins_evk>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins_a>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	sgtl5000: codec at 0a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +		clocks = <&saif0>;
> +	};
> +
> +	at24 at 51 {
> +		compatible = "at24,24c32";
> +		pagesize = <32>;
> +		reg = <0x51>;
> +	};
> +};
> +
> +
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcdif_24bit_pins_a
> +		     &lcdif_pins_evk>;
> +	lcd-supply = <&reg_lcd_3v3>;
> +	display = <&display>;
> +	status = "okay";
> +
> +	display: display {
> +		bits-per-pixel = <32>;
> +		bus-width = <24>;
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: timing0 {
> +				clock-frequency = <33500000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hback-porch = <89>;
> +				hfront-porch = <164>;
> +				vback-porch = <23>;
> +				vfront-porch = <10>;
> +				hsync-len = <10>;
> +				vsync-len = <10>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
>  		};
>  	};
> +};
>  
> -	backlight {
> -		compatible = "pwm-backlight";
> -		pwms = <&pwm 2 5000000>;
> -		brightness-levels = <0 4 8 16 32 64 128 255>;
> -		default-brightness-level = <6>;
> +&lradc {
> +	fsl,lradc-touchscreen-wires = <4>;
> +	status = "okay";
> +	fsl,lradc-touchscreen-wires = <4>;
> +	fsl,ave-ctrl = <4>;
> +	fsl,ave-delay = <2>;
> +	fsl,settling = <10>;
> +};
> +
> +&mac0 {
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac0_pins_a>;
> +	phy-supply = <&reg_fec_3v3>;
> +	phy-reset-gpios = <&gpio4 13 0>;
> +	phy-reset-duration = <100>;
> +	status = "okay";
> +};
> +
> +&mac1 {
> +	phy-mode = "rmii";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mac1_pins_a>;
> +	status = "okay";
> +};
> +
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm2_pins_a>;
> +	status = "okay";
> +};
> +
> +&saif0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&saif0_pins_a>;
> +	status = "okay";
> +};
> +
> +&saif1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&saif1_pins_a>;
> +	fsl,saif-master = <&saif0>;
> +	status = "okay";
> +};
> +
> +&ssp0 {
> +	compatible = "fsl,imx28-mmc";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_8bit_pins_a
> +		     &mmc0_cd_cfg &mmc0_sck_cfg>;
> +	bus-width = <8>;
> +	wp-gpios = <&gpio2 12 0>;
> +	vmmc-supply = <&reg_vddio_sd0>;
> +	status = "okay";
> +};
> +
> +&ssp1 {
> +	compatible = "fsl,imx28-mmc";
> +	bus-width = <8>;
> +	wp-gpios = <&gpio0 28 0>;
> +};
> +
> +&ssp2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "fsl,imx28-spi";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_pins_a>;
> +	status = "okay";
> +
> +	flash: m25p80 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "sst,sst25vf016b";
> +		spi-max-frequency = <40000000>;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb0_id_pins_a>;
> +	vbus-supply = <&reg_usb0_vbus>;
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	vbus-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbphy0 {
> +	status = "okay";
> +};
> +
> +&usbphy1 {
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hog_pins_a>;
> +
> +	hog_pins_a: hog at 0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_SSP1_CMD__GPIO_2_13
> +			MX28_PAD_SSP1_DATA3__GPIO_2_15
> +			MX28_PAD_ENET0_RX_CLK__GPIO_4_13
> +			MX28_PAD_SSP1_SCK__GPIO_2_12
> +			MX28_PAD_PWM3__GPIO_3_28
> +			MX28_PAD_LCD_RESET__GPIO_3_30
> +			MX28_PAD_AUART2_RX__GPIO_3_8
> +			MX28_PAD_AUART2_TX__GPIO_3_9
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	led_pin_gpio3_5: led_gpio3_5 at 0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_AUART1_TX__GPIO_3_5
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	gpmi_pins_evk: gpmi-nand-evk at 0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_GPMI_CE1N__GPMI_CE1N
> +			MX28_PAD_GPMI_RDY1__GPMI_READY1
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
> +	};
> +
> +	lcdif_pins_evk: lcdif-evk at 0 {
> +		reg = <0>;
> +		fsl,pinmux-ids = <
> +			MX28_PAD_LCD_RD_E__LCD_VSYNC
> +			MX28_PAD_LCD_WR_RWN__LCD_HSYNC
> +			MX28_PAD_LCD_RS__LCD_DOTCLK
> +			MX28_PAD_LCD_CS__LCD_ENABLE
> +		>;
> +		fsl,drive-strength = <MXS_DRIVE_4mA>;
> +		fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +		fsl,pull-up = <MXS_PULL_DISABLE>;
>  	};
>  };
> -- 
> 1.8.3.2
> 
