From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 16 May 2012 12:50:20 +0200
Subject: [PATCH 3/4] ARM i.MX: remove now unnecessary argument from
 mxc_timer_init
In-Reply-To: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
References: <1337165421-17118-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1337165421-17118-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the timer code now does a clk_get to get its clock we don't
need the struct clk argument anymore.
This also changes the alternative EPIT timer to do a clk_get.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx1.c            |    3 +--
 arch/arm/mach-imx/clk-imx21.c           |    4 ++--
 arch/arm/mach-imx/clk-imx25.c           |    2 +-
 arch/arm/mach-imx/clk-imx27.c           |    3 +--
 arch/arm/mach-imx/clk-imx31.c           |    3 +--
 arch/arm/mach-imx/clk-imx35.c           |    6 ++----
 arch/arm/mach-imx/clk-imx51-imx53.c     |    6 ++----
 arch/arm/mach-imx/clk-imx6q.c           |    2 +-
 arch/arm/plat-mxc/epit.c                |   11 ++++++++++-
 arch/arm/plat-mxc/include/mach/common.h |    4 ++--
 arch/arm/plat-mxc/time.c                |   21 ++++++++++-----------
 11 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 0f0beb5..516ddee 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -108,8 +108,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[clk32], NULL, "mxc_rtc.0");
 	clk_register_clkdev(clk[clko], "clko", NULL);
 
-	mxc_timer_init(NULL, MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR),
-			MX1_TIM1_INT);
+	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index 4e4f384..ea13e61 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -180,7 +180,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[sdhc1_ipg_gate], "sdhc1", NULL);
 	clk_register_clkdev(clk[sdhc2_ipg_gate], "sdhc2", NULL);
 
-	mxc_timer_init(NULL, MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR),
-			MX21_INT_GPT1);
+	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1);
+
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index d9833bb..fdd8cc8 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -243,6 +243,6 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[sdma_ahb], "ahb", "imx35-sdma");
 	clk_register_clkdev(clk[iim_ipg], "iim", NULL);
 
-	mxc_timer_init(NULL, MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
+	mxc_timer_init(MX25_IO_ADDRESS(MX25_GPT1_BASE_ADDR), 54);
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index 50a7ebd..295cbd7 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -263,8 +263,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[ssi1_baud_gate], "bitrate" , "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_baud_gate], "bitrate" , "imx-ssi.1");
 
-	mxc_timer_init(NULL, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
-			MX27_INT_GPT1);
+	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
 
 	clk_prepare_enable(clk[emi_ahb_gate]);
 
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index a854b9c..c9a06d8 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -175,8 +175,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
-	mxc_timer_init(NULL, MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR),
-			MX31_INT_GPT);
+	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index a9e60bf..920a8cc 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -267,11 +267,9 @@ int __init mx35_clocks_init()
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 
 #ifdef CONFIG_MXC_USE_EPIT
-	epit_timer_init(&epit1_clk,
-			MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
+	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
 #else
-	mxc_timer_init(NULL, MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR),
-			MX35_INT_GPT);
+	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 1e7828d..c1739f6 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -329,8 +329,7 @@ int __init mx51_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(clk[esdhc_b_podf], 166250000);
 
 	/* System timer */
-	mxc_timer_init(NULL, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
-		MX51_INT_GPT);
+	mxc_timer_init(MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR), MX51_INT_GPT);
 
 	clk_prepare_enable(clk[iim_gate]);
 	imx_print_silicon_rev("i.MX51", mx51_revision());
@@ -412,8 +411,7 @@ int __init mx53_clocks_init(unsigned long rate_ckil, unsigned long rate_osc,
 	clk_set_rate(clk[esdhc_b_podf], 200000000);
 
 	/* System timer */
-	mxc_timer_init(NULL, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
-		MX53_INT_GPT);
+	mxc_timer_init(MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR), MX53_INT_GPT);
 
 	clk_prepare_enable(clk[iim_gate]);
 	imx_print_silicon_rev("i.MX53", mx53_revision());
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index f40a35d..24324f2 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -433,7 +433,7 @@ int __init mx6q_clocks_init(void)
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
 	irq = irq_of_parse_and_map(np, 0);
-	mxc_timer_init(NULL, base, irq);
+	mxc_timer_init(base, irq);
 
 	return 0;
 }
diff --git a/arch/arm/plat-mxc/epit.c b/arch/arm/plat-mxc/epit.c
index 9129c9e..88726f4 100644
--- a/arch/arm/plat-mxc/epit.c
+++ b/arch/arm/plat-mxc/epit.c
@@ -50,6 +50,7 @@
 #include <linux/irq.h>
 #include <linux/clockchips.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/time.h>
@@ -201,8 +202,16 @@ static int __init epit_clockevent_init(struct clk *timer_clk)
 	return 0;
 }
 
-void __init epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
+void __init epit_timer_init(void __iomem *base, int irq)
 {
+	struct clk *timer_clk;
+
+	timer_clk = clk_get_sys("imx-epit.0", NULL);
+	if (IS_ERR(timer_clk)) {
+		pr_err("i.MX epit: unable to get clk\n");
+		return;
+	}
+
 	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 0319c4a..da02540 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -53,8 +53,8 @@ extern void imx35_soc_init(void);
 extern void imx50_soc_init(void);
 extern void imx51_soc_init(void);
 extern void imx53_soc_init(void);
-extern void epit_timer_init(struct clk *timer_clk, void __iomem *base, int irq);
-extern void mxc_timer_init(struct clk *timer_clk, void __iomem *, int);
+extern void epit_timer_init(void __iomem *base, int irq);
+extern void mxc_timer_init(void __iomem *, int);
 extern int mx1_clocks_init(unsigned long fref);
 extern int mx21_clocks_init(unsigned long lref, unsigned long fref);
 extern int mx25_clocks_init(void);
diff --git a/arch/arm/plat-mxc/time.c b/arch/arm/plat-mxc/time.c
index d865f79..00e8e65 100644
--- a/arch/arm/plat-mxc/time.c
+++ b/arch/arm/plat-mxc/time.c
@@ -281,23 +281,22 @@ static int __init mxc_clockevent_init(struct clk *timer_clk)
 	return 0;
 }
 
-void __init mxc_timer_init(struct clk *timer_clk, void __iomem *base, int irq)
+void __init mxc_timer_init(void __iomem *base, int irq)
 {
 	uint32_t tctl_val;
+	struct clk *timer_clk;
 	struct clk *timer_ipg_clk;
 
-	if (!timer_clk) {
-		timer_clk = clk_get_sys("imx-gpt.0", "per");
-		if (IS_ERR(timer_clk)) {
-			pr_err("i.MX timer: unable to get clk\n");
-			return;
-		}
-
-		timer_ipg_clk = clk_get_sys("imx-gpt.0", "ipg");
-		if (!IS_ERR(timer_ipg_clk))
-			clk_prepare_enable(timer_ipg_clk);
+	timer_clk = clk_get_sys("imx-gpt.0", "per");
+	if (IS_ERR(timer_clk)) {
+		pr_err("i.MX timer: unable to get clk\n");
+		return;
 	}
 
+	timer_ipg_clk = clk_get_sys("imx-gpt.0", "ipg");
+	if (!IS_ERR(timer_ipg_clk))
+		clk_prepare_enable(timer_ipg_clk);
+
 	clk_prepare_enable(timer_clk);
 
 	timer_base = base;
-- 
1.7.10
