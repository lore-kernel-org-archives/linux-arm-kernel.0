From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 17:07:26 -0300
Subject: [PATCH v4 12/12] ARM: mvebu: Relocate Armada XP PCIe device tree nodes
In-Reply-To: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371672446-21583-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mbus has been added to the device tree, it's possible to
move the PCIe nodes out of internal registers, placing it directly
below the mbus. This is a more accurate representation of the
hardware.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts               |  67 ++--
 arch/arm/boot/dts/armada-xp-gp.dts               |  43 +--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 209 ++++++-------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 245 +++++++--------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 377 ++++++++++++-----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  19 +-
 6 files changed, 483 insertions(+), 477 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index d157387..ef0d2c5 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -31,8 +31,42 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0xf0, 0x02) 0xe0000000 0 0xe0000000 0x8100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * All 6 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+			pcie at 2,0 {
+				/* Port 0, Lane 1 */
+				status = "okay";
+			};
+			pcie at 3,0 {
+				/* Port 0, Lane 2 */
+				status = "okay";
+			};
+			pcie at 4,0 {
+				/* Port 0, Lane 3 */
+				status = "okay";
+			};
+			pcie at 9,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+			pcie at 10,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -125,39 +159,6 @@
 					spi-max-frequency = <20000000>;
 				};
 			};
