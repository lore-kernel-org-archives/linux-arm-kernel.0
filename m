From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 25 Jan 2016 11:21:48 +0100
Subject: [PATCH v3 05/12] arm64, acpi, numa: NUMA support based on SRAT
 and SLIT
In-Reply-To: <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
References: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
 <1453541967-3744-6-git-send-email-guohanjun@huawei.com>
Message-ID: <20160125102148.GE24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.01.16 17:39:20, Hanjun Guo wrote:
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> new file mode 100644
> index 0000000..f7f7533
> --- /dev/null
> +++ b/arch/arm64/kernel/acpi_numa.c

> +/* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
> +int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> +{
> +	u64 start, end;
> +	int node, pxm;
> +
> +	if (srat_disabled())
> +		return -EINVAL;
> +
> +	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {

Must be:

	ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {

Allow extensions to struct acpi_srat_mem_affinity in newer versions.

> +		bad_srat();
> +		return -EINVAL;

We need a pr_err() here to avoid that numa setup fails silently due to
bad fw. This applies to all error paths.

See my delta patch below. You can merge it with your patch.

-Robert

> +	}


>From 78945c73e4ec03756a135a75133ed29694a7a0f2 Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@cavium.com>
Date: Wed, 11 Nov 2015 09:53:39 +0100
Subject: [PATCH] arm64, acpi, numa: Add error messages for bad SRAT tables

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/kernel/acpi_numa.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index f7f7533761cd..936ad6c43740 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -143,6 +143,8 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 		return;
 
 	if (pa->header.length < sizeof(struct acpi_srat_gicc_affinity)) {
+		pr_err("SRAT: Invalid SRAT header length: %d\n",
+			pa->header.length);
 		bad_srat();
 		return;
 	}
@@ -166,7 +168,7 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
 	}
 
 	if (get_mpidr_in_madt(pa->acpi_processor_uid, &mpidr)) {
-		pr_warn("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
+		pr_err("SRAT: PXM %d with ACPI ID %d has no valid MPIDR in MADT\n",
 			pxm, pa->acpi_processor_uid);
 		bad_srat();
 		return;
@@ -190,7 +192,9 @@ int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 	if (srat_disabled())
 		return -EINVAL;
 
-	if (ma->header.length != sizeof(struct acpi_srat_mem_affinity)) {
+	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
+		pr_err("SRAT: Unexpected header length: %d\n",
+			ma->header.length);
 		bad_srat();
 		return -EINVAL;
 	}
@@ -216,10 +220,17 @@ int __init acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 		(unsigned long long) start, (unsigned long long) end - 1);
 
 	if (numa_add_memblk(node, start, (end - start)) < 0) {
+		pr_err("SRAT: Failed to add memblk to node %u [mem %#010Lx-%#010Lx]\n",
+			node, (unsigned long long) start,
+			(unsigned long long) end - 1);
 		bad_srat();
 		return -EINVAL;
 	}
 
+	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
+		node, pxm,
+		(unsigned long long) start, (unsigned long long) end - 1);
+
 	return 0;
 }
 
-- 
2.7.0.rc3
