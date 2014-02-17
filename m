From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 10:55:29 +0800
Subject: [PATCH] ARM: dts: imx27-phytec-phycore-*: Add diagnostic PMIC LEDs
In-Reply-To: <1392464118-3353-1-git-send-email-shc_work@mail.ru>
References: <1392464118-3353-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140217025527.GG9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 15, 2014 at 03:35:18PM +0400, Alexander Shiyan wrote:
> PCM-038 module have three triple LEDs connected to PMIC which
> can be used for diagnostic purposes. This patch adds support
> for these LEDs for PCM-038 SOM and adds basic LED-triggers for
> these LEDs for PCM-970 RDK, the remaining LEDs are available
> for use from userspace.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts  | 50 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi |  6 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> index 9f8ad51..9a07543 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> @@ -96,6 +96,56 @@
>  	status = "okay";
>  };
>  
> +&pmicleds {
> +	ledr1: led at 3 {
> +		reg = <3>;
> +		label = "system:red1:user";
> +	};
> +
> +	ledg1: led at 4 {
> +		reg = <4>;
> +		label = "system:green1:user";
> +	};
> +
> +	ledb1: led at 5 {
> +		reg = <5>;
> +		label = "system:blue1:user";
> +	};
> +
> +	ledr2: led at 6 {
> +		reg = <6>;
> +		label = "system:red2:user";
> +	};
> +
> +	ledg2: led at 7 {
> +		reg = <7>;
> +		label = "system:green2:user";
> +	};
> +
> +	ledb2: led at 8 {
> +		reg = <8>;
> +		label = "system:blue2:user";
> +	};
> +
> +	ledr3: led at 9 {
> +		reg = <9>;
> +		label = "system:red3:nand";
> +		linux,default-trigger = "nand-disk";
> +	};
> +
> +	ledg3: led at 10 {
> +		reg = <10>;
> +		label = "system:green3:live";
> +		linux,default-trigger = "heartbeat";
> +	};
> +
> +	ledb3: led at 11 {
> +		reg = <11>;
> +		label = "system:blue3:cpu";
> +		linux,default-trigger = "cpu0";


I do not see this trigger and above "nand-disk" in
Documentation/devicetree/bindings/leds/common.txt.
So they're just missing from bindings doc and kernel actually supports
them?

> +	};
> +};
> +
>  &sdhci2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdhc2>;
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> index 230cfaf..258eafa 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
> @@ -69,6 +69,12 @@
>  		fsl,mc13xxx-uses-adc;
>  		fsl,mc13xxx-uses-rtc;
>  
> +		pmicleds: leds {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			led-control = <0x001 0x000 0x000 0x000 0x000 0x000>;

I can only see led-control mentioned in
Documentation/devicetree/bindings/mfd/mc13xxx.txt as below.

- leds : Contain the led nodes and initial register values in property
  "led-control".

But I failed to see where this property is actually defined.

Shawn

> +		};
> +
>  		regulators {
>  			/* SW1A and SW1B joined operation */
>  			sw1_reg: sw1a {
> -- 
> 1.8.3.2
> 
