From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 14 Mar 2015 19:49:39 +0800
Subject: [PATCH 04/10] ARM: zx: add initial L2CC initialization
In-Reply-To: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
Message-ID: <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an initial L2 Cache controller initialization.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 arch/arm/mach-zx/zx296702.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/mach-zx/zx296702.c b/arch/arm/mach-zx/zx296702.c
index fdd7961..9c055ea 100644
--- a/arch/arm/mach-zx/zx296702.c
+++ b/arch/arm/mach-zx/zx296702.c
@@ -7,9 +7,52 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/init.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+#include "core.h"
+
+static void __init zx_l2x0_init(void)
+{
+	void __iomem *base;
+	struct device_node *np;
+	unsigned int val;
+
+	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
+	if (!np)
+		goto out;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		of_node_put(np);
+		goto out;
+	}
+
+	val = readl_relaxed(base + L310_PREFETCH_CTRL);
+	val |= 0x70800000;
+	writel_relaxed(val, base + L310_PREFETCH_CTRL);
+
+	writel_relaxed(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
+		       base + L310_POWER_CTRL);
+
+	iounmap(base);
+	of_node_put(np);
+
+out:
+	l2x0_of_init(0x7c433C01, 0x8000c3fe);
+}
+
+static void __init zx296702_init_machine(void)
+{
+	zx_l2x0_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *zx296702_dt_compat[] __initconst = {
 	"zte,zx296702",
 	NULL,
@@ -17,4 +60,5 @@ static const char *zx296702_dt_compat[] __initconst = {
 
 DT_MACHINE_START(ZX, "ZTE ZX296702 (Device Tree)")
 	.dt_compat	= zx296702_dt_compat,
+	.init_machine	= zx296702_init_machine,
 MACHINE_END
-- 
1.9.1
