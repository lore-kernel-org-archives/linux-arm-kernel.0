From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sun, 30 Sep 2012 17:22:53 -0600
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
Message-ID: <20120930232253.GD30637@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the CACHE_FEROCEON_L2 test to kirkwood_l2_init, since linking
fails on the reference to feroceon_l2_init.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 arch/arm/mach-kirkwood/board-dt.c |    2 --
 arch/arm/mach-kirkwood/common.c   |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e4eb450..d00223e 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -50,9 +50,7 @@ static void __init kirkwood_dt_init(void)
 
 	kirkwood_setup_cpu_mbus();
 
-#ifdef CONFIG_CACHE_FEROCEON_L2
 	kirkwood_l2_init();
-#endif
 
 	/* Setup root of clk tree */
 	kirkwood_clk_init();
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 1201191..4177304 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -645,6 +645,7 @@ char * __init kirkwood_id(void)
 
 void __init kirkwood_l2_init(void)
 {
+#ifdef CONFIG_CACHE_FEROCEON_L2
 #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH
 	writel(readl(L2_CONFIG_REG) | L2_WRITETHROUGH, L2_CONFIG_REG);
 	feroceon_l2_init(1);
@@ -652,6 +653,7 @@ void __init kirkwood_l2_init(void)
 	writel(readl(L2_CONFIG_REG) & ~L2_WRITETHROUGH, L2_CONFIG_REG);
 	feroceon_l2_init(0);
 #endif
+#endif
 }
 
 void __init kirkwood_init(void)
@@ -669,9 +671,7 @@ void __init kirkwood_init(void)
 
 	kirkwood_setup_cpu_mbus();
 
-#ifdef CONFIG_CACHE_FEROCEON_L2
 	kirkwood_l2_init();
-#endif
 
 	/* Setup root of clk tree */
 	kirkwood_clk_init();
-- 
1.7.4.1
