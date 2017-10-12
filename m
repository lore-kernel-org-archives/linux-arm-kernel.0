From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Oct 2017 19:32:46 +0100
Subject: [PATCH v3 1/2] drivers/irqchip: gicv3: probe device ID space before
 quirks handling
In-Reply-To: <20171012183247.23679-1-ard.biesheuvel@linaro.org>
References: <20171012183247.23679-1-ard.biesheuvel@linaro.org>
Message-ID: <20171012183247.23679-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before adding another SoC whose device ID space deviates from the
value presented in the GIC ID registers, let's slightly refactor
the code so that the ID registers are probed before that quirks
handling executes. This allows us to move the device ID override
into the quirk handler itself.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d89343d613..891de07fd4cc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1650,23 +1650,14 @@ static void its_free_tables(struct its_node *its)
 
 static int its_alloc_tables(struct its_node *its)
 {
-	u64 typer = gic_read_typer(its->base + GITS_TYPER);
-	u32 ids = GITS_TYPER_DEVBITS(typer);
 	u64 shr = GITS_BASER_InnerShareable;
 	u64 cache = GITS_BASER_RaWaWb;
 	u32 psz = SZ_64K;
 	int err, i;
 
-	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375) {
-		/*
-		* erratum 22375: only alloc 8MB table size
-		* erratum 24313: ignore memory access type
-		*/
-		cache   = GITS_BASER_nCnB;
-		ids     = 0x14;                 /* 20 bits, 8MB */
-	}
-
-	its->device_ids = ids;
+	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375)
+		/* erratum 24313: ignore memory access type */
+		cache = GITS_BASER_nCnB;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		struct its_baser *baser = its->tables + i;
@@ -2741,6 +2732,8 @@ static void __maybe_unused its_enable_quirk_cavium_22375(void *data)
 {
 	struct its_node *its = data;
 
+	/* erratum 22375: only alloc 8MB table size */
+	its->device_ids = 0x14;		/* 20 bits, 8MB */
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
 }
 
@@ -2942,6 +2935,7 @@ static int __init its_probe_one(struct resource *res,
 	its->base = its_base;
 	its->phys_base = res->start;
 	its->ite_size = GITS_TYPER_ITT_ENTRY_SIZE(typer);
+	its->device_ids = GITS_TYPER_DEVBITS(typer);
 	its->is_v4 = !!(typer & GITS_TYPER_VLPIS);
 	if (its->is_v4) {
 		if (!(typer & GITS_TYPER_VMOVP)) {
-- 
2.11.0
