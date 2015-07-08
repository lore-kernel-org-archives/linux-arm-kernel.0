From: hdegoede@redhat.com (Hans de Goede)
Date: Wed,  8 Jul 2015 16:41:40 +0200
Subject: [PATCH v6 4/4] musb: sunxi: Add support for musb controller in A33 SoC
In-Reply-To: <1436366500-12555-1-git-send-email-hdegoede@redhat.com>
References: <1436366500-12555-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1436366500-12555-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A33 SoC uses the same musb controller as found on the A31 and later,
but allwinner has removed the configdata register, this commit adds special
handling for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt  |  3 ++-
 drivers/usb/musb/sunxi.c                                  | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
index fde180b..862cd7c 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.txt
@@ -2,7 +2,8 @@ Allwinner sun4i A10 musb DRC/OTG controller
 -------------------------------------------
 
 Required properties:
- - compatible      : "allwinner,sun4i-a10-musb" or "allwinner,sun6i-a31-musb"
+ - compatible      : "allwinner,sun4i-a10-musb", "allwinner,sun6i-a31-musb"
+                     or "allwinner,sun8i-a33-musb"
  - reg             : mmio address range of the musb controller
  - clocks          : clock specifier for the musb controller ahb gate clock
  - reset           : reset specifier for the ahb reset (A31 and newer only)
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index df2f75e..f9f6304 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -73,6 +73,7 @@
 #define SUNXI_MUSB_FL_PHY_ON			4
 #define SUNXI_MUSB_FL_HAS_SRAM			5
 #define SUNXI_MUSB_FL_HAS_RESET			6
+#define SUNXI_MUSB_FL_NO_CONFIGDATA		7
 
 /* Our read/write methods need access and do not get passed in a musb ref :| */
 static struct musb *sunxi_musb;
@@ -370,6 +371,8 @@ static u32 sunxi_musb_busctl_offset(u8 epnum, u16 offset)
 
 static u8 sunxi_musb_readb(const void __iomem *addr, unsigned offset)
 {
+	struct sunxi_glue *glue;
+
 	if (addr == sunxi_musb->mregs) {
 		/* generic control or fifo control reg access */
 		switch (offset) {
@@ -392,6 +395,12 @@ static u8 sunxi_musb_readb(const void __iomem *addr, unsigned offset)
 		case MUSB_RXFIFOSZ:
 			return readb(addr + SUNXI_MUSB_RXFIFOSZ);
 		case MUSB_CONFIGDATA + 0x10: /* See musb_read_configdata() */
+			glue = dev_get_drvdata(sunxi_musb->controller->parent);
+			/* A33 saves a reg, and we get to hardcode this */
+			if (test_bit(SUNXI_MUSB_FL_NO_CONFIGDATA,
+				     &glue->flags))
+				return 0xde;
+
 			return readb(addr + SUNXI_MUSB_CONFIGDATA);
 		/* Offset for these is fixed by sunxi_musb_busctl_offset() */
 		case SUNXI_MUSB_TXFUNCADDR:
@@ -643,6 +652,11 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 
+	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb")) {
+		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
+		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
+	}
+
 	glue->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(glue->clk)) {
 		dev_err(&pdev->dev, "Error getting clock: %ld\n",
@@ -723,6 +737,7 @@ static int sunxi_musb_remove(struct platform_device *pdev)
 static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-musb", },
 	{ .compatible = "allwinner,sun6i-a31-musb", },
+	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{}
 };
 
-- 
2.4.3
