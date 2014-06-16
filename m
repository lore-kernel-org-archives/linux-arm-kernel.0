From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 16 Jun 2014 16:53:06 +0530
Subject: [PATCH V3 06/16] irqchip: crossbar: remove IS_ERR_VALUE check
In-Reply-To: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
References: <1402917796-31574-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1402917796-31574-7-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

IS_ERR_VALUE makes sense only *if* there could be valid values in
negative error range. But in the cases that we do use it, there is no
such case. Just remove the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sricharan R <r.sricharan@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 9528cf2..42ea49d 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -102,15 +102,15 @@ static int crossbar_domain_xlate(struct irq_domain *d,
 				 unsigned long *out_hwirq,
 				 unsigned int *out_type)
 {
-	unsigned long ret;
+	int ret;
 
 	ret = get_prev_map_irq(intspec[1]);
-	if (!IS_ERR_VALUE(ret))
+	if (ret >= 0)
 		goto found;
 
 	ret = allocate_free_irq(intspec[1]);
 
-	if (IS_ERR_VALUE(ret))
+	if (ret < 0)
 		return ret;
 
 found:
-- 
1.7.9.5
