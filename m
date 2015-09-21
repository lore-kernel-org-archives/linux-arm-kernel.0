From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:38 +0200
Subject: [PATCH v5 5/6] irqchip,
 gicv3-its: Workaround for Cavium ThunderX errata 22375, 24313
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-6-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This implements two gicv3-its errata workarounds for ThunderX. Both
with small impact affecting only ITS table allocation.

 erratum 22375: only alloc 8MB table size
 erratum 24313: ignore memory access type

The fixes are in ITS initialization and basically ignore memory access
type and table size provided by the TYPER and BASER registers.

v5:
 * fix table size wrongly allocating only 4MB
 * introduced CAVIUM_ERRATUM_22375 config option
 * added config description
 * introduced ITS_FLAGS_WORKAROUND_CAVIUM_22375

v3:
 * fix erratum to be dependend from iidr

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig               | 17 +++++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c | 37 +++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2e65757ae7be..08a948f15650 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -331,6 +331,23 @@ config ARM64_ERRATUM_845719
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_22375
+	bool "Cavium erratum 22375, 24313"
+	default y
+	help
+	  Enable workaround for erratum 22375, 24313.
+
+	  This implements two gicv3-its errata workarounds for ThunderX. Both
+	  with small impact affecting only ITS table allocation.
+
+	    erratum 22375: only alloc 8MB table size
+	    erratum 24313: ignore memory access type
+
+	  The fixes are in ITS initialization and basically ignore memory access
+	  type and table size provided by the TYPER and BASER registers.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_23154
 	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5c6023e80f6d..4e9ef1f80c63 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -39,7 +39,8 @@
 
 #include "irq-gic-common.h"
 
-#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1 << 0)
+#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -816,9 +817,22 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
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
+	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_22375) {
+		/*
+		 * erratum 22375: only alloc 8MB table size
+		 * erratum 24313: ignore memory access type
+		 */
+		cache	= 0;
+		ids	= 0x14;			/* 20 bits, 8MB */
+	} else {
+		cache	= GITS_BASER_WaWb;
+		typer	= readq_relaxed(its->base + GITS_TYPER);
+		ids	= GITS_TYPER_DEVBITS(typer);
+	}
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -1373,7 +1387,22 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+static void __maybe_unused its_enable_quirk_cavium_22375(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
+}
+
 static const struct gic_quirk its_quirks[] = {
+#ifdef CONFIG_CAVIUM_ERRATUM_22375
+	{
+		.desc	= "ITS: Cavium errata 22375, 24313",
+		.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
+		.mask	= 0xffff0fff,
+		.init	= its_enable_quirk_cavium_22375,
+	},
+#endif
 	{
 	}
 };
-- 
2.1.1
