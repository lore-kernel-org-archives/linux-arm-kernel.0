From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 27 Oct 2015 14:14:58 +0200
Subject: [PATCH 4/6] ARM: OMAP2+: dts: cm-t335: add support for MMC
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1445948100-16446-5-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for MMC0 pins.
Add fixed regulator 'vmmc_fixed'.
Enable MMC0 in 4-bit mode.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 9d6117a..976c330 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -31,6 +31,14 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	/* regulator for mmc */
+	vmmc_fixed: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &am33xx_pinmux {
@@ -104,6 +112,23 @@
 			0x174 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			/* mmc0_dat3.mmc0_dat3 */
+			0xf0 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat2.mmc0_dat2 */
+			0xf4 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat1.mmc0_dat1 */
+			0xf8 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat0.mmc0_dat0 */
+			0xfc (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_clk.mmc0_clk */
+			0x100 (PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_cmd.mmc0_cmd */
+			0x104 (PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
 };
 
 &uart0 {
@@ -203,3 +228,11 @@
 	status = "okay";
 };
 
+&mmc1 {
+	status = "okay";
+	vmmc-supply = <&vmmc_fixed>;
+	bus-width = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+};
+
-- 
2.6.0
