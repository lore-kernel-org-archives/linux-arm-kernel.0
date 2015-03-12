From: moon.linux@yahoo.com (Anand Moon)
Date: Thu, 12 Mar 2015 12:59:51 +0530
Subject: [PATCH] ARM: dts: exynos5420 Fixes -ELOOP (Too many levels of
 symbolic links)
Message-ID: <1426145391-30089-1-git-send-email-moon.linux@yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BUG of recursive symbolic link and be observed by using below powerdebug
        git://git.linaro.org/tools/powerdebug.git.

This utility populates the Clock, Regulators, Sensors and Gpio.
Some how the regulators were not getting populated by this utility.
After debugging this powerdebug application using 'strace' I can across following.

Below output is trunkated.

stat64("/sys/class/regulator/regulator.0/usb at 12000000-vdd10/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group/devices/usb at 12000000/
iommu_group/devices/usb at 12000000/iommu_group", 0xbec45fb8) = -1 ELOOP (Too many levels of symbolic links)
close(63)                               = 0
close(62)                               = 0

These changes depend on following series of commit.
 Pull iommu fixes from Joerg Roedel:
     "The patches contain:

       - fix multiple ARM IOMMU drivers to behave well when the hardware is
         not present

       - mark MSM driver as broken

       - fix build errors with the new ARM generic io-page-table code"

    * tag 'iommu-fixes-v4.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu:
      iommu/io-pgtable-arm: Add built time dependency
      iommu/msm: Mark driver BROKEN
      iommu/rockchip: Play nice in multi-platform builds
      iommu/omap: Play nice in multi-platform builds
      iommu/exynos: Play nice in multi-platform builds
      iommu/io-pgtable-arm: Fix self-test WARNs on i386

After these changes powerdebug will populate regulators.

Tested on OdroidXU3 board.

Signed-off-by: Anand Moon <moon.linux@yahoo.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9dc2e97..a5f13a3 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -840,14 +840,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+	};
 
-		usbdrd_dwc3_0: dwc3 {
-			compatible = "snps,dwc3";
-			reg = <0x12000000 0x10000>;
-			interrupts = <0 72 0>;
-			phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
-			phy-names = "usb2-phy", "usb3-phy";
-		};
+	usbdrd_dwc3_0: dwc3 {
+		compatible = "snps,dwc3";
+		reg = <0x12000000 0x10000>;
+		interrupts = <0 72 0>;
+		phys = <&usbdrd_phy0 0>, <&usbdrd_phy0 1>;
+		phy-names = "usb2-phy", "usb3-phy";
 	};
 
 	usbdrd_phy0: phy at 12100000 {
@@ -866,14 +866,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+	};
 
-		usbdrd_dwc3_1: dwc3 {
-			compatible = "snps,dwc3";
-			reg = <0x12400000 0x10000>;
-			interrupts = <0 73 0>;
-			phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
-			phy-names = "usb2-phy", "usb3-phy";
-		};
+	usbdrd_dwc3_1: dwc3 {
+		compatible = "snps,dwc3";
+		reg = <0x12400000 0x10000>;
+		interrupts = <0 73 0>;
+		phys = <&usbdrd_phy1 0>, <&usbdrd_phy1 1>;
+		phy-names = "usb2-phy", "usb3-phy";
 	};
 
 	usbdrd_phy1: phy at 12500000 {
-- 
2.1.0
