From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Wed, 25 Nov 2015 08:39:37 +0200
Subject: [PATCH 05/18] ARM: am57xx: cl-som-am57x: dts: add eMMC support
In-Reply-To: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448433590-1399-6-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CM-SOM-AM57X has two options of main storage devices - eMMC or NAND.
Add eMMC chip support (over MMC2 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index b6919a7..ed50a75 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -36,6 +36,13 @@
 			default-state = "off";
 		};
 	};
+
+	vdd_3v3: fixedregulator-vdd_3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &dra7_pmx_core {
@@ -71,6 +78,21 @@
 			DRA7XX_CORE_IOPAD(0x3818, PIN_INPUT_PULLUP | MUX_MODE14) /* wakeup0.gpio1_0 */
 		>;
 	};
+
+	mmc2_pins_default: mmc2_pins_default {
+		pinctrl-single,pins = <
+			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
+			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
+			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
+			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
+			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
+			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
+			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
+			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
+			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
+			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
+		>;
+	};
 };
 
 &i2c1 {
@@ -297,4 +319,15 @@
 	};
 };
 
+&mmc2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins_default>;
+
+	vmmc-supply = <&vdd_3v3>;
+	bus-width = <8>;
+	ti,non-removable;
+	cap-mmc-dual-data-rate;
+};
 
-- 
1.9.1
