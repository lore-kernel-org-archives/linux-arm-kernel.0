From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon,  2 Feb 2015 20:45:41 +0800
Subject: [PATCH v8 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1422881149-8177-14-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MADT contains the information for MPIDR which is essential for
SMP initialization, parse the GIC cpu interface structures to
get the MPIDR value and map it to cpu_logical_map(), and add
enabled cpu with valid MPIDR into cpu_possible_map.

ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
Parking protocol, but the Parking protocol is only specified for
ARMv7 now, so make PSCI as the only way for the SMP boot protocol
before some updates for the ACPI spec or the Parking protocol spec.

Parking protocol patches for SMP boot will be sent to upstream when
the new version of Parking protocol is ready.

CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Mark Rutland <mark.rutland@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/arm64/include/asm/acpi.h    |   2 +
 arch/arm64/include/asm/cpu_ops.h |   1 +
 arch/arm64/include/asm/smp.h     |   5 +-
 arch/arm64/kernel/acpi.c         | 150 ++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpu_ops.c      |   2 +-
 arch/arm64/kernel/setup.c        |   7 +-
 arch/arm64/kernel/smp.c          |   2 +-
 7 files changed, 161 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 1aea87c..8984aa5 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -58,12 +58,14 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+void __init acpi_init_cpus(void);
 
 #else
 static inline void disable_acpi(void) { }
 static inline void enable_acpi(void) { }
 static inline bool acpi_psci_present(void) { return false; }
 static inline bool acpi_psci_use_hvc(void) { return false; }
+static inline void acpi_init_cpus(void) { }
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 6f8e2ef..5615970 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -66,5 +66,6 @@ struct cpu_operations {
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
 int __init cpu_read_ops(struct device_node *dn, int cpu);
 void __init cpu_read_bootcpu_ops(void);
+const struct cpu_operations *cpu_get_ops(const char *name);
 
 #endif /* ifndef __ASM_CPU_OPS_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 780f82c..bf22650 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -39,9 +39,10 @@ extern void show_ipi_list(struct seq_file *p, int prec);
 extern void handle_IPI(int ipinr, struct pt_regs *regs);
 
 /*
- * Setup the set of possible CPUs (via set_cpu_possible)
+ * Discover the set of possible CPUs and determine their
+ * SMP operations.
  */
-extern void smp_init_cpus(void);
+extern void of_smp_init_cpus(void);
 
 /*
  * Provide a function to raise an IPI cross call on CPUs in callmap.
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index b9f64ec..f80caef 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -24,6 +24,10 @@
 #include <linux/memblock.h>
 #include <linux/smp.h>
 
+#include <asm/cputype.h>
+#include <asm/cpu_ops.h>
+#include <asm/smp_plat.h>
+
 int acpi_noirq;			/* skip ACPI IRQ initialization */
 int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
@@ -31,6 +35,8 @@ EXPORT_SYMBOL(acpi_disabled);
 int acpi_pci_disabled;		/* skip ACPI PCI scan and IRQ initialization */
 EXPORT_SYMBOL(acpi_pci_disabled);
 
+static int enabled_cpus;	/* Processors (GICC) with enabled flag in MADT */
+
 /*
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
@@ -51,6 +57,134 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
+/**
+ * acpi_map_gic_cpu_interface - generates a logical cpu number
+ * and map to MPIDR represented by GICC structure
+ * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
+ * @enabled: this cpu is enabled or not
+ *
+ * Returns the logical cpu number which maps to MPIDR
+ */
+static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
+{
+	int cpu;
+
+	if (mpidr == INVALID_HWID) {
+		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
+		return -EINVAL;
+	}
+
+	total_cpus++;
+	if (!enabled)
+		return -EINVAL;
+
+	if (enabled_cpus >=  NR_CPUS) {
+		pr_warn("NR_CPUS limit of %d reached, Processor %d/0x%llx ignored.\n",
+			NR_CPUS, total_cpus, mpidr);
+		return -EINVAL;
+	}
+
+	/* No need to check duplicate MPIDRs for the first CPU */
+	if (enabled_cpus) {
+		/*
+		 * Duplicate MPIDRs are a recipe for disaster. Scan
+		 * all initialized entries and check for
+		 * duplicates. If any is found just ignore the CPU.
+		 */
+		for_each_possible_cpu(cpu) {
+			if (cpu_logical_map(cpu) == mpidr) {
+				pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
+				       mpidr);
+				return -EINVAL;
+			}
+		}
+
+		/* allocate a logical cpu id for the new comer */
+		cpu = cpumask_next_zero(-1, cpu_possible_mask);
+	} else {
+		/*
+		 * First GICC entry must be BSP as ACPI spec said
+		 * in section 5.2.12.15
+		 */
+		if  (cpu_logical_map(0) != mpidr) {
+			pr_err("First GICC entry with MPIDR 0x%llx is not BSP\n",
+			       mpidr);
+			return -EINVAL;
+		}
+
+		/*
+		 * boot_cpu_init() already hold bit 0 in cpu_possible_mask
+		 * for BSP, no need to allocate again.
+		 */
+		cpu = 0;
+	}
+
+	if (!acpi_psci_present())
+		return -EOPNOTSUPP;
+
+	cpu_ops[cpu] = cpu_get_ops("psci");
+	/* CPU 0 was already initialized */
+	if (cpu) {
+		if (!cpu_ops[cpu])
+			return -EINVAL;
+
+		if (cpu_ops[cpu]->cpu_init(NULL, cpu))
+			return -EOPNOTSUPP;
+
+		/* map the logical cpu id to cpu MPIDR */
+		cpu_logical_map(cpu) = mpidr;
+
+		set_cpu_possible(cpu, true);
+	}
+
+	enabled_cpus++;
+	return cpu;
+}
+
+static int __init
+acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
+				const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *processor;
+
+	processor = (struct acpi_madt_generic_interrupt *)header;
+
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(header);
+
+	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
+		processor->flags & ACPI_MADT_ENABLED);
+
+	return 0;
+}
+
+/* Parse GIC cpu interface entries in MADT for SMP init */
+void __init acpi_init_cpus(void)
+{
+	int count;
+
+	/*
+	 * do a partial walk of MADT to determine how many CPUs
+	 * we have including disabled CPUs, and get information
+	 * we need for SMP init
+	 */
+	count = acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT,
+			acpi_parse_gic_cpu_interface, 0);
+
+	if (!count) {
+		pr_err("No GIC CPU interface entries present\n");
+		return;
+	} else if (count < 0) {
+		pr_err("Error parsing GIC CPU interface entry\n");
+		return;
+	}
+
+	/* Make boot-up look pretty */
+	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
+}
+
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
 	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
