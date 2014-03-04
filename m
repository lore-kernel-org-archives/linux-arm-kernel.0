From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Mar 2014 10:48:52 -0800
Subject: [PATCH 2/2] mfd: pm8921: Use IRQCHIP_SKIP_SET_WAKE
In-Reply-To: <1393958932-3585-1-git-send-email-sboyd@codeaurora.org>
References: <1393958932-3585-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1393958932-3585-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to implement a dummy irq_set_wake op if we just set
IRQCHIP_SKIP_SET_WAKE.

Suggested-by: Josh Cartwright <joshc@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/pm8921-core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mfd/pm8921-core.c b/drivers/mfd/pm8921-core.c
index 3ebbdf6c61db..3493cd6e973b 100644
--- a/drivers/mfd/pm8921-core.c
+++ b/drivers/mfd/pm8921-core.c
@@ -240,18 +240,12 @@ static int pm8xxx_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	return pm8xxx_config_irq(chip, block, config);
 }
 
-static int pm8xxx_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	return 0;
-}
-
 static struct irq_chip pm8xxx_irq_chip = {
 	.name		= "pm8xxx",
 	.irq_mask_ack	= pm8xxx_irq_mask_ack,
 	.irq_unmask	= pm8xxx_irq_unmask,
 	.irq_set_type	= pm8xxx_irq_set_type,
-	.irq_set_wake	= pm8xxx_irq_set_wake,
-	.flags		= IRQCHIP_MASK_ON_SUSPEND,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE,
 };
 
 static int pm8xxx_irq_domain_map(struct irq_domain *d, unsigned int irq,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
