From: khilman@ti.com (Kevin Hilman)
Date: Fri,  6 Jul 2012 09:33:54 -0700
Subject: [PATCH] drivers/rtc/rtc-twl.c: fix threaded IRQ to use IRQF_ONESHOT
Message-ID: <1341592434-4207-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Requesting a threaded interrupt without a primary handler and without
IRQF_ONESHOT is dangerous, and after commit 1c6c6952 (genirq: Reject
bogus threaded irq requests), these requests are rejected.  This
causes ->probe() to fail, and the RTC driver not to be availble.

To fix, add IRQF_ONESHOT to the IRQ flags.

Tested on OMAP3730/OveroSTORM and OMAP4430/Panda board using rtcwake
to wake from system suspend multiple times.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Resending to broader audience and including Andrew.  Since, I understand
that drivers/rtc is somewhat orphaned, Andrew, can you queue this fix for
v3.5.  Thanks.

 drivers/rtc/rtc-twl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 258abea..c5d06fe 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -510,7 +510,7 @@ static int __devinit twl_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = request_threaded_irq(irq, NULL, twl_rtc_interrupt,
-				   IRQF_TRIGGER_RISING,
+				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				   dev_name(&rtc->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
-- 
1.7.9.2
