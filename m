From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 11:30:32 +0200
Subject: [PATCH v2 3/6] rtc: at91sam9: add DT support
In-Reply-To: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410255035-26775-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1410255035-26775-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_match_table to the existing driver so that rtc nodes defined in at91
DTs can be attached to this driver.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 74a9ca0..57014b7 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -454,6 +454,14 @@ static int at91_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(at91_rtc_pm_ops, at91_rtc_suspend, at91_rtc_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id at91_rtc_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9260-rtt" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
+#endif
+
 static struct platform_driver at91_rtc_driver = {
 	.probe		= at91_rtc_probe,
 	.remove		= at91_rtc_remove,
@@ -462,6 +470,7 @@ static struct platform_driver at91_rtc_driver = {
 		.name	= "rtc-at91sam9",
 		.owner	= THIS_MODULE,
 		.pm	= &at91_rtc_pm_ops,
+		.of_match_table = of_match_ptr(at91_rtc_dt_ids),
 	},
 };
 
-- 
1.9.1
