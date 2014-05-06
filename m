From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 06 May 2014 23:32:56 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAxLzJdIEFSTTogZHRzOiBpbXg1MS1ldWtyZWEtbWJp?=
 =?UTF-8?B?bXhzZDUxLWJhc2Vib2FyZDogQWRkIENBTiBzdXBwb3J0?=
In-Reply-To: <1399404113-29207-1-git-send-email-fabio.estevam@freescale.com>
References: <1399404113-29207-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1399404776.560722294@f389.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 6 May 2014 16:21:52 -0300 ?? Fabio Estevam <fabio.estevam@freescale.com>:
> Add support for CAN based on a MCP2515 connected to ECSPI1.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v3:
> - Provide a fixed-clock for CAN
> - Separate escpi from CAN control pin groups
> - Use vdd-supply for mcp2515
> - Fix typo on commit log
> 
> Changes since v2:
> - None
> Changes since v1:
> - Use active low for spi chipselect
> - Remove unused GPIOs for CAN
>  .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> index 8b1098e..c1f32f9 100644
> --- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
> @@ -24,6 +24,14 @@
>  	model = "Eukrea CPUIMX51";
>  	compatible = "eukrea,mbimxsd51","eukrea,cpuimx51", "fsl,imx51";
>  
> +	clocks {
> +		clk24M: can_clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +
>  	gpio_keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -50,6 +58,23 @@
>  		};
>  	};
>  
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_can: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +			startup-delay-us = <20000>;
> +			enable-active-high;
> +		};
> +	};
> +
>  	sound {
>  		compatible = "eukrea,asoc-tlv320";
>  		eukrea,model = "imx51-eukrea-tlv320aic23";
> @@ -86,6 +111,26 @@
>  	status = "okay";
>  };
>  
> +&ecspi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1>;
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	can0: can at 0 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_can>;
> +		compatible = "microchip,mcp2515";
> +		reg = <0>;
> +		clocks = <&clk24M>;
> +		spi-max-frequency = <1000000>;

This should be of course 10000000, or removed completely
since driver already applies such limitation to the SPI bus.
I think Shawn can fix this during commit.

---
