From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:32 -0300
Subject: [PATCH v6 21/21] ARM: mvebu: Relocate Armada 370/XP PCIe device tree
 nodes
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-22-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mbus has been added to the device tree, it's possible to
move the PCIe nodes out of internal registers, placing it directly
below the mbus. This is a more accurate representation of the
hardware.

Moving the PCIe nodes, we now need to introduce an extra cell to
encode the window target ID and attribute. Since this depends on
the PCIe port, we split the ranges translation entries, to correspond
to each MBus window.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts         |  32 +-
 arch/arm/boot/dts/armada-370.dtsi                |  99 +++---
 arch/arm/boot/dts/armada-xp-db.dts               |  67 ++--
 arch/arm/boot/dts/armada-xp-gp.dts               |  42 +--
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         | 217 +++++++------
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         | 256 ++++++++-------
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         | 395 ++++++++++++-----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  18 +-
 8 files changed, 584 insertions(+), 542 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 19341d2..2471d9d 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -28,6 +28,22 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
+		pcie-controller {
+			status = "okay";
+
+			/* Internal mini-PCIe connector */
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+
+			/* Connected on the PCB to a USB 3.0 XHCI controller */
+			pcie at 2,0 {
+				/* Port 1, Lane 0 */
+				status = "okay";
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
@@ -123,22 +139,6 @@
 					reg = <0x25>;
 				};
 			};
-
-			pcie-controller {
-				status = "okay";
-
-				/* Internal mini-PCIe connector */
-				pcie at 1,0 {
-					/* Port 0, Lane 0 */
-					status = "okay";
-				};
-
-				/* Connected on the PCB to a USB 3.0 XHCI controller */
-				pcie at 2,0 {
-					/* Port 1, Lane 0 */
-					status = "okay";
-				};
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index bd21d49..066a79f 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -36,6 +36,57 @@
 			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 		};
 
+		pcie-controller {
+			compatible = "marvell,armada-370-pcie";
+			status = "disabled";
+			device_type = "pci";
+
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			bus-range = <0x00 0xff>;
+
+			ranges =
+			       <0x82000000 0 0x40000    MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000
+				0x82000000 0 0x80000    MBUS_ID(0xf0, 0x01) 0x80000 0 0x00002000
+				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
+				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */
+				0x82001000 0 0xe0000000 MBUS_ID(0x08, 0xe8) 0xe0000000 0 0x08000000 /* Port 1.0 MEM */
+				0x81001000 0 0          MBUS_ID(0x08, 0xe0) 0xe8000000 0 0x00100000 /* Port 1.0 IO */>;
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
+				assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
+				reg = <0x1000 0 0 0 0>;
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
+		};
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
@@ -174,54 +225,6 @@
 					0x18304 0x4>;
 				status = "okay";
 			};
