From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 28 May 2016 11:54:27 +0200
Subject: [PATCH v5 16/22] ARM: dts: exynos: Add USB to Exynos5410
In-Reply-To: <1464429273-23457-1-git-send-email-krzk@kernel.org>
References: <1464429273-23457-1-git-send-email-krzk@kernel.org>
Message-ID: <1464429273-23457-17-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move USB 3.0 DWC and 2.0 EHCI/OHCI nodes from exynos5420.dtsi to
exynos54xx.dtsi common for entire family. For Exynos542x/5800 this
should not have functional impact but for Exynos5410 this effectively
adds USB support.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5410.dtsi |  39 +++++++++++
 arch/arm/boot/dts/exynos5420.dtsi | 133 +++++++++++---------------------------
 arch/arm/boot/dts/exynos54xx.dtsi |  79 ++++++++++++++++++++++
 3 files changed, 157 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 1354b5bbc14e..6146bf164248 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -188,4 +188,43 @@
 		  3 0 0x07000000 0x20000>;
 };
 
+&usbdrd3_0 {
+	clocks = <&clock CLK_USBD300>;
+	clock-names = "usbdrd30";
+};
+
+&usbdrd_phy0 {
+	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
+	clock-names = "phy", "ref";
+	samsung,pmu-syscon = <&pmu_system_controller>;
+};
+
+&usbdrd3_1 {
+	clocks = <&clock CLK_USBD301>;
+	clock-names = "usbdrd30";
+};
+
+&usbdrd_phy1 {
+	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
+	clock-names = "phy", "ref";
+	samsung,pmu-syscon = <&pmu_system_controller>;
+};
+
+&usbhost1 {
+	clocks = <&clock CLK_USBH20>;
+	clock-names = "usbhost";
+};
+
+&usbhost2 {
+	clocks = <&clock CLK_USBH20>;
+	clock-names = "usbhost";
+};
+
+&usb2_phy {
+	clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
+	clock-names = "phy", "ref";
+	samsung,sysreg-phandle = <&sysreg_system_controller>;
+	samsung,pmureg-phandle = <&pmu_system_controller>;
+};
+
 #include "exynos5410-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ebf2ed3c5ff8..8fa65eb8027d 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -41,8 +41,6 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
