From: wuyun.wu@huawei.com (Yun Wu)
Date: Wed, 4 Mar 2015 11:18:16 +0800
Subject: [PATCH v3 3/5] irqchip: gicv3-its: add limitation to page order
In-Reply-To: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
References: <1425439098-10708-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1425439098-10708-4-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When required size of Device Table is out of the page allocator's
capability, the whole ITS will fail in probing. This actually is
not the hardware's problem and is mainly a limitation of the kernel
page allocator. This patch will keep ITS going on to the next
initializaion stage with an explicit warning.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f5bfa42..e8bda0b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -828,6 +828,11 @@ static int its_alloc_tables(struct its_node *its)
 			u32 ids = GITS_TYPER_DEVBITS(typer);

 			order = get_order((1UL << ids) * entry_size);
+			if (order >= MAX_ORDER) {
+				order = MAX_ORDER - 1;
+				pr_warn("%s: DT size too large, reduce page order to %u\n",
+					its->msi_chip.of_node->full_name, order);
+			}
 		}

 		alloc_size = (1 << order) * PAGE_SIZE;
--
1.8.0
