From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Oct 2013 11:46:27 +0200
Subject: [PATCH 5/9] rtc: amba: Remove unnecessary amba_set_drvdata()
In-Reply-To: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
References: <27e289763bbcb7d10f84081543cfc3a4dc770398.1380793579.git.michal.simek@xilinx.com>
Message-ID: <c9c7ff49f1f9b42a5cd31ce988102c067c9afaa1.1380793579.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver core clears the driver data to NULL after device_release
or on probe failure, so just remove it from here.

Driver core change:
"device-core: Ensure drvdata = NULL when no driver is bound"
(sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/rtc/rtc-pl030.c | 2 --
 drivers/rtc/rtc-pl031.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
index 22bacdb..a804f75 100644
--- a/drivers/rtc/rtc-pl030.c
+++ b/drivers/rtc/rtc-pl030.c
@@ -153,8 +153,6 @@ static int pl030_remove(struct amba_device *dev)
 {
 	struct pl030_rtc *rtc = amba_get_drvdata(dev);

-	amba_set_drvdata(dev, NULL);
-
 	writel(0, rtc->base + RTC_CR);

 	free_irq(dev->irq[0], rtc);
diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 0f0609b..c9ca86e 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -305,7 +305,6 @@ static int pl031_remove(struct amba_device *adev)
 {
 	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);

-	amba_set_drvdata(adev, NULL);
 	free_irq(adev->irq[0], ldata);
 	rtc_device_unregister(ldata->rtc);
 	iounmap(ldata->base);
@@ -392,7 +391,6 @@ out_no_irq:
 	rtc_device_unregister(ldata->rtc);
 out_no_rtc:
 	iounmap(ldata->base);
-	amba_set_drvdata(adev, NULL);
 out_no_remap:
 	kfree(ldata);
 out:
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/563d0f62/attachment.sig>
