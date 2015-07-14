From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Jul 2015 11:44:40 +0800
Subject: [PATCH 1/2] ARM: dts: imx7d: enable snvs rtc, onoffkey and power
 off
In-Reply-To: <1436376180-5891-1-git-send-email-Frank.Li@freescale.com>
References: <1436376180-5891-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150714034440.GE4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 01:22:59AM +0800, Frank.Li at freescale.com wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Change SNVS rtc to syscon interface.
> Enable onoff key and power off function.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  arch/arm/boot/dts/imx7d-sdb.dts |  4 ++++
>  arch/arm/boot/dts/imx7d.dtsi    | 27 +++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 4d1a4b9..214eba9 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -223,6 +223,10 @@
>  	};
>  };
>  
> +&snvs_poweroff {
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index b4cd8fd..308ad1b 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -322,17 +322,32 @@
>  			};
>  
>  			snvs: snvs at 30370000 {
> -				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> -				#address-cells = <1>;
> -				#size-cells = <1>;
> -				ranges = <0 0x30370000 0x10000>;
> +				compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +				reg = <0x30370000 0x10000>;
>  
> -				snvs-rtc-lp at 34 {
> +				snvs_rtc: snvs-rtc-lp {
>  					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -					reg = <0x34 0x58>;
> +					regmap = <&snvs>;
> +					offset = <0x34>;
>  					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
>  						     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  				};
> +
> +				snvs_poweroff: snvs-poweroff {
> +					compatible = "syscon-poweroff";
> +					regmap = <&snvs>;
> +					offset = <0x38>;
> +					mask = <0x60>;
> +					status = "disabled";
> +				};

For such completely internal device without any board level
configuration and pin-out, we should probably just leave it enabled by
default, i.e. drop status = "disabled" and save status = "okay" in board
level dts?

Shawn

> +
> +				snvs_pwrkey: snvs-powerkey {
> +					compatible = "fsl,sec-v4.0-pwrkey";
> +					regmap = <&snvs>;
> +					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +					linux,keycode = <KEY_POWER>;
> +					wakeup;
> +				};
>  			};
>  
>  			clks: ccm at 30380000 {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
