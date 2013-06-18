From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:33 -0300
Subject: [PATCH v3 08/12] ARM: mvebu: Add MBus to Armada 370/XP device tree
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-9-git-send-email-ezequiel.garcia@free-electrons.com>
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
 arch/arm/boot/dts/armada-370-db.dts              | 2 ++
 arch/arm/boot/dts/armada-370-mirabox.dts         | 2 ++
 arch/arm/boot/dts/armada-370-rd.dts              | 2 ++
 arch/arm/boot/dts/armada-370-xp.dtsi             | 7 ++-----
 arch/arm/boot/dts/armada-370.dtsi                | 5 +++--
 arch/arm/boot/dts/armada-xp-db.dts               | 2 ++
 arch/arm/boot/dts/armada-xp-gp.dts               | 3 +--
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 +--
 arch/arm/boot/dts/armada-xp.dtsi                 | 3 +++
 9 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 231f8b2..530d1cf 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,6 +30,8 @@
 	};
 
 	soc {
+		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 7005f27..ad60835 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -25,6 +25,8 @@
 	};
 
 	soc {
+		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 5c3a1ec..9c2ab7f 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -28,6 +28,8 @@
 	};
 
 	soc {
+		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <200000000>;
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 52a1f5e..633534dd 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -29,18 +29,15 @@
 	};
 
 	soc {
-		#address-cells = <1>;
+		#address-cells = <2>;
 		#size-cells = <1>;
-		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
-		ranges = <0          0 0xd0000000 0x0100000 /* internal registers */
-			  0xe0000000 0 0xe0000000 0x8100000 /* PCIe */>;
 
 		internal-regs {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0 0xffff0001 0 0x100000>;
 
 			mpic: interrupt-controller at 20000 {
 				compatible = "marvell,mpic";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 08ec6e3..c274b7b 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -29,8 +29,9 @@
 	};
 
 	soc {
-		ranges = <0          0xd0000000 0x0100000 /* internal registers */
-			  0xe0000000 0xe0000000 0x8100000 /* PCIe */>;
+		compatible = "marvell,armada370-mbus", "simple-bus";
+		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 9a6ad0e..0996215 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,6 +30,8 @@
 	};
 
 	soc {
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index e0c6f60..f095a3e 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,8 +39,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000
-			  0xf0000000 0 0xf0000000 0x1000000>;
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 27a0ecf..91827cb 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,8 +27,7 @@
 	};
 
 	soc {
-		ranges = <0          0 0xd0000000 0x100000
-			  0xf0000000 0 0xf0000000 0x8000000>;
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 3e770db..feec757 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -23,6 +23,9 @@
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
 	soc {
+		compatible = "marvell,armadaxp-mbus", "simple-bus";
+		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
+
 		internal-regs {
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
-- 
1.8.1.5
