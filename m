From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Aug 2015 14:32:45 +0200
Subject: [PATCH 3/6] ARM: dts: sun6i: hummingbird: Use axp221.dtsi for
 axp221 regulators
In-Reply-To: <1440755679-8266-4-git-send-email-wens@csie.org>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-4-git-send-email-wens@csie.org>
Message-ID: <20150828123244.GK29389@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:54:36PM +0800, Chen-Yu Tsai wrote:
> Now that we have axp221.dtsi describing common axp22x hardware, use
> it and reference the nodes instead of declaring the whole tree.
> 
> Also add regulator reference for cpu0 supply.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 114 ++++++++++++++--------------
>  1 file changed, 56 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> index d0cfadac0691..d019cb70acec 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -67,6 +67,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>  &ehci0 {
>  	status = "okay";
>  };
> @@ -119,7 +123,7 @@
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
> -	vmmc-supply = <&vcc_3v0>;
> +	vmmc-supply = <&reg_dcdc1>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
>  	cd-inverted;
> @@ -134,7 +138,7 @@
>  &mmc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_hummingbird>;
> -	vmmc-supply = <&vcc_wifi>;
> +	vmmc-supply = <&reg_aldo1>;
>  	mmc-pwrseq = <&wifi_pwrseq>;
>  	bus-width = <4>;
>  	non-removable;
> @@ -169,65 +173,59 @@
>  		reg = <0x68>;
>  		interrupt-parent = <&nmi_intc>;
>  		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		dcdc1-supply = <&vcc_3v0>;
> -		dcdc5-supply = <&vcc_dram>;
> -
> -		regulators {
> -			x-powers,dcdc-freq = <3000>;
> -
> -			vcc_3v0: dcdc1 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "vcc-3v0";
> -			};
> -
> -			vdd_cpu: dcdc2 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <1320000>;
> -				regulator-name = "vdd-cpu";
> -			};
> -
> -			vdd_gpu: dcdc3 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <700000>;
> -				regulator-max-microvolt = <1320000>;
> -				regulator-name = "vdd-gpu";
> -			};
> -
> -			vdd_sys_dll: dcdc4 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <1100000>;
> -				regulator-max-microvolt = <1100000>;
> -				regulator-name = "vdd-sys-dll";
> -			};
> -
> -			vcc_dram: dcdc5 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <1500000>;
> -				regulator-max-microvolt = <1500000>;
> -				regulator-name = "vcc-dram";
> -			};
> -
> -			vcc_wifi: aldo1 {
> -				regulator-min-microvolt = <3300000>;
> -				regulator-max-microvolt = <3300000>;
> -				regulator-name = "vcc_wifi";
> -			};
> -
> -			avcc: aldo3 {
> -				regulator-always-on;
> -				regulator-min-microvolt = <3000000>;
> -				regulator-max-microvolt = <3000000>;
> -				regulator-name = "avcc";
> -			};
> -		};
>  	};
>  };
>  
> +#include "axp221.dtsi"
> +
> +&reg_aldo1 {
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-wifi";
> +};
> +
> +&reg_aldo3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};
> +
> +&reg_dcdc1 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "vcc-3v0";
> +};
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <700000>;
> +	regulator-max-microvolt = <1320000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <700000>;
> +	regulator-max-microvolt = <1320000>;
> +	regulator-name = "vdd-gpu";
> +};

I'm know it's just a mechanical change from your part, but is the GPU
regulator really need to be always on?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150828/bda2fc3c/attachment.sig>
