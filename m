From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  4 Aug 2017 19:11:56 -0500
Subject: [RFC 1/4] drivers: base: cacheinfo: Add support for ACPI based
 firmware tables
In-Reply-To: <20170805001159.12769-1-jeremy.linton@arm.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
Message-ID: <20170805001159.12769-2-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index eb3af27..44fa374 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -215,6 +215,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 }
 #endif
 
+int __weak cache_setup_acpi(unsigned int cpu)
+{
+	return -ENOTSUPP;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -225,11 +230,11 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (this_cpu_ci->cpu_map_populated)
 		return 0;
 
-	if (of_have_populated_dt())
+	if (!acpi_disabled)
+		ret = cache_setup_acpi(cpu);
+	else if (of_have_populated_dt())
 		ret = cache_setup_of_node(cpu);
-	else if (!acpi_disabled)
-		/* No cache property/hierarchy support yet in ACPI */
-		ret = -ENOTSUPP;
+
 	if (ret)
 		return ret;
 
@@ -286,7 +291,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 static void cache_override_properties(unsigned int cpu)
 {
-	if (of_have_populated_dt())
+	if (acpi_disabled && of_have_populated_dt())
 		return cache_of_override_properties(cpu);
 }
 
-- 
2.9.4
