From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:36 -0300
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device tree
 nodes
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-12-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mbus has been added to the device tree, it's possible to
move the PCIe nodes out of internal registers, placing it directly
below the mbus. This is a more accurate representation of the
hardware.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts      |  1 +
 arch/arm/boot/dts/armada-370-mirabox.dts | 33 +++++------
 arch/arm/boot/dts/armada-370-rd.dts      |  1 +
 arch/arm/boot/dts/armada-370.dtsi        | 97 ++++++++++++++++----------------
 4 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index c313968..6891343 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -31,6 +31,7 @@
 
 	soc {
 		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  0xffff0002 0 0xe0000000 0x8100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index abb1ccf..830727a 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -26,8 +26,25 @@
 
 	soc {
 		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  0xffff0002 0 0xe0000000 0x8100000
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
@@ -122,22 +139,6 @@
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
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 9ae8bdc..132cf8e 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -29,6 +29,7 @@
 
 	soc {
 		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  0xffff0002 0 0xe0000000 0x8100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index c7f9971..1288a78 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -38,6 +38,55 @@
 			ranges = <0 MBUS_ID(0x01, 0xe0) 0 0xffffffff>;
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
+			       <0x82000000 0 0x40000    0xffff0001 0x40000 0 0x00002000
+				0x82000000 0 0x80000    0xffff0001 0x80000 0 0x00002000
+				0x82000000 0 0xe0000000 0xffff0002 0          0 0x08000000
+				0x81000000 0 0          0xffff0002 0x8000000  0 0x00100000>;
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
@@ -176,54 +225,6 @@
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
-- 
1.8.1.5
