From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 15 May 2017 00:30:35 +0800
Subject: [PATCH v7 03/13] dt-bindings: add bindings for DE2 on V3s SoC
In-Reply-To: <20170514163045.40366-1-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
Message-ID: <20170514163045.40366-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC have a display engine which have a different pipeline
with older SoCs.

Add document for it (new compatibles and the new "mixer" part).

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v7:
- Reduced some text.
Changes in v4:
- Removed the refactor at TCON chapter.
Changes in v3:
- Remove the description of having a BE directly as allwinner,pipeline.

 .../bindings/display/sunxi/sun4i-drm.txt           | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index 7acdbf14ae1c..66b85a195ef2 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -41,6 +41,7 @@ Required properties:
    * allwinner,sun6i-a31-tcon
    * allwinner,sun6i-a31s-tcon
    * allwinner,sun8i-a33-tcon
+   * allwinner,sun8i-v3s-tcon
  - reg: base address and size of memory-mapped region
  - interrupts: interrupt associated to this IP
  - clocks: phandles to the clocks feeding the TCON. Three are needed:
@@ -62,7 +63,7 @@ Required properties:
   second the block connected to the TCON channel 1 (usually the TV
   encoder)
 
-On SoCs other than the A33, there is one more clock required:
+On SoCs other than the A33 and V3s, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
 DRC
@@ -148,6 +149,26 @@ Required properties:
   Documentation/devicetree/bindings/media/video-interfaces.txt. The
   first port should be the input endpoints, the second one the outputs
 
+Display Engine 2.0 Mixer
+------------------------
+
+The DE2 mixer have many functionalities, currently only layer blending is
+supported.
+
+Required properties:
+  - compatible: value must be one of:
+    * allwinner,sun8i-v3s-de2-mixer
+  - reg: base address and size of the memory-mapped region.
+  - clocks: phandles to the clocks feeding the mixer
+    * bus: the mixer interface clock
+    * mod: the mixer module clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset controllers driving the mixer
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the output
+
 
 Display Engine Pipeline
 -----------------------
@@ -162,9 +183,10 @@ Required properties:
     * allwinner,sun6i-a31-display-engine
     * allwinner,sun6i-a31s-display-engine
     * allwinner,sun8i-a33-display-engine
+    * allwinner,sun8i-v3s-display-engine
 
   - allwinner,pipelines: list of phandle to the display engine
-    frontends available.
+    frontends (DE 1.0) or mixers (DE 2.0) available.
 
 Example:
 
-- 
2.12.2
