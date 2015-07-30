From: henryc.chen@mediatek.com (Henry Chen)
Date: Thu, 30 Jul 2015 22:53:14 +0800
Subject: [PATCH] rtc: mt6397: implement suspend/resume function in rtc-mt6397
 driver
Message-ID: <1438267994-13934-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the suspend/resume function in order to control rtc's irq_wake flag and handle as wakeup source.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c0090b6..9f6c9f8 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -373,6 +373,31 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mt6397_rtc_suspend(struct device *dev)
+{
+	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(rtc->irq);
+
+	return 0;
+}
+
+static int mt6397_rtc_resume(struct device *dev)
+{
+	struct mt6397_rtc *rtc = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(rtc->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
+			mt6397_rtc_resume);
+
 static const struct of_device_id mt6397_rtc_of_match[] = {
 	{ .compatible = "mediatek,mt6397-rtc", },
 	{ }
@@ -382,6 +407,7 @@ static struct platform_driver mtk_rtc_driver = {
 	.driver = {
 		.name = "mt6397-rtc",
 		.of_match_table = mt6397_rtc_of_match,
+		.pm = &mt6397_pm_ops,
 	},
 	.probe	= mtk_rtc_probe,
 	.remove = mtk_rtc_remove,
-- 
1.8.1.1.dirty
