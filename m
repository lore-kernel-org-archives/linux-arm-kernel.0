From: urjaman@gmail.com (Urja Rannikko)
Date: Tue, 28 Aug 2018 18:55:13 +0000
Subject: [PATCH 7/7] dts: rk3288-veyron-chromebook: dedicate npll to VOP0/HDMI
 + HDMI rates
In-Reply-To: <20180828185513.13216-1-urjaman@gmail.com>
References: <20180828185513.13216-1-urjaman@gmail.com>
Message-ID: <20180828185513.13216-8-urjaman@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables flexible HDMI rates on the rk3288 chromebooks so that they
actually work with displays (also others than a 1080p one) in the wild.

The frequency list matches what ChromeOS allows.

The 500Mhz GPU opp is removed since it is not available without NPLL.

Signed-off-by: Urja Rannikko <urjaman@gmail.com>
---
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index b16d570ff029..70ed0b2a9549 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -163,6 +163,25 @@
 	};
 };
 
+&cru {
+	/* Dedicate NPLL for VOP0 / VOP_BIG for HDMI. */
+	rockchip,npll-for-vop = <0>;
+	/* The first assigned clocks are DCLK_VOP0 and DCLK_VOP1 */
+	assigned-clock-parents = <&cru PLL_NPLL>, <&cru PLL_GPLL>;
+};
+
+/* Delete the nodes that allow non-desirable VOP - connector links. That
+ * is the eDP cannot use vopb and HDMI cannot use vopl. */
+
+/delete-node/ &edp_in_vopb;
+/delete-node/ &vopb_out_edp;
+/delete-node/ &hdmi_in_vopl;
+/delete-node/ &vopl_out_hdmi;
+
+/* Delete the 500 Mhz GPU opp since that cannot be easily made
+ * without NPLL. */
+/delete-node/ &{/gpu-opp-table/opp at 500000000};
+
 &edp {
 	status = "okay";
 
@@ -186,6 +205,54 @@
 	status = "okay";
 };
 
+&hdmi {
+	/* These depend on NPLL being dedicated to HDMI use. */
+	rockchip,hdmi-rates-hz = <
+		25176471	/* for 25.175 MHz, 0.006% off */
+		25200000
+		27000000
+		28320000
+		30240000
+		31500000
+		32000000
+		33750000
+		36000000
+		40000000
+		49500000
+		50000000
+		54000000
+		57290323	/* for 57.284 MHz, .011 % off */
+		65000000
+		68250000
+		71000000
+		72000000
+		73250000
+		74250000
+		74437500	/* for 74.44 MHz, .003% off */
+		75000000
+		78750000
+		78800000
+		79500000
+		83500000
+		85500000
+		88750000
+		97750000
+		101000000
+		106500000
+		108000000
+		115500000
+		118666667	/* for 118.68 MHz, .011% off */
+		119000000
+		121714286	/* for 121.75 MHz, .029% off */
+		135000000
+		136800000	/* for 136.75 MHz, .037% off */
+		146250000
+		148500000
+		154000000
+		162000000 >;
+};
+
+
 &gpio_keys {
 	pinctrl-0 = <&pwr_key_l &ap_lid_int_l>;
 	lid {
-- 
2.18.0
