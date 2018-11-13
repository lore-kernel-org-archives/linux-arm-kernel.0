From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 13 Nov 2018 16:46:25 +0530
Subject: [PATCH v4 18/26] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
Message-ID: <20181113111633.20189-19-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
bridge panel, which is available on same PCB with 24-bit RGB interface.

So, this patch adds DSI specific binding details on existing
dt-bindings file.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
index 35bc0c839f49..b7855dc7c66f 100644
--- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
@@ -1,12 +1,39 @@
 Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
 
+S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
+
+Depending on the variant, the PCB attached to the panel module either
+supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
+an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
+itself
+
 Required properties:
-- compatible: should be "bananapi,s070wv20-ct16"
+- compatible:
+  for 24-bit RGB interface, use "bananapi,s070wv20-ct16"
+  for ICN6211 MIPI-DSI to RGB bridge, use "bananapi,s070wv20-ct16-icn6211"
+
+Required properties for RGB:
 - power-supply: see ./panel-common.txt
 
+Required properties for MIPI-DSI to RGB:
+- reg: for DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
 Optional properties:
-- enable-gpios: see ./simple-panel.txt
+- enable-gpios: see ./simple-panel.txt(not available in MIPI-DSI to RGB bridge)
 - backlight: see ./simple-panel.txt
 
 This binding is compatible with the simple-panel binding, which is specified
 in ./simple-panel.txt.
+
+Example:
+panel at 0 {
+	compatible = "bananapi,s070wv20-ct16-icn6211";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo1>;
+	reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	backlight = <&backlight_dsi>;
+};
-- 
2.18.0.321.gffc6fa0e3
