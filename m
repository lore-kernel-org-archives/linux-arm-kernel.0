From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Mar 2013 16:05:49 -0700
Subject: [PATCH] irqchip: gic: fix irq_trigger return
Message-ID: <1363734349-32635-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

The genirq layer expects a 0 in case of failure but the code is
returning -ENXIO. Fix it.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/irqchip/irq-gic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 644d724..2ebf28a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -236,7 +236,8 @@ static int gic_retrigger(struct irq_data *d)
 	if (gic_arch_extn.irq_retrigger)
 		return gic_arch_extn.irq_retrigger(d);
 
-	return -ENXIO;
+	/* the genirq layer expects 0 for a failure */
+	return 0;
 }
 
 #ifdef CONFIG_SMP
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
