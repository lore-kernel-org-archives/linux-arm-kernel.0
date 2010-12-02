From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 10:46:17 -0800
Subject: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
	driver
In-Reply-To: <20101202184419.GR17222@atomide.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-10-git-send-email-manjugk@ti.com>
	<20101202184419.GR17222@atomide.com>
Message-ID: <20101202184617.GS17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [101202 10:34]:
> 
> This fails on omap1 as d is not allocated. Please merge the
> following fix.

And another fix here:

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Dec 2010 10:19:15 -0800
Subject: [PATCH] Fix omap1_system_dma_init to use ioremap

Fix omap1_system_dma_init to use ioremap

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -280,6 +280,12 @@ static int __init omap1_system_dma_init(void)
 		return -ENOMEM;
 	}
 
+	dma_base = ioremap(res[0].start, resource_size(&res[0]));
+	if (!dma_base) {
+		pr_err("%s: Unable to ioremap\n", __func__);
+		return -ENODEV;
+	}
+
 	ret = platform_device_add_resources(pdev, res, ARRAY_SIZE(res));
 	if (ret) {
 		dev_err(&pdev->dev, "%s: Unable to add resources for %s%d\n",
@@ -337,8 +343,6 @@ static int __init omap1_system_dma_init(void)
 
 	p->dma_attr = d;
 
-	dma_base		= (void __iomem *)res[0].start;
-
 	p->show_dma_caps	= omap1_show_dma_caps;
 	p->clear_lch_regs	= omap1_clear_lch_regs;
 	p->clear_dma		= omap1_clear_dma;
