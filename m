From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 13 Apr 2013 16:56:39 +0200
Subject: [PATCHv3 04/10] arm: kirkwood: add SoC-level Device Tree data for
 PCIe interfaces
In-Reply-To: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365865005-26653-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1365865005-26653-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds Device Tree details to enable the PCIe interfaces on
Kirkwood. The 6281 has one PCIe interface, the 6282 has two PCIe
interfaces.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6281.dtsi |   31 ++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-6282.dtsi |   48 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi      |    1 +
 3 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index d6c9d65..5137668 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -40,5 +40,36 @@
 				marvell,function = "sdio";
 			};
 		};
+
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 192cf76..00a698e 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -59,5 +59,53 @@
 			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
+
+		pcie-controller {
+			compatible = "marvell,kirkwood-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges = <0x82000000 0 0x00040000 0x00040000 0 0x00002000   /* Port 0.0 registers */
+			          0x82000000 0 0x00044000 0x00044000 0 0x00002000   /* Port 1.0 registers */
+				  0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+			          0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x00040000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 9>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 2>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001000 0 0x00044000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &intc 10>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gate_clk 18>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 2c738d9..8aae1cf 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -19,6 +19,7 @@
 	ocp at f1000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0xf1000000 0x4000000
+		          0xe0000000 0xe0000000 0x8100000 /* PCIE */
 		          0xf5000000 0xf5000000 0x0000400>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.7.9.5
