From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 09:28:48 +0000
Subject: [PATCH 1/3] ARM: dts: atlas7: set right memory range and hwspinlock
 for IPC stuff
Message-ID: <1436779729-3052-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

this patch sets memory range for IPC stuff according to register layout.
there is no memory overlap for all components.

it also sets the right hwspinlock for these components.

Cc: Suman Anna <s-anna@ti.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 5dfd3a4..01ae884 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -94,39 +94,43 @@
 		};
 
 		ipc at 13240000 {
-			compatible = "sirf,atlas7-ipc";
+			compatible = "sirf,atlas7-ipc", "simple-bus";
 			ranges = <0x13240000 0x13240000 0x00010000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			hwspinlock {
+			hwlock: hwlock at 0 {
 				compatible = "sirf,hwspinlock";
-				reg = <0x13240000 0x00010000>;
-
-				num-spinlocks = <30>;
+				reg = <0x13240400 0x0100>;
+				#hwlock-cells = <1>;
 			};
 
 			ns_m3_rproc at 0 {
 				compatible = "sirf,ns2m30-rproc";
-				reg = <0x13240000 0x00010000>;
+				reg = <0x13240108 0x4>,
+					<0x13240208 0x4>;
 				interrupts = <0 123 0>;
+				hwlocks = <&hwlock 0>, <&hwlock 1>;
 			};
 
 			ns_m3_rproc at 1 {
 				compatible = "sirf,ns2m31-rproc";
-				reg = <0x13240000 0x00010000>;
+				reg = <0x1324010C 0x4>,
+					<0x1324020C 0x4>;
 				interrupts = <0 126 0>;
 			};
 
 			ns_kal_rproc at 0 {
 				compatible = "sirf,ns2kal0-rproc";
-				reg = <0x13240000 0x00010000>;
+				reg = <0x13240110 0x4>,
+					<0x13240308 0x4>;
 				interrupts = <0 124 0>;
 			};
 
 			ns_kal_rproc at 1 {
 				compatible = "sirf,ns2kal1-rproc";
-				reg = <0x13240000 0x00010000>;
+				reg = <0x13240114 0x4>,
+					<0x1324030C 0x4>;
 				interrupts = <0 127 0>;
 			};
 		};
-- 
2.3.5
