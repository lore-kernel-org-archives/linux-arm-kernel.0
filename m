From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 24 Nov 2015 16:02:11 +0200
Subject: [PATCH v2 4/6] ARM: OMAP2+: dts: cm-t335: add support for MMC
In-Reply-To: <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1448373733-5839-5-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configuration for MMC0 pins.
Add fixed regulator 'vmmc_fixed'.
Enable MMC0 in 4-bit mode.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
v1 -> v2: integrate AM33XX_IOPAD macro in pinmux definitions

 arch/arm/boot/dts/am335x-cm-t335.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 431b6dd..0a20256 100644
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
@@ -105,6 +113,23 @@
 			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			/* mmc0_dat3.mmc0_dat3 */
+			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat2.mmc0_dat2 */
+			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat1.mmc0_dat1 */
+			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_dat0.mmc0_dat0 */
+			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_clk.mmc0_clk */
+			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)
+			/* mmc0_cmd.mmc0_cmd */
+			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
+		>;
+	};
 };
 
 &uart0 {
@@ -204,3 +229,11 @@
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
2.5.0
