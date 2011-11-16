From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Nov 2011 16:01:17 +0000
Subject: [PATCH] ARM: SCU: use cpu_logical_map for per-CPU low power mode
Message-ID: <1321459277-25604-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scu_power_mode changes the power mode for the current CPU, which it
determines from smp_processor_id(). However, this assumes that the
physical CPU number is equal to Linux's logical CPU number and if this
is not true, we will power off the wrong CPU.

This patch uses cpu_logical_map to translate the logical CPU number
into a physical one in scu_power_mode.

Reported-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp_scu.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 8f5dd79..5582a3a 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -21,6 +21,20 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
+static int __scu_power_mode(void __iomem *scu_base, unsigned int mode, int cpu)
+{
+	unsigned int val;
+
+	if (mode > 3 || mode == 1 || cpu > 3)
+		return -EINVAL;
+
+	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
+	val |= mode;
+	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 /*
  * Get the number of CPU cores from the SCU configuration
@@ -61,7 +75,6 @@ void scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
-#endif
 
 /*
  * Set the executing CPUs power mode as defined.  This will be in
@@ -73,15 +86,12 @@ void scu_enable(void __iomem *scu_base)
  */
 int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 {
-	unsigned int val;
-	int cpu = smp_processor_id();
-
-	if (mode > 3 || mode == 1 || cpu > 3)
-		return -EINVAL;
-
-	val = __raw_readb(scu_base + SCU_CPU_STATUS + cpu) & ~0x03;
-	val |= mode;
-	__raw_writeb(val, scu_base + SCU_CPU_STATUS + cpu);
-
-	return 0;
+	int cpu = cpu_logical_map(smp_processor_id());
+	return __scu_power_mode(scu_base, mode, cpu);
 }
+#else	/* CONFIG_SMP */
+int scu_power_mode(void __iomem *scu_base, unsigned int mode)
+{
+	return __scu_power_mode(scu_base, mode, 0);
+}
+#endif
-- 
1.7.4.1
