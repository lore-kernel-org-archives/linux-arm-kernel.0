From: dwoo08.lee@samsung.com (Dongwoo Lee)
Date: Tue, 20 Jun 2017 16:12:23 +0900
Subject: [PATCH 1/2] arm64: dts: exynos: Fix wrong label for USB 3.0
 controller node
In-Reply-To: <1497942745-8607-1-git-send-email-dwoo08.lee@samsung.com>
References: <1497942745-8607-1-git-send-email-dwoo08.lee@samsung.com>
 <CGME20170620071230epcas5p497144c7ccd8485da9109b8905a5ea36e@epcas5p4.samsung.com>
Message-ID: <1497942745-8607-2-git-send-email-dwoo08.lee@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5433 has two usb 3.0 controllers: usbhost and usbdrd. usbhost
is host-only controller whereas usbdrd supports both peripheral and
host mode. "drd" means dual-role device, so usbhost cannot be labeled
with the name contains "drd". Howerver, the label usbdrd_dwc3_0 was
used for usbhost's dwc3 node. It seems it obviously fault because TM2
and TM2E doesn't use usbhost but dr_mode property is assigned to it.

This patch assigns the proper label for two dwc3 nodes, and apply
changes to the related reference.

Signed-off-by: Dongwoo Lee <dwoo08.lee@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 804a270..477c3bc 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -1202,7 +1202,7 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd_dwc3 {
 	dr_mode = "otg";
 };
 
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 727f36a..7fe994b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1367,7 +1367,7 @@
 			ranges;
 			status = "disabled";
 
-			dwc3 at 15400000 {
+			usbdrd_dwc3: dwc3 at 15400000 {
 				compatible = "snps,dwc3";
 				reg = <0x15400000 0x10000>;
 				interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
@@ -1414,7 +1414,7 @@
 			ranges;
 			status = "disabled";
 
-			usbdrd_dwc3_0: dwc3 at 15a00000 {
+			usbhost_dwc3: dwc3 at 15a00000 {
 				compatible = "snps,dwc3";
 				reg = <0x15a00000 0x10000>;
 				interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1
