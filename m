From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 19 Feb 2016 16:22:43 +0100
Subject: [PATCH v3 1/7] irqchip/gic-v3: always return IRQ_SET_MASK_OK_DONE in
 gic_set_affinity
In-Reply-To: <1455895369-13187-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1455895369-13187-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1455895369-13187-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Always return IRQ_SET_MASK_OK_DONE instead of IRQ_SET_MASK_OK when the
affinity has been updated. When using stacked irqchips, returning
IRQ_SET_MASK_OK_DONE means skipping all descendant irqchips.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7be6ddc34f6..ca120a99bd5a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -634,7 +634,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	else
 		gic_dist_wait_for_rwp();
 
-	return IRQ_SET_MASK_OK;
+	return IRQ_SET_MASK_OK_DONE;
 }
 #else
 #define gic_set_affinity	NULL
-- 
2.7.1
