From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Aug 2018 14:23:08 +0200
Subject: [PATCH 1/2] drm/bridge: Add virtual display DT bindings
Message-ID: <20180824122308.3092-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds bindings for a virtual display to be used with displays
inside entirely virtual environments which do not emulate things
like monitors but just need timing information to be supplied to
its display controller.

This is inspired by earlier work by Liviu Dudau.

Cc: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Ryan Harkin <ryan.harkin@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../display/bridge/virtual-display-bridge.txt | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt b/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt
new file mode 100644
index 000000000000..ea4f5a91ab94
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt
@@ -0,0 +1,62 @@
+Virtual Display Bridge
+
+This represents a display that is contained within an emulated
+environment.
+
+This means that the display engine mainly expects some timing
+parameters to be written into it, and after that the emulator will
+respond by creating a virtual display with the requested
+resolution characteristics.
+
+As the operating system cannot "detect" such a display, rather the
+emulator will respond to what the controller outputs, a
+chicken-and-egg problem needs to be solved: the resolution and
+timing characteristics need to be defined and set up somewhere.
+
+The virtual display bridge solves this by defining a bridge with
+all timing characteristics encoded into the device tree node.
+
+Required properies:
+- compatible: shall be "virtual-display-bridge"
+
+Required subnodes:
+- display-timings: contains in turn a display timing node
+  see display-timing.txt
+- ports: contains the display ports, see media/video-interfaces.txt
+
+Example:
+
+bridge {
+	compatible = "virtual-display-bridge";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	display-timings {
+		/* Some standard VGA timing */
+		timing0 {
+			clock-frequency = <23750>;
+			hactive = <640>;
+			vactive = <480>;
+			hfront-porch = <48>;
+			hback-porch = <16>;
+			hsync-len = <96>;
+			vfront-porch = <33>;
+			vback-porch = <9>;
+			vsync-len = <3>;
+			vrefresh = <60>;
+		};
+	};
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			reg = <0>;
+
+			display_bridge_in: endpoint {
+				remote-endpoint = <&foo>;
+			};
+		};
+	};
+};
-- 
2.17.1
