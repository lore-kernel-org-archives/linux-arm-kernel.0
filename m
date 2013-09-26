From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 26 Sep 2013 12:46:14 +0200
Subject: [PATCH 2/2] ARM i.MX53: dts: Add TVE to i.MX53-QSB device tree
In-Reply-To: <1380192374-9531-1-git-send-email-p.zabel@pengutronix.de>
References: <1380192374-9531-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1380192374-9531-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the TVE which is driving the VGA connector on i.MX53-QSB.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsb.dts | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index cf1aef7..3bbedf7 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -173,6 +173,15 @@ memgpu: /memreserve/ 0xb0000000 0x04000000;
 		};
 	};
 
+	tve {
+		pinctrl_vga_sync_1: vgasync-grp1 {
+			fsl,pins = <
+				/* VGA_HSYNC, VSYNC with max drive strength */
+				MX53_PAD_EIM_OE__IPU_DI1_PIN7 0xe6
+				MX53_PAD_EIM_RW__IPU_DI1_PIN8 0xe6
+			>;
+		};
+	};
 };
 
 &uart1 {
@@ -280,8 +289,8 @@ memgpu: /memreserve/ 0xb0000000 0x04000000;
 			};
 
 			ldo8_reg: ldo8 {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3600000>;
+				regulator-min-microvolt = <2750000>;
+				regulator-max-microvolt = <2750000>;
 				regulator-always-on;
 			};
 
@@ -318,6 +327,13 @@ memgpu: /memreserve/ 0xb0000000 0x04000000;
 	status = "okay";
 };
 
+&tve {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_vga_sync_1>;
+	dac-supply = <&ldo7_reg>;
+	status = "okay";
+};
+
 &usbh1 {
 	vbus-supply = <&reg_usb_vbus>;
 	phy_type = "utmi";
-- 
1.8.4.rc3
