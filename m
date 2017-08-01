From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 1 Aug 2017 10:11:18 +0530
Subject: [PATCH 5/6] ARM: dts: keystone-k2g-evm: Enable MMC0 and MMC1
In-Reply-To: <20170801044119.16201-1-lokeshvutla@ti.com>
References: <20170801044119.16201-1-lokeshvutla@ti.com>
Message-ID: <20170801044119.16201-6-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MMC0 which is used for micro SD and MMC1 which is used for the on
board EMMC.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[fcooper at ti.com: add mmc1, bufferclass and pullup/pulldown settings]
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
[nsekhar at ti.com: add card detect GPIO support]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 61883cb969d2..f47f95d8bf1c 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -25,6 +25,13 @@
 		reg = <0x00000008 0x00000000 0x00000000 0x80000000>;
 	};
 
+	vcc3v3_dcin_reg: fixedregulator-vcc3v3-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc0_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &k2g_pinctrl {
@@ -34,6 +41,33 @@
 			K2G_CORE_IOPAD(0x11d0) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
 		>;
 	};
+
+	mmc0_pins: pinmux_mmc0_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1300) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_dat3.mmc0_dat3 */
+			K2G_CORE_IOPAD(0x1304) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_dat2.mmc0_dat2 */
+			K2G_CORE_IOPAD(0x1308) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_dat1.mmc0_dat1 */
+			K2G_CORE_IOPAD(0x130c) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_dat0.mmc0_dat0 */
+			K2G_CORE_IOPAD(0x1310) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_clk.mmc0_clk */
+			K2G_CORE_IOPAD(0x1314) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE2)	/* mmc0_cmd.mmc0_cmd */
+			K2G_CORE_IOPAD(0x12ec) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE3)	/* mmc0_sdcd.gpio1_12 */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x10ec) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat7.mmc1_dat7 */
+			K2G_CORE_IOPAD(0x10f0) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat6.mmc1_dat6 */
+			K2G_CORE_IOPAD(0x10f4) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat5.mmc1_dat5 */
+			K2G_CORE_IOPAD(0x10f8) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat4.mmc1_dat4 */
+			K2G_CORE_IOPAD(0x10fc) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat3.mmc1_dat3 */
+			K2G_CORE_IOPAD(0x1100) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat2.mmc1_dat2 */
+			K2G_CORE_IOPAD(0x1104) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat1.mmc1_dat1 */
+			K2G_CORE_IOPAD(0x1108) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_dat0.mmc1_dat0 */
+			K2G_CORE_IOPAD(0x110c) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_clk.mmc1_clk */
+			K2G_CORE_IOPAD(0x1110) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE0)	/* mmc1_cmd.mmc1_cmd */
+		>;
+	};
 };
 
 &uart0 {
@@ -41,3 +75,22 @@
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
+
+&gpio1 {
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&vcc3v3_dcin_reg>;
+	cd-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&vcc3v3_dcin_reg>; /* VCC3V3_EMMC is connected to VCC3V3_DCIN */
+	status = "okay";
+};
-- 
2.13.0
