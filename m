From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 26 Aug 2016 14:30:23 -0400
Subject: [PATCH v2 6/7] arm64: dts: exynos: Add dts file for
 Exynos5433-based TM2 board
In-Reply-To: <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
References: <1472046551-703-1-git-send-email-cw00.choi@samsung.com>
 <1472046551-703-7-git-send-email-cw00.choi@samsung.com>
Message-ID: <0a6dffe0-8508-724e-c831-d14c32f8cd64@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanwoo,

The patch looks mostly good to me, I've just some comments:

[snip]

> +
> +&decon {
> +	status = "okay";
> +	iommu-reserved-mapping = <0x20000000 0x20000000 0xc0000000>;
> +

This property never made to mainline due not having an agreement on
how this should be fixed properly IIUC [0]. So you should remove it.

[snip]

> +
> +	s2mps13-pmic at 66 {
> +		compatible = "samsung,s2mps13-pmic";
> +		interrupt-parent = <&gpa0>;
> +		interrupts = <7 IRQ_TYPE_NONE>;
> +		reg = <0x66>;
> +		samsung,s2mps11-wrstbi-ground;
> +
> +		s2mps13_osc: clocks {
> +			compatible = "samsung,s2mps13-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps13_ap", "s2mps13_cp",
> +				"s2mps13_bt";
> +		};
> +

I see that most of the following regulators are marked as always-on
but I wonder if this is really needed. For example some of them are
looked up by consumer devices.

[snip]

> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "VDD1_E_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};

This is used by both the ADC and the TMU so I guess it should be safe
to not mark it as always-on (unless is used by other critical IP block
not described in the DT).

[snip]

> +
> +			ldo6_reg: LDO6 {
> +				regulator-name = "VDD10_MIPI2L_1.0V_AP";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;

Same question, this is used by both the dsi and usbdrd30 nodes so maybe
it shouldn't be marked as always-on as well.

> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo7_reg: LDO7 {
> +				regulator-name = "VDD18_MIPI2L_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;

This is used by the dsi node as well.

[snip]

> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "VDD33_USB30_3.0V_AP";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;

Use by the usbdrd30 node.

[snip]

> +
> +			ldo18_reg: LDO18 {
> +				regulator-name = "V_CODEC_1.8V_AP";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;

Use by the wm5110-codec node.

[snip]

> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "VDD_EGL_1.0V_AP";

I wonder if this shouldn't be "VDD_ATL_1.0V_AP" or something since
the big cluster isn't called Eagle like in arm32 Exynos but Atlas?

> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "VDD_KFC_1.0V_AP";

Same, maybe using "VDD_APL_1.0V_AP" since the big cluster is Apollo?

> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +

Used by the big and LITTLE clusters respectively, although for these two
I'm not that sure if it would be safe to remove the always-on property.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

[0]: http://www.spinics.net/lists/arm-kernel/msg419747.html

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
