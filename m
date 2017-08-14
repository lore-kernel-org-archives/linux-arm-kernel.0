From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 14 Aug 2017 23:58:56 +0200
Subject: [PATCH v6 2/6] ARM: smp_scu: add a helper for powering on a specific
 CPU
In-Reply-To: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
References: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170814215900.1032-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To boot the secondary CPUs on the Amlogic Meson8/Meson8m2 (Cortex-A9)
and Meson8b (Cortex-A5) SoCs we have to enable SCU mode SCU_PM_NORMAL,
otherwise the secondary cores will not start.
This patch adds a scu_cpu_power_enable() function which can be used to
enable SCU_PM_NORMAL for a specific (logical) CPU. An internal helper
function is also created, to avoid code duplication with
scu_power_mode().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/include/asm/smp_scu.h |  6 ++++++
 arch/arm/kernel/smp_scu.c      | 35 +++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index bfe163c40024..11e636f33ed9 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -26,6 +26,7 @@ static inline unsigned long scu_a9_get_base(void)
 #ifdef CONFIG_HAVE_ARM_SCU
 unsigned int scu_get_core_count(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
+int scu_cpu_power_enable(void __iomem *, unsigned int);
 #else
 static inline unsigned int scu_get_core_count(void __iomem *scu_base)
 {
@@ -35,6 +36,11 @@ static inline int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 {
 	return -EINVAL;
 }
+static inline int scu_cpu_power_enable(void __iomem *scu_base,
+				       unsigned int mode)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 72f9241ad5db..1d549c16b5fc 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -72,18 +72,12 @@ void scu_enable(void __iomem *scu_base)
 }
 #endif
 
-/*
- * Set the executing CPUs power mode as defined.  This will be in
- * preparation for it executing a WFI instruction.
- *
- * This function must be called with preemption disabled, and as it
- * has the side effect of disabling coherency, caches must have been
- * flushed.  Interrupts must also have been disabled.
- */
-int scu_power_mode(void __iomem *scu_base, unsigned int mode)
+static int scu_set_power_mode_internal(void __iomem *scu_base,
+				       unsigned int logical_cpu,
+				       unsigned int mode)
 {
 	unsigned int val;
-	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
+	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(logical_cpu), 0);
 
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
@@ -94,3 +88,24 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 
 	return 0;
 }
+
+/*
+ * Set the executing CPUs power mode as defined.  This will be in
+ * preparation for it executing a WFI instruction.
+ *
+ * This function must be called with preemption disabled, and as it
+ * has the side effect of disabling coherency, caches must have been
+ * flushed.  Interrupts must also have been disabled.
+ */
+int scu_power_mode(void __iomem *scu_base, unsigned int mode)
+{
+	return scu_set_power_mode_internal(scu_base, smp_processor_id(), mode);
+}
+
+/*
+ * Set the given (logical) CPU's power mode to SCU_PM_NORMAL.
+ */
+int scu_cpu_power_enable(void __iomem *scu_base, unsigned int cpu)
+{
+	return scu_set_power_mode_internal(scu_base, cpu, SCU_PM_NORMAL);
+}
-- 
2.14.1
