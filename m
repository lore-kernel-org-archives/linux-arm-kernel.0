From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:09:02 +0800
Subject: [PATCH 5/7] fb: pxa: support pinmux operation
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/video/pxafb.c |   10 ++++++++++
 drivers/video/pxafb.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 1d1e4f1..af5f618 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -47,6 +47,7 @@
 #include <linux/ioport.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -1799,11 +1800,18 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
+	fbi->pmx = pinmux_get(dev, NULL);
+	if (IS_ERR(fbi->pmx)) {
+		kfree(fbi);
+		return NULL;
+	}
 	fbi->clk = clk_get(dev, NULL);
 	if (IS_ERR(fbi->clk)) {
+		pinmux_put(fbi->pmx);
 		kfree(fbi);
 		return NULL;
 	}
+	pinmux_enable(fbi->pmx);
 
 	strcpy(fbi->fb.fix.id, PXA_NAME);
 
@@ -2293,6 +2301,8 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	release_mem_region(r->start, resource_size(r));
 
 	clk_put(fbi->clk);
+	pinmux_disable(fbi->pmx);
+	pinmux_put(fbi->pmx);
 	kfree(fbi);
 
 	return 0;
diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index 26ba9fa..d232816 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -110,6 +110,7 @@ struct pxafb_info {
 	struct fb_info		fb;
 	struct device		*dev;
 	struct clk		*clk;
+	struct pinmux		*pmx;
 
 	void __iomem		*mmio_base;
 
-- 
1.7.0.4
