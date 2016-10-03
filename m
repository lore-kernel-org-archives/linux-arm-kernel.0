From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon,  3 Oct 2016 17:45:19 +0200
Subject: [PATCH v3] drm: tilcdc: add a da850-specific compatible string
Message-ID: <1475509519-29516-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to some potential tweaks for the da850 LCDC (for example: the
required memory bandwith settings) we need a separate compatible
for the IP present on the da850 boards.

Suggested-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- added the new compatible to the bindings documentation

v2 -> v3:
- made the documentation more detailed

 Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 6 ++++--
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                         | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
index a83abd7..6fddb4f 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
@@ -1,7 +1,9 @@
 Device-Tree bindings for tilcdc DRM driver
 
 Required properties:
- - compatible: value should be "ti,am33xx-tilcdc".
+ - compatible: value should be one of the following:
+    - "ti,am33xx-tilcdc" for AM335x based boards
+    - "ti,da850-tilcdc" for DA850/AM18x/OMAP-L138 based boards
  - interrupts: the interrupt number
  - reg: base address and size of the LCDC device
 
@@ -51,7 +53,7 @@ Optional nodes:
 Example:
 
 	fb: fb at 4830e000 {
-		compatible = "ti,am33xx-tilcdc";
+		compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";
 		reg = <0x4830e000 0x1000>;
 		interrupt-parent = <&intc>;
 		interrupts = <36>;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index a694977..231f2c7 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -723,6 +723,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 
 static struct of_device_id tilcdc_of_match[] = {
 		{ .compatible = "ti,am33xx-tilcdc", },
+		{ .compatible = "ti,da850-tilcdc", },
 		{ },
 };
 MODULE_DEVICE_TABLE(of, tilcdc_of_match);
-- 
2.9.3
