From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Dec 2010 10:44:19 -0800
Subject: [PATCH v5 09/14] OMAP: DMA: Convert DMA library into platform
	driver
In-Reply-To: <1290603110-14119-10-git-send-email-manjugk@ti.com>
References: <1290603110-14119-1-git-send-email-manjugk@ti.com>
	<1290603110-14119-10-git-send-email-manjugk@ti.com>
Message-ID: <20101202184419.GR17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* G, Manjunath Kondaiah <manjugk@ti.com> [101124 04:42]:
> Convert DMA library into DMA platform driver and make use of
> platform data provided by hwmod data base for OMAP2+ onwards.
> 
> For OMAP1 processors, the DMA driver in mach-omap uses resource
> structures for getting platform data.

And has never been tested..

<snip>

>  static int __init omap1_system_dma_init(void)
>  {
>  	struct omap_system_dma_plat_info	*p;
> +	struct omap_dma_dev_attr		*d;
>  	struct platform_device			*pdev;
>  	int ret;
>  
> @@ -153,22 +295,74 @@ static int __init omap1_system_dma_init(void)
>  		goto exit_device_put;
>  	}
>  
> +	d = p->dma_attr;

This fails on omap1 as d is not allocated. Please merge the
following fix.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 2 Dec 2010 10:02:08 -0800
Subject: [PATCH] Fix dma init for omap1

Fix dma init for omap1

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -295,13 +295,20 @@ static int __init omap1_system_dma_init(void)
 		goto exit_device_put;
 	}
 
-	d = p->dma_attr;
+	d = kzalloc(sizeof(struct omap_dma_dev_attr), GFP_KERNEL);
+	if (!d) {
+		dev_err(&pdev->dev, "%s: Unable to allocate 'd' for %s\n",
+			__func__, pdev->name);
+		ret = -ENOMEM;
+		goto exit_release_p;
+	}
+
 	d->chan = kzalloc(sizeof(struct omap_dma_lch) *
 					(d->lch_count), GFP_KERNEL);
 	if (!d->chan) {
 		dev_err(&pdev->dev, "%s: Memory allocation failed"
 					"for d->chan!!!\n", __func__);
-		goto exit_release_p;
+		goto exit_release_d;
 	}
 
 	/* Valid attributes for omap1 plus processors */
@@ -328,6 +335,8 @@ static int __init omap1_system_dma_init(void)
 			d->chan_count = 9;
 	}
 
+	p->dma_attr = d;
+
 	dma_base		= (void __iomem *)res[0].start;
 
 	p->show_dma_caps	= omap1_show_dma_caps;
@@ -361,6 +370,8 @@ static int __init omap1_system_dma_init(void)
 
 exit_release_chan:
 	kfree(d->chan);
+exit_release_d:
+	kfree(d);
 exit_release_p:
 	kfree(p);
 exit_device_put:
