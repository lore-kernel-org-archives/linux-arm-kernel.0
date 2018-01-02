From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  2 Jan 2018 15:55:56 +0100
Subject: [PATCH v2 6/8] arm64: dts: marvell: use aliases for SPI busses on
 Armada 7K/8K
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <20180102145558.9773-7-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are currently using the cell-index DT property to assign SPI bus
numbers. This property is specific to the spi-orion driver, and
requires each SPI controller to have a unique ID defined in the Device
Tree.

As we are about to merge armada-cp110-master.dtsi and
armada-cp110-slave.dtsi into a single file, those cell-index
properties that differ between the master CP110 and the slave CP110
are a difference that would have to be handled.

In order to avoid this, we switch to using the "aliases" DT node to
assign a unique number to each SPI controller. This is more generic,
and directly handled by the SPI core.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi         | 2 ++
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi         | 4 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        | 2 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 2 --
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 2 --
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 0e1a1e5be399..815e64b3a874 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -50,6 +50,8 @@
 	aliases {
 		gpio1 = &cpm_gpio1;
 		gpio2 = &cpm_gpio2;
+		spi1 = &cpm_spi0;
+		spi2 = &cpm_spi1;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
index b280ddd3c397..de9c34333cd4 100644
--- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
@@ -51,6 +51,10 @@
 	aliases {
 		gpio1 = &cps_gpio1;
 		gpio2 = &cpm_gpio2;
+		spi1 = &cpm_spi0;
+		spi2 = &cpm_spi1;
+		spi3 = &cps_spi0;
+		spi4 = &cps_spi1;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 0575207cafee..f9b66b81f9fc 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -58,6 +58,7 @@
 		serial0 = &uart0;
 		serial1 = &uart1;
 		gpio0 = &ap_gpio;
+		spi0 = &spi0;
 	};
 
 	psci {
@@ -203,7 +204,6 @@
 				reg = <0x510600 0x50>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				cell-index = <0>;
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&ap_clk 3>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index f89053577bcc..162e6c228bd9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -280,7 +280,6 @@
 				reg = <0x700600 0x50>;
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
-				cell-index = <1>;
 				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
@@ -290,7 +289,6 @@
 				reg = <0x700680 0x50>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				cell-index = <2>;
 				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index a658b72b0229..207b6f444e24 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -281,7 +281,6 @@
 				reg = <0x700600 0x50>;
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
-				cell-index = <3>;
 				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
@@ -291,7 +290,6 @@
 				reg = <0x700680 0x50>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				cell-index = <4>;
 				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
-- 
2.14.3
