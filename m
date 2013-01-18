From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 18 Jan 2013 11:54:40 +0100
Subject: [RESEND][v3 4/9] ARM: Add API to detect SCU base address from CP15
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130118.125440.65456178743324707.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add API to detect SCU base address from CP15.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
NOTE:
This wasn't delivered to linux-arm-kernel at lists.infradead.org, resending....

For usage: http://patchwork.ozlabs.org/patch/212013/
---
 arch/arm/include/asm/smp_scu.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 4eb6d00..f619eef 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -6,6 +6,23 @@
 #define SCU_PM_POWEROFF	3
 
 #ifndef __ASSEMBLER__
+
+#include <asm/cputype.h>
+
+static inline phys_addr_t scu_get_base(void)
+{
+	phys_addr_t pa;
+	unsigned long part_number = read_cpuid_part_number();
+
+	switch (part_number) {
+	case ARM_CPU_PART_CORTEX_A9:
+		/* Get SCU physical base */
+		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
+		return pa;
+	default:
+		return 0;
+	}
+}
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
-- 
1.7.9.5
