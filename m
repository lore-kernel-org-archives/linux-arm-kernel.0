From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 26 Jul 2017 11:05:39 +0100
Subject: [PATCH] drm: hdlcd: allow HDLCD to be used without interrupt
Message-ID: <E1daJCF-0003pG-DI@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some ARM platforms do not wire the HDLCD interrupt.  Allow hdlcd to
initialise without an interrupt present.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 Documentation/devicetree/bindings/display/arm,hdlcd.txt |  6 +++---
 drivers/gpu/drm/arm/hdlcd_drv.c                         | 13 ++++++++-----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/arm,hdlcd.txt b/Documentation/devicetree/bindings/display/arm,hdlcd.txt
index 78bc24296f3e..7f78b455c4b2 100644
--- a/Documentation/devicetree/bindings/display/arm,hdlcd.txt
+++ b/Documentation/devicetree/bindings/display/arm,hdlcd.txt
@@ -8,9 +8,6 @@ digital encoder (DVI or HDMI).
 Required properties:
   - compatible: "arm,hdlcd"
   - reg: Physical base address and length of the controller's registers.
-  - interrupts: One interrupt used by the display controller to notify the
-    interrupt controller when any of the interrupt sources programmed in
-    the interrupt mask register have activated.
   - clocks: A list of phandle + clock-specifier pairs, one for each
     entry in 'clock-names'.
   - clock-names: A list of clock names. For HDLCD it should contain:
@@ -22,6 +19,9 @@ digital encoder (DVI or HDMI).
     Documentation/devicetree/bindings/graph.txt.
 
 Optional properties:
+  - interrupts: One interrupt used by the display controller to notify the
+    interrupt controller when any of the interrupt sources programmed in
+    the interrupt mask register have activated.
   - memory-region: phandle to a node describing memory (see
     Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt) to be
     used for the framebuffer; if not present, the framebuffer may be located
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index d3da87fbd85a..283c435fe90b 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -36,7 +36,7 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 	struct platform_device *pdev = to_platform_device(drm->dev);
 	struct resource *res;
 	u32 version;
-	int ret;
+	int ret, irq;
 
 	hdlcd->clk = devm_clk_get(drm->dev, "pxlclk");
 	if (IS_ERR(hdlcd->clk))
@@ -82,10 +82,13 @@ static int hdlcd_load(struct drm_device *drm, unsigned long flags)
 		goto setup_fail;
 	}
 
-	ret = drm_irq_install(drm, platform_get_irq(pdev, 0));
-	if (ret < 0) {
-		DRM_ERROR("failed to install IRQ handler\n");
-		goto irq_fail;
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0) {
+		ret = drm_irq_install(drm, irq);
+		if (ret < 0) {
+			DRM_ERROR("failed to install IRQ handler\n");
+			goto irq_fail;
+		}
 	}
 
 	return 0;
-- 
2.7.4
