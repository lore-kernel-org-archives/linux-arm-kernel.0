From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:44:36 -0400
Subject: [PATCH 5/5] mfd: fix max8925 irq control bit incorrect setting
In-Reply-To: <1283953476-2395-4-git-send-email-haojian.zhuang@marvell.com>
References: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-3-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953476-2395-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

In max8925_irq_sync_unlock(), irq control bit is set at the same time.
Zero means enabling irq, and one means disabling irq.

The original code is:
	irq_chg[0] &= irq_data->enable;

It should be changed to:
	irq_chg[0] &= ~irq_data->enable;

Otherwise, irq control bit is mess.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Samuel Ortiz <sameo@openedhand.com>
---
 drivers/mfd/max8925-core.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index f9cdfbe..44695f5 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -434,24 +434,25 @@ static void max8925_irq_sync_unlock(unsigned int irq)
 	irq_tsc = cache_tsc;
 	for (i = 0; i < ARRAY_SIZE(max8925_irqs); i++) {
 		irq_data = &max8925_irqs[i];
+		/* 1 -- disable, 0 -- enable */
 		switch (irq_data->mask_reg) {
 		case MAX8925_CHG_IRQ1_MASK:
-			irq_chg[0] &= irq_data->enable;
+			irq_chg[0] &= ~irq_data->enable;
 			break;
 		case MAX8925_CHG_IRQ2_MASK:
-			irq_chg[1] &= irq_data->enable;
+			irq_chg[1] &= ~irq_data->enable;
 			break;
 		case MAX8925_ON_OFF_IRQ1_MASK:
-			irq_on[0] &= irq_data->enable;
+			irq_on[0] &= ~irq_data->enable;
 			break;
 		case MAX8925_ON_OFF_IRQ2_MASK:
-			irq_on[1] &= irq_data->enable;
+			irq_on[1] &= ~irq_data->enable;
 			break;
 		case MAX8925_RTC_IRQ_MASK:
-			irq_rtc &= irq_data->enable;
+			irq_rtc &= ~irq_data->enable;
 			break;
 		case MAX8925_TSC_IRQ_MASK:
-			irq_tsc &= irq_data->enable;
+			irq_tsc &= ~irq_data->enable;
 			break;
 		default:
 			dev_err(chip->dev, "wrong IRQ\n");
-- 
1.5.6.5
