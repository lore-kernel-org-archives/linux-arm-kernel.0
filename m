From: briannorris@chromium.org (Brian Norris)
Date: Thu,  1 Dec 2016 18:27:32 -0800
Subject: [PATCH 8/9] arm64: dts: rockchip: partially describe PWM regulators
 for Gru
In-Reply-To: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
Message-ID: <1480645653-36943-9-git-send-email-briannorris@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to add regulators to the CPU nodes, so cpufreq doesn't think it
can crank up the clock speed without changing the voltage. However, we
don't yet have the DT bindings to fully describe the Over Voltage
Protection (OVP) circuits on these boards. Without that description, we
might end up changing the voltage too much, too fast.

Add the pwm-regulator descriptions and associate the CPU OPPs, but leave
them disabled.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 146 +++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 59b452504106..90adfb5cba38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -172,6 +172,98 @@
 		vin-supply = <&ppvar_sys>;
 	};
 
+	ppvar_bigcpu: ppvar-bigcpu {
+		compatible = "pwm-regulator";
+		regulator-name = "ppvar_bigcpu";
+		/*
+		 * OVP circuit requires special handling which is not yet
+		 * represented. Keep disabled for now.
+		 */
+		status = "disabled";
+
+		pwms = <&pwm1 0 3337 0>;
+
+		/* EC turns on w/ ap_core_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <798674>;
+		regulator-max-microvolt = <1302172>;
+
+		pwm-supply = <&ppvar_sys>;
+		pwm-dutycycle-range = <100 0>;
+		pwm-dutycycle-unit = <100>;
+	};
+
+	ppvar_litcpu: ppvar-litcpu {
+		compatible = "pwm-regulator";
+		regulator-name = "ppvar_litcpu";
+		/*
+		 * OVP circuit requires special handling which is not yet
+		 * represented. Keep disabled for now.
+		 */
+		status = "disabled";
+
+		pwms = <&pwm2 0 3337 0>;
+
+		/* EC turns on w/ ap_core_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <799065>;
+		regulator-max-microvolt = <1303738>;
+
+		pwm-supply = <&ppvar_sys>;
+		pwm-dutycycle-range = <100 0>;
+		pwm-dutycycle-unit = <100>;
+	};
+
+	ppvar_gpu: ppvar-gpu {
+		compatible = "pwm-regulator";
+		regulator-name = "ppvar_gpu";
+		/*
+		 * OVP circuit requires special handling which is not yet
+		 * represented. Keep disabled for now.
+		 */
+		status = "disabled";
+
+		pwms = <&pwm0 0 3337 0>;
+
+		/* EC turns on w/ ap_core_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <785782>;
+		regulator-max-microvolt = <1217729>;
+
+		pwm-supply = <&ppvar_sys>;
+		pwm-dutycycle-range = <100 0>;
+		pwm-dutycycle-unit = <100>;
+	};
+
+	ppvar_centerlogic: ppvar-centerlogic {
+		compatible = "pwm-regulator";
+		regulator-name = "ppvar_centerlogic";
+		/*
+		 * OVP circuit requires special handling which is not yet
+		 * represented. Keep disabled for now.
+		 */
+		status = "disabled";
+
+		pwms = <&pwm3 0 3337 0>;
+
+		/* EC turns on w/ ppvar_centerlogic_en; always on for AP */
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <800069>;
+		regulator-max-microvolt = <1049692>;
+
+		pwm-supply = <&ppvar_sys>;
+		pwm-dutycycle-range = <100 0>;
+		pwm-dutycycle-unit = <100>;
+	};
+
 	/* Schematics call this PPVAR even though it's fixed */
 	ppvar_logic: ppvar-logic {
 		compatible = "regulator-fixed";
@@ -444,6 +536,60 @@
 	};
 };
 
+/*
+ * Set some suspend operating points to avoid OVP in suspend
+ *
+ * When we go into S3 ARM Trusted Firmware will transition our PWM regulators
+ * from wherever they're at back to the "default" operating point (whatever
+ * voltage we get when we set the PWM pins to "input").
+ *
+ * This quick transition under light load has the possibility to trigger the
+ * regulator "over voltage protection" (OVP).
+ *
+ * To make extra certain that we don't hit this OVP at suspend time, we'll
+ * transition to a voltage that's much closer to the default (~1.0 V) so that
+ * there will not be a big jump.  Technically we only need to get within 200 mV
+ * of the default voltage, but the speed here should be fast enough and we need
+ * suspend/resume to be rock solid.
+ */
+
+&cluster0_opp {
+	opp05 {
+		opp-suspend;
+	};
+};
+
+&cluster1_opp {
+	opp06 {
+		opp-suspend;
+	};
+};
+
+&cpu_l0 {
+	cpu-supply = <&ppvar_litcpu>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&ppvar_litcpu>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&ppvar_litcpu>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&ppvar_litcpu>;
+};
+
+&cpu_b0 {
+	cpu-supply = <&ppvar_bigcpu>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&ppvar_bigcpu>;
+};
+
+
 &cru {
 	assigned-clocks =
 		<&cru PLL_GPLL>, <&cru PLL_CPLL>,
-- 
2.8.0.rc3.226.g39d4020
