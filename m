From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Wed, 15 Apr 2015 17:49:22 +0800
Subject: [PATCH] irqchip/gicv3-its: Decrease page size when needed
Message-ID: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The default page size of ITS table has been changed to 64KB,
but for some platforms the real size of allocate memory which
calculated by DEVBITS of register GITS_TYPER may smaller than
default size. In this case, psz must be decreased, otherwise,
the wrong page number will cause kernel hang.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 596b0a9..d0374a6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -844,6 +844,9 @@ static int its_alloc_tables(struct its_node *its)
 
 		its->tables[i] = base;
 
+		while (alloc_size < psz)
+			psz = psz >> 1;
+
 retry_baser:
 		val = (virt_to_phys(base) 				 |
 		       (type << GITS_BASER_TYPE_SHIFT)			 |
-- 
1.9.1
