From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 28 Nov 2012 21:21:10 -0500
Subject: [PATCH 4/4] rtc: pxa: request rtc irqs when probe/remove the device
In-Reply-To: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1354155670-6267-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original pxa_rtc_open/pxa_rtc_release will be called
when the /dev/rtc0 is opened or closed.
In fact, these two functions will register/unregister the irqs.
User application will use /dev/rtc0 to read the rtc time or set
the alarm. The rtc should still run indepent of open/close the
rtc device.
So only register the irqs when probe the device,
and disable clock and unregister the irqs when remove the device.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/rtc/rtc-pxa.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index 29646af..19abeb8 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -340,8 +340,6 @@ static int pxa_rtc_proc(struct device *dev, struct seq_file *seq)
 }
 
 static const struct rtc_class_ops pxa_rtc_ops = {
-	.open = pxa_rtc_open,
-	.release = pxa_rtc_release,
 	.read_time = pxa_rtc_read_time,
 	.set_time = pxa_rtc_set_time,
 	.read_alarm = pxa_rtc_read_alarm,
@@ -435,6 +433,11 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = pxa_rtc_open(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to request irqs for rtc\n");
+		goto err_open;
+	}
 	/*
 	 * If the clock divider is uninitialized then reset it to the
 	 * default value to get the 1Hz clock.
@@ -461,6 +464,8 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 err_rtc_reg:
+	pxa_rtc_release(&pdev->dev);
+err_open:
 	if (pxa_rtc->id == RTC_PXA95X)
 		 iounmap(pxa_rtc->base_psbr);
 err_map_base_psbr:
@@ -477,6 +482,8 @@ static int __exit pxa_rtc_remove(struct platform_device *pdev)
 
 	rtc_device_unregister(pxa_rtc->rtc);
 
+	pxa_rtc_release(&pdev->dev);
+
 	spin_lock_irq(&pxa_rtc->lock);
 	iounmap(pxa_rtc->base);
 	spin_unlock_irq(&pxa_rtc->lock);
-- 
1.7.4.1
