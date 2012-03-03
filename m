From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sat, 3 Mar 2012 22:18:24 +0100
Subject: [PATCH 4/4] ARM: S3C24XX: remove call to s3c24xx_setup_clocks
In-Reply-To: <201203032214.36820.heiko@sntech.de>
References: <201203032214.36820.heiko@sntech.de>
Message-ID: <201203032218.24421.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the clocks can calculate their rate themself now, there is no
need to set it statically.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common-s3c2443.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index 6f3bcad..4604315 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -571,9 +571,6 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 	struct clk *xtal_clk;
 	unsigned long xtal;
 	unsigned long pll;
-	unsigned long fclk;
-	unsigned long hclk;
-	unsigned long pclk;
 	int ptr;
 
 	xtal_clk = clk_get(NULL, "xtal");
@@ -582,17 +579,13 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 
 	pll = get_mpll(mpllcon, xtal);
 	clk_msysclk.clk.rate = pll;
-
-	fclk = clk_get_rate(&clk_armdiv);
-	hclk = clk_get_rate(&clk_h);
-	pclk = clk_get_rate(&clk_p);
-
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
+	clk_mpll.rate = pll;
 
 	printk("CPU: MPLL %s %ld.%03ld MHz, cpu %ld.%03ld MHz, mem %ld.%03ld MHz, pclk %ld.%03ld MHz\n",
 	       (mpllcon & S3C2443_PLLCON_OFF) ? "off" : "on",
-	       print_mhz(pll), print_mhz(fclk),
-	       print_mhz(hclk), print_mhz(pclk));
+	       print_mhz(pll), print_mhz(clk_get_rate(&clk_armdiv)),
+	       print_mhz(clk_get_rate(&clk_h)),
+	       print_mhz(clk_get_rate(&clk_p)));
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
 		s3c_set_clksrc(&clksrc_clks[ptr], true);
-- 
1.7.2.3
