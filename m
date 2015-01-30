From: wuyun.wu@huawei.com (Yun Wu)
Date: Fri, 30 Jan 2015 15:46:45 +0800
Subject: [PATCH 1/5] irqchip: gicv3-its: allocate proper size for DT
In-Reply-To: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1422604009-9248-2-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A hardware implementation may be designed to search the device
table (DT) using a direct mapping between device ID and memory
address, and in this scenario a single page, currently allocated
for DT in ITS driver, will be probably not enough.

This patch will try best to get this addressed by enlarging DT
size with a limitation of MAX_ORDER pages.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d8996bd..a391417 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -70,6 +70,7 @@ struct its_node {
 	struct its_collection	*collections;
 	struct list_head	its_device_list;
 	u64			flags;
+	u32			dev_id_bits;
 	u32			ite_size;
 };

@@ -799,6 +800,7 @@ static int its_alloc_tables(struct its_node *its)
 {
 	int err;
 	int i;
+	int size;
 	int psz = PAGE_SIZE;
 	u64 shr = GITS_BASER_InnerShareable;

@@ -812,8 +814,13 @@ static int its_alloc_tables(struct its_node *its)
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;

-		/* We're lazy and only allocate a single page for now */
-		base = (void *)get_zeroed_page(GFP_KERNEL);
+		if (type == GITS_BASER_TYPE_DEVICE)
+			size = 1 << its->dev_id_bits;
+		else
+			size = PAGE_SIZE;
+
+		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						get_order(size / PAGE_SIZE));
 		if (!base) {
 			err = -ENOMEM;
 			goto out_free;
@@ -841,7 +848,7 @@ retry_baser:
 			break;
 		}

-		val |= (PAGE_SIZE / psz) - 1;
+		val |= (size / psz) - 1;

 		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
 		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -1261,7 +1268,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	struct its_node *its;
 	void __iomem *its_base;
 	u32 val;
-	u64 baser, tmp;
+	u64 baser, typer, tmp;
 	int err;

 	err = of_address_to_resource(node, 0, &res);
@@ -1297,7 +1304,15 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	its->base = its_base;
 	its->phys_base = res.start;
 	its->msi_chip.of_node = node;
-	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
+
+	typer = readq_relaxed(its_base + GITS_TYPER);
+	its->ite_size = ((typer >> 4) & 0xf) + 1;
+	its->dev_id_bits = ((typer >> 13) & 0x1f) + 1;
+	if (its->dev_id_bits > KMALLOC_SHIFT_MAX) {
+		pr_warn("%s: DT size too large (%ubits -> %ubits)\n",
+			node->full_name, its->dev_id_bits, KMALLOC_SHIFT_MAX);
+		its->dev_id_bits = KMALLOC_SHIFT_MAX;
+	}

 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
--
1.8.0