@@ -62,8 +196,20 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 	 * boot protocol configuration data, or we will disable ACPI.
 	 */
 	if (table->revision > 5 ||
-	    (table->revision == 5 && fadt->minor_revision >= 1))
-		return 0;
+	    (table->revision == 5 && fadt->minor_revision >= 1)) {
+		/*
+		 * ACPI 5.1 only has two explicit methods to boot up SMP,
+		 * PSCI and Parking protocol, but the Parking protocol is
+		 * only specified for ARMv7 now, so make PSCI as the only
+		 * way for the SMP boot protocol before some updates for
+		 * the Parking protocol spec.
+		 */
+		if (acpi_psci_present())
+			return 0;
+
+		pr_warn("No PSCI support, will not bring up secondary CPUs\n");
+		return -EOPNOTSUPP;
+	}
 
 	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
 		table->revision, fadt->minor_revision);
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index cce9524..fb8ff9b 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -35,7 +35,7 @@ static const struct cpu_operations *supported_cpu_ops[] __initconst = {
 	NULL,
 };
 
-static const struct cpu_operations * __init cpu_get_ops(const char *name)
+const struct cpu_operations * __init cpu_get_ops(const char *name)
 {
 	const struct cpu_operations **ops = supported_cpu_ops;
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 43ae914..1099ddc 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -449,13 +449,16 @@ void __init setup_arch(char **cmdline_p)
 	if (acpi_disabled) {
 		unflatten_device_tree();
 		psci_dt_init();
+		cpu_read_bootcpu_ops();
+#ifdef CONFIG_SMP
+		of_smp_init_cpus();
+#endif
 	} else {
 		psci_acpi_init();
+		acpi_init_cpus();
 	}
 
-	cpu_read_bootcpu_ops();
 #ifdef CONFIG_SMP
-	smp_init_cpus();
 	smp_build_mpidr_hash();
 #endif
 
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 7ae6ee0..5aaf5a4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -323,7 +323,7 @@ void __init smp_prepare_boot_cpu(void)
  * cpu logical map array containing MPIDR values related to logical
  * cpus. Assumes that cpu_logical_map(0) has already been initialized.
  */
-void __init smp_init_cpus(void)
+void __init of_smp_init_cpus(void)
 {
 	struct device_node *dn = NULL;
 	unsigned int i, cpu = 1;
-- 
1.9.1
