From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Apr 2013 16:29:10 +0200
Subject: [PATCH v4 5/5] ARM: dts: mvebu: Convert mvebu device tree files to 64
 bits
In-Reply-To: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365776950-30094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365776950-30094-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use more than 4GB of RAM when the LPAE is
activated, the dts must be converted in 64 bits.

Only Armada XP is LPAE capable, but as it shares a common dtsi file
with Armada 370, then the common file include the skeleton64. Thanks
to the use of the overload capability of the device tree format,
armada-370 include the 32 bit skeleton and all the armada 370 based
dts can remain the same.

This was heavily based on the work of Lior Amsalem.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi             |    4 ++--
 arch/arm/boot/dts/armada-370.dtsi                |    2 ++
 arch/arm/boot/dts/armada-xp-db.dts               |    2 +-
 arch/arm/boot/dts/armada-xp-gp.dts               |   14 ++++++++------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    2 +-
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index bf8f911..272bbc6 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -16,7 +16,7 @@
  * 370 and Armada XP SoC.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "skeleton64.dtsi"
 
 / {
 	model = "Marvell Armada 370 and XP SoC";
@@ -33,7 +33,7 @@
 		#size-cells = <1>;
 		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
-		ranges = <0 0xd0000000 0x100000>;
+		ranges = <0 0 0xd0000000 0x100000>;
 
 		internal-regs {
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 6ef95dd..b2c1b5a 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -16,6 +16,7 @@
  */
 
 /include/ "armada-370-xp.dtsi"
+/include/ "skeleton.dtsi"
 
 / {
 	model = "Marvell Armada 370 family SoC";
@@ -28,6 +29,7 @@
 	};
 
 	soc {
+		ranges = <0 0xd0000000 0x100000>;
 		internal-regs {
 			system-controller at 18200 {
 				compatible = "marvell,armada-370-xp-system-controller";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 6c8b032..d6cc8bf 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -26,7 +26,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x80000000>; /* 2 GB */
+		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index d9972c9..26ad06f 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -26,14 +26,16 @@
 
 	memory {
 		device_type = "memory";
-
 		/*
-		 * 4 GB of plug-in RAM modules by default but only 3GB
-		 * are visible, the amount of memory available can be
-		 * changed by the bootloader according the size of the
-		 * module actually plugged
+                 * 8 GB of plug-in RAM modules by default.The amount
+                 * of memory available can be changed by the
+                 * bootloader according the size of the module
+                 * actually plugged. Only 7GB are usable because
+                 * addresses from 0xC0000000 to 0xffffffff are used by
+                 * the internal registers of the SoC.
 		 */
-		reg = <0x00000000 0xC0000000>;
+		reg = <0x00000000 0x00000000 0x00000000 0xC0000000>,
+		      <0x00000001 0x00000000 0x00000001 0x00000000>;
 	};
 
 	soc {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 15a66a8..f14d36c 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -23,7 +23,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0xC0000000>; /* 3 GB */
+		reg = <0 0x00000000 0 0xC0000000>; /* 3 GB */
 	};
 
 	soc {
-- 
1.7.9.5
