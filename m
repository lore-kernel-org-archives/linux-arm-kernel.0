From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  4 Aug 2017 19:11:57 -0500
Subject: [RFC 2/4] arm64: cacheinfo: Add support for ACPI/PPTT generated
 topology
In-Reply-To: <20170805001159.12769-1-jeremy.linton@arm.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
Message-ID: <20170805001159.12769-3-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACPI specification now includes a tree based description
of the cache hierarchy. On arm64 the first step is assuring
that we allocate sufficient levels to contain all the
individual cache descriptions beyond what is described
by the individual cores. Lets initially just stub that
out with a routine which indicates that there aren't further
levels beyond what is reported by the cores.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 23 ++++++++++++++++++-----
 include/linux/cacheinfo.h     |  1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 380f2e2..2e2cf0d 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cacheinfo.h>
 #include <linux/of.h>
 
@@ -44,9 +45,17 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+#ifndef CONFIG_ACPI
+int acpi_find_last_cache_level(unsigned int cpu)
+{
+	/*ACPI kernels should be built with PPTT support*/
+	return 0;
+}
+#endif
+
 static int __init_cache_level(unsigned int cpu)
 {
-	unsigned int ctype, level, leaves, of_level;
+	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,15 +68,19 @@ static int __init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	of_level = of_find_last_cache_level(cpu);
-	if (level < of_level) {
+	if (acpi_disabled)
+		fw_level = of_find_last_cache_level(cpu);
+	else
+		fw_level = acpi_find_last_cache_level(cpu);
+
+	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
 		 * the information may be available in the device tree
 		 * only unified external caches are considered here
 		 */
-		leaves += (of_level - level);
-		level = of_level;
+		leaves += (fw_level - level);
+		level = fw_level;
 	}
 
 	this_cpu_ci->num_levels = level;
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 6a524bf..e9233c7 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -98,6 +98,7 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+int acpi_find_last_cache_level(unsigned int cpu);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.9.4
