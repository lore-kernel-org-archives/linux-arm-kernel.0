From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 21 Feb 2012 17:04:55 +0800
Subject: [PATCH 6/7] rtc: sa1100: enable clk support
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1329815096-6200-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clk support in sa1100 rtc.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/rtc/rtc-sa1100.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index 90425ce..f031f4d 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -23,6 +23,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/clk.h>
 #include <linux/rtc.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -63,6 +64,7 @@ struct sa1100_rtc {
 	int			irq_1hz;
 	int			irq_alarm;
 	struct rtc_device	*rtc;
+	struct clk		*clk;
 
 	void __iomem		*reg_base;
 	void __iomem		*reg_rcnr;
@@ -306,6 +308,13 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
+	info->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed to find rtc clock source\n");
+		ret = PTR_ERR(info->clk);
+		goto err_clk;
+	}
+	clk_prepare_enable(info->clk);
 	info->iobase = res->start;
 	info->iosize = resource_size(res);
 	info->irq_1hz = irq_1hz;
@@ -379,6 +388,9 @@ err_dev:
 	iounmap(info->reg_base);
 err_map:
 	platform_set_drvdata(pdev, NULL);
+	clk_disable_unprepare(info->clk);
+	clk_put(info->clk);
+err_clk:
 	kfree(info);
 	return ret;
 }
@@ -391,6 +403,8 @@ static int sa1100_rtc_remove(struct platform_device *pdev)
 		rtc_device_unregister(info->rtc);
 		platform_set_drvdata(pdev, NULL);
 		iounmap(info->reg_base);
+		clk_disable_unprepare(info->clk);
+		clk_put(info->clk);
 		kfree(info);
 	}
 
-- 
1.7.0.4
