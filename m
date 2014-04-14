From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Apr 2014 11:52:56 +0200
Subject: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
 various boards
In-Reply-To: <1397209093-10077-8-git-send-email-carlo@caione.org>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-8-git-send-email-carlo@caione.org>
Message-ID: <20140414095256.GA28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

On Fri, Apr 11, 2014 at 11:38:11AM +0200, Carlo Caione wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
> 
> In all the DTs the min and max microvolt allowed for each regulator are actually
> the min and max voltage possible for the regulator itself. This is not safe but
> we do not have the ranges allowed for each board and the original Allwinner 
> driver does exactly this way.
> 
> AXP20x has the so called Power Path Management (IPS) that can select the proper
> power supply according to the status of the external power and the Li-battery
> status. The output of the IPS block is usually a 5V fixed voltage used as 
> input supply for all the other regulators. This fixed voltage is represented
> in the DT as a fixed voltage regulator in the "regulator" subnode.
> 
>  arch/arm/boot/dts/sun4i-a10-a1000.dts           | 69 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts      | 69 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts       | 75 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       | 69 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      | 75 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  | 75 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts         | 69 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 70 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 70 +++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 70 +++++++++++++++++++++++

That looks like a lot of them. Did you test all of them?
Are all those regulators you define used on all these boards?

>  10 files changed, 711 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index fa746aea..029a880 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -88,6 +88,75 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;

That should be in the DTSI.

> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupts = <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				acin-supply = <&axp_ipsout_reg>;
> +				vin2-supply = <&axp_ipsout_reg>;
> +				vin3-supply = <&axp_ipsout_reg>;
> +				ldo24in-supply = <&axp_ipsout_reg>;
> +				ldo3in-supply = <&axp_ipsout_reg>;
> +				ldo5in-supply = <&axp_ipsout_reg>;
> +
> +				regulators {
> +					compatible = "x-powers,axp20x-reg";

I told you a few times already, but don't introduce pattern-matching
compatibles.

> +
> +					x-powers,dcdc-freq = <1500>;
> +
> +					axp_ipsout_reg: axp_ipsout {
> +						compatible = "regulator-fixed";
> +						regulator-name = "axp-ipsout";
> +						regulator-min-microvolt = <5000000>;
> +						regulator-max-microvolt = <5000000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-min-microvolt = <1250000>;
> +						regulator-max-microvolt = <3300000>;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +					};
> +				};
> +			};
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index 4684cbe..635fd4b 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -80,6 +80,75 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&i2c0_pins_a>;
>  			status = "okay";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupts = <0>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +
> +				acin-supply = <&axp_ipsout_reg>;
> +				vin2-supply = <&axp_ipsout_reg>;
> +				vin3-supply = <&axp_ipsout_reg>;
> +				ldo24in-supply = <&axp_ipsout_reg>;
> +				ldo3in-supply = <&axp_ipsout_reg>;
> +				ldo5in-supply = <&axp_ipsout_reg>;
> +
> +				regulators {
> +					compatible = "x-powers,axp20x-reg";
> +
> +					x-powers,dcdc-freq = <1500>;
> +
> +					axp_ipsout_reg: axp_ipsout {
> +						compatible = "regulator-fixed";
> +						regulator-name = "axp-ipsout";
> +						regulator-min-microvolt = <5000000>;
> +						regulator-max-microvolt = <5000000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_vcore_reg: dcdc2 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <2275000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_ddr_reg: dcdc3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_rtc_reg: ldo1 {
> +						regulator-always-on;
> +					};
> +
> +					axp_analog_reg: ldo2 {
> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +						regulator-always-on;
> +					};
> +
> +					axp_pll_reg: ldo3 {
> +						regulator-min-microvolt = <700000>;
> +						regulator-max-microvolt = <3500000>;
> +					};
> +
> +					axp_hdmi_reg: ldo4 {
> +						regulator-min-microvolt = <1250000>;
> +						regulator-max-microvolt = <3300000>;
> +					};
> +
> +					axp_mic_reg: ldo5 {
> +						regulator-min-microvolt = <1800000>;
> +						regulator-max-microvolt = <3300000>;
> +					};
> +				};
> +			};
>  		};
>  
>  		i2c1: i2c at 01c2b000 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> index d7c17e4..8f2db9c 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> @@ -82,6 +82,81 @@
>  			pinctrl-0 = <&uart0_pins_a>;
>  			status = "okay";
>  		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";

That should be in a separate patch.

These comments apply to most of the changes here. Make sure you edit
all of them.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/8e5946b5/attachment.sig>
