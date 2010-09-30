From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 16:49:59 +0900
Subject: [PATCH v2 3/3] ARM: S5PC210: Set the common L2 cache configurations
Message-ID: <20100930074959.GA11798@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

S5PC210 has PL310 1MiB L2 cache.
It uses the optimized data & tag latency and also enable the prefetch.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index e5b261a..b50312e 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -15,6 +15,7 @@
 #include <asm/mach/irq.h>
 
 #include <asm/proc-fns.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -121,6 +122,24 @@ static int __init s5pv310_core_init(void)
 
 core_initcall(s5pv310_core_init);
 
+static int __init s5pv310_init_cache(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	void __iomem *p = S5P_VA_L2CC;
+
+	/* TAG,  Data latency control */
+	writel(0x110, p + L2X0_TAG_LATENCY_CTRL);
+	writel(0x110, p + L2X0_DATA_LATENCY_CTRL);
+
+	/* L2 cache prefetch control */
+	writel(0x30000007, p + L2X0_PREFETCH_CTRL);
+
+	l2x0_init(p, 0x3C070001, 0xC200FFFF);
+#endif
+	return 0;
+}
+early_initcall(s5pv310_init_cache);
+
 int __init s5pv310_init(void)
 {
 	printk(KERN_INFO "S5PV310: Initializing architecture\n");
-- 
1.5.3.3
