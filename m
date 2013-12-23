From: mporter@linaro.org (Matt Porter)
Date: Mon, 23 Dec 2013 13:36:38 -0500
Subject: [PATCH v9 9/9] ARM: dts: add usb udc support to bcm281xx
In-Reply-To: <1387823798-10211-1-git-send-email-mporter@linaro.org>
References: <1387823798-10211-1-git-send-email-mporter@linaro.org>
Message-ID: <1387823798-10211-10-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds USB OTG/PHY and clock support to BCM281xx and enables
UDC support on the bcm11351-brt and bcm28155-ap boards.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
---
 arch/arm/boot/dts/bcm11351-brt.dts |  6 ++++++
 arch/arm/boot/dts/bcm11351.dtsi    | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm28155-ap.dts  |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
index 23cd16d..396b704 100644
--- a/arch/arm/boot/dts/bcm11351-brt.dts
+++ b/arch/arm/boot/dts/bcm11351-brt.dts
@@ -44,5 +44,11 @@
 		status = "okay";
 	};
 
+	usbotg: usb at 3f120000 {
+		status = "okay";
+	};
 
+	usbphy: usb-phy at 3f130000 {
+		status = "okay";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 1246885..0fbb455 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -243,4 +243,22 @@
 			#clock-cells = <0>;
 		};
 	};
+
+	usbotg: usb at 3f120000 {
+		compatible = "snps,dwc2";
+		reg = <0x3f120000 0x10000>;
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&usb_otg_ahb_clk>;
+		clock-names = "otg";
+		phys = <&usbphy>;
+		phy-names = "usb2-phy";
+		status = "disabled";
+	};
+
+	usbphy: usb-phy at 3f130000 {
+		compatible = "brcm,kona-usb2-phy";
+		reg = <0x3f130000 0x28>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
index 08e47c2..a3bc436 100644
--- a/arch/arm/boot/dts/bcm28155-ap.dts
+++ b/arch/arm/boot/dts/bcm28155-ap.dts
@@ -43,4 +43,12 @@
 		cd-gpios = <&gpio 14 0>;
 		status = "okay";
 	};
+
+	usbotg: usb at 3f120000 {
+		status = "okay";
+	};
+
+	usbphy: usb-phy at 3f130000 {
+		status = "okay";
+	};
 };
-- 
1.8.4
