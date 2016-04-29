From: ashoks@broadcom.com (Ashok Kumar)
Date: Fri, 29 Apr 2016 05:18:42 -0700
Subject: [RFC PATCH] irqchip/gic-v3-its: Allocate ITS tables from
 corresponding node memory
Message-ID: <1461932322-1206-1-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the case of systems having multi socket and multi ITS, allocating
local node memory for ITS device table, collection table, interrupt
translation table and command queue will help in reducing inter-chip
traffic even though they(except command queue) could be cached in the GIC.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
This patch is created on top of Cavium thunderx erratum 23144 patch [1].

I am not sure how to do this for ACPI as GIC ITS ID in MADT doesn't map to
_PXM. Am I missing something here? Any thoughts?

[1] https://lkml.org/lkml/2016/4/15/830 - [PATCH v5] irqchip, gicv3-its, \
numa: Enable workaround for Cavium thunderx erratum 23144

Thanks,
Ashok

CC: marc.zyngier at arm.com
CC: rrichter at caviumnetworks.com
CC: gkulkarni at caviumnetworks.com
CC: jchandra at broadcom.com

 drivers/irqchip/irq-gic-v3-its.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 75f258f..9a187c0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -860,6 +860,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		int alloc_pages;
 		u64 tmp;
 		void *base;
+		struct page *pg;
 
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
@@ -897,11 +898,13 @@ retry_alloc_baser:
 				node_name, order, alloc_pages);
 		}
 
-		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
-		if (!base) {
+		pg = alloc_pages_node(its->numa_node,
+				      GFP_KERNEL | __GFP_ZERO, order);
+		if (!pg) {
 			err = -ENOMEM;
 			goto out_free;
 		}
+		base = page_address(pg);
 
 		its->tables[i].base = base;
 		its->tables[i].order = order;
@@ -1184,7 +1187,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
-	itt = kzalloc(sz, GFP_KERNEL);
+	itt = kzalloc_node(sz, GFP_KERNEL, its->numa_node);
 	lpi_map = its_lpi_alloc_chunks(nvecs, &lpi_base, &nr_lpis);
 	if (lpi_map)
 		col_map = kzalloc(sizeof(*col_map) * nr_lpis, GFP_KERNEL);
@@ -1526,7 +1529,8 @@ static int __init its_probe(struct device_node *node,
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
 	its->numa_node = of_node_to_nid(node);
 
-	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
+	its->cmd_base = kzalloc_node(ITS_CMD_QUEUE_SZ, GFP_KERNEL,
+				     its->numa_node);
 	if (!its->cmd_base) {
 		err = -ENOMEM;
 		goto out_free_its;
-- 
1.7.1
