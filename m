From: Markus.Niebel@tq-group.com (Markus Niebel)
Date: Thu,  4 Sep 2014 14:05:05 +0200
Subject: [PATCH] ARM: DT: imx53: fix lvds channel 1 port
Message-ID: <1409832305-24255-1-git-send-email-Markus.Niebel@tq-group.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

using LVDS channel 1 on an i.MX53 leads to following error:

imx-ldb 53fa8008.ldb: unable to set di0 parent clock to ldb_di1

This comes from imx_ldb_set_clock with mux = 0. Mux parameter must be "1" for
reparenting di1 clock to ldb_di1. The value of the mux param comes from device
tree port settings.

On i.MX5, the internal two-input-multiplexer is used. Due to hardware limitations,
only one port (port@[0,1]) can be used for each channel (lvds-channel@[0,1],
respectively)

Documentation update suggested by Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
---
 Documentation/devicetree/bindings/staging/imx-drm/ldb.txt | 15 +++++++++++++--
 arch/arm/boot/dts/imx53.dtsi                              | 12 ++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
index 578a1fc..443bcb6 100644
--- a/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
+++ b/Documentation/devicetree/bindings/staging/imx-drm/ldb.txt
@@ -56,6 +56,9 @@ Required properties:
  - fsl,data-width : should be <18> or <24>
  - port: A port node with endpoint definitions as defined in
    Documentation/devicetree/bindings/media/video-interfaces.txt.
+   On i.MX5, the internal two-input-multiplexer is used.
+   Due to hardware limitations, only one port (port@[0,1])
+   can be used for each channel (lvds-channel@[0,1], respectively)
    On i.MX6, there should be four ports (port@[0-3]) that correspond
    to the four LVDS multiplexer inputs.
 
@@ -78,6 +81,8 @@ ldb: ldb at 53fa8008 {
 		      "di0", "di1";
 
 	lvds-channel at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <0>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
@@ -86,7 +91,9 @@ ldb: ldb at 53fa8008 {
 			/* ... */
 		};
 
-		port {
+		port at 0 {
+			reg = <0>;
+
 			lvds0_in: endpoint {
 				remote-endpoint = <&ipu_di0_lvds0>;
 			};
@@ -94,6 +101,8 @@ ldb: ldb at 53fa8008 {
 	};
 
 	lvds-channel at 1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		reg = <1>;
 		fsl,data-mapping = "spwg";
 		fsl,data-width = <24>;
@@ -102,7 +111,9 @@ ldb: ldb at 53fa8008 {
 			/* ... */
 		};
 
-		port {
+		port at 1 {
+			reg = <1>;
+
 			lvds1_in: endpoint {
 				remote-endpoint = <&ipu_di1_lvds1>;
 			};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6456a00..1a2202d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -419,10 +419,14 @@
 				status = "disabled";
 
 				lvds-channel at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <0>;
 					status = "disabled";
 
-					port {
+					port at 0 {
+						reg = <0>;
+
 						lvds0_in: endpoint {
 							remote-endpoint = <&ipu_di0_lvds0>;
 						};
@@ -430,10 +434,14 @@
 				};
 
 				lvds-channel at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
 					reg = <1>;
 					status = "disabled";
 
-					port {
+					port at 1 {
+						reg = <1>;
+
 						lvds1_in: endpoint {
 							remote-endpoint = <&ipu_di1_lvds1>;
 						};
-- 
2.1.0