-		usbdrdphy0 = &usbdrd_phy0;
-		usbdrdphy1 = &usbdrd_phy1;
 	};
 
 	/*
@@ -770,98 +768,6 @@
 			clock-names = "secss";
 		};
 
-		usbdrd3_0: usb3-0 {
-			compatible = "samsung,exynos5250-dwusb3";
-			clocks = <&clock CLK_USBD300>;
-			clock-names = "usbdrd30";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usbdrd_dwc3_0: dwc3 at 12000000 {
-				compatible = "snps,dwc3";
-				reg = <0x12000000 0x10000>;
-				interrupts = <0 72 0>;
-				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
-				phy-names = "usb2-phy", "usb3-phy";
-			};
-		};
-
-		usbdrd_phy0: phy at 12100000 {
-			compatible = "samsung,exynos5420-usbdrd-phy";
-			reg = <0x12100000 0x100>;
-			clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
-			clock-names = "phy", "ref";
-			samsung,pmu-syscon = <&pmu_system_controller>;
-			#phy-cells = <1>;
-		};
-
-		usbdrd3_1: usb3-1 {
-			compatible = "samsung,exynos5250-dwusb3";
-			clocks = <&clock CLK_USBD301>;
-			clock-names = "usbdrd30";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			usbdrd_dwc3_1: dwc3 at 12400000 {
-				compatible = "snps,dwc3";
-				reg = <0x12400000 0x10000>;
-				interrupts = <0 73 0>;
-				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
-				phy-names = "usb2-phy", "usb3-phy";
-			};
-		};
-
-		usbdrd_phy1: phy at 12500000 {
-			compatible = "samsung,exynos5420-usbdrd-phy";
-			reg = <0x12500000 0x100>;
-			clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
-			clock-names = "phy", "ref";
-			samsung,pmu-syscon = <&pmu_system_controller>;
-			#phy-cells = <1>;
-		};
-
-		usbhost2: usb at 12110000 {
-			compatible = "samsung,exynos4210-ehci";
-			reg = <0x12110000 0x100>;
-			interrupts = <0 71 0>;
-
-			clocks = <&clock CLK_USBH20>;
-			clock-names = "usbhost";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port at 0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
-		};
-
-		usbhost1: usb at 12120000 {
-			compatible = "samsung,exynos4210-ohci";
-			reg = <0x12120000 0x100>;
-			interrupts = <0 71 0>;
-
-			clocks = <&clock CLK_USBH20>;
-			clock-names = "usbhost";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			port at 0 {
-				reg = <0>;
-				phys = <&usb2_phy 1>;
-			};
-		};
-
-		usb2_phy: phy at 12130000 {
-			compatible = "samsung,exynos5250-usb2-phy";
-			reg = <0x12130000 0x100>;
-			clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
-			clock-names = "phy", "ref";
-			#phy-cells = <1>;
-			samsung,sysreg-phandle = <&sysreg_system_controller>;
-			samsung,pmureg-phandle = <&pmu_system_controller>;
-		};
-
 		sysmmu_g2dr: sysmmu at 0x10A60000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x10A60000 0x1000>;
@@ -1153,4 +1059,43 @@
 	clock-names = "uart", "clk_uart_baud0";
 };
 
+&usbdrd3_0 {
+	clocks = <&clock CLK_USBD300>;
+	clock-names = "usbdrd30";
+};
+
+&usbdrd_phy0 {
+	clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
+	clock-names = "phy", "ref";
+	samsung,pmu-syscon = <&pmu_system_controller>;
+};
+
+&usbdrd3_1 {
+	clocks = <&clock CLK_USBD301>;
+	clock-names = "usbdrd30";
+};
+
+&usbdrd_phy1 {
+	clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
+	clock-names = "phy", "ref";
+	samsung,pmu-syscon = <&pmu_system_controller>;
+};
+
+&usbhost1 {
+	clocks = <&clock CLK_USBH20>;
+	clock-names = "usbhost";
+};
+
+&usbhost2 {
+	clocks = <&clock CLK_USBH20>;
+	clock-names = "usbhost";
+};
+
+&usb2_phy {
+	clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
+	clock-names = "phy", "ref";
+	samsung,sysreg-phandle = <&sysreg_system_controller>;
+	samsung,pmureg-phandle = <&pmu_system_controller>;
+};
+
 #include "exynos5420-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 1bcfb7f455c1..e01d068d4c38 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -20,6 +20,11 @@
 / {
 	compatible = "samsung,exynos5";
 
+	aliases {
+		usbdrdphy0 = &usbdrd_phy0;
+		usbdrdphy1 = &usbdrd_phy1;
+	};
+
 	soc: soc {
 		sysram at 02020000 {
 			compatible = "mmio-sram";
@@ -64,5 +69,79 @@
 						<11 &gic 0 131 0>;
 			};
 		};
+
+		usbdrd3_0: usb3-0 {
+			compatible = "samsung,exynos5250-dwusb3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbdrd_dwc3_0: dwc3 at 12000000 {
+				compatible = "snps,dwc3";
+				reg = <0x12000000 0x10000>;
+				interrupts = <0 72 0>;
+				phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usbdrd_phy0: phy at 12100000 {
+			compatible = "samsung,exynos5420-usbdrd-phy";
+			reg = <0x12100000 0x100>;
+			#phy-cells = <1>;
+		};
+
+		usbdrd3_1: usb3-1 {
+			compatible = "samsung,exynos5250-dwusb3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			usbdrd_dwc3_1: dwc3 at 12400000 {
+				compatible = "snps,dwc3";
+				reg = <0x12400000 0x10000>;
+				interrupts = <0 73 0>;
+				phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
+				phy-names = "usb2-phy", "usb3-phy";
+			};
+		};
+
+		usbdrd_phy1: phy at 12500000 {
+			compatible = "samsung,exynos5420-usbdrd-phy";
+			reg = <0x12500000 0x100>;
+			#phy-cells = <1>;
+		};
+
+		usbhost2: usb at 12110000 {
+			compatible = "samsung,exynos4210-ehci";
+			reg = <0x12110000 0x100>;
+			interrupts = <0 71 0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port at 0 {
+				reg = <0>;
+				phys = <&usb2_phy 1>;
+			};
+		};
+
+		usbhost1: usb at 12120000 {
+			compatible = "samsung,exynos4210-ohci";
+			reg = <0x12120000 0x100>;
+			interrupts = <0 71 0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port at 0 {
+				reg = <0>;
+				phys = <&usb2_phy 1>;
+			};
+		};
+
+		usb2_phy: phy at 12130000 {
+			compatible = "samsung,exynos5250-usb2-phy";
+			reg = <0x12130000 0x100>;
+			#phy-cells = <1>;
+		};
 	};
 };
-- 
2.7.4
