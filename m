From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 7 Jan 2012 00:24:49 +0100
Subject: [PATCH 2/8] S3C24XX: move common S3C2443 clock definitions to clock.h
In-Reply-To: <201201070022.40431.heiko@sntech.de>
References: <201201070022.40431.heiko@sntech.de>
Message-ID: <201201070024.50162.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-samsung/clock.h currently keeps all the SoC specific clock
declarations except the ones for S3C2443/S3C2416 which were kept in
s3c2443.h.

This patch moves them out of s3c2443.h to get rid of the header
completely later on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c                |    1 -
 arch/arm/plat-s3c24xx/s3c2443-clock.c        |    1 -
 arch/arm/plat-samsung/include/plat/clock.h   |   19 +++++++++++++++++++
 arch/arm/plat-samsung/include/plat/s3c2443.h |   19 -------------------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 59f54d1..5e36905 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -15,7 +15,6 @@
 #include <linux/clk.h>
 
 #include <plat/s3c2416.h>
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 95e6819..3633060 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -12,7 +12,6 @@
 
 #include <mach/regs-s3c2443-clock.h>
 
-#include <plat/s3c2443.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 73c66d4..956af0b1 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -79,6 +79,10 @@ extern struct clk clk_epll;
 extern struct clk clk_xtal;
 extern struct clk clk_ext;
 
+/* S3C2443/S3C2416 specific clocks */
+extern struct clksrc_clk clk_epllref;
+extern struct clksrc_clk clk_esysclk;
+
 /* S3C64XX specific clocks */
 extern struct clk clk_h2;
 extern struct clk clk_27m;
@@ -116,6 +120,21 @@ extern void s3c2412_setup_clocks(void);
 extern void s3c244x_setup_clocks(void);
 extern void s3c2443_setup_clocks(void);
 
+
+/* S3C2443/S3C2416 specific clock functions */
+
+typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
+
+extern void s3c2443_common_setup_clocks(pll_fn get_mpll);
+extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
+				       unsigned int *divs, int nr_divs,
+				       int divmask);
+
+extern int s3c2443_clkcon_enable_h(struct clk *clk, int enable);
+extern int s3c2443_clkcon_enable_p(struct clk *clk, int enable);
+extern int s3c2443_clkcon_enable_s(struct clk *clk, int enable);
+
+
 /* S3C64XX specific functions and clocks */
 
 extern int s3c64xx_sclk_ctrl(struct clk *clk, int enable);
diff --git a/arch/arm/plat-samsung/include/plat/s3c2443.h b/arch/arm/plat-samsung/include/plat/s3c2443.h
index ffaecb9..a5b794f 100644
--- a/arch/arm/plat-samsung/include/plat/s3c2443.h
+++ b/arch/arm/plat-samsung/include/plat/s3c2443.h
@@ -32,22 +32,3 @@ extern void s3c2443_restart(char mode, const char *cmd);
 #define s3c2443_init NULL
 #define s3c2443_restart NULL
 #endif
-
-/* common code used by s3c2443 and others.
- * note, not to be used outside of arch/arm/mach-s3c* */
-
-struct clk;	/* some files don't need clk.h otherwise */
-
-typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
-
-extern void s3c2443_common_setup_clocks(pll_fn get_mpll);
-extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-				       unsigned int *divs, int nr_divs,
-				       int divmask);
-
-extern int s3c2443_clkcon_enable_h(struct clk *clk, int enable);
-extern int s3c2443_clkcon_enable_p(struct clk *clk, int enable);
-extern int s3c2443_clkcon_enable_s(struct clk *clk, int enable);
-
-extern struct clksrc_clk clk_epllref;
-extern struct clksrc_clk clk_esysclk;
-- 
1.7.5.4
