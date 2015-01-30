From: wuyun.wu@huawei.com (Yun Wu)
Date: Fri, 30 Jan 2015 15:46:47 +0800
Subject: [PATCH 3/5] irqchip: gicv3-its: use 64KB page as default granule
In-Reply-To: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
References: <1422604009-9248-1-git-send-email-wuyun.wu@huawei.com>
Message-ID: <1422604009-9248-4-git-send-email-wuyun.wu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The field of page size in register GITS_BASERn might be read-only
if an implementation only supports a single, fixed page size. But
currently the ITS driver will throw out an error when PAGE_SIZE
is less than the minimum size supported by an ITS. So addressing
this problem by using 64KB pages as default granule for all the
ITS base tables.

Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2a08d85..430bc92 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -801,7 +801,7 @@ static int its_alloc_tables(struct its_node *its)
 	int err;
 	int i;
 	int size;
-	int psz = PAGE_SIZE;
+	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;

 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
--
1.8.0
