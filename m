From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 22 Jan 2013 07:52:01 +0200
Subject: [v3 1/2] ARM: Add API to detect SCU base address from CP15
Message-ID: <1358833924-24535-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add API to detect SCU base address from CP15.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
Update: Use Russell's suggestion,
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143321.html
---
 arch/arm/include/asm/smp_scu.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 4eb6d00..006f026 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -6,6 +6,23 @@
 #define SCU_PM_POWEROFF	3
 
 #ifndef __ASSEMBLER__
+
+#include <asm/cputype.h>
+
+static inline bool scu_a9_has_base(void)
+{
+	return read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9;
+}
+
+static inline unsigned long scu_a9_get_base(void)
+{
+	unsigned long pa;
+
+	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
+
+	return pa;
+}
+
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
-- 
1.7.9.5
