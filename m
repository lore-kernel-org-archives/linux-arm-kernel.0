From: rric@kernel.org (Robert Richter)
Date: Sun,  3 May 2015 22:49:31 +0200
Subject: [PATCH 3/4] arm64: gicv3: its: Read typer register outside the loop
In-Reply-To: <1430686172-18222-1-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
Message-ID: <1430686172-18222-4-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

No need to read the typer register in the loop. Values do not change.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a2619a1d5bb3..916c4724c771 100644
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
 			order = get_order((1UL << ids) * entry_size);
 			if (order >= MAX_ORDER) {
 				order = MAX_ORDER - 1;
-- 
2.1.1
