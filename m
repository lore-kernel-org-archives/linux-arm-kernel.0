From: rric@kernel.org (Robert Richter)
Date: Fri, 14 Aug 2015 20:28:03 +0200
Subject: [PATCH v4 3/5] irqchip,
 gicv3-its: Read typer register outside the loop
In-Reply-To: <1439576885-15621-1-git-send-email-rric@kernel.org>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
Message-ID: <1439576885-15621-4-git-send-email-rric@kernel.org>
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
index 466edf8a7477..06131db7a198 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -803,6 +803,8 @@ static int its_alloc_tables(struct its_node *its)
 	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;
 	u64 cache = GITS_BASER_WaWb;
+	u64 typer = readq_relaxed(its->base + GITS_TYPER);
+	u32 ids = GITS_TYPER_DEVBITS(typer);
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -826,9 +828,6 @@ static int its_alloc_tables(struct its_node *its)
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