-
-			pcie-controller {
-				compatible = "marvell,armada-370-pcie";
-				status = "disabled";
-				device_type = "pci";
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-
-				bus-range = <0x00 0xff>;
-
-				ranges = <0x82000000 0 0x40000 0x40000 0 0x00002000   /* Port 0.0 registers */
-					0x82000000 0 0x80000 0x80000 0 0x00002000   /* Port 1.0 registers */
-					0x82000000 0 0xe0000000 0xe0000000 0 0x08000000   /* non-prefetchable memory */
-					0x81000000 0 0          0xe8000000 0 0x00100000>; /* downstream I/O */
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
-					assigned-addresses = <0x82002800 0 0x80000 0 0x2000>;
-					reg = <0x1000 0 0 0 0>;
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
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 76ae1a9..bcf6d79 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -62,6 +62,39 @@
 			};
 		};
 
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
@@ -155,40 +188,6 @@
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
-
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 8c0de20..2298e4a 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -71,6 +71,27 @@
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
@@ -154,27 +175,6 @@
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
index f8eaa38..335a1c1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -44,6 +44,119 @@
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
+				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
+				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */
+				0x82001000 0 0xe0000000 MBUS_ID(0x04, 0xd8) 0xe0000000 0 0x08000000 /* Port 0.1 MEM */
+				0x81001000 0 0          MBUS_ID(0x04, 0xd0) 0xe8000000 0 0x00100000 /* Port 0.2 IO */
+				0x82001800 0 0xe0000000 MBUS_ID(0x04, 0xb8) 0xe0000000 0 0x08000000 /* Port 0.2 MEM */
+				0x81001800 0 0          MBUS_ID(0x04, 0xb0) 0xe8000000 0 0x00100000 /* Port 0.2 IO */
+				0x82002000 0 0xe0000000 MBUS_ID(0x04, 0x78) 0xe0000000 0 0x08000000 /* Port 0.3 MEM */
+				0x81002000 0 0          MBUS_ID(0x04, 0x70) 0xe8000000 0 0x00100000 /* Port 0.3 IO */
+				0x82004800 0 0xe0000000 MBUS_ID(0x04, 0xf8) 0xe0000000 0 0x08000000 /* Port 2.0 MEM */
+				0x81004800 0 0          MBUS_ID(0x04, 0xf0) 0xe8000000 0 0x00100000 /* Port 2.0 IO */>;
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
@@ -77,110 +190,6 @@
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
index 985373a..4d429ac 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -45,6 +45,140 @@
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
+				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
+				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */
+				0x82001000 0 0xe0000000 MBUS_ID(0x04, 0xd8) 0xe0000000 0 0x08000000 /* Port 0.1 MEM */
+				0x81001000 0 0          MBUS_ID(0x04, 0xd0) 0xe8000000 0 0x00100000 /* Port 0.1 IO */
+				0x82001800 0 0xe0000000 MBUS_ID(0x04, 0xb8) 0xe0000000 0 0x08000000 /* Port 0.2 MEM */
+				0x81001800 0 0          MBUS_ID(0x04, 0xb0) 0xe8000000 0 0x00100000 /* Port 0.2 IO */
+				0x82002000 0 0xe0000000 MBUS_ID(0x04, 0x78) 0xe0000000 0 0x08000000 /* Port 0.3 MEM */
+				0x81002000 0 0          MBUS_ID(0x04, 0x70) 0xe8000000 0 0x00100000 /* Port 0.3 IO */
+				0x82002800 0 0xe0000000 MBUS_ID(0x08, 0xe8) 0xe0000000 0 0x08000000 /* Port 1.0 MEM */
+				0x82004800 0 0xe0000000 MBUS_ID(0x04, 0xf8) 0xe0000000 0 0x08000000 /* Port 2.0 MEM */
+				0x81004800 0 0          MBUS_ID(0x04, 0xf0) 0xe8000000 0 0x00100000 /* Port 2.0 IO */
+				0x82005000 0 0xe0000000 MBUS_ID(0x08, 0xf8) 0xe0000000 0 0x08000000 /* Port 3.0 MEM */
+				0x81005000 0 0          MBUS_ID(0x08, 0xf0) 0xe8000000 0 0x00100000 /* Port 3.0 IO */>;
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
@@ -97,128 +231,6 @@
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
index f8bf25a..3ad3c95 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -61,6 +61,213 @@
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
+				0x82000800 0 0xe0000000 MBUS_ID(0x04, 0xe8) 0xe0000000 0 0x08000000 /* Port 0.0 MEM */
+				0x81000800 0 0          MBUS_ID(0x04, 0xe0) 0xe8000000 0 0x00100000 /* Port 0.0 IO */
+				0x82001000 0 0xe0000000 MBUS_ID(0x04, 0xd8) 0xe0000000 0 0x08000000 /* Port 0.1 MEM */
+				0x81001000 0 0          MBUS_ID(0x04, 0xd0) 0xe8000000 0 0x00100000 /* Port 0.2 IO */
+				0x82001800 0 0xe0000000 MBUS_ID(0x04, 0xb8) 0xe0000000 0 0x08000000 /* Port 0.2 MEM */
+				0x81001800 0 0          MBUS_ID(0x04, 0xb0) 0xe8000000 0 0x00100000 /* Port 0.2 IO */
+				0x82002000 0 0xe0000000 MBUS_ID(0x04, 0x78) 0xe0000000 0 0x08000000 /* Port 0.3 MEM */
+				0x81002000 0 0          MBUS_ID(0x04, 0x70) 0xe8000000 0 0x00100000 /* Port 0.3 IO */
+				0x82002800 0 0xe0000000 MBUS_ID(0x08, 0xe8) 0xe0000000 0 0x08000000 /* Port 1.0 MEM */
+				0x81002800 0 0          MBUS_ID(0x08, 0xe0) 0xe8000000 0 0x00100000 /* Port 1.0 IO */
+				0x82003000 0 0xe0000000 MBUS_ID(0x08, 0xd8) 0xe0000000 0 0x08000000 /* Port 1.1 MEM */
+				0x81003000 0 0          MBUS_ID(0x08, 0xd0) 0xe8000000 0 0x00100000 /* Port 1.1 IO */
+				0x82003800 0 0xe0000000 MBUS_ID(0x08, 0xb8) 0xe0000000 0 0x08000000 /* Port 1.2 MEM */
+				0x81003800 0 0          MBUS_ID(0x08, 0xb0) 0xe8000000 0 0x00100000 /* Port 1.2 IO */
+				0x82004000 0 0xe0000000 MBUS_ID(0x08, 0x78) 0xe0000000 0 0x08000000 /* Port 1.3 MEM */
+				0x81004000 0 0          MBUS_ID(0x08, 0x70) 0xe8000000 0 0x00100000 /* Port 1.3 IO */
+				0x82004800 0 0xe0000000 MBUS_ID(0x04, 0xf8) 0xe0000000 0 0x08000000 /* Port 2.0 MEM */
+				0x81004800 0 0          MBUS_ID(0x04, 0xf0) 0xe8000000 0 0x00100000 /* Port 2.0 IO */
+				0x82005000 0 0xe0000000 MBUS_ID(0x08, 0xf8) 0xe0000000 0 0x08000000 /* Port 3.0 MEM */
+				0x81005000 0 0          MBUS_ID(0x08, 0xf0) 0xe8000000 0 0x00100000 /* Port 3.0 IO */>;
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
@@ -113,194 +320,6 @@
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
index 2b60ee0..5695afc 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -59,6 +59,15 @@
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
@@ -176,15 +185,6 @@
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
