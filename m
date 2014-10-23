From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 23:10:58 +0000
Subject: [PATCH 05/10] arm64: Convert dts to use reserved-memory nodes
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <411296ab915959b862923d827e730a1db2ff9b4e.1414099246.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree regions described by /memreserve/ entries are not available in
/proc/device-tree, and hence are not available to user space utilities that use
/proc/device-tree.  In order for these regions to be available, convert any
arm64 DTS files using /memreserve/ entries to use reserved-memory nodes.

This change is required for kexec re-boot to work properly when a user does not
specify a second stage DTB via the kexec --dtb option.  When the --dtb option is
not specified kexec will prepare the second stage DTB using data from
/proc/device-tree.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/boot/dts/foundation-v8.dts  | 13 +++++++++++--
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts | 13 +++++++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/foundation-v8.dts b/arch/arm64/boot/dts/foundation-v8.dts
index 4a06090..2b76c2d 100644
--- a/arch/arm64/boot/dts/foundation-v8.dts
+++ b/arch/arm64/boot/dts/foundation-v8.dts
@@ -6,8 +6,6 @@
 
 /dts-v1/;
 
-/memreserve/ 0x80000000 0x00010000;
-
 / {
 	model = "Foundation-v8A";
 	compatible = "arm,foundation-aarch64", "arm,vexpress";
@@ -64,6 +62,17 @@
 		      <0x00000008 0x80000000 0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		firmware-memory at 0x80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x00010000>;
+		};
+	};
+
 	gic: interrupt-controller at 2c001000 {
 		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
diff --git a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
index 572005e..0f80807 100644
--- a/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
+++ b/arch/arm64/boot/dts/rtsm_ve-aemv8a.dts
@@ -9,8 +9,6 @@
 
 /dts-v1/;
 
-/memreserve/ 0x80000000 0x00010000;
-
 / {
 	model = "RTSM_VE_AEMv8A";
 	compatible = "arm,rtsm_ve,aemv8a", "arm,vexpress";
@@ -67,6 +65,17 @@
 		      <0x00000008 0x80000000 0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		firmware-memory at 0x80000000 {
+			no-map;
+			reg = <0x0 0x80000000 0x0 0x00010000>;
+		};
+	};
+
 	gic: interrupt-controller at 2c001000 {
 		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
