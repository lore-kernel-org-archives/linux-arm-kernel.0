From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Mar 2015 12:02:03 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <551537ED.7060402@gmail.com>
References: <551537ED.7060402@gmail.com>
Message-ID: <551538AB.50207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iain,

On 27-03-15 11:58, Iain Paton wrote:
> add pmic regulator definitions matching the manufacturers 3.4.x fex
> file.
>
> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> ---
>
> As this file belongs to Hans and he decided not to use axp209.dtsi in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315612.html
> then I won't add it here.

That was because using it was breaking stuff, but now that we know better
which regulators are used for what, and which one we most add an always-on;
property too, I would greatly prefer you to acually use axp209.dtsi, see
e.g. the sun5i-a13-utoo-p66.dts file where I'm using it.

Can you please respin this patch using axp209.dtsi?

Also please do not add nodes for unused regulators, like the ldo-s for the csi-s.

Thanks & Regards,

Hans


>
>   arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 68 ++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> index 31dc2f1..f7a8fcc 100644
> --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> @@ -67,6 +67,15 @@
>   			default-state = "on";
>   		};
>   	};
> +
> +	reg_axp_ipsout: axp_ipsout {
> +		compatible = "regulator-fixed";
> +		regulator-name = "axp-ipsout";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +
>   };
>
>   &ahci {
> @@ -97,10 +106,69 @@
>   	axp209: pmic at 34 {
>   		compatible = "x-powers,axp209";
>   		reg = <0x34>;
> +		interrupt-parent = <&intc>;
>   		interrupts = <0>;
>
>   		interrupt-controller;
>   		#interrupt-cells = <1>;
> +
> +		acin-supply = <&reg_axp_ipsout>;
> +		vin2-supply = <&reg_axp_ipsout>;
> +		vin3-supply = <&reg_axp_ipsout>;
> +		ldo24in-supply = <&reg_axp_ipsout>;
> +		ldo3in-supply = <&reg_axp_ipsout>;
> +
> +		x-powers,dcdc-freq = <1500>;
> +
> +		regulators {
> +			vdd_rtc: ldo1 {
> +				regulator-min-microvolt = <1300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-name="vdd_rtc";
> +			};
> +
> +			avcc: ldo2 {
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-name="avcc";
> +			};
> +
> +			vcc_csi0: ldo3 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-name="vcc_csi0";
> +			};
> +
> +			vcc_csi1: ldo4 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-name="vcc_csi1";
> +			};
> +
> +			ldo5 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-name="reg_unused";
> +			};
> +
> +			vdd_cpu: dcdc2 {
> +				regulator-min-microvolt = <1250000>;
> +				regulator-max-microvolt = <1550000>;
> +				regulator-always-on;
> +				regulator-name="vdd_cpu";
> +			};
> +
> +			vdd_int: dcdc3 {
> +				regulator-min-microvolt = <1250000>;
> +				regulator-max-microvolt = <1250000>;
> +				regulator-always-on;
> +				regulator-name="vdd_int";
> +			};
> +		};
>   	};
>   };
>
>
