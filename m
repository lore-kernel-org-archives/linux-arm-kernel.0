From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 19 Apr 2018 16:05:34 +0200
Subject: [PATCH 04/61] bus: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180419140641.27926-5-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/bus/brcmstb_gisb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 68ac3e93b600..f58ff67e97ac 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -150,8 +150,7 @@ static ssize_t gisb_arb_get_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	u32 timeout;
 
 	mutex_lock(&gdev->lock);
@@ -165,8 +164,7 @@ static ssize_t gisb_arb_set_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 	int val, ret;
 
 	ret = kstrtoint(buf, 10, &val);
@@ -418,8 +416,7 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int brcmstb_gisb_arb_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gdev->saved_timeout = gisb_read(gdev, ARB_TIMER);
 
@@ -431,8 +428,7 @@ static int brcmstb_gisb_arb_suspend(struct device *dev)
  */
 static int brcmstb_gisb_arb_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct brcmstb_gisb_arb_device *gdev = platform_get_drvdata(pdev);
+	struct brcmstb_gisb_arb_device *gdev = dev_get_drvdata(dev);
 
 	gisb_write(gdev, gdev->saved_timeout, ARB_TIMER);
 
-- 
2.11.0
