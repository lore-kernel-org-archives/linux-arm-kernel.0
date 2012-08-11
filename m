From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 11 Aug 2012 12:04:35 +0100
Subject: [PATCH 5/7] ARM: virt: Add boot-time diagnostics
In-Reply-To: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
References: <1344683077-12841-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1344683077-12841-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

In order to easily detect pathological cases, print some diagnostics
when the kernel boots.

This also provides helpers to detect that HYP mode is actually available,
which can be used by other subsystems to enable HYP specific features.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/virt.h |   17 +++++++++++++++++
 arch/arm/kernel/setup.c     |   20 ++++++++++++++++++++
 arch/arm/kernel/smp.c       |    3 +++
 3 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 0a99723..86164df 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -47,6 +47,23 @@ unsigned long __hyp_get_vectors(void);
 #define __boot_cpu_mode	(SVC_MODE)
 #endif
 
+#ifndef ZIMAGE
+void hyp_mode_check(void);
+
+/* Reports the availability of HYP mode */
+static inline bool is_hyp_mode_available(void)
+{
+	return ((__boot_cpu_mode & MODE_MASK) == HYP_MODE &&
+		!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH));
+}
+
+/* Check if the bootloader has booted CPUs in different modes */
+static inline bool is_hyp_mode_mismatched(void)
+{
+	return !!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH);
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index a81dcec..04fd01f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -55,6 +55,7 @@
 #include <asm/traps.h>
 #include <asm/unwind.h>
 #include <asm/memblock.h>
+#include <asm/virt.h>
 
 #if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 #include "compat.h"
@@ -937,6 +938,21 @@ static int __init meminfo_cmp(const void *_a, const void *_b)
 	return cmp < 0 ? -1 : cmp > 0 ? 1 : 0;
 }
 
+void __init hyp_mode_check(void)
+{
+#ifdef CONFIG_ARM_VIRT_EXT
+	if (is_hyp_mode_available()) {
+		pr_info("CPU: All CPU(s) started in HYP mode.\n");
+		pr_info("CPU: Virtualization extensions available.\n");
+	} else if (is_hyp_mode_mismatched()) {
+		pr_warn("CPU: WARNING: CPU(s) started in wrong/inconsistent modes (primary CPU mode 0x%x)\n",
+			__boot_cpu_mode & MODE_MASK);
+		pr_warn("CPU: This may indicate a broken bootloader or firmware.\n");
+	} else
+		pr_info("CPU: All CPU(s) started in SVC mode.\n");
+#endif
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct machine_desc *mdesc;
@@ -980,6 +996,10 @@ void __init setup_arch(char **cmdline_p)
 	if (is_smp())
 		smp_init_cpus();
 #endif
+
+	if (!is_smp())
+		hyp_mode_check();
+
 	reserve_crashkernel();
 
 	tcm_init();
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebd8ad2..adf226e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -42,6 +42,7 @@
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
 #include <asm/smp_plat.h>
+#include <asm/virt.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -287,6 +288,8 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	       num_online_cpus(),
 	       bogosum / (500000/HZ),
 	       (bogosum / (5000/HZ)) % 100);
+
+	hyp_mode_check();
 }
 
 void __init smp_prepare_boot_cpu(void)
-- 
1.7.8.6
