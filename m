From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 02 Nov 2015 12:33:06 -0800
Subject: [PATCH v8 1/2] arm-soc: Import initial tango4 device tree
In-Reply-To: <56377ED5.4070203@sigmadesigns.com>
References: <56377E76.2080209@sigmadesigns.com>
 <56377ED5.4070203@sigmadesigns.com>
Message-ID: <5637C882.7060003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/15 07:18, Marc Gonzalez wrote:
> This device tree was tested on a Sigma Designs SMP8758 Vantage-1172
> development board.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  arch/arm/boot/dts/Makefile                |   2 +
>  arch/arm/boot/dts/tango4-common.dtsi      | 121 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tango4-smp8758.dtsi     |  30 ++++++++
>  arch/arm/boot/dts/tango4-vantage-1172.dts |  24 ++++++
>  4 files changed, 177 insertions(+)
>  create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
>  create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
>  create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts

Since you are introducing DTS with compatible strings etc. you need to
document these in Documentation/devicetree/bindings/ as well for people
to know how to write their own for their Tango4-based designs.

> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 246473a244f6..2499295051d5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
>  	sun9i-a80-cubieboard4.dtb
> +dtb-$(CONFIG_ARCH_TANGOX) += \
> +	tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>  	tegra20-harmony.dtb \
>  	tegra20-iris-512.dtb \
> diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
> new file mode 100644
> index 000000000000..90e9a6e736ae
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-common.dtsi
> @@ -0,0 +1,121 @@
> +/*
> + * Derived from Mans Rullgard's Tango3 DT
> + * https://github.com/mansr/linux-tangox
> + */

Most DTSes these days contain a proper license, typically BSD, yours
should have one too.

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	clocks {
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		xtal: xtal {
> +			compatible = "fixed-clock";
> +			clock-frequency = <27000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		clkgen: clkgen at 10000 {
> +			compatible = "sigma,tango4-clkgen";
> +			reg = <0x10000 0x40>;
> +			clocks = <&xtal>;
> +			clock-output-names = "cpuclk", "sysclk";
> +			#clock-cells = <1>;
> +		};
> +	};

Do not you have some sort of internal bus/bridge which maps these ARM
peripherals to your SoC? You have a simple-bus node later on for your
internal and own IPs, it would seem logical to have such a thing here as
well for these ARM peripherals.

[snip]

> diff --git a/arch/arm/boot/dts/tango4-smp8758.dtsi b/arch/arm/boot/dts/tango4-smp8758.dtsi
> new file mode 100644
> index 000000000000..4eb23a12e27f
> --- /dev/null
> +++ b/arch/arm/boot/dts/tango4-smp8758.dtsi
> @@ -0,0 +1,30 @@
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "sigma,tango4-smp";
> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +			device_type = "cpu";
> +			reg = <0>;

Missing next-level-cache property and 'enable-method' property.
-- 
Florian
