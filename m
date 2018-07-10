From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 10 Jul 2018 14:25:30 -0700
Subject: [PATCH 1/2] arm64: dts: stingray: add PAXC support
In-Reply-To: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
References: <1531257931-11591-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1531257931-11591-2-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PAXC support to Broadcom Stingray SoC

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-pcie.dtsi  | 54 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 11 +++++
 2 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
new file mode 100644
index 0000000..33a472a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pcie.dtsi
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+
+pcie8: pcie at 60400000 {
+	compatible = "brcm,iproc-pcie-paxc-v2";
+	reg = <0 0x60400000 0 0x1000>;
+	linux,pci-domain = <8>;
+
+	bus-range = <0x0 0x1>;
+
+	#address-cells = <3>;
+	#size-cells = <2>;
+	device_type = "pci";
+	ranges = <0x83000000 0 0x10000000 0 0x10000000 0 0x20000000>;
+
+	dma-coherent;
+
+	msi-map = <0x100 &gic_its 0x2000 0x1>, /* PF0 */
+		  <0x108 &gic_its 0x2040 0x8>, /* PF0-VF0-7 */
+		  <0x101 &gic_its 0x2080 0x1>, /* PF1 */
+		  <0x110 &gic_its 0x20c8 0x8>, /* PF1-VF8-15 */
+		  <0x102 &gic_its 0x2100 0x1>, /* PF2 */
+		  <0x118 &gic_its 0x2150 0x8>, /* PF2-VF16-23 */
+		  <0x103 &gic_its 0x2180 0x1>, /* PF3 */
+		  <0x120 &gic_its 0x21d8 0x8>, /* PF3-VF24-31 */
+		  <0x104 &gic_its 0x2200 0x1>, /* PF4 */
+		  <0x128 &gic_its 0x2260 0x8>, /* PF4-VF32-39 */
+		  <0x105 &gic_its 0x2280 0x1>, /* PF5 */
+		  <0x130 &gic_its 0x22e8 0x8>, /* PF5-VF40-47 */
+		  <0x106 &gic_its 0x2300 0x1>, /* PF6 */
+		  <0x138 &gic_its 0x2370 0x8>, /* PF6-VF48-55 */
+		  <0x107 &gic_its 0x2380 0x1>, /* PF7 */
+		  <0x140 &gic_its 0x23f8 0x8>; /* PF7-VF56-63 */
+
+	phys = <&pcie_phy 8>;
+	phy-names = "pcie-phy";
+};
+
+pcie-ss {
+	compatible = "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0x0 0x0 0x40000000 0x800>;
+
+	pcie_phy: phy at 0 {
+		compatible = "brcm,sr-pcie-phy";
+		reg = <0x0 0x200>;
+		brcm,sr-cdru = <&cdru>;
+		brcm,sr-mhb = <&mhb>;
+		#phy-cells = <1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index e8be784..4ad4797 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -146,6 +146,11 @@
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	mhb: syscon at 60401000 {
+		compatible = "brcm,sr-mhb", "syscon";
+		reg = <0 0x60401000 0 0x38c>;
+	};
+
 	scr {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -265,6 +270,11 @@
 			status = "okay";
 		};
 
+		cdru: syscon at 1d000 {
+			compatible = "brcm,sr-cdru", "syscon";
+			reg = <0x0001d000 0x400>;
+		};
+
 		gpio_crmu: gpio at 24800 {
 			compatible = "brcm,iproc-gpio";
 			reg = <0x00024800 0x4c>;
@@ -276,6 +286,7 @@
 
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
+	#include "stingray-pcie.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.1.4
