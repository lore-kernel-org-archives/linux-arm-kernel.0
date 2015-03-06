From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:47 +0000
Subject: [PATCH 08/11] irqchip: gicv3-its: use 64KB page as default granule
In-Reply-To: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
References: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1425659870-11832-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yun Wu <wuyun.wu@huawei.com>

The field of page size in register GITS_BASERn might be read-only
if an implementation only supports a single, fixed page size. But
currently the ITS driver will throw out an error when PAGE_SIZE
is less than the minimum size supported by an ITS. So addressing
this problem by using 64KB pages as default granule for all the
ITS base tables.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
[maz: fixed bug breaking non Device Table allocations]
Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69eeea3..0fe25a9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -800,14 +800,14 @@ static int its_alloc_tables(struct its_node *its)
 {
 	int err;
 	int i;
-	int psz = PAGE_SIZE;
+	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
 		u64 type = GITS_BASER_TYPE(val);
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
-		int order = 0;
+		int order = get_order(psz);
 		int alloc_size;
 		u64 tmp;
 		void *base;
-- 
2.1.4
