From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:55 +0530
Subject: [RFC PATCH 40/40] arm64: dts: k3-am6: Add Root Complex PCIe dt node
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-41-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Root Complex PCIe dt node.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 83 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi      |  1 +
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index b08d15fa110e..0a5d74a8eef4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -14,6 +14,21 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_mode: pcie-mode at 4060 {
+			compatible = "syscon";
+			reg = <0x00004060 0x4>;
+		};
+
+		pcie1_mode: pcie-mode at 4070 {
+			compatible = "syscon";
+			reg = <0x00004070 0x4>;
+		};
+
+		pcie_devid: pcie-devid at 210 {
+			compatible = "syscon";
+			reg = <0x00000210 0x4>;
+		};
+
 		serdes0_clk: serdes_clk at 4080 {
 			compatible = "syscon";
 			reg = <0x00004080 0x4>;
@@ -128,4 +143,72 @@
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 	};
+
+	pcie0_rc: pcie at 5500000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5500000 0x0 0x1000>, <0x0 0x5501000 0x0 0x1000>, <0x0 0x10000000 0x0 0x2000>, <0x0 0x5506000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 120>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000
+			  0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie0_mode>;
+		bus-range = <0x0 0xff>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-ob-windows = <16>;
+		num-viewport = <16>;
+		interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
+				<0 0 0 2 &pcie0_intc 0>, /* INT B */
+				<0 0 0 3 &pcie0_intc 0>, /* INT C */
+				<0 0 0 4 &pcie0_intc 0>; /* INT D */
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		status = "disabled";
+
+		pcie0_intc: legacy-interrupt-controller at 1 {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie1_rc: pcie at 5600000 {
+		compatible = "ti,am654-pcie-rc";
+		reg =  <0x0 0x5600000 0x0 0x1000>, <0x0 0x5601000 0x0 0x1000>, <0x0 0x18000000 0x0 0x2000>, <0x0 0x5606000 0x0 0x1000>;
+		reg-names = "app", "dbics", "config", "atu";
+		power-domains = <&k3_pds 121>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges = <0x81000000 0 0          0x0   0x18020000 0 0x00010000
+			  0x82000000 0 0x18030000 0x0   0x18030000 0 0x07FD0000>;
+		ti,syscon-pcie-id = <&pcie_devid>;
+		ti,syscon-pcie-mode = <&pcie1_mode>;
+		bus-range = <0x0 0xff>;
+		status = "disabled";
+		device_type = "pci";
+		num-lanes = <1>;
+		num-ob-windows = <16>;
+		num-viewport = <16>;
+		interrupts = <GIC_SPI 355 IRQ_TYPE_EDGE_RISING>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>, /* INT A */
+				<0 0 0 2 &pcie1_intc 0>, /* INT B */
+				<0 0 0 3 &pcie1_intc 0>, /* INT C */
+				<0 0 0 4 &pcie1_intc 0>; /* INT D */
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+
+		pcie1_intc: legacy-interrupt-controller at 1 {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 343 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index 3d4bf369d030..b87081765894 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -61,6 +61,7 @@
 			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 /* MCUSS Range */
 			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
 			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
-- 
2.17.1
