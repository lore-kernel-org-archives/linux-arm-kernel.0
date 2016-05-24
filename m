From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 24 May 2016 15:35:35 -0700
Subject: [PATCH v7 05/15] acpi,
 numa: move acpi_numa_slit_init() to drivers/acpi/numa.c
In-Reply-To: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
References: <1464129345-18985-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1464129345-18985-6-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Identical implementations of acpi_numa_slit_init() are used by both
x86 and follow-on arm64 support.  Move it to drivers/acpi/numa.c, and
guard with CONFIG_X86 || CONFIG_ARM64 because ia64 has its own
architecture specific implementation.

No code change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/x86/mm/srat.c  | 27 ---------------------------
 drivers/acpi/numa.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 90b6ed9..f242a11 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -42,33 +42,6 @@ static __init inline int srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported@this point.
- */
-void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
-{
-	int i, j;
-
-	for (i = 0; i < slit->locality_count; i++) {
-		const int from_node = pxm_to_node(i);
-
-		if (from_node == NUMA_NO_NODE)
-			continue;
-
-		for (j = 0; j < slit->locality_count; j++) {
-			const int to_node = pxm_to_node(j);
-
-			if (to_node == NUMA_NO_NODE)
-				continue;
-
-			numa_set_distance(from_node, to_node,
-				slit->entry[slit->locality_count * i + j]);
-		}
-	}
-}
-
 /* Callback for Proximity Domain -> x2APIC mapping */
 void __init
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index fb2c0d6..7e0649d 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -197,6 +197,35 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 	return 1;
 }
 
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+/*
+ * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
+ * I/O localities since SRAT does not list them.  I/O localities are
+ * not supported at this point.
+ */
+void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+{
+	int i, j;
+
+	for (i = 0; i < slit->locality_count; i++) {
+		const int from_node = pxm_to_node(i);
+
+		if (from_node == NUMA_NO_NODE)
+			continue;
+
+		for (j = 0; j < slit->locality_count; j++) {
+			const int to_node = pxm_to_node(j);
+
+			if (to_node == NUMA_NO_NODE)
+				continue;
+
+			numa_set_distance(from_node, to_node,
+				slit->entry[slit->locality_count * i + j]);
+		}
+	}
+}
+#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
+
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-- 
1.7.11.7
