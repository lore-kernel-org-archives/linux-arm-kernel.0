From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:21 +0800
Subject: [PATCH v3 06/12] acpi, numa: Enable ACPI based NUMA on ARM64
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-7-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Add function needed for cpu to node mapping, and enable
ACPI based NUMA for ARM64 in Kconfig

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig |  2 +-
 drivers/acpi/numa.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/acpi.h | 17 ++++++++++++++++-
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index d6d5749..31875ab 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -283,7 +283,7 @@ config ACPI_THERMAL
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (X86 || IA64)
+	depends on (X86 || IA64 || ARM64)
 	default y if IA64_GENERIC || IA64_SGI_SN2
 
 config ACPI_CUSTOM_DSDT_FILE
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 2de6068..4728525 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -167,6 +167,18 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_SRAT_TYPE_GICC_AFFINITY:
+		{
+			struct acpi_srat_gicc_affinity *p =
+			    (struct acpi_srat_gicc_affinity *)header;
+			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
+				 p->acpi_processor_uid,
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_GICC_ENABLED) ?
+				 "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -252,6 +264,24 @@ acpi_parse_processor_affinity(struct acpi_subtable_header *header,
 	return 0;
 }
 
+static int __init
+acpi_parse_gicc_affinity(struct acpi_subtable_header *header,
+			 const unsigned long end)
+{
+	struct acpi_srat_gicc_affinity *processor_affinity;
+
+	processor_affinity = (struct acpi_srat_gicc_affinity *)header;
+	if (!processor_affinity)
+		return -EINVAL;
+
+	acpi_table_print_srat_entry(header);
+
+	/* let architecture-dependent part to do it */
+	acpi_numa_gicc_affinity_init(processor_affinity);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -296,6 +326,9 @@ int __init acpi_numa_init(void)
 {
 	int cnt = 0;
 
+	if (acpi_disabled)
+		return -EINVAL;
+
 	/*
 	 * Should not limit number with cpu num that is from NR_CPUS or nr_cpus=
 	 * SRAT cpu entries could have different order with that in MADT.
@@ -308,6 +341,8 @@ int __init acpi_numa_init(void)
 				     acpi_parse_x2apic_affinity, 0);
 		acpi_table_parse_srat(ACPI_SRAT_TYPE_CPU_AFFINITY,
 				     acpi_parse_processor_affinity, 0);
+		acpi_table_parse_srat(ACPI_SRAT_TYPE_GICC_AFFINITY,
+				      acpi_parse_gicc_affinity, 0);
 		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 					    acpi_parse_memory_affinity,
 					    NR_NODE_MEMBLKS);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 574d829..e386ae2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -168,10 +168,25 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
-/* the following four functions are architecture-dependent */
+/* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
+
+#if defined(CONFIG_X86) || defined(CONFIG_IA64)
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
+#else
+static inline void
+acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa) { }
+#endif
+
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
+
+#ifdef CONFIG_ARM64
+void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
+#else
+static inline void
+acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
+#endif
+
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
 
 #ifdef CONFIG_ACPI_HAS_NUMA_ARCH_FIXUP
-- 
1.9.1
