From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sat, 19 May 2018 20:31:19 +0200
Subject: [PATCH 07/15] dt-bindings: display: sun4i-drm: Add R40 HDMI pipeline
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Message-ID: <20180519183127.2718-8-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Missing compatibles and descriptions needed to implement R40 HDMI
pipeline are added.

For mixers only compatibles are added.

TCON description is expanded with R40 TV TCON compatibles. If the SoC
has TCON TOP unit, phandle to that unit has to be specified. Additional
clock has to be specified if SoC has TCON TOP and TCON is TV TCON.

New compatible is added for DWC HDMI PHY, which has additional clock
specified.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 .../bindings/display/sunxi/sun4i-drm.txt         | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
index a099957ab62a..634276f713e8 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
@@ -101,6 +101,7 @@ DWC HDMI PHY
 
 Required properties:
   - compatible: value must be one of:
+    * allwinner,sun50i-a64-hdmi-phy
     * allwinner,sun8i-a83t-hdmi-phy
     * allwinner,sun8i-h3-hdmi-phy
   - reg: base address and size of memory-mapped region
@@ -111,8 +112,9 @@ Required properties:
   - resets: phandle to the reset controller driving the PHY
   - reset-names: must be "phy"
 
-H3 HDMI PHY requires additional clock:
+H3 and A64 HDMI PHY requires additional clocks:
   - pll-0: parent of phy clock
+  - pll-1: second possible phy clock parent (A64 only)
 
 TV Encoder
 ----------
@@ -145,6 +147,8 @@ Required properties:
    * allwinner,sun8i-a33-tcon
    * allwinner,sun8i-a83t-tcon-lcd
    * allwinner,sun8i-a83t-tcon-tv
+   * allwinner,sun8i-r40-tcon-tv-0
+   * allwinner,sun8i-r40-tcon-tv-1
    * allwinner,sun8i-v3s-tcon
    * allwinner,sun9i-a80-tcon-lcd
    * allwinner,sun9i-a80-tcon-tv
@@ -179,7 +183,7 @@ For TCONs with channel 0, there is one more clock required:
 For TCONs with channel 1, there is one more clock required:
    - 'tcon-ch1': The clock driving the TCON channel 1
 
-When TCON support LVDS (all TCONs except TV TCON on A83T and those found
+When TCON support LVDS (all TCONs except TV TCONs on A83T, R40 and those found
 in A13, H3, H5 and V3s SoCs), you need one more reset line:
    - 'lvds': The reset line driving the LVDS logic
 
@@ -187,6 +191,12 @@ And on the A23, A31, A31s and A33, you need one more clock line:
    - 'lvds-alt': An alternative clock source, separate from the TCON channel 0
                  clock, that can be used to drive the LVDS clock
 
+If SoC has TCON TOP, like R40, TCON has to have phandle to TCON TOP:
+   - 'allwinner,tcon-top': Phandle to TCON TOP unit
+
+TV TCONs which have phandle to TCON TOP need one more clock:
+   - 'tcon-top': TV TCON gate found in TCON TOP unit
+
 TCON TOP
 --------
 
@@ -330,6 +340,8 @@ Required properties:
     * allwinner,sun8i-a83t-de2-mixer-0
     * allwinner,sun8i-a83t-de2-mixer-1
     * allwinner,sun8i-h3-de2-mixer-0
+    * allwinner,sun8i-r40-de2-mixer-0
+    * allwinner,sun8i-r40-de2-mixer-1
     * allwinner,sun8i-v3s-de2-mixer
   - reg: base address and size of the memory-mapped region.
   - clocks: phandles to the clocks feeding the mixer
-- 
2.17.0
