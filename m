From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Thu, 14 May 2015 18:02:25 -0500
Subject: [PATCH] irqchip: GICv3: ITS: don't assume 64K page size in
 its_alloc_tables
Message-ID: <1431644545-31904-1-git-send-email-stuart.yoder@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

its_alloc_tables() needs to account for page sizes other than
64KB.  Without this change, when PAGE_SIZE=4KB its_alloc_tables()
gets stuck in an infinite loop.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---

think this should go into 4.1 if at all possible...without it I am
unable to boot a 4.1 kernel on the LS2085 SoC

 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9687f8a..58a6612 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -800,7 +800,7 @@ static int its_alloc_tables(struct its_node *its)
 {
 	int err;
 	int i;
-	int psz = SZ_64K;
+	int psz = PAGE_SIZE;
 	u64 shr = GITS_BASER_InnerShareable;
 	u64 cache = GITS_BASER_WaWb;
 
-- 
2.3.3
