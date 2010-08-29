From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 29 Aug 2010 13:17:03 +0200
Subject: [PATCH] pxa168fb: Add .remove function
Message-ID: <1283080623-13937-1-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa168fb driver is missing .remove function so the framebuffer isn't
correctly shut down when the module is removed.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---

I only compile-tested it. Haojian, could you please review and test it properly?
Thanks !

 drivers/video/pxa168fb.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 5d786bd..7ce4aac 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -784,12 +784,51 @@ failed:
 	return ret;
 }
 
+static int __devexit pxa168fb_remove(struct platform_device *pdev)
+{
+	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
+	struct fb_info *info;
+	int irq;
+	struct resource *res;
+
+	if (!fbi)
+		return 0;
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
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
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
 
 static int __init pxa168fb_init(void)
-- 
1.7.1
