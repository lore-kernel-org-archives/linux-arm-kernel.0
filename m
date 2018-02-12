From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Feb 2018 19:28:50 +0800
Subject: [PATCH v3 4/5] dt-bindings: clock: mediatek: update audsys
 documentation to adapt MFD device
In-Reply-To: <cover.1518424204.git.ryder.lee@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
Message-ID: <61928ad523a7aeffb8f16d4caad56836b65ae407.1518424204.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MediaTek audio hardware block that exposes functionalities that are
handled by separate subsystems in the kernel.  These functions are all
mapped somewhere at 0x112xxxxx, and there are some control bits are mixed
up with other functions within the same registers.

Therefore, it's better to switch the AUDSYS to MFD device for the sake of
avoiding adding individual nodes with the overlapping regions for those
devices.

This patch adds a top level node "simple-mfd" to represent whole subsystem,
which consists of two portions - audio componets and clock part.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,audsys.txt      | 37 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 9b8f578..677af40 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -1,22 +1,45 @@
-MediaTek AUDSYS controller
+MediaTek Audio Subsystem
 ============================
+The audio subsystem is one of the multi-function blocks of MediaTek SoCs.
+It contains a system controller, which provides a number registers giving
+access to two features: AUDSYS clocks and Audio Front End (AFE) components.
 
+For the top level node:
+- compatible: must be: "syscon", "simple-mfd";
+- reg: register area of the Audio Subsystem
+
+Required sub-nodes:
+
+AUDSYS clocks:
+-------
 The MediaTek AUDSYS controller provides various clocks to the system.
 
 Required Properties:
 
 - compatible: Should be one of:
-	- "mediatek,mt7622-audsys", "syscon"
+	- "mediatek,mt2701-audsys";
+	- "mediatek,mt7622-audsys";
 - #clock-cells: Must be 1
 
 The AUDSYS controller uses the common clk binding from
 Documentation/devicetree/bindings/clock/clock-bindings.txt
 The available clocks are defined in dt-bindings/clock/mt*-clk.h.
 
+AFE components:
+-------
+For common binding part and usage, refer to
+../sonud/mt2701-afe-pcm.txt.
+
 Example:
 
-audsys: audsys at 11220000 {
-	compatible = "mediatek,mt7622-audsys", "syscon";
-	reg = <0 0x11220000 0 0x1000>;
-	#clock-cells = <1>;
-};
+	audio-subsystem at 11220000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0 0x11220000 0 0x2000>;
+
+		audsys: clock {
+			compatible = "mediatek,mt2701-audsys";
+			#clock-cells = <1>;
+		};
+
+		...
+	};
-- 
1.9.1
