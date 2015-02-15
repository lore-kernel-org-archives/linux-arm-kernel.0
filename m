From: wuyun.wu@huawei.com (Yun Wu)
Date: Sun, 15 Feb 2015 17:32:02 +0800
Subject: [PATCH v2 5/6] irqchip: gicv3-its: add support for power down
In-Reply-To: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1423992723-5028-6-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's unsafe to change the configurations of an activated ITS directly
since this will lead to unpredictable results. This patch guarantees
a safe quiescent status before initializing an ITS.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 42c03b2..29eb665 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1321,6 +1321,31 @@ static const struct irq_domain_ops its_domain_ops = {
 	.deactivate		= its_irq_domain_deactivate,
 };

+static int its_check_quiesced(void __iomem *base)
+{
+	u32 count = 1000000;	/* 1s */
+	u32 val;
+
+	val = readl_relaxed(base + GITS_CTLR);
+	if (val & GITS_CTLR_QUIESCENT)
+		return 0;
+
+	/* Disable the generation of all interrupts to this ITS */
+	val &= ~GITS_CTLR_ENABLE;
+	writel_relaxed(val, base + GITS_CTLR);
+
+	/* Poll GITS_CTLR and wait until ITS becomes quiescent */
+	while (count--) {
+		val = readl_relaxed(base + GITS_CTLR);
+		if (val & GITS_CTLR_QUIESCENT)
+			return 0;
+		cpu_relax();
+		udelay(1);
+	}
+
+	return -EBUSY;
+}
+
 static int its_probe(struct device_node *node, struct irq_domain *parent)
 {
 	struct resource res;
@@ -1349,6 +1374,13 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 		goto out_unmap;
 	}

+	err = its_check_quiesced(its_base);
+	if (err) {
+		pr_warn("%s: failed to quiesce, behaviour unpredictable\n",
+			node->full_name);
+		goto out_unmap;
+	}
+
 	pr_info("ITS: %s\n", node->full_name);

 	its = kzalloc(sizeof(*its), GFP_KERNEL);
--
1.8.0
