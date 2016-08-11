From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Aug 2016 18:50:50 +0100
Subject: [PATCH v2] arm64: dts: qcom: Fix broken interrupt trigger settings
Message-ID: <1470937850-10492-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a device uses the GIC as its interrupt controller and generates
SPIs, only the values 1 (edge rising) and 4 (level high) are legal.

Anything else is just plain wrong (can't be programmed into the HW),
and leads to aborted driver probes (USB doesn't work with 4.8-rc1
on a Dragonboard 410C).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
* From v1:
  - Fixed USB interrupts after review from Stephen

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 10 +++++-----
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 11bdc24..b010d33 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -483,7 +483,7 @@
 			compatible = "qcom,ci-hdrc";
 			reg = <0x78d9000 0x400>;
 			dr_mode = "peripheral";
-			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			usb-phy = <&usb_otg>;
 			status = "disabled";
 		};
@@ -491,7 +491,7 @@
 		usb_host: ehci at 78d9000 {
 			compatible = "qcom,ehci-host";
 			reg = <0x78d9000 0x400>;
-			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			usb-phy = <&usb_otg>;
 			status = "disabled";
 		};
@@ -499,8 +499,8 @@
 		usb_otg: phy at 78d9000 {
 			compatible = "qcom,usb-otg-snps";
 			reg = <0x78d9000 0x400>;
-			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 
 			qcom,vdd-levels = <500000 1000000 1320000>;
 			qcom,phy-init-sequence = <0x44 0x6B 0x24 0x13>;
@@ -594,7 +594,7 @@
 			      <0x200a000 0x002100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 55ec3e8..69ed6e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -339,7 +339,7 @@
 			      <0x400a000 0x002100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 326 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
-- 
2.1.4
