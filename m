From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 15 May 2013 17:16:08 +0200
Subject: [PATCH] rtc: max8998: Check for pdata presence before dereferencing
Message-ID: <1368630968-30460-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the driver can crash with a NULL pointer dereference if no pdata
is provided, despite of successful registration of MFD part. This patch
fixes the problem by adding a NULL check before dereferencing the pdata
pointer.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/rtc/rtc-max8998.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index 48b6612..d5af7ba 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -285,7 +285,7 @@ static int max8998_rtc_probe(struct platform_device *pdev)
 			info->irq, ret);
 
 	dev_info(&pdev->dev, "RTC CHIP NAME: %s\n", pdev->id_entry->name);
-	if (pdata->rtc_delay) {
+	if (pdata && pdata->rtc_delay) {
 		info->lp3974_bug_workaround = true;
 		dev_warn(&pdev->dev, "LP3974 with RTC REGERR option."
 				" RTC updates will be extremely slow.\n");
-- 
1.8.2.1
