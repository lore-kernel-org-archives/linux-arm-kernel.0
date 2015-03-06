From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:48 +0000
Subject: [PATCH 09/11] irqchip: gicv3-its: add limitation to page order
In-Reply-To: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
References: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1425659870-11832-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yun Wu <wuyun.wu@huawei.com>

When required size of Device Table is out of the page allocator's
capability, the whole ITS will fail in probing. This actually is
not the hardware's problem and is mainly a limitation of the kernel
page allocator. This patch will keep ITS going on to the next
initializaion stage with an explicit warning.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fe25a9..ec20d4a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -828,6 +828,11 @@ static int its_alloc_tables(struct its_node *its)
 			u32 ids = GITS_TYPER_DEVBITS(typer);
 
 			order = get_order((1UL << ids) * entry_size);
+			if (order >= MAX_ORDER) {
+				order = MAX_ORDER - 1;
+				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
+					its->msi_chip.of_node->full_name, order);
+			}
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
-- 
2.1.4
