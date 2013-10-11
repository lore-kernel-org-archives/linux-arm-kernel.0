From: rogerq@ti.com (Roger Quadros)
Date: Fri, 11 Oct 2013 19:13:16 +0300
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask is
 changed
Message-ID: <1381507996-15021-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On OMAPs the IO ring must be rearmed each time the pad wakeup
configuration is changed. So call pcs_soc->rearm() from
pcs_irq_set().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/pinctrl/pinctrl-single.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index c2aada7..1800e47 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1604,6 +1604,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
 		pcs->write(mask, pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 	}
+
+	if (pcs_soc->rearm)
+		pcs_soc->rearm();
 }
 
 /**
@@ -1626,8 +1629,6 @@ static void pcs_irq_unmask(struct irq_data *d)
 	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
 
 	pcs_irq_set(pcs_soc, d->irq, true);
-	if (pcs_soc->rearm)
-		pcs_soc->rearm();
 }
 
 /**
-- 
1.7.4.1