-
-			pcie-controller {
-				status = "okay";
-
-				/*
-				 * All 6 slots are physically present as
-				 * standard PCIe slots on the board.
-				 */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-				pcie at 2,0 {
-					/* Port 0, Lane 1 */
-					status = "okay";
-				};
-				pcie at 3,0 {
-					/* Port 0, Lane 2 */
-					status = "okay";
-				};
-				pcie at 4,0 {
-					/* Port 0, Lane 3 */
-					status = "okay";
-				};
-				pcie at 9,0 {
-					/* Port 2, Lane 0 */
-					status = "okay";
-				};
-				pcie at 10,0 {
-					/* Port 3, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 30bf645..c328538 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -40,6 +40,7 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0xf0, 0x02) 0xe0000000 0 0xe0000000 0x8100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
@@ -71,6 +72,27 @@
 			};
 		};
 
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * The 3 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+			pcie at 9,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+			pcie at 10,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -144,27 +166,6 @@
 					spi-max-frequency = <108000000>;
 				};
 			};
-
-			pcie-controller {
-				status = "okay";
-
-				/*
-				 * The 3 slots are physically present as
-				 * standard PCIe slots on the board.
-				 */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-				pcie at 9,0 {
-					/* Port 2, Lane 0 */
-					status = "okay";
-				};
-				pcie at 10,0 {
-					/* Port 3, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index f8eaa38..448b826 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -44,6 +44,111 @@
 	};
 
 	soc {
+		/*
+		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
+				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
+				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
+				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
+				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				0x82000000 0 0xe0000000 MBUS_ID(0xf0, 0x02) 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				0x81000000 0 0 MBUS_ID(0xf0, 0x02) 0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie at 3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie at 4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie at 9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+		};
+
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78230-pinctrl";
@@ -77,110 +182,6 @@
 				#interrupts-cells = <2>;
 				interrupts = <87>, <88>, <89>;
 			};
-
-			/*
-			 * MV78230 has 2 PCIe units Gen2.0: One unit can be
-			 * configured as x4 or quad x1 lanes. One unit is
-			 * x4/x1.
-			 */
-			pcie-controller {
-				compatible = "marvell,armada-xp-pcie";
-				status = "disabled";
-				device_type = "pci";
-
-#address-cells = <3>;
-#size-cells = <2>;
-
-				bus-range = <0x00 0xff>;
-
-				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-					0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
-					0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
-					0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
-					0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
-					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-					0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
-
-				pcie at 1,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
-					reg = <0x0800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 58>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 5>;
-					status = "disabled";
-				};
-
-				pcie at 2,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
-					reg = <0x1000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 59>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <1>;
-					clocks = <&gateclk 6>;
-					status = "disabled";
-				};
-
-				pcie at 3,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
-					reg = <0x1800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 60>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <2>;
-					clocks = <&gateclk 7>;
-					status = "disabled";
-				};
-
-				pcie at 4,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
-					reg = <0x2000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 61>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <3>;
-					clocks = <&gateclk 8>;
-					status = "disabled";
-				};
-
-				pcie at 9,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
-					reg = <0x4800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 99>;
-					marvell,pcie-port = <2>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 26>;
-					status = "disabled";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index c80c60e..f0d29dd 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -45,6 +45,129 @@
 	};
 
 	soc {
+		/*
+		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
+				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
+				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
+				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
+				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
+				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
+				0x82000000 0 0xe0000000 MBUS_ID(0xf0, 0x02) 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				0x81000000 0 0 MBUS_ID(0xf0, 0x02) 0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie at 3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie at 4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie at 9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie at 10,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x82000 0 0x2000>;
+				reg = <0x5000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 103>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 27>;
+				status = "disabled";
+			};
+		};
+
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78260-pinctrl";
@@ -97,128 +220,6 @@
 				clocks = <&gateclk 1>;
 				status = "disabled";
 			};
-
-			/*
-			 * MV78260 has 3 PCIe units Gen2.0: Two units can be
-			 * configured as x4 or quad x1 lanes. One unit is
-			 * x4/x1.
-			 */
-			pcie-controller {
-				compatible = "marvell,armada-xp-pcie";
-				status = "disabled";
-				device_type = "pci";
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-
-				bus-range = <0x00 0xff>;
-
-				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-					0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
-					0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
-					0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
-					0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
-					0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
-					0x82000000 0 0x82000 0x82000 0 0x00002000   /* Port 3.0 registers */
-					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-					0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
-
-				pcie at 1,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
-					reg = <0x0800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 58>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 5>;
-					status = "disabled";
-				};
-
-				pcie at 2,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x44000 0 0x2000>;
-					reg = <0x1000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 59>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <1>;
-					clocks = <&gateclk 6>;
-					status = "disabled";
-				};
-
-				pcie at 3,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x48000 0 0x2000>;
-					reg = <0x1800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 60>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <2>;
-					clocks = <&gateclk 7>;
-					status = "disabled";
-				};
-
-				pcie at 4,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x4c000 0 0x2000>;
-					reg = <0x2000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 61>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <3>;
-					clocks = <&gateclk 8>;
-					status = "disabled";
-				};
-
-				pcie at 9,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x42000 0 0x2000>;
-					reg = <0x4800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 99>;
-					marvell,pcie-port = <2>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 26>;
-					status = "disabled";
-				};
-
-				pcie at 10,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x82000 0 0x2000>;
-					reg = <0x5000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 103>;
-					marvell,pcie-port = <3>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 27>;
-					status = "disabled";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 3874548..ac10503 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -60,6 +60,195 @@
 	};
 
 	soc {
+		/*
+		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. Two units are
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-xp-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
+				0x82000000 0 0x42000 MBUS_ID(0xf0, 0x01) 0x42000 0 0x00002000   /* Port 2.0 registers */
+				0x82000000 0 0x44000 MBUS_ID(0xf0, 0x01) 0x44000 0 0x00002000   /* Port 0.1 registers */
+				0x82000000 0 0x48000 MBUS_ID(0xf0, 0x01) 0x48000 0 0x00002000   /* Port 0.2 registers */
+				0x82000000 0 0x4c000 MBUS_ID(0xf0, 0x01) 0x4c000 0 0x00002000   /* Port 0.3 registers */
+				0x82000000 0 0x80000 MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000   /* Port 1.0 registers */
+				0x82000000 0 0x82000 MBUS_ID(0xf0, 0x01) 0x82000 0 0x00002000   /* Port 3.0 registers */
+				0x82000000 0 0x84000 MBUS_ID(0xf0, 0x01) 0x84000 0 0x00002000   /* Port 1.1 registers */
+				0x82000000 0 0x88000 MBUS_ID(0xf0, 0x01) 0x88000 0 0x00002000   /* Port 1.2 registers */
+				0x82000000 0 0x8c000 MBUS_ID(0xf0, 0x01) 0x8c000 0 0x00002000   /* Port 1.3 registers */
+				0x82000000 0 0xe0000000 MBUS_ID(0xf0, 0x02) 0xe0000000 0 0x08000000   /* non-prefetchable memory */
+				0x81000000 0 0 MBUS_ID(0xf0, 0x02) 0xe8000000 0 0x00100000>; /* downstream I/O */
+
+			pcie at 1,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
+				reg = <0x0800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 58>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+			};
+
+			pcie at 2,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 59>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 6>;
+				status = "disabled";
+			};
+
+			pcie at 3,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
+				reg = <0x1800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 60>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 7>;
+				status = "disabled";
+			};
+
+			pcie at 4,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
+				reg = <0x2000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 61>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 8>;
+				status = "disabled";
+			};
+
+			pcie at 5,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
+				reg = <0x2800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 62>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+
+			pcie at 6,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
+				reg = <0x3000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 63>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <1>;
+				clocks = <&gateclk 10>;
+				status = "disabled";
+			};
+
+			pcie at 7,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
+				reg = <0x3800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 64>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <2>;
+				clocks = <&gateclk 11>;
+				status = "disabled";
+			};
+
+			pcie at 8,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
+				reg = <0x4000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 65>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <3>;
+				clocks = <&gateclk 12>;
+				status = "disabled";
+			};
+			pcie at 9,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
+				reg = <0x4800 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 99>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 26>;
+				status = "disabled";
+			};
+
+			pcie at 10,0 {
+				device_type = "pci";
+				assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
+				reg = <0x5000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				#interrupt-cells = <1>;
+				ranges;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 0 &mpic 103>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				clocks = <&gateclk 27>;
+				status = "disabled";
+			};
+		};
+
 		internal-regs {
 			pinctrl {
 				compatible = "marvell,mv78460-pinctrl";
@@ -112,194 +301,6 @@
 				clocks = <&gateclk 1>;
 				status = "disabled";
 			};
-
-			/*
-			 * MV78460 has 4 PCIe units Gen2.0: Two units can be
-			 * configured as x4 or quad x1 lanes. Two units are
-			 * x4/x1.
-			 */
-			pcie-controller {
-				compatible = "marvell,armada-xp-pcie";
-				status = "disabled";
-				device_type = "pci";
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-
-				bus-range = <0x00 0xff>;
-
-				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-					0x82000000 0 0x42000 0x42000 0 0x00002000   /* Port 2.0 registers */
-					0x82000000 0 0x44000 0x44000 0 0x00002000   /* Port 0.1 registers */
-					0x82000000 0 0x48000 0x48000 0 0x00002000   /* Port 0.2 registers */
-					0x82000000 0 0x4c000 0x4c000 0 0x00002000   /* Port 0.3 registers */
-					0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
-					0x82000000 0 0x82000 0x82000 0 0x00002000   /* Port 3.0 registers */
-					0x82000000 0 0x84000 0x84000 0 0x00002000   /* Port 1.1 registers */
-					0x82000000 0 0x88000 0x88000 0 0x00002000   /* Port 1.2 registers */
-					0x82000000 0 0x8c000 0x8c000 0 0x00002000   /* Port 1.3 registers */
-					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-					0x81000000 0 0	  0xe8000000 0 0x00100000>; /* downstream I/O */
-
-				pcie at 1,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82000800 0 0x40000 0 0x2000>;
-					reg = <0x0800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 58>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 5>;
-					status = "disabled";
-				};
-
-				pcie at 2,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82001000 0 0x44000 0 0x2000>;
-					reg = <0x1000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 59>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <1>;
-					clocks = <&gateclk 6>;
-					status = "disabled";
-				};
-
-				pcie at 3,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82001800 0 0x48000 0 0x2000>;
-					reg = <0x1800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 60>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <2>;
-					clocks = <&gateclk 7>;
-					status = "disabled";
-				};
-
-				pcie at 4,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82002000 0 0x4c000 0 0x2000>;
-					reg = <0x2000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 61>;
-					marvell,pcie-port = <0>;
-					marvell,pcie-lane = <3>;
-					clocks = <&gateclk 8>;
-					status = "disabled";
-				};
-
-				pcie at 5,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
-					reg = <0x2800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 62>;
-					marvell,pcie-port = <1>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 9>;
-					status = "disabled";
-				};
-
-				pcie at 6,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82003000 0 0x84000 0 0x2000>;
-					reg = <0x3000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 63>;
-					marvell,pcie-port = <1>;
-					marvell,pcie-lane = <1>;
-					clocks = <&gateclk 10>;
-					status = "disabled";
-				};
-
-				pcie at 7,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82003800 0 0x88000 0 0x2000>;
-					reg = <0x3800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 64>;
-					marvell,pcie-port = <1>;
-					marvell,pcie-lane = <2>;
-					clocks = <&gateclk 11>;
-					status = "disabled";
-				};
-
-				pcie at 8,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82004000 0 0x8c000 0 0x2000>;
-					reg = <0x4000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 65>;
-					marvell,pcie-port = <1>;
-					marvell,pcie-lane = <3>;
-					clocks = <&gateclk 12>;
-					status = "disabled";
-				};
-				pcie at 9,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82004800 0 0x42000 0 0x2000>;
-					reg = <0x4800 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 99>;
-					marvell,pcie-port = <2>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 26>;
-					status = "disabled";
-				};
-
-				pcie at 10,0 {
-					device_type = "pci";
-					assigned-addresses = <0x82005000 0 0x82000 0 0x2000>;
-					reg = <0x5000 0 0 0 0>;
-					#address-cells = <3>;
-					#size-cells = <2>;
-					#interrupt-cells = <1>;
-					ranges;
-					interrupt-map-mask = <0 0 0 0>;
-					interrupt-map = <0 0 0 0 &mpic 103>;
-					marvell,pcie-port = <3>;
-					marvell,pcie-lane = <0>;
-					clocks = <&gateclk 27>;
-					status = "disabled";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 565765c..cebc27e 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -28,6 +28,7 @@
 
 	soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+			  MBUS_ID(0xf0, 0x02) 0xe0000000 0 0xe0000000 0x8100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x8000000>;
 
@@ -59,6 +60,15 @@
 			};
 		};
 
+		pcie-controller {
+			status = "okay";
+			/* Internal mini-PCIe connector */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -172,15 +182,6 @@
 			usb at 51000 {
 				status = "okay";
 			};
-
-			pcie-controller {
-				status = "okay";
-				/* Internal mini-PCIe connector */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
 };
-- 
1.8.1.5
