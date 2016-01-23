From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:19 +0800
Subject: [PATCH v3 04/12] acpi, numa: introduce ACPI_HAS_NUMA_ARCH_FIXUP
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-5-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

acpi_numa_arch_fixup() is only used for IA64, x86 introduce a dummy
function for it, when we came to a new architecture (such as ARM64),
we need to introduce another dummy one to make the code compile.

That's pretty boring so introduce ACPI_HAS_NUMA_ARCH_FIXUP and
select it for IA64, introduce a stub function for acpi_numa_arch_fixup()
then it's pretty clean for x86 and ARM64.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/ia64/Kconfig    | 1 +
 arch/x86/mm/srat.c   | 2 --
 drivers/acpi/Kconfig | 3 +++
 include/linux/acpi.h | 5 +++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index eb0249e..1285cef 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -17,6 +17,7 @@ config IA64
 	select ACPI if (!IA64_HP_SIM)
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT if ACPI
 	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
+	select ACPI_HAS_NUMA_ARCH_FIXUP if ACPI
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_IDE
 	select HAVE_OPROFILE
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index c2aea63..9fa1746 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -210,8 +210,6 @@ out_err:
 	return -1;
 }
 
-void __init acpi_numa_arch_fixup(void) {}
-
 int __init x86_acpi_numa_init(void)
 {
 	int ret;
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5eef4cb..d6d5749 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -57,6 +57,9 @@ config ACPI_SYSTEM_POWER_STATES_SUPPORT
 config ACPI_CCA_REQUIRED
 	bool
 
+config ACPI_HAS_NUMA_ARCH_FIXUP
+	bool
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface (EXPERIMENTAL)"
 	select ACPI_DEBUG
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1991aea..574d829 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -173,7 +173,12 @@ void acpi_numa_slit_init (struct acpi_table_slit *slit);
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
+
+#ifdef CONFIG_ACPI_HAS_NUMA_ARCH_FIXUP
 void acpi_numa_arch_fixup(void);
+#else
+static inline void acpi_numa_arch_fixup(void) { }
+#endif
 
 #ifndef PHYS_CPUID_INVALID
 typedef u32 phys_cpuid_t;
-- 
1.9.1
