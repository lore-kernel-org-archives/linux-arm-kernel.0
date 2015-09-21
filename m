From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:36 +0200
Subject: [PATCH v5 3/6] irqchip,
 gicv3-its: Read typer register outside the loop
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

No need to read the typer register in the loop. Values do not change.

This patch is basically a prerequisite for a follow-on patch that adds
errata code for Cavium ThunderX. It moves the calculation of the
number of id entries to the beginning of the function close to other
setup values that are needed to allocate the its table. Now we have a
central location to modify the setup parameters and the errata code
can be implemented in a single block.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0636cb33aeea..b073f28ea00d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -815,6 +815,8 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;
 	u64 cache = GITS_BASER_WaWb;
+	u64 typer = readq_relaxed(its->base + GITS_TYPER);
+	u32 ids = GITS_TYPER_DEVBITS(typer);
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -838,9 +840,6 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		 * For other tables, only allocate a single page.
 		 */
 		if (type == GITS_BASER_TYPE_DEVICE) {
-			u64 typer = readq_relaxed(its->base + GITS_TYPER);
-			u32 ids = GITS_TYPER_DEVBITS(typer);
-
 			/*
 			 * 'order' was initialized earlier to the default page
 			 * granule of the the ITS.  We can't have an allocation
-- 
2.1.1
