From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:50:30 +0200
Subject: [PATCH v3 3/6] ARM: mvebu: improve PMSU driver to request its resource
In-Reply-To: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483433-25836-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483433-25836-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the PMSU driver was using of_iomap() to map its registers,
but of_iomap() doesn't call request_mem_region(). This commit fixes
the memory mapping code of the PMSU to do so, which will also be
useful for a later commit since we will need to adjust the resource
base address and size for Device Tree backward compatibility.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 1807639..b337fe5 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -16,6 +16,8 @@
  * other SOC units
  */
 
+#define pr_fmt(fmt) "mvebu-pmsu: " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
@@ -63,15 +65,39 @@ int armada_xp_boot_cpu(unsigned int cpu_id, void *boot_addr)
 static int __init armada_370_xp_pmsu_init(void)
 {
 	struct device_node *np;
+	struct resource res;
+	int ret = 0;
 
 	np = of_find_matching_node(NULL, of_pmsu_table);
-	if (np) {
-		pr_info("Initializing Power Management Service Unit\n");
-		pmsu_mp_base = of_iomap(np, 0);
-		of_node_put(np);
+	if (!np)
+		return 0;
+
+	pr_info("Initializing Power Management Service Unit\n");
+
+	if (of_address_to_resource(np, 0, &res)) {
+		pr_err("unable to get resource\n");
+		ret = -ENOENT;
+		goto out;
 	}
 
-	return 0;
+	if (!request_mem_region(res.start, resource_size(&res),
+				np->full_name)) {
+		pr_err("unable to request region\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pmsu_mp_base = ioremap(res.start, resource_size(&res));
+	if (!pmsu_mp_base) {
+		pr_err("unable to map registers\n");
+		release_mem_region(res.start, resource_size(&res));
+		ret = -ENOMEM;
+		goto out;
+	}
+
+ out:
+	of_node_put(np);
+	return ret;
 }
 
 early_initcall(armada_370_xp_pmsu_init);
-- 
1.8.3.2
