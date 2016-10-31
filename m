From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 31 Oct 2016 15:45:38 +0100
Subject: [PATCH v2 5/5] ARM: dts: da850-lcdk: add tilcdc panel node
In-Reply-To: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1477925138-23457-6-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tilcdc driver is not yet ready for working together with the
dumb-vga-dac drm bridge. While the work on enabling drm_bridge
support in tilcdc continues, enable the VGA connector on da850-lcdk
with the following workaround: use the tilcdc-panel driver with
a set of common (and tested) resolutions.

Once the drm bridge support is complete, we'll remove the node added
by this patch and use the correct solution. This change will be
transparent for the user.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index b39796e..df582c6 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -62,6 +62,65 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	/*
+	 * Remove this node once the tilcdc driver gets support for
+	 * drm bridge modules.
+	 */
+	panel {
+		compatible = "ti,tilcdc,panel";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+		status = "okay";
+
+		panel-info {
+			ac-bias = <0>;
+			ac-bias-intrpt = <0>;
+			dma-burst-sz = <16>;
+			bpp = <16>;
+			fdd = <255>;
+			sync-edge = <0>;
+			sync-ctrl = <0>;
+			raster-order = <0>;
+			fifo-th = <5>;
+		};
+
+		display-timings {
+			native-mode = <&svga_timings>;
+			vga_timings: 640x480 at 60 {
+				clock-frequency = <27500000>;
+				hactive = <640>;
+				hback-porch = <90>;
+				hfront-porch = <40>;
+				hsync-len = <128>;
+				vactive = <480>;
+				vback-porch = <23>;
+				vfront-porch = <1>;
+				vsync-len = <4>;
+			};
+			vga_timings_hf: 640x480 at 75 {
+				clock-frequency = <34000000>;
+				hactive = <640>;
+				hback-porch = <90>;
+				hfront-porch = <40>;
+				hsync-len = <128>;
+				vactive = <480>;
+				vback-porch = <23>;
+				vfront-porch = <1>;
+				vsync-len = <4>;
+			};
+			svga_timings: 800x600 at 56 {
+				clock-frequency = <37500000>;
+				hactive = <800>;
+				hback-porch = <140>;
+				hfront-porch = <40>;
+				hsync-len = <128>;
+				vactive = <600>;
+				vback-porch = <23>;
+				vfront-porch = <1>;
+				vsync-len = <4>;
+			};
+		};
+	};
 };
 
 &pmx_core {
@@ -251,3 +310,7 @@
 &ddrctl {
 	status = "okay";
 };
+
+&display {
+	status = "okay";
+};
-- 
2.9.3
