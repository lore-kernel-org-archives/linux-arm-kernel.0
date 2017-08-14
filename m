From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 14 Aug 2017 23:58:57 +0200
Subject: [PATCH v6 3/6] ARM: smp_scu: allow the platform code to read the SCU
 CPU status
In-Reply-To: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
References: <20170814215900.1032-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170814215900.1032-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Amlogic Meson8 / Meson8m2 (both Cortex-A9) and Meson8b (Cortex-A5)
the CPU hotplug code needs to wait until the SCU status of the CPU that
is being taken offline is SCU_PM_POWEROFF.
Provide a utility function (which can be invoked for example from
.cpu_kill()) which allows reading the SCU status of a CPU.

While here, replace the magic number 0x3 with a preprocessor macro
(SCU_CPU_STATUS_MASK) so we don't have to duplicate this magic number in
the new function.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/include/asm/smp_scu.h |  6 ++++++
 arch/arm/kernel/smp_scu.c      | 18 +++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 11e636f33ed9..992b34c4267f 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -27,6 +27,7 @@ static inline unsigned long scu_a9_get_base(void)
 unsigned int scu_get_core_count(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
 int scu_cpu_power_enable(void __iomem *, unsigned int);
+int scu_get_cpu_power_mode(void __iomem *scu_base, unsigned int logical_cpu);
 #else
 static inline unsigned int scu_get_core_count(void __iomem *scu_base)
 {
@@ -41,6 +42,11 @@ static inline int scu_cpu_power_enable(void __iomem *scu_base,
 {
 	return -EINVAL;
 }
+static inline int scu_get_cpu_power_mode(void __iomem *scu_base,
+					 unsigned int logical_cpu)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 1d549c16b5fc..c6b33074c393 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -21,6 +21,7 @@
 #define SCU_STANDBY_ENABLE	(1 << 5)
 #define SCU_CONFIG		0x04
 #define SCU_CPU_STATUS		0x08
+#define SCU_CPU_STATUS_MASK	GENMASK(1, 0)
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
@@ -82,7 +83,8 @@ static int scu_set_power_mode_internal(void __iomem *scu_base,
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
 
-	val = readb_relaxed(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val = readb_relaxed(scu_base + SCU_CPU_STATUS + cpu);
+	val &= ~SCU_CPU_STATUS_MASK;
 	val |= mode;
 	writeb_relaxed(val, scu_base + SCU_CPU_STATUS + cpu);
 
@@ -109,3 +111,17 @@ int scu_cpu_power_enable(void __iomem *scu_base, unsigned int cpu)
 {
 	return scu_set_power_mode_internal(scu_base, cpu, SCU_PM_NORMAL);
 }
+
+int scu_get_cpu_power_mode(void __iomem *scu_base, unsigned int logical_cpu)
+{
+	unsigned int val;
+	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(logical_cpu), 0);
+
+	if (cpu > 3)
+		return -EINVAL;
+
+	val = readb_relaxed(scu_base + SCU_CPU_STATUS + cpu);
+	val &= SCU_CPU_STATUS_MASK;
+
+	return val;
+}
-- 
2.14.1
