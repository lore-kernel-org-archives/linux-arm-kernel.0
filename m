From: ddaney.cavm@gmail.com (David Daney)
Date: Mon, 18 Apr 2016 14:14:03 -0700
Subject: [PATCH v4 05/14] acpi,
 numa: move acpi_numa_slit_init() to drivers/acpi/numa.c
In-Reply-To: <1461014052-30788-1-git-send-email-ddaney.cavm@gmail.com>
References: <1461014052-30788-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1461014052-30788-6-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Identical implementations of acpi_numa_slit_init() are used by both
x86 and follow-on arm64 support.  Move it to drivers/acpi/numa.c, and
mark it as __weak because ia64 has its own architecture specific
implementation.

No code change.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/x86/mm/srat.c  | 27 ---------------------------
 drivers/acpi/numa.c | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 27 deletions(-)

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
index f41f06b..5403d62 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -197,6 +197,33 @@ static int __init slit_valid(struct acpi_table_slit *slit)
 	return 1;
 }
 
+/*
+ * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
+ * I/O localities since SRAT does not list them.  I/O localities are
+ * not supported at this point.
+ */
+void __init __weak acpi_numa_slit_init(struct acpi_table_slit *slit)
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
+
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
 	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-- 
1.7.11.7
