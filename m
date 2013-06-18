From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 08:25:34 -0300
Subject: [PATCH v3 09/12] ARM: mvebu: Add BootROM to Armada 370/XP device tree
In-Reply-To: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371554737-25319-10-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to access the SoC BootROM, we need to declare a mapping
(through a ranges property). The mbus driver will use this property
to allocate a suitable address decoding window.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              | 3 ++-
 arch/arm/boot/dts/armada-370-mirabox.dts         | 3 ++-
 arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
 arch/arm/boot/dts/armada-370-xp.dtsi             | 2 ++
 arch/arm/boot/dts/armada-370.dtsi                | 6 ++++++
 arch/arm/boot/dts/armada-xp-db.dts               | 3 ++-
 arch/arm/boot/dts/armada-xp-gp.dts               | 3 ++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 ++-
 arch/arm/boot/dts/armada-xp.dtsi                 | 6 ++++++
 9 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 530d1cf..c313968 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -30,7 +30,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index ad60835..abb1ccf 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -25,7 +25,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 9c2ab7f..9ae8bdc 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -28,7 +28,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 633534dd..4ae5eb5 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -16,6 +16,8 @@
  * 370 and Armada XP SoC.
  */
 
+#define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
+
 /include/ "skeleton64.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index c274b7b..c7f9971 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -32,6 +32,12 @@
 		compatible = "marvell,armada370-mbus", "simple-bus";
 		reg = <0xd0020000 0x100>, <0xd0020180 0x20>;
 
+		bootrom {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x01, 0xe0) 0 0xffffffff>;
+		};
+
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 0996215..84e7ab2 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -30,7 +30,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index f095a3e..1f4daa7 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,7 +39,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 91827cb..ea47196 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,7 +27,8 @@
 	};
 
 	soc {
-		ranges = <0xffff0001 0 0 0xd0000000 0x100000>;
+		ranges = <0xffff0001 0 0 0xd0000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
 		internal-regs {
 			serial at 12000 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index feec757..2516899 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -26,6 +26,12 @@
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 		reg = <0 0xd0020000 0 0x100>, <0 0xd0020180 0 0x20>;
 
+		bootrom {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x01, 0x1d) 0 0xffffffff>;
+		};
+
 		internal-regs {
 			L2: l2-cache {
 				compatible = "marvell,aurora-system-cache";
-- 
1.8.1.5
