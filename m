From: wuyun.wu@huawei.com (Yun Wu)
Date: Sun, 15 Feb 2015 17:32:00 +0800
Subject: [PATCH v2 3/6] irqchip: gicv3-its: limit order of DT size to MAX_ORDER
In-Reply-To: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
References: <1423992723-5028-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1423992723-5028-4-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When required DT size is out of the kmalloc()'s capability, the whole
ITS will fail in probing. This actually is not the hardware's problem
and is mainly a limitation of the kernel memory allocator. This patch
will keep ITS going on to the next initializaion step with an explicit
warning.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f5bfa42..de36606 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -828,6 +828,12 @@ static int its_alloc_tables(struct its_node *its)
 			u32 ids = GITS_TYPER_DEVBITS(typer);

 			order = get_order((1UL << ids) * entry_size);
+			if (order >= MAX_ORDER) {
+				pr_warn("%s: DT size too large, reduce to %u pages\n",
+					its->msi_chip.of_node->full_name,
+					1 << order);
+				order = MAX_ORDER;
+			}
 		}

 		alloc_size = (1 << order) * PAGE_SIZE;
--
1.8.0
