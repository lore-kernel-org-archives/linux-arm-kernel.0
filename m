From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 21 Oct 2014 10:26:18 +0800
Subject: [PATCH v2 2/3] i2c/at91: add support for system PM
In-Reply-To: <1413858379-22865-1-git-send-email-wenyou.yang@atmel.com>
References: <1413858379-22865-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1413858379-22865-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 1b43b08..8f8fd2a 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -861,7 +861,32 @@ static int at91_twi_runtime_resume(struct device *dev)
 	return clk_prepare_enable(twi_dev->clk);
 }
 
+static int at91_twi_suspend(struct device *dev)
+{
+	if (!pm_runtime_suspended(dev))
+		at91_twi_runtime_suspend(dev);
+
+	return 0;
+}
+
+static int at91_twi_resume(struct device *dev)
+{
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
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
+	SET_SYSTEM_SLEEP_PM_OPS(at91_twi_suspend, at91_twi_resume)
 	SET_RUNTIME_PM_OPS(at91_twi_runtime_suspend,
 				at91_twi_runtime_resume, NULL)
 };
-- 
1.7.9.5
