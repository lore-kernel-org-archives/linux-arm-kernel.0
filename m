From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Thu, 18 Jan 2018 10:58:20 +0530
Subject: [PATCH v2] irqchip/gic-v3-its: Add workaround for ThunderX2 erratum
 #174
Message-ID: <20180118052820.30286-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This erratum is observed on the ThunderX2 GICv3 ITS. When a
MOVI command is used to change affinity of a LPI to a collection/cpu
on another node, the LPI is not delivered to the cpu.
An additional INV command is required after the MOVI to deliver
the LPI to the new destination.

If we add INV after MOVI, there is a chance that we lose LPIs which
are raised when the affinity is changed. So for now, adding workaround fix
to disable inter node affinity change.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---

v2: Added workaround to avoid inter node affinity change.

v1: Initial patch

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 10 ++++++++++
 drivers/irqchip/irq-gic-v3-its.c       | 21 ++++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index fc1c884..fb27cb5 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -63,6 +63,7 @@ stable kernels.
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
 | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
 | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
+| Cavium         | ThunderX2 ITS   | #174            | CAVIUM_ERRATUM_174          |
 | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
 | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
 |                |                 |                 |                             |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e..0dbf3bd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -461,6 +461,16 @@ config ARM64_ERRATUM_843419
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_174
+	bool "Cavium ThunderX2 erratum 174"
+	default y
+	help
+	  Cavium ThunderX2 dual socket systems may loose interrupts
+	  on affinity change to a cpu on other node.
+	  This workaround fix avoids inter node affinity change.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 06f025f..b0cb528 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_174		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -1102,7 +1103,8 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 		return -EINVAL;
 
        /* lpi cannot be routed to a redistributor that is on a foreign node */
-	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144 ||
+			its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_174) {
 		if (its_dev->its->numa_node >= 0) {
 			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 			if (!cpumask_intersects(mask_val, cpu_mask))
@@ -2904,6 +2906,15 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
+static bool __maybe_unused its_enable_quirk_cavium_174(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_174;
+
+	return true;
+}
+
 static bool __maybe_unused its_enable_quirk_cavium_22375(void *data)
 {
 	struct its_node *its = data;
@@ -3031,6 +3042,14 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_hip07_161600802,
 	},
 #endif
+#ifdef CONFIG_CAVIUM_ERRATUM_174
+	{
+		.desc	= "ITS: Cavium ThunderX2 erratum 174",
+		.iidr	= 0x13f,	/* ThunderX2 pass A1/A2/B0 */
+		.mask	= 0xffffffff,
+		.init	= its_enable_quirk_cavium_174,
+	},
+#endif
 	{
 	}
 };
-- 
2.9.4
