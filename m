From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Thu, 16 Apr 2015 13:30:59 +0800
Subject: [PATCH v2] irqchip/gicv3-its: ITS table size should not be smaller
 than PSZ
Message-ID: <1429162259-11344-1-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default page size of ITS table has been changed to 64KB,
but for some platforms the real size of allocated memory which
calculated by DEVBITS of register GITS_TYPER may be smaller than
default size. In this case, the allocation size must be increased
to the default size, otherwise, the wrong page number will cause
kernel hang.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
v2-v1:
Increase allocation size instead of decreasing PSZ

 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9687f8a..19ab86d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -828,7 +828,8 @@ static int its_alloc_tables(struct its_node *its)
 			u64 typer = readq_relaxed(its->base + GITS_TYPER);
 			u32 ids = GITS_TYPER_DEVBITS(typer);
 
-			order = get_order((1UL << ids) * entry_size);
+			order = max(get_order((1UL << ids) * entry_size),
+				    order);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
 				pr_warn("%s: Device Table too large, reduce its page order to %u\n",
-- 
1.9.1
