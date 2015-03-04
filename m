From: wuyun.wu@huawei.com (Yun Wu)
Date: Wed, 4 Mar 2015 11:18:17 +0800
Subject: [PATCH v3 4/5] irqchip: gicv3-its: define macros for GITS_CTLR fields
In-Reply-To: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
References: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1425439098-10708-5-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define macros for GITS_CTLR fields to avoid using magic numbers.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 2 +-
 include/linux/irqchip/arm-gic-v3.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8bda0b..d13c24e 100644
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
index 3459b43..c9d3002 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -134,6 +134,9 @@

 #define GITS_TRANSLATER			0x10040

+#define GITS_CTLR_ENABLE		(1U << 0)
+#define GITS_CTLR_QUIESCENT		(1U << 31)
+
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
 #define GITS_TYPER_PTA			(1UL << 19)
--
1.8.0
