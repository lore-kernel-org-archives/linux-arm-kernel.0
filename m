From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 11:38:19 +0100
Subject: [PATCHv2 08/12] arm64: psci: remove ACPI coupling
In-Reply-To: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1431945503-6939-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit ARM port doesn't have ACPI headers, and conditionally
including them is going to look horrendous. In preparation for sharing
the PSCI invocation code with 32-bit, move the acpi_psci_* function
declarations and definitions such that the PSCI client code need not
include ACPI headers.

While it would seem like we could simply hide the ACPI includes in
psci.h, the ACPI headers have hilarious circular dependencies which make
this infeasible without reorganising most of ACPICA. So rather than
doing that, move the acpi_psci_* prototypes into psci.h.

The psci_acpi_init function is made dependent on CONFIG_ACPI (with a
stub implementation in asm/psci.h) such that it need not be built for
32-bit ARM or kernels without ACPI support. The currently missing __init
annotations are added to the prototypes in the header.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Al Stone <al.stone@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/acpi.h | 14 --------------
 arch/arm64/include/asm/psci.h | 11 +++++++++--
 arch/arm64/kernel/acpi.c      | 11 +++++++++++
 arch/arm64/kernel/psci.c      |  4 ++--
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59c05d8..b0fecad 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -39,18 +39,6 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
-/* 1 to indicate PSCI 0.2+ is implemented */
-static inline bool acpi_psci_present(void)
-{
-	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
-}
-
-/* 1 to indicate HVC must be used instead of SMC as the PSCI conduit */
-static inline bool acpi_psci_use_hvc(void)
-{
-	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
-}
-
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
@@ -88,8 +76,6 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
 
 #else
-static inline bool acpi_psci_present(void) { return false; }
-static inline bool acpi_psci_use_hvc(void) { return false; }
 static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
 
diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index 2454bc5..b5d4c1d 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,7 +14,14 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
-int psci_dt_init(void);
-int psci_acpi_init(void);
+int __init psci_dt_init(void);
+
+#ifdef CONFIG_ACPI
+int __init psci_acpi_init(void);
+bool __init acpi_psci_present(void);
+bool __init acpi_psci_use_hvc(void);
+#else
+static inline int psci_acpi_init(void) { return 0; }
+#endif
 
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 8b83955..fe56771b 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -95,6 +95,17 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
+bool __init acpi_psci_present(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT;
+}
+
+/* Whether HVC must be used instead of SMC as the PSCI conduit */
+bool __init acpi_psci_use_hvc(void)
+{
+	return acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC;
+}
+
 /**
  * acpi_map_gic_cpu_interface - generates a logical cpu number
  * and map to MPIDR represented by GICC structure
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4ef9472..47fa474 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,7 +15,6 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
-#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
@@ -25,7 +24,6 @@
 #include <linux/slab.h>
 #include <uapi/linux/psci.h>
 
-#include <asm/acpi.h>
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
@@ -436,6 +434,7 @@ int __init psci_dt_init(void)
 	return init_fn(np);
 }
 
+#ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
  * explicitly clarified in SBBR
@@ -456,6 +455,7 @@ int __init psci_acpi_init(void)
 
 	return psci_probe();
 }
+#endif
 
 #ifdef CONFIG_SMP
 
-- 
1.9.1
