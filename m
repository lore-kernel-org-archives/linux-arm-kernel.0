From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:35 +0200
Subject: [PATCH v5 2/6] irqchip,
 gicv3: Workaround for Cavium ThunderX erratum 23154
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-3-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch implements Cavium ThunderX erratum 23154.

The gicv3 of ThunderX requires a modified version for reading the IAR
status to ensure data synchronization. Since this is in the fast-path
and called with each interrupt, runtime patching is used using jump
label patching for smallest overhead (no-op). This is the same
technique as used for tracepoints.

v5:
 * fixed calling gic_read_iar_cavium_thunderx() if jump label is
   enabled
 * made is_cavium_thunderx static
 * removed ARCH_THUNDER dependency for Cavium errata options to
   make it available for generic kernels

v4:
 * simplify code to only use cpus_have_cap() in gicv3_enable_quirks()

v3:
 * fix erratum to be dependend from midr
 * use arm64 errata framework

v2:
 * implement code in a single asm() to keep instruction sequence
 * added comment to the code that explains the erratum
 * apply workaround also if running as guest, thus check MIDR

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/Kconfig                  | 10 +++++++++
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/include/asm/cputype.h    | 17 ++++++++-------
 arch/arm64/kernel/cpu_errata.c      |  9 ++++++++
 drivers/irqchip/irq-gic-v3.c        | 42 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663c0160..2e65757ae7be 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -331,6 +331,16 @@ config ARM64_ERRATUM_845719
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_23154
+	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
+	default y
+	help
+	  The gicv3 of ThunderX requires a modified version for
+	  reading the IAR status to ensure data synchronization
+	  (access to icc_iar1_el1 is not sync'ed before and after).
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 171570702bb8..dbc78d2b8cc6 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -27,8 +27,9 @@
 #define ARM64_HAS_SYSREG_GIC_CPUIF		3
 #define ARM64_HAS_PAN				4
 #define ARM64_HAS_LSE_ATOMICS			5
+#define ARM64_WORKAROUND_CAVIUM_23154		6
 
-#define ARM64_NCAPS				6
+#define ARM64_NCAPS				7
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index ee6403df9fe4..100a3d1b17c8 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -62,15 +62,18 @@
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
-#define ARM_CPU_IMP_ARM		0x41
-#define ARM_CPU_IMP_APM		0x50
+#define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_APM			0x50
+#define ARM_CPU_IMP_CAVIUM		0x43
 
-#define ARM_CPU_PART_AEM_V8	0xD0F
-#define ARM_CPU_PART_FOUNDATION	0xD00
-#define ARM_CPU_PART_CORTEX_A57	0xD07
-#define ARM_CPU_PART_CORTEX_A53	0xD03
+#define ARM_CPU_PART_AEM_V8		0xD0F
+#define ARM_CPU_PART_FOUNDATION		0xD00
+#define ARM_CPU_PART_CORTEX_A57		0xD07
+#define ARM_CPU_PART_CORTEX_A53		0xD03
 
-#define APM_CPU_PART_POTENZA	0x000
+#define APM_CPU_PART_POTENZA		0x000
+
+#define CAVIUM_CPU_PART_THUNDERX	0x0A1
 
 #define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
 #define ID_AA64MMFR0_BIGENDEL0_MASK	(0xf << ID_AA64MMFR0_BIGENDEL0_SHIFT)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 6ffd91438560..574450c257a4 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -23,6 +23,7 @@
 
 #define MIDR_CORTEX_A53 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_THUNDERX	MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 
 #define CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			MIDR_ARCHITECTURE_MASK)
@@ -82,6 +83,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_RANGE(MIDR_CORTEX_A53, 0x00, 0x04),
 	},
 #endif
+#ifdef CONFIG_CAVIUM_ERRATUM_23154
+	{
+	/* Cavium ThunderX, pass 1.x */
+		.desc = "Cavium erratum 23154",
+		.capability = ARM64_WORKAROUND_CAVIUM_23154,
+		MIDR_RANGE(MIDR_THUNDERX, 0x00, 0x01),
+	},
+#endif
 	{
 	}
 };
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 7deed6ef54c2..5899e471df4c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -114,7 +114,7 @@ static void gic_redist_wait_for_rwp(void)
 }
 
 /* Low level accessors */
-static u64 __maybe_unused gic_read_iar(void)
+static u64 gic_read_iar_common(void)
 {
 	u64 irqstat;
 
@@ -122,6 +122,38 @@ static u64 __maybe_unused gic_read_iar(void)
 	return irqstat;
 }
 
+/*
+ * Cavium ThunderX erratum 23154
+ *
+ * The gicv3 of ThunderX requires a modified version for reading the
+ * IAR status to ensure data synchronization (access to icc_iar1_el1
+ * is not sync'ed before and after).
+ */
+static u64 gic_read_iar_cavium_thunderx(void)
+{
+	u64 irqstat;
+
+	asm volatile(
+		"nop;nop;nop;nop\n\t"
+		"nop;nop;nop;nop\n\t"
+		"mrs_s %0, " __stringify(ICC_IAR1_EL1) "\n\t"
+		"nop;nop;nop;nop"
+		: "=r" (irqstat));
+	mb();
+
+	return irqstat;
+}
+
+static struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;
+
+static u64 __maybe_unused gic_read_iar(void)
+{
+	if (static_key_false(&is_cavium_thunderx))
+		return gic_read_iar_cavium_thunderx();
+	else
+		return gic_read_iar_common();
+}
+
 static void __maybe_unused gic_write_pmr(u64 val)
 {
 	asm volatile("msr_s " __stringify(ICC_PMR_EL1) ", %0" : : "r" (val));
@@ -839,6 +871,12 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.free = gic_irq_domain_free,
 };
 
+static void gicv3_enable_quirks(void)
+{
+	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
+		static_key_slow_inc(&is_cavium_thunderx);
+}
+
 static int __init gic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *dist_base;
@@ -904,6 +942,8 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_data.nr_redist_regions = nr_redist_regions;
 	gic_data.redist_stride = redist_stride;
 
+	gicv3_enable_quirks();
+
 	/*
 	 * Find out how many interrupts are supported.
 	 * The GIC only supports up to 1020 interrupt sources (SGI+PPI+SPI)
-- 
2.1.1
