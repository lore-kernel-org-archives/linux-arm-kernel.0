From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:40 +0200
Subject: [PATCH 07/26] clk: vt8500: parse pmc_base from clock driver
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, clock providers for vt8500 depend on machine_init providing
pmc_base address before calling of_clk_init. With upcoming arch-wide
.time_init calling of_clk_init, we should make clock providers independent
of mach code. This adds a pmc_base parsing helper to current clock provider
that gets called if there is no pmc_base set, yet.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk-vt8500.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index 82306f5..a5ee01c 100644
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
 
@@ -626,6 +629,21 @@ const struct clk_ops vtwm_pll_ops = {
 	.recalc_rate = vtwm_pll_recalc_rate,
 };
 
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
 static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
 {
 	u32 reg;
@@ -636,6 +654,9 @@ static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
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
