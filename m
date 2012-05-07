From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 6 May 2012 22:08:28 -0700
Subject: [PATCH 3/5] clk: remove COMMON_CLK_DISABLE_UNUSED
In-Reply-To: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
Message-ID: <1336367310-5140-4-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exposing this option generates confusion and incorrect behavior for
single-image builds across platforms.  Enable this behavior permanently.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/Kconfig |   11 -----------
 drivers/clk/clk.c   |    2 --
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index f05a60d..4864407 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -23,17 +23,6 @@ config COMMON_CLK
 menu "Common Clock Framework"
 	depends on COMMON_CLK
 
-config COMMON_CLK_DISABLE_UNUSED
-	bool "Disabled unused clocks at boot"
-	depends on COMMON_CLK
-	---help---
-	  Traverses the entire clock tree and disables any clocks that are
-	  enabled in hardware but have not been enabled by any device drivers.
-	  This saves power and keeps the software model of the clock in line
-	  with reality.
-
-	  If in doubt, say "N".
-
 config COMMON_CLK_DEBUG
 	bool "DebugFS representation of clock tree"
 	depends on COMMON_CLK
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7ceca0e..e5d5dc1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -196,7 +196,6 @@ late_initcall(clk_debug_init);
 static inline int clk_debug_register(struct clk *clk) { return 0; }
 #endif
 
-#ifdef CONFIG_COMMON_CLK_DISABLE_UNUSED
 /* caller must hold prepare_lock */
 static void clk_disable_unused_subtree(struct clk *clk)
 {
@@ -246,7 +245,6 @@ static int clk_disable_unused(void)
 	return 0;
 }
 late_initcall(clk_disable_unused);
-#endif
 
 /***    helper functions   ***/
 
-- 
1.7.5.4
