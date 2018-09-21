From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:50 +0530
Subject: [RFC PATCH 35/40] ARM: dts: keystone-k2e: Use the updated binding to
 describe PCIe in k2e
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-36-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the updated binding to describe PCIe in k2e. (The older binding has
never worked in upstream kernel since serdes driver was never upstreamed).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 15 ++++++++-------
 arch/arm/boot/dts/keystone.dtsi     | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 085e7326ea8e..d9945d600c95 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -136,20 +136,21 @@
 		};
 
 		pcie1: pcie at 21020000 {
-			compatible = "ti,keystone-pcie","snps,dw-pcie";
+			compatible = "ti,keystone-pcie", "snps,dw-pcie";
+			reg =  <0x21020000 0x1000>, <0x21021000 0x1000>, <0x21022000 0x1000>;
+			reg-names = "app", "dbics", "config";
 			clocks = <&clkpcie1>;
-			clock-names = "pcie";
+			clock-names = "fck";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21021000 0x2000>, <0x21020000 0x1000>, <0x02620128 4>;
-			ranges = <0x82000000 0 0x60000000 0x60000000
-				  0 0x10000000>;
-
+			ranges = <0x82000000 0 0x60000000 0x60000000 0 0x10000000>;
+			ti,syscon-pcie-id = <&pcie_devid>;
+			ti,syscon-pcie-mode = <&pcie_mode>;
 			status = "disabled";
 			device_type = "pci";
 			num-lanes = <2>;
+			num-viewport = <32>;
 			bus-range = <0x00 0xff>;
-
 			/* error interrupt */
 			interrupts = <GIC_SPI 385 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c298675a29a5..0245fe854367 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -93,6 +93,16 @@
 			#size-cells = <1>;
 			ranges = <0x0 0x02620000 0x1000>;
 
+			pcie_devid: pcie-devid at 128 {
+				compatible = "syscon";
+				reg = <0x00000128 0x4>;
+			};
+
+			pcie_mode: pcie-mode at 14c {
+				compatible = "syscon";
+				reg = <0x0000014c 0x4>;
+			};
+
 			kirq0: keystone_irq at 2a0 {
 				compatible = "ti,keystone-irq";
 				reg = <0x2a0 0x4>;
@@ -297,13 +307,13 @@
 
 		pcie0: pcie at 21800000 {
 			compatible = "ti,keystone-pcie", "snps,dw-pcie";
+			reg =  <0x21800000 0x1000>, <0x21801000 0x1000>, <0x21802000 0x1000>;
+			reg-names = "app", "dbics", "config";
 			clocks = <&clkpcie>;
-			clock-names = "pcie";
+			clock-names = "fck";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			reg =  <0x21801000 0x2000>, <0x21800000 0x1000>, <0x02620128 4>;
-			ranges = <0x82000000 0 0x50000000 0x50000000
-				  0 0x10000000>;
+			ranges = <0x82000000 0 0x50000000 0x50000000 0 0x10000000>;
 
 			status = "disabled";
 			device_type = "pci";
-- 
2.17.1
