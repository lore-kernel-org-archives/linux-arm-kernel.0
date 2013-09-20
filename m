From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 20 Sep 2013 08:22:33 +0200
Subject: [PATCH v2 07/26] clk: vt8500: parse pmc_base from clock driver
In-Reply-To: <1379526839-14798-8-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-8-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379658153-28070-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, clock providers for vt8500 depend on machine_init providing
pmc_base address before calling of_clk_init. With upcoming arch-wide
.time_init calling of_clk_init, we should make clock providers independent
of mach code. This adds a pmc_base parsing helper to current clock provider
that gets called if there is no pmc_base set, yet.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
Changelog:
v1->v2:
- Also check pmc_base in vtwm_device_clk_init (Reported by Tony Prisk)
  This also requires vtwm_set_pmc_base to move upwards.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk-vt8500.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 82306f5..39fe72a 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -15,11 +15,14 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 
+#define LEGACY_PMC_BASE		0xD8130000
+
 /* All clocks share the same lock as none can be changed concurrently */
 static DEFINE_SPINLOCK(_lock);
 
@@ -53,6 +56,21 @@ struct clk_pll {
 
 static void __iomem *pmc_base;
 
+static __init void vtwm_set_pmc_base(void)
+{
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "via,vt8500-pmc");
+
+	if (np)
+		pmc_base = of_iomap(np, 0);
+	else
+		pmc_base = ioremap(LEGACY_PMC_BASE, 0x1000);
+	of_node_put(np);
+
+	if (!pmc_base)
+		pr_err("%s:of_iomap(pmc) failed\n", __func__);
+}
+
 #define to_clk_device(_hw) container_of(_hw, struct clk_device, hw)
 
 #define VT8500_PMC_BUSY_MASK		0x18
@@ -222,6 +240,9 @@ static __init void vtwm_device_clk_init(struct device_node *node)
 	int rc;
 	int clk_init_flags = 0;
 
+	if (!pmc_base)
+		vtwm_set_pmc_base();
+
 	dev_clk = kzalloc(sizeof(*dev_clk), GFP_KERNEL);
 	if (WARN_ON(!dev_clk))
 		return;
@@ -636,6 +657,9 @@ static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
 	struct clk_init_data init;
 	int rc;
 
+	if (!pmc_base)
+		vtwm_set_pmc_base();
+
 	rc = of_property_read_u32(node, "reg", &reg);
 	if (WARN_ON(rc))
 		return;
-- 
1.7.10.4
