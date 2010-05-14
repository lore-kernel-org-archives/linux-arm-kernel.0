From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 14 May 2010 18:01:39 +0300
Subject: [PATCH v2 06/17] omap: mailbox: update omap1 probing
In-Reply-To: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
References: <1273849310-32169-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1273849310-32169-7-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on omap2 code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap1/mailbox.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/mailbox.c b/arch/arm/mach-omap1/mailbox.c
index 15bf2a2..211b9fc 100644
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
@@ -161,27 +156,32 @@ static int __devinit omap1_mbox_probe(struct platform_device *pdev)
 	}
 
 	mbox_base = ioremap(res->start, resource_size(res));
-	if (!mbox_base) {
-		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENODEV;
-	}
+	if (!mbox_base)
+		return -ENOMEM;
 
 	/* DSP IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (unlikely(!res)) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
-		iounmap(mbox_base);
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
