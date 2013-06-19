From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 17:07:19 -0300
Subject: [PATCH v4 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1371672446-21583-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1371672446-21583-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address decoding window to access the BootROM should not be
allocated programatically, but declared in the device tree.

Instead of allocating it, we add a check to verify the DT has
declared a valid node to access the BootROM.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/platsmp.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index 93f2f3a..a952f8d 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/mbus.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -29,6 +30,9 @@
 #include "pmsu.h"
 #include "coherency.h"
 
+#define AXP_BOOTROM_BASE 0xfff00000
+#define AXP_BOOTROM_SIZE 0x100000
+
 void __init set_secondary_cpus_clock(void)
 {
 	int thiscpu;
@@ -115,10 +119,29 @@ static void __init armada_xp_smp_init_cpus(void)
 
 void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
 {
+	struct device_node *node;
+	struct resource res;
+	int err;
+
 	set_secondary_cpus_clock();
 	flush_cache_all();
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
-	mvebu_mbus_add_window("bootrom", 0xfff00000, SZ_1M);
+
+	/*
+	 * In order to boot the secondary CPUs we need to ensure
+	 * the bootROM is mapped at the correct address.
+	 */
+	node = of_find_compatible_node(NULL, NULL, "marvell,bootrom");
+	if (!node)
+		panic("Cannot find 'marvell,bootrom' compatible node");
+
+	err = of_address_to_resource(node, 0, &res);
+	if (err < 0)
+		panic("Cannot get 'bootrom' node address");
+
+	if (res.start != AXP_BOOTROM_BASE||
+	    resource_size(&res) != AXP_BOOTROM_SIZE)
+		panic("The address for the BootROM is incorrect");
 }
 
 struct smp_operations armada_xp_smp_ops __initdata = {
-- 
1.8.1.5
