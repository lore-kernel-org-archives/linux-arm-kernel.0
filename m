From: paulius.zaleckas@gmail.com (Paulius Zaleckas)
Date: Tue, 12 Oct 2010 22:40:21 +0300
Subject: [PATCH RFC/RFT] ARM: S5P: Fix USB and 48M clock enable procedure
Message-ID: <20101012194021.11514.12704.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---

 arch/arm/mach-s5p6440/clock.c              |   23 -------
 arch/arm/plat-s5p/clock.c                  |   86 ++++++++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/s5p-clock.h |    1 
 3 files changed, 86 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index ca6e48d..5a5b245 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -295,27 +295,6 @@ static struct clksrc_clk clk_pclk_low = {
 	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
 };
 
-int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
-{
-	unsigned long flags;
-	u32 val;
-
-	/* can't rely on clock lock, this register has other usages */
-	local_irq_save(flags);
-
-	val = __raw_readl(S5P_OTHERS);
-	if (enable)
-		val |= S5P_OTHERS_USB_SIG_MASK;
-	else
-		val &= ~S5P_OTHERS_USB_SIG_MASK;
-
-	__raw_writel(val, S5P_OTHERS);
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
 static int s5p6440_pclk_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLK_GATE_PCLK, clk, enable);
@@ -769,8 +748,6 @@ void __init_or_cpufreq s5p6440_setup_clocks(void)
 	clk_fout_epll.enable = s5p6440_epll_enable;
 	clk_fout_epll.ops = &s5p6440_epll_ops;
 
-	clk_48m.enable = s5p6440_clk48m_ctrl;
-
 	xtal_clk = clk_get(NULL, "ext_xtal");
 	BUG_ON(IS_ERR(xtal_clk));
 
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index b5e2552..337ced6 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -19,11 +19,16 @@
 #include <linux/clk.h>
 #include <linux/sysdev.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 #include <asm/div64.h>
 
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/s5p-clock.h>
+#include <plat/regs-usb-hsotg-phy.h>
 
 /* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
  * clk_ext_xtal_mux.
@@ -33,9 +38,89 @@ struct clk clk_ext_xtal_mux = {
 	.id		= -1,
 };
 
+#ifdef S3C_VA_USB_HSPHY
+void __init s5p_clk_xusbxti_is_osc(int is_osc)
+{
+	u32 val;
+
+	/* no need to protect since it will be called from machine init */
+	val = __raw_readl(S3C_PHYCLK);
+	if (is_osc)
+		val |= S3C_PHYCLK_EXT_OSC;
+	else
+		val &= ~S3C_PHYCLK_EXT_OSC;
+	__raw_writel(val, S3C_PHYCLK);
+}
+
+static int clk_xusbxti_ctrl(struct clk *clk, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	/* can't rely on clock lock, this register has other usages */
+	local_irq_save(flags);
+
+#if defined(S5P_OTHERS) && defined(S5P_OTHERS_USB_SIG_MASK)
+	val = __raw_readl(S5P_OTHERS);
+	if (enable)
+		val |= S5P_OTHERS_USB_SIG_MASK;
+	else
+		val &= ~S5P_OTHERS_USB_SIG_MASK;
+
+	__raw_writel(val, S5P_OTHERS);
+#endif
+
+	val = __raw_readl(S3C_PHYPWR);
+	if (enable)
+		val &= ~(SRC_PHYPWR_OTG_DISABLE | SRC_PHYPWR_ANALOG_POWERDOWN |
+			 SRC_PHYPWR_FORCE_SUSPEND);
+	else
+		val |= (SRC_PHYPWR_OTG_DISABLE | SRC_PHYPWR_ANALOG_POWERDOWN |
+			SRC_PHYPWR_FORCE_SUSPEND);
+	__raw_writel(val, S3C_PHYPWR);
+	mdelay(1);
+
+	if (enable) {
+		val = __raw_readl(S3C_PHYCLK);
+
+		val &= ~S3C_PHYCLK_CLKSEL_MASK;
+
+		switch (clk->rate) {
+		case 12000000:
+			val |= S3C_PHYCLK_CLKSEL_12M;
+			break;
+		case 24000000:
+			val |= S3C_PHYCLK_CLKSEL_24M;
+			break;
+		default:
+			pr_err("Invalid USB PHY external clock frequency: %lu\n",
+			       clk->rate);
+		case 48000000:
+			/* default reference clock */
+			break;
+		}
+
+		__raw_writel(val | S3C_PHYCLK_CLK_FORCE, S3C_PHYCLK);
+
+		/* issue a full set of resets to the otg and core */
+		__raw_writel(S3C_RSTCON_PHY, S3C_RSTCON);
+		udelay(20);	/* at-least 10uS */
+		__raw_writel(0, S3C_RSTCON);
+	}
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+#else
+#define clk_xusbxti_ctrl NULL
+#endif /* S3C_VA_USB_HSPHY */
+
 struct clk clk_xusbxti = {
 	.name		= "xusbxti",
 	.id		= -1,
+	.rate		= 48000000,
+	.enable		= clk_xusbxti_ctrl,
 };
 
 struct clk s5p_clk_27m = {
@@ -49,6 +134,7 @@ struct clk clk_48m = {
 	.name		= "clk_48m",
 	.id		= -1,
 	.rate		= 48000000,
+	.parent		= &clk_xusbxti,
 };
 
 /* APLL clock output
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index 09418b1..1c9266d 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -38,7 +38,6 @@ extern struct clksrc_sources clk_src_apll;
 extern struct clksrc_sources clk_src_mpll;
 extern struct clksrc_sources clk_src_epll;
 
-extern int s5p6440_clk48m_ctrl(struct clk *clk, int enable);
 extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
 
 #endif /* __ASM_PLAT_S5P_CLOCK_H */
