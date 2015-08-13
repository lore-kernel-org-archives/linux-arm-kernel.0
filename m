From: rric@kernel.org (Robert Richter)
Date: Thu, 13 Aug 2015 16:47:57 +0200
Subject: [PATCH v2 5/5] irqchip,
 gicv3-its: Workaround for Cavium ThunderX errata 22375, 24313
In-Reply-To: <1439477277-6157-1-git-send-email-rric@kernel.org>
References: <1439477277-6157-1-git-send-email-rric@kernel.org>
Message-ID: <1439477277-6157-6-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This implements two gicv3-its errata workarounds for ThunderX. Both
with small impact affecting only ITS table allocation.

 erratum 22375: only alloc 8MB table size
 erratum 24313: ignore memory access type

The fixes are in ITS initialization and basically ignore memory access
type and table size provided by the TYPER and BASER registers.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index bf0659821683..d629e0e03322 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -39,7 +39,8 @@
 #include "irq-gic-common.h"
 #include "irqchip.h"
 
-#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1 << 0)
+#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
+#define ITS_FLAGS_CAVIUM_THUNDERX		(1ULL << 1)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -803,9 +804,22 @@ static int its_alloc_tables(struct its_node *its)
 	int i;
 	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;
-	u64 cache = GITS_BASER_WaWb;
-	u64 typer = readq_relaxed(its->base + GITS_TYPER);
-	u32 ids = GITS_TYPER_DEVBITS(typer);
+	u64 cache;
+	u64 typer;
+	u32 ids;
+
+	if (its->flags & ITS_FLAGS_CAVIUM_THUNDERX) {
+		/*
+		 * erratum 22375: only alloc 8MB table size
+		 * erratum 24313: ignore memory access type
+		 */
+		cache	= 0;
+		ids	= 0x13;			/* 20 bits, 8MB */
+	} else {
+		cache	= GITS_BASER_WaWb;
+		typer	= readq_relaxed(its->base + GITS_TYPER);
+		ids	= GITS_TYPER_DEVBITS(typer);
+	}
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -1391,8 +1405,25 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+static void its_enable_cavium_thunderx(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_CAVIUM_THUNDERX;
+}
+
 static const struct gic_capabilities its_errata[] = {
 	{
+		/*
+		 * Need to be applied in guests too, thus use midr as
+		 * iidr is emulated with different vendor id.
+		 */
+		.desc		= "ITS: Cavium errata 22375, 24313",
+		.midr		= 0x43000a10,	/* ThunderX pass 1.x */
+		.midr_mask	= 0xfff0fff0,
+		.init		= its_enable_cavium_thunderx,
+	},
+	{
 	}
 };
 
-- 
2.1.1
