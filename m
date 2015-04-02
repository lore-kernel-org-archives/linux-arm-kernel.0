From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 16:36:15 +0200
Subject: [PATCH 1/2] mfd: sec: Fix RTC alarm interrupt number on S2MPS11
In-Reply-To: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
References: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1427985376-20420-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC on S2MPS11 is the same as S2MPS14. However interrupt numbers of
RTC alarms 0 and 1 were inversed between these two devices. So when
rtc-s5m driver requested S2MPS14_IRQ_RTCA0 interrupt, it matched to
S2MPS11_IRQ_RTCA1, not RTCA0.

Fix this by using consistent RTC alarm interrupt numbers and adding a
BUILD_BUG_ON for future generations.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mfd/sec-irq.c           | 14 ++++++++++----
 include/linux/mfd/samsung/irq.h |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index ba86a918c2da..806fa8dbb22d 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -61,14 +61,14 @@ static const struct regmap_irq s2mps11_irqs[] = {
 		.reg_offset = 1,
 		.mask = S2MPS11_IRQ_RTC60S_MASK,
 	},
-	[S2MPS11_IRQ_RTCA0] = {
-		.reg_offset = 1,
-		.mask = S2MPS11_IRQ_RTCA0_MASK,
-	},
 	[S2MPS11_IRQ_RTCA1] = {
 		.reg_offset = 1,
 		.mask = S2MPS11_IRQ_RTCA1_MASK,
 	},
+	[S2MPS11_IRQ_RTCA0] = {
+		.reg_offset = 1,
+		.mask = S2MPS11_IRQ_RTCA0_MASK,
+	},
 	[S2MPS11_IRQ_SMPL] = {
 		.reg_offset = 1,
 		.mask = S2MPS11_IRQ_SMPL_MASK,
@@ -484,6 +484,12 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 		return ret;
 	}
 
+	/*
+	 * The rtc-s5m driver requests S2MPS14_IRQ_RTCA0 also for S2MPS11
+	 * so the interrupt number must be consistent.
+	 */
+	BUILD_BUG_ON(((enum s2mps14_irq)S2MPS11_IRQ_RTCA0) != S2MPS14_IRQ_RTCA0);
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/samsung/irq.h b/include/linux/mfd/samsung/irq.h
index f35af7361b60..667aa40486dd 100644
--- a/include/linux/mfd/samsung/irq.h
+++ b/include/linux/mfd/samsung/irq.h
@@ -74,8 +74,8 @@ enum s2mps11_irq {
 	S2MPS11_IRQ_MRB,
 
 	S2MPS11_IRQ_RTC60S,
-	S2MPS11_IRQ_RTCA0,
 	S2MPS11_IRQ_RTCA1,
+	S2MPS11_IRQ_RTCA0,
 	S2MPS11_IRQ_SMPL,
 	S2MPS11_IRQ_RTC1S,
 	S2MPS11_IRQ_WTSR,
-- 
1.9.1
