From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 16 Apr 2014 21:30:44 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIEFSTTogZHRzOiBpbXgyNzogUGxhY2UgdGhlIHVz?=
 =?UTF-8?B?YiBwaHkgbm9kZXMgaW4gdGhlIGJvYXJkIGR0cyBmaWxlcw==?=
In-Reply-To: <1397668217-17551-2-git-send-email-festevam@gmail.com>
References: <1397668217-17551-1-git-send-email-festevam@gmail.com>
 <1397668217-17551-2-git-send-email-festevam@gmail.com>
Message-ID: <1397669444.19723407@f371.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 16 Apr 2014 14:10:16 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> It is not a good approach to have the USB PHY nodes inside imx27.dtsi since
> the USB PHYs on mx27 are not internal to the SoC.
> 
> Place the USB PHY nodes in the board dts files instead.
> 
> Also, each board may have a different clock source for the USB PHY, so do not
> hardcode it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Applies on top of "[PATCH] ARM: dts: imx27-phytec-phycore-som: Move PMIC IRQ GPIO into a separate pin group"
...
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> index 33c5dc2..c48b9f8 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> @@ -20,6 +20,15 @@
>  		reg = <0xa0000000 0x08000000>;
>  	};
>  
> +	clocks {
> +		clk_26M: codec_clock {

codec? 26M? Why?

> +			compatible = "fixed-clock";
> +			reg = <0>;
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -41,6 +50,28 @@
>  			regulator-max-microvolt = <5000000>;
>  		};
>  	};
> +
> +	usbphy {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbphy0: usbphy at 0 {
> +			compatible = "usb-nop-xceiv";
> +			reg = <0>;
> +			vcc-supply = <&sw3_reg>;
> +			clocks = <&clk_26M>;

Just <&clks 0> is enough in this case.

> +			clock-names = "main_clk";
> +		};
> +
> +		usbphy2: usbphy at 2 {
> +			compatible = "usb-nop-xceiv";
> +			reg = <0>;
> +			vcc-supply = <&reg_5v0>;
> +			clocks = <&clk_26M>;
> +			clock-names = "main_clk";
> +		};
> +	};

SOM has no second ULPI.
So this should be moved to RDK.

---
