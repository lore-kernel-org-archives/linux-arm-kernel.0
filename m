From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 29 Aug 2010 20:32:16 -0400
Subject: [PATCH] pxa168fb: Add .remove function
Message-ID: <1283128337-4605-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa168fb driver is missing .remove function so the framebuffer isn't
correctly shut down when the module is removed.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/video/pxa168fb.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index c91a7f7..ec2ddb2 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -784,12 +784,53 @@ failed:
 	return ret;
 }
 
+static int __devexit pxa168fb_remove(struct platform_device *pdev)
+{
+	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
+	struct fb_info *info;
+	int irq;
+	unsigned int data;
+
+	if (!fbi)
+		return 0;
+
+	/* disable DMA transfer */
+	data = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
+	data &= ~CFG_GRA_ENA_MASK;
+	writel(data, fbi->reg_base + LCD_SPU_DMA_CTRL0);
+
+	info = fbi->info;
+
+	unregister_framebuffer(info);
+
+	writel(GRA_FRAME_IRQ0_ENA(0x0), fbi->reg_base + SPU_IRQ_ENA);
+
+	if (info->cmap.len)
+		fb_dealloc_cmap(&info->cmap);
+
+	irq = platform_get_irq(pdev, 0);
+	free_irq(irq, fbi);
+
+	dma_free_writecombine(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
+				info->screen_base, info->fix.smem_start);
+
+	iounmap(fbi->reg_base);
+
+	clk_disable(fbi->clk);
+	clk_put(fbi->clk);
+
+	framebuffer_release(info);
+
+	return 0;
+}
+
 static struct platform_driver pxa168fb_driver = {
 	.driver		= {
 		.name	= "pxa168-fb",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pxa168fb_probe,
+	.remove		= __devexit_p(pxa168fb_remove),
 };
 
 static int __devinit pxa168fb_init(void)
@@ -798,6 +839,12 @@ static int __devinit pxa168fb_init(void)
 }
 module_init(pxa168fb_init);
 
+static void __exit pxa168fb_exit(void)
+{
+	platform_driver_unregister(&pxa168fb_driver);
+}
+module_exit(pxa168fb_exit);
+
 MODULE_AUTHOR("Lennert Buytenhek <buytenh@marvell.com> "
 	      "Green Wan <gwan@marvell.com>");
 MODULE_DESCRIPTION("Framebuffer driver for PXA168/910");
-- 
1.5.6.5
