From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:49 +0000
Subject: [PATCH 10/11] irqchip: gicv3-its: define macros for GITS_CTLR fields
In-Reply-To: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
References: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1425659870-11832-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yun Wu <wuyun.wu@huawei.com>

Define macros for GITS_CTLR fields to avoid using magic numbers.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 2 +-
 include/linux/irqchip/arm-gic-v3.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ec20d4a..826da70 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1388,7 +1388,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	writeq_relaxed(baser, its->base + GITS_CBASER);
 	tmp = readq_relaxed(its->base + GITS_CBASER);
 	writeq_relaxed(0, its->base + GITS_CWRITER);
-	writel_relaxed(1, its->base + GITS_CTLR);
+	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
 	if ((tmp ^ baser) & GITS_BASER_SHAREABILITY_MASK) {
 		pr_info("ITS: using cache flushing for cmd queue\n");
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index cbdd440..781974a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -166,6 +166,9 @@
 
 #define GITS_TRANSLATER			0x10040
 
+#define GITS_CTLR_ENABLE		(1U << 0)
+#define GITS_CTLR_QUIESCENT		(1U << 31)
+
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
 #define GITS_TYPER_PTA			(1UL << 19)
-- 
2.1.4
