From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 21 Jan 2013 09:42:55 +0200
Subject: [v2 1/1] ARM: Add API to detect SCU base address from CP15
In-Reply-To: <50F97E19.8070607@wwwdotorg.org>
References: <50F97E19.8070607@wwwdotorg.org>
Message-ID: <1358754175-15484-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add API to detect SCU base address from CP15.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
For usage: http://patchwork.ozlabs.org/patch/212013/
---
 arch/arm/include/asm/smp_scu.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 4eb6d00..1733ec7 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -6,6 +6,18 @@
 #define SCU_PM_POWEROFF	3
 
 #ifndef __ASSEMBLER__
+
+#include <asm/cputype.h>
+
+static inline phys_addr_t scu_get_base(void)
+{
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9) {
+		phys_addr_t pa;
+		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
+		return pa;
+	}
+	return 0;
+}
 unsigned int scu_get_core_count(void __iomem *);
 void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
-- 
1.7.9.5
