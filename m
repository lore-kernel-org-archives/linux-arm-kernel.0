From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 26 Apr 2015 22:31:02 +0800
Subject: [PATCH 01/11] ARM: imx: use dynamic mapping for timer
In-Reply-To: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
References: <1430058672-9267-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1430058672-9267-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass physical address of timer block to mxc_timer_init() call, which in
turn does dynamic mapping within the function.  Thus, we can avoid using
static mapping in clock drivers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx1.c  | 2 +-
 arch/arm/mach-imx/clk-imx21.c | 2 +-
 arch/arm/mach-imx/clk-imx27.c | 2 +-
 arch/arm/mach-imx/clk-imx31.c | 2 +-
 arch/arm/mach-imx/clk-imx35.c | 2 +-
 arch/arm/mach-imx/common.h    | 2 +-
 arch/arm/mach-imx/time.c      | 5 +++--
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx1.c b/arch/arm/mach-imx/clk-imx1.c
index 37c307a8d896..f4a76e841966 100644
--- a/arch/arm/mach-imx/clk-imx1.c
+++ b/arch/arm/mach-imx/clk-imx1.c
@@ -98,7 +98,7 @@ int __init mx1_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ipg", "imx1-fb.0");
 	clk_register_clkdev(clk[IMX1_CLK_DUMMY], "ahb", "imx1-fb.0");
 
-	mxc_timer_init(MX1_IO_ADDRESS(MX1_TIM1_BASE_ADDR), MX1_TIM1_INT);
+	mxc_timer_init(MX1_TIM1_BASE_ADDR, MX1_TIM1_INT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index 4b4c75339aa6..facdf1ddd7f1 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -153,7 +153,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[IMX21_CLK_I2C_GATE], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[IMX21_CLK_OWIRE_GATE], NULL, "mxc_w1.0");
 
-	mxc_timer_init(MX21_IO_ADDRESS(MX21_GPT1_BASE_ADDR), MX21_INT_GPT1);
+	mxc_timer_init(MX21_GPT1_BASE_ADDR, MX21_INT_GPT1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index ab6349ec23b9..aeb19982a36e 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -229,7 +229,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_AHB_GATE], "ahb", "m2m-emmaprp.0");
 	clk_register_clkdev(clk[IMX27_CLK_EMMA_IPG_GATE], "ipg", "m2m-emmaprp.0");
 
-	mxc_timer_init(MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR), MX27_INT_GPT1);
+	mxc_timer_init(MX27_GPT1_BASE_ADDR, MX27_INT_GPT1);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 286ef422cebc..8a103a2c8b68 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -182,7 +182,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	mx31_revision();
 	clk_disable_unprepare(clk[iim_gate]);
 
-	mxc_timer_init(MX31_IO_ADDRESS(MX31_GPT1_BASE_ADDR), MX31_INT_GPT);
+	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index a0d2b57fd376..4ef1e8bdac5b 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -279,7 +279,7 @@ int __init mx35_clocks_init(void)
 #ifdef CONFIG_MXC_USE_EPIT
 	epit_timer_init(MX35_IO_ADDRESS(MX35_EPIT1_BASE_ADDR), MX35_INT_EPIT1);
 #else
-	mxc_timer_init(MX35_IO_ADDRESS(MX35_GPT1_BASE_ADDR), MX35_INT_GPT);
+	mxc_timer_init(MX35_GPT1_BASE_ADDR, MX35_INT_GPT);
 #endif
 
 	return 0;
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 0f04e30b726d..5cddd1534265 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -44,7 +44,7 @@ void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
 void epit_timer_init(void __iomem *base, int irq);
-void mxc_timer_init(void __iomem *, int);
+void mxc_timer_init(unsigned long, int);
 int mx1_clocks_init(unsigned long fref);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 15d18e198303..acb1ff577cda 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -344,12 +344,13 @@ static void __init _mxc_timer_init(int irq,
 	setup_irq(irq, &mxc_timer_irq);
 }
 
-void __init mxc_timer_init(void __iomem *base, int irq)
+void __init mxc_timer_init(unsigned long pbase, int irq)
 {
 	struct clk *clk_per = clk_get_sys("imx-gpt.0", "per");
 	struct clk *clk_ipg = clk_get_sys("imx-gpt.0", "ipg");
 
-	timer_base = base;
+	timer_base = ioremap(pbase, SZ_4K);
+	BUG_ON(!timer_base);
 
 	_mxc_timer_init(irq, clk_per, clk_ipg);
 }
-- 
1.9.1
