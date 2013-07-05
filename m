From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Jul 2013 18:39:29 -0300
Subject: [PATCH v6 18/21] ARM: mvebu: Add MBus to Armada 370/XP device tree
In-Reply-To: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373060372-32357-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373060372-32357-19-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370/XP SoC family has a completely configurable address
space handled by the MBus controller.

This patch introduces the device tree layout of MBus, making the
'soc' node as mbus-compatible.
Since every peripheral/controller is a child of this 'soc' node,
this makes all of them sit behind the mbus, thus describing the
hardware accurately.

A translation entry has been added for the internal-regs mapping.
This can't be done in the common armada-370-xp.dtsi because A370
and AXP have different addressing width.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              |  2 ++
 arch/arm/boot/dts/armada-370-mirabox.dts         |  2 ++
 arch/arm/boot/dts/armada-370-rd.dts              |  2 ++
 arch/arm/boot/dts/armada-370-xp.dtsi             | 15 ++++++++++-----
 arch/arm/boot/dts/armada-370.dtsi                |  4 ++--
 arch/arm/boot/dts/armada-xp-db.dts               |  4 +---
 arch/arm/boot/dts/armada-xp-gp.dts               |  4 +---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  4 +---
 arch/arm/boot/dts/armada-xp.dtsi                 |  2 ++
 9 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 55b986c..5920b4e 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,6 +30,8 @@
 	};
 
 	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 37530af..a4202b6 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -25,6 +25,8 @@
 	};
 
 	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 7aa2171..dd0ba01 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -28,6 +28,8 @@
 	};
 
 	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..62639b4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -18,6 +18,8 @@
 
 /include/ "skeleton64.dtsi"
 
+#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
 / {
 	model = "Marvell Armada 370 and XP SoC";
 	compatible = "marvell,armada-370-xp";
@@ -38,18 +40,21 @@
 	};
 
 	soc {
-		#address-cells = <1>;
+		#address-cells = <2>;
 		#size-cells = <1>;
-		compatible = "simple-bus";
+		controller = <&mbusc>;
 		interrupt-parent = <&mpic>;
-		ranges = <0          0 0xd0000000 0x0100000 /* internal registers */
-			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
 
 		internal-regs {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
+
+			mbusc: mbus-controller at 20000 {
+				compatible = "marvell,mbus-controller";
+				reg = <0x20000 0x100>, <0x20180 0x20>;
+			};
 
 			mpic: interrupt-controller at 20000 {
 				compatible = "marvell,mpic";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 08ec6e3..4b54e51 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -29,8 +29,8 @@
 	};
 
 	soc {
-		ranges = <0          0xd0000000 0x0100000 /* internal registers */
-			  0xe0000000 0xe0000000 0x8100000 /* PCIe */>;
+		compatible = "marvell,armada370-mbus", "simple-bus";
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index a9bd766..0d4ce54 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,9 +30,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000	/* Internal registers 1MiB */
-			  0xe0000000 0 0xe0000000 0x8100000     /* PCIe */
-			  0xf0000000 0 0xf0000000 0x1000000>;	/* Device Bus, NOR 16MiB   */
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 54843e5..2fa9209 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,9 +39,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000  /* Internal registers 1MiB */
-			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */
-			  0xf0000000 0 0xf0000000 0x1000000 /* Device Bus, NOR 16MiB  */>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index d090264..a3e3a12 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,9 +27,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000	/* Internal registers 1MiB */
-			  0xe0000000 0 0xe0000000 0x8100000     /* PCIe */
-			  0xf0000000 0 0xf0000000 0x8000000     /* Device Bus, NOR 128MiB   */>;
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 8c07bfe..8033824 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -27,6 +27,8 @@
 	};
 
 	soc {
+		compatible = "marvell,armadaxp-mbus", "simple-bus";
+
 		internal-regs {
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
-- 
1.8.1.5
