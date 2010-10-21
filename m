From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 15:44:43 +0900
Subject: [PATCH V3 3/3] ARM: S5PV310: Add L2 cache init function in cpu.c
In-Reply-To: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
References: <1287643483-16046-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287643483-16046-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

This patch adds L2 cache initialization code in cpu.c of ARCH_S5PV310.
It includes TAG and Data latency, Prefetch, and Power configurations.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 5b97900..4e3f5be 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -15,6 +15,7 @@
 #include <asm/mach/irq.h>
 
 #include <asm/proc-fns.h>
+#include <asm/hardware/cache-l2x0.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -148,6 +149,28 @@ static int __init s5pv310_core_init(void)
 
 core_initcall(s5pv310_core_init);
 
+#ifdef CONFIG_CACHE_L2X0
+static int __init s5pv310_l2x0_cache_init(void)
+{
+	/* TAG, Data Latency Control: 2cycle */
+	__raw_writel(0x110, S5P_VA_L2CC + L2X0_TAG_LATENCY_CTRL);
+	__raw_writel(0x110, S5P_VA_L2CC + L2X0_DATA_LATENCY_CTRL);
+
+	/* L2X0 Prefetch Control */
+	__raw_writel(0x30000007, S5P_VA_L2CC + L2X0_PREFETCH_CTRL);
+
+	/* L2X0 Power Control */
+	__raw_writel(L2X0_DYNAMIC_CLK_GATING_EN | L2X0_STNDBY_MODE_EN,
+		     S5P_VA_L2CC + L2X0_POWER_CTRL);
+
+	l2x0_init(S5P_VA_L2CC, 0x7C070001, 0xC200ffff);
+
+	return 0;
+}
+
+early_initcall(s5pv310_l2x0_cache_init);
+#endif
+
 int __init s5pv310_init(void)
 {
 	printk(KERN_INFO "S5PV310: Initializing architecture\n");
-- 
1.6.2.5
