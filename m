From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 29 Jul 2015 14:02:01 +0800
Subject: [PATCH] drivers/rtc/rtc-pl031.c: reset registers in init flow
Message-ID: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
the data register (DR) will read back as value zero. So the suspend
test code will set the match register (MR) for 10 seconds' timeout; But
there have chance later will read back some random values from DR
register; So finally miss with match value and will not trigger
waken up event anymore.

This issue can be dismissed by reset registers in initialization flow;
And this code have no harm for ST's variant.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/rtc/rtc-pl031.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..01768de 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -345,6 +345,12 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
 	dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
 
+	/* Init registers */
+	writel(0x0, ldata->base + RTC_LR);
+	writel(0x0, ldata->base + RTC_DR);
+	writel(0x0, ldata->base + RTC_IMSC);
+	writel(RTC_BIT_AI, ldata->base + RTC_ICR);
+
 	data = readl(ldata->base + RTC_CR);
 	/* Enable the clockwatch on ST Variants */
 	if (vendor->clockwatch)
-- 
1.9.1
