From: tony@atomide.com (Tony Lindgren)
Date: Thu,  3 Dec 2015 17:25:33 -0800
Subject: [PATCH 5/7] ARM: dts: Add mmc support for dm8148-evm
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Message-ID: <1449192335-10137-6-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a mmc slot on the dm8148-evm that's wired to the sd_1
interface.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-evm.dts | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index 109fd47..08d01c3 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -15,6 +15,14 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>;	/* 1 GB */
 	};
+
+	/* MIC94060YC6 controlled by SD1_POW pin */
+	vmmcsd_fixed: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmcsd_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &cpsw_emac0 {
@@ -26,3 +34,26 @@
 	phy_id = <&davinci_mdio>, <1>;
 	phy-mode = "rgmii";
 };
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd1_pins>;
+	vmmc-supply = <&vmmcsd_fixed>;
+	bus-width = <4>;
+	cd-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+};
+
+&pincntl {
+	sd1_pins: pinmux_sd1_pins {
+		pinctrl-single,pins = <
+			DM814X_IOPAD(0x0800, PIN_INPUT | 0x1)	/* SD1_CLK */
+			DM814X_IOPAD(0x0804, PIN_INPUT_PULLUP |  0x1)	/* SD1_CMD */
+			DM814X_IOPAD(0x0808, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[0] */
+			DM814X_IOPAD(0x080c, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[1] */
+			DM814X_IOPAD(0x0810, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[2] */
+			DM814X_IOPAD(0x0814, PIN_INPUT_PULLUP |  0x1)	/* SD1_DAT[3] */
+			DM814X_IOPAD(0x0924, PIN_OUTPUT |  0x40)	/* SD1_POW */
+			DM814X_IOPAD(0x093C, PIN_INPUT_PULLUP |  0x80)	/* GP1[6] */
+			>;
+	};
+};
-- 
2.6.2
