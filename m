From: rric@kernel.org (Robert Richter)
Date: Tue, 30 Jun 2015 16:14:03 +0200
Subject: [PATCH 4/4] irqchip, gicv3-its: Implement Cavium ThunderX errata 22375,
 24313
In-Reply-To: <1435673643-31676-1-git-send-email-rric@kernel.org>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
Message-ID: <1435673643-31676-5-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This implements two gicv3-its errata for ThunderX. Both with small
impact affecting only ITS table allocation.

 erratum 22375: only alloc 8MB table size
 erratum 24313: ignore memory access type

The fixes are in ITS initialization and basically ignore memory access
type and table size provided by the TYPER and BASER registers.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index de2fc82bba83..049ef761fbc3 100644
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
@@ -1382,8 +1396,21 @@ static int its_force_quiescent(void __iomem *base)
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
+		.desc	= "ITS: Cavium errata 22375, 24313",
+		.id	= 0xa100034c,	/* ThunderX pass 1.x */
+		.mask	= 0xffff0fff,
+		.init	= its_enable_cavium_thunderx,
+	},
+	{
 	}
 };
 
-- 
2.1.1
