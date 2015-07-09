From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Jul 2015 14:19:08 +0100
Subject: [PATCH 3/6] irqchip: GICv3: Skip LPI deactivation
In-Reply-To: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436447951-22357-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to other GICv3 interrupts, LPIs do not have an active state
by virtue of being edge-triggered only (they only have a pending state).

Given this, there is no point trying to deactivate them, and we can
skip the ICC_DIR_EL1 entierely.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 49768fc..e02592b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -295,10 +295,14 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	if (static_key_true(&supports_deactivate))
+	if (static_key_true(&supports_deactivate)) {
+		/* No need to deactivate an LPI */
+		if (gic_irq(d) >= 8192)
+			return;
 		gic_write_dir(gic_irq(d));
-	else
+	} else {
 		gic_write_eoir(gic_irq(d));
+	}
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
-- 
2.1.4
