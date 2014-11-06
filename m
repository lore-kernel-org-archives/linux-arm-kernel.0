From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 6 Nov 2014 16:52:52 +0800
Subject: [PATCH] mmc: atmel-mci: adopt pinctrl support
Message-ID: <1415263973-15012-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amend the atmel mci pin controller to optionally take a pin control
handle and set the state of the pins to:
- "default" on boot, resume and before performing an transfer.
- "sleep" on suspend().

This should make it possible to optimize energy usage for the pins
both for the suspend/resume cycle.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 4df1599..eb4bfbc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -39,6 +39,7 @@
 #include <linux/atmel_pdc.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/cacheflush.h>
 #include <asm/io.h>
@@ -2385,6 +2386,8 @@ static int __init atmci_probe(struct platform_device *pdev)
 	int				irq;
 	int				ret, i;
 
+	pinctrl_pm_select_default_state(&pdev->dev);
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
@@ -2568,6 +2571,8 @@ static int atmci_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(host->mck);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -2575,6 +2580,8 @@ static int atmci_runtime_resume(struct device *dev)
 {
 	struct atmel_mci *host = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	return clk_prepare_enable(host->mck);
 }
 #endif
-- 
1.7.9.5
