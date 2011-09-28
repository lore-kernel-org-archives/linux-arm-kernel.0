From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 28 Sep 2011 12:19:32 +0200
Subject: [PATCH 2/8] S3C2443: Add infrastructure to transmit armdiv to common
	code
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <201109281219.32988.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed for making the armdiv clock common to S3C2443 and
S3C2416/2450.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c2416/clock.c                |    4 +++-
 arch/arm/mach-s3c2443/clock.c                |    4 +++-
 arch/arm/plat-s3c24xx/include/plat/s3c2443.h |    4 +++-
 arch/arm/plat-s3c24xx/s3c2443-clock.c        |   12 +++++++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 5569def..3060796 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -158,7 +158,9 @@ void __init s3c2416_init_clocks(int xtal)
 
 	clk_epll.parent = &clk_epllref.clk;
 
-	s3c2443_common_init_clocks(xtal, s3c2416_get_pll, s3c2416_fclk_div);
+	s3c2443_common_init_clocks(xtal, s3c2416_get_pll, s3c2416_fclk_div,
+				   armdiv, ARRAY_SIZE(armdiv),
+				   S3C2416_CLKDIV0_ARMDIV_MASK);
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index cd51d04..88edc55 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -283,7 +283,9 @@ void __init s3c2443_init_clocks(int xtal)
 	clk_epll.rate = s3c2443_get_epll(epllcon, xtal);
 	clk_epll.parent = &clk_epllref.clk;
 
-	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll, s3c2443_fclk_div);
+	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll, s3c2443_fclk_div,
+				   armdiv, ARRAY_SIZE(armdiv),
+				   S3C2443_CLKDIV0_ARMDIV_MASK);
 
 	s3c2443_setup_clocks();
 
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
index a19715f..7b824cb 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
@@ -40,7 +40,9 @@ typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
 typedef unsigned int (*fdiv_fn)(unsigned long clkcon0);
 
 extern void s3c2443_common_setup_clocks(pll_fn get_mpll, fdiv_fn fdiv);
-extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll, fdiv_fn fdiv);
+extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll, fdiv_fn fdiv,
+				       unsigned int *divs, int nr_divs,
+				       int divmask);
 
 extern int s3c2443_clkcon_enable_h(struct clk *clk, int enable);
 extern int s3c2443_clkcon_enable_p(struct clk *clk, int enable);
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 07a4c81..3f2117b 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -160,6 +160,10 @@ static struct clk clk_prediv = {
 	},
 };
 
+static unsigned int *armdiv;
+static int nr_armdiv;
+static int armdivmask;
+
 /* usbhost
  *
  * usb host bus-clock, usually 48MHz to provide USB bus clock timing
@@ -470,10 +474,16 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 };
 
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-				       fdiv_fn get_fdiv)
+				       fdiv_fn get_fdiv,
+				       unsigned int *divs, int nr_divs,
+				       int divmask)
 {
 	int ptr;
 
+	armdiv = divs;
+	nr_armdiv = nr_divs;
+	armdivmask = divmask;
+
 	/* s3c2443 parents h and p clocks from prediv */
 	clk_h.parent = &clk_prediv;
 	clk_p.parent = &clk_prediv;
-- 
1.7.5.4
