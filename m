From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 11:47:35 +0900
Subject: [PATCHv2] ARM: S5P: Can handle edge interrupt handler
Message-ID: <017f01cce867$825f9740$871ec5c0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KeyYoung Park <keyyoung.park@samsung.com>

While wake up, if external interrupt uses handle_level_irq
as handle_irq (it actually uses edge type irq), That interrupt is missed.
So, if external uses edge type irq, it should use handle_edge_irq.

Signed-off-by: KeyYoung Park <keyyoung.park@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 arch/arm/plat-s5p/irq-eint.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s5p/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
index c496b35..efdea58 100644
--- a/arch/arm/plat-s5p/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -115,6 +115,11 @@ static int s5p_irq_eint_set_type(struct irq_data *data, unsigned int type)
 	else
 		printk(KERN_ERR "No such irq number %d", offs);
 
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		__irq_set_handler_locked(data->irq, handle_edge_irq);
+	else
+		__irq_set_handler_locked(data->irq, handle_level_irq);
+
 	return 0;
 }
 
-- 
1.7.1
