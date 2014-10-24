From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 24 Oct 2014 14:50:16 +0800
Subject: [PATCH v3 2/3] i2c/at91: add support for system PM
In-Reply-To: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
References: <1414133417-11530-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1414133417-11530-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index a25fb5e..6a84a2a 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -861,7 +861,33 @@ static int at91_twi_runtime_resume(struct device *dev)
 	return clk_prepare_enable(twi_dev->clk);
 }
 
+static int at91_twi_suspend_noirq(struct device *dev)
+{
+	if (!pm_runtime_status_suspended(dev))
+		at91_twi_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int at91_twi_resume_noirq(struct device *dev)
+{
+	int ret;
+
+	if (!pm_runtime_status_suspended(dev)) {
+		ret = at91_twi_runtime_resume(dev);
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_request_autosuspend(dev);
+
+	return 0;
+}
+
 static const struct dev_pm_ops at91_twi_pm = {
+	.suspend_noirq	= at91_twi_suspend_noirq,
+	.resume_noirq	= at91_twi_resume_noirq,
 	.runtime_suspend	= at91_twi_runtime_suspend,
 	.runtime_resume		= at91_twi_runtime_resume,
 };
-- 
1.7.9.5
