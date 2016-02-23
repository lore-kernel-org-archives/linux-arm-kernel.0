From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Feb 2016 15:06:38 +0100
Subject: [PATCH 2/3] ARM: mv78xx0: avoid unused function warning
In-Reply-To: <1456236403-115511-1-git-send-email-arnd@arndb.de>
References: <1456236403-115511-1-git-send-email-arnd@arndb.de>
Message-ID: <1456236403-115511-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mv78xx0 produces a harmless warning when CONFIG_CACHE_FEROCEON_L2 is
disabled:

arch/arm/mach-mv78xx0/common.c:385:19: warning: 'is_l2_writethrough' defined but not used [-Wunused-function]

This avoids the warning by changing the #ifdef to an if(IS_ENABLED())
check with the same resulting object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mv78xx0/common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index a1a04df9c05c..99cc93900a24 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -405,9 +405,8 @@ void __init mv78xx0_init(void)
 	printk("HCLK = %dMHz, ", (hclk + 499999) / 1000000);
 	printk("TCLK = %dMHz\n", (get_tclk() + 499999) / 1000000);
 
-#ifdef CONFIG_CACHE_FEROCEON_L2
-	feroceon_l2_init(is_l2_writethrough());
-#endif
+	if (IS_ENABLED(CONFIG_CACHE_FEROCEON_L2))
+		feroceon_l2_init(is_l2_writethrough());
 
 	/* Setup root of clk tree */
 	clk_init();
-- 
2.7.0
