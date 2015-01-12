From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 17:14:31 +0800
Subject: [PATCH v4 2/4] irqchip: mtk-sysirq: Get irq number from register
 resource size
In-Reply-To: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421054073-43468-3-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yingjoe Chen <yingjoe.chen@mediatek.com>

Originally mtk-sysirq hardcoded supported irq number to 224. This
was fine since all SoCs before support the same number of irqs for
intpol.

However MT8173 intpol support 32 more irq pins, changes to get
irq number from register resource size to suppor MT8173 properly.

Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 0b0d2c0..fadd865 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -23,8 +23,6 @@
 
 #include "irqchip.h"
 
-#define MT6577_SYS_INTPOL_NUM	(224)
-
 struct mtk_sysirq_chip_data {
 	spinlock_t lock;
 	void __iomem *intpol_base;
@@ -124,7 +122,8 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 {
 	struct irq_domain *domain, *domain_parent;
 	struct mtk_sysirq_chip_data *chip_data;
-	int ret = 0;
+	struct resource res;
+	int ret, size, intpol_num;
 
 	domain_parent = irq_find_host(parent);
 	if (!domain_parent) {
@@ -132,19 +131,24 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return ret;
+
 	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
 	if (!chip_data)
 		return -ENOMEM;
 
-	chip_data->intpol_base = of_io_request_and_map(node, 0, "intpol");
-	if (IS_ERR(chip_data->intpol_base)) {
+	size = resource_size(&res);
+	intpol_num = size * 8;
+	chip_data->intpol_base = ioremap(res.start, size);
+	if (!chip_data->intpol_base) {
 		pr_err("mtk_sysirq: unable to map sysirq register\n");
 		ret = PTR_ERR(chip_data->intpol_base);
 		goto out_free;
 	}
 
-	domain = irq_domain_add_hierarchy(domain_parent, 0,
-					  MT6577_SYS_INTPOL_NUM, node,
+	domain = irq_domain_add_hierarchy(domain_parent, 0, intpol_num, node,
 					  &sysirq_domain_ops, chip_data);
 	if (!domain) {
 		ret = -ENOMEM;
-- 
1.8.1.1.dirty
