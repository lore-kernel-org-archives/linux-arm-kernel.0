From: martin@kaiser.cx (martin at kaiser.cx)
Date: Wed, 25 Jan 2017 22:42:25 +0100
Subject: [PATCH v2] clk: samsung: mark s3c...._clk_sleep_init() as __init
In-Reply-To: <1485293599-23581-1-git-send-email-martin@kaiser.cx>
References: <1485293599-23581-1-git-send-email-martin@kaiser.cx>
Message-ID: <1485380545-24815-1-git-send-email-martin@kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Kaiser <martin@kaiser.cx>

These functions are referencing s3c...._clk_regs[], which are marked as
__initdata. When compiling with CONFIG_DEBUG_SECTION_MISMATCH=y, this
produces warnings like

WARNING: vmlinux.o(.text+0x198350):
Section mismatch in reference from the function s3c2410_clk_sleep_init()
to the (unknown reference) .init.data:(unknown)

Mark the s3c...._clk_sleep_init() functions as __init in
order to fix this.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
Fix the commit message, describe what the problem really is.
(Thanks, Krzysztof)

 drivers/clk/samsung/clk-s3c2410.c |    4 ++--
 drivers/clk/samsung/clk-s3c2412.c |    4 ++--
 drivers/clk/samsung/clk-s3c2443.c |    4 ++--
 drivers/clk/samsung/clk-s3c64xx.c |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index d7a1e77..e0650c3 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -76,7 +76,7 @@ static void s3c2410_clk_resume(void)
 	.resume = s3c2410_clk_resume,
 };
 
-static void s3c2410_clk_sleep_init(void)
+static void __init s3c2410_clk_sleep_init(void)
 {
 	s3c2410_save = samsung_clk_alloc_reg_dump(s3c2410_clk_regs,
 						ARRAY_SIZE(s3c2410_clk_regs));
@@ -90,7 +90,7 @@ static void s3c2410_clk_sleep_init(void)
 	return;
 }
 #else
-static void s3c2410_clk_sleep_init(void) {}
+static void __init s3c2410_clk_sleep_init(void) {}
 #endif
 
 PNAME(fclk_p) = { "mpll", "div_slow" };
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index ec873ee..b8340a4 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -69,7 +69,7 @@ static void s3c2412_clk_resume(void)
 	.resume = s3c2412_clk_resume,
 };
 
-static void s3c2412_clk_sleep_init(void)
+static void __init s3c2412_clk_sleep_init(void)
 {
 	s3c2412_save = samsung_clk_alloc_reg_dump(s3c2412_clk_regs,
 						ARRAY_SIZE(s3c2412_clk_regs));
@@ -83,7 +83,7 @@ static void s3c2412_clk_sleep_init(void)
 	return;
 }
 #else
-static void s3c2412_clk_sleep_init(void) {}
+static void __init s3c2412_clk_sleep_init(void) {}
 #endif
 
 static struct clk_div_table divxti_d[] = {
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index 5e24a17..abb935c 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -89,7 +89,7 @@ static void s3c2443_clk_resume(void)
 	.resume = s3c2443_clk_resume,
 };
 
-static void s3c2443_clk_sleep_init(void)
+static void __init s3c2443_clk_sleep_init(void)
 {
 	s3c2443_save = samsung_clk_alloc_reg_dump(s3c2443_clk_regs,
 						ARRAY_SIZE(s3c2443_clk_regs));
@@ -103,7 +103,7 @@ static void s3c2443_clk_sleep_init(void)
 	return;
 }
 #else
-static void s3c2443_clk_sleep_init(void) {}
+static void __init s3c2443_clk_sleep_init(void) {}
 #endif
 
 PNAME(epllref_p) = { "mpllref", "mpllref", "xti", "ext" };
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index a48bd5f..7306867 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -121,7 +121,7 @@ static void s3c64xx_clk_resume(void)
 	.resume = s3c64xx_clk_resume,
 };
 
-static void s3c64xx_clk_sleep_init(void)
+static void __init s3c64xx_clk_sleep_init(void)
 {
 	s3c64xx_save_common = samsung_clk_alloc_reg_dump(s3c64xx_clk_regs,
 						ARRAY_SIZE(s3c64xx_clk_regs));
@@ -145,7 +145,7 @@ static void s3c64xx_clk_sleep_init(void)
 		__func__);
 }
 #else
-static void s3c64xx_clk_sleep_init(void) {}
+static void __init s3c64xx_clk_sleep_init(void) {}
 #endif
 
 /* List of parent clocks common for all S3C64xx SoCs. */
-- 
1.7.10.4
