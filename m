From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:26 +0800
Subject: [PATCH v3 11/12] acpi, numa: remove unneeded acpi_numa=1
In-Reply-To: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1453541967-3744-12-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

acpi_numa is default to 0, it's set to -1 when disable acpi numa or
when a bad SRAT is parsed, and it's only consumed in srat_disabled()
(compare it with 0) to continue parse the SRAT or not, so we don't
need to set acpi_numa to 1 when we get a valid SRAT entry.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi_numa.c | 1 -
 arch/x86/mm/srat.c            | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index fb1556f..03ac1b9 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -132,7 +132,6 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 	early_node_cpu_hwid[cpus_in_srat].node_id = node;
 	early_node_cpu_hwid[cpus_in_srat].cpu_hwid =  mpidr;
 	node_set(node, numa_nodes_parsed);
-	acpi_numa = 1;
 	cpus_in_srat++;
 	pr_info("SRAT: PXM %d -> MPIDR 0x%Lx -> Node %d cpu %d\n",
 		pxm, mpidr, node, cpus_in_srat);
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 7078b3f..af1dc14 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -59,7 +59,6 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	acpi_numa = 1;
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
 	       pxm, apic_id, node);
 }
@@ -101,7 +100,6 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	acpi_numa = 1;
 	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
 	       pxm, apic_id, node);
 }
-- 
1.9.1
