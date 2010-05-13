From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 13 May 2010 20:47:26 +0300
Subject: [PATCH 05/15] omap: mailbox: update omap1 probing
In-Reply-To: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
References: <1273772856-10881-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1273772856-10881-6-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on omap2 code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index f3266dd..9667f2f 100644
--- a/arch/arm/mach-omap1/mailbox.c
+++ b/arch/arm/mach-omap1/mailbox.c
@@ -146,12 +146,7 @@ EXPORT_SYMBOL(mbox_dsp_info);
 static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-
-	if (pdev->num_resources != 2) {
-		dev_err(&pdev->dev, "invalid number of resources: %d\n",
-			pdev->num_resources);
-		return -ENODEV;
-	}
+	int ret;
 
 	/* MBOX base */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -159,23 +154,33 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid mem resource\n");
 		return -ENODEV;
 	}
-	mbox_base = OMAP1_IO_ADDRESS(res->start);
+	mbox_base = ioremap(res->start, resource_size(res));
+	if (!mbox_base)
+		return -ENOMEM;
 
 	/* DSP IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_out;
 	}
 	mbox_dsp_info.irq = res->start;
 
-	return omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
+	if (ret)
+		goto err_out;
+	return 0;
+
+err_out:
+	iounmap(mbox_base);
+	return ret;
 }
 
 static int __devexit omap1_mbox_remove(struct platform_device *pdev)
 {
 	omap_mbox_unregister(&mbox_dsp_info);
-
+	iounmap(mbox_base);
 	return 0;
 }
 
-- 
1.7.1
