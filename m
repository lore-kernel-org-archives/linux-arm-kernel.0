From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:18 -0700
Subject: [PATCH 14/46] davinci: DA850/OMAP-L138: allow async3 source to be
	changed
In-Reply-To: <1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-5-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-6-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-7-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-8-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-9-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-10-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-11-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-12-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-13-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-14-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-15-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The patch allows Async3 clock source to be selected between PLL1 SYSCLK2
and PLL0 SYSCLK2.

Having Async3 source from PLL1 SYSCLK2 allows peripherals on that
domain to remain unaffected by frequency scaling on PLL0.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.h              |    4 +-
 arch/arm/mach-davinci/da850.c              |   40 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    1 +
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index a75d3f7..d45dc69 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -69,9 +69,9 @@ struct clk {
 	const char		*name;
 	unsigned long		rate;
 	u8			usecount;
-	u8			flags;
 	u8			lpsc;
 	u8			psc_ctlr;
+	u32			flags;
 	struct clk              *parent;
 	struct list_head	children; 	/* list of children */
 	struct list_head	childnode;	/* parent's child list node */
@@ -82,7 +82,7 @@ struct clk {
 	int (*round_rate) (struct clk *clk, unsigned long rate);
 };
 
-/* Clock flags */
+/* Clock flags: SoC-specific flags start at BIT(16) */
 #define ALWAYS_ENABLED		BIT(1)
 #define CLK_PSC                 BIT(2)
 #define PSC_DSP                 BIT(3) /* PSC uses DSP domain, not ARM */
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index f5c3a6a..575e9cc 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -30,12 +30,17 @@
 #include "clock.h"
 #include "mux.h"
 
+/* SoC specific clock flags */
+#define DA850_CLK_ASYNC3	BIT(16)
+
 #define DA850_PLL1_BASE		0x01e1a000
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
 
 #define DA850_REF_FREQ		24000000
 
+#define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
+
 static struct pll_data pll0_data = {
 	.num		= 1,
 	.phys_base	= DA8XX_PLL0_BASE,
@@ -232,6 +237,7 @@ static struct clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART1,
+	.flags		= DA850_CLK_ASYNC3,
 	.psc_ctlr	= 1,
 };
 
@@ -239,6 +245,7 @@ static struct clk uart2_clk = {
 	.name		= "uart2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART2,
+	.flags		= DA850_CLK_ASYNC3,
 	.psc_ctlr	= 1,
 };
 
@@ -790,6 +797,30 @@ static struct davinci_timer_info da850_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
+static void da850_set_async3_src(int pllnum)
+{
+	struct clk *clk, *newparent = pllnum ? &pll1_sysclk2 : &pll0_sysclk2;
+	struct davinci_clk *c;
+	unsigned int v;
+	int ret;
+
+	for (c = da850_clks; c->lk.clk; c++) {
+		clk = c->lk.clk;
+		if (clk->flags & DA850_CLK_ASYNC3) {
+			ret = clk_set_parent(clk, newparent);
+			WARN(ret, "DA850: unable to re-parent clock %s",
+								clk->name);
+		}
+       }
+
+	v = __raw_readl(DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG));
+	if (pllnum)
+		v |= CFGCHIP3_ASYNC3_CLKSRC;
+	else
+		v &= ~CFGCHIP3_ASYNC3_CLKSRC;
+	__raw_writel(v, DA8XX_SYSCFG_VIRT(DA8XX_CFGCHIP3_REG));
+}
+
 static struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
@@ -823,4 +854,13 @@ void __init da850_init(void)
 	davinci_soc_info_da850.pinmux_base = DA8XX_SYSCFG_VIRT(0x120);
 
 	davinci_common_init(&davinci_soc_info_da850);
+
+	/*
+	 * Move the clock source of Async3 domain to PLL1 SYSCLK2.
+	 * This helps keeping the peripherals on this domain insulated
+	 * from CPU frequency changes caused by DVFS. The firmware sets
+	 * both PLL0 and PLL1 to the same frequency so, there should not
+	 * be any noticible change even in non-DVFS use cases.
+	 */
+	da850_set_async3_src(1);
 }
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 6f03650..ec2821b 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -34,6 +34,7 @@ extern void __iomem *da8xx_syscfg_base;
 #define DA8XX_SYSCFG_BASE	(IO_PHYS + 0x14000)
 #define DA8XX_SYSCFG_VIRT(x)	(da8xx_syscfg_base + (x))
 #define DA8XX_JTAG_ID_REG	0x18
+#define DA8XX_CFGCHIP3_REG	0x188
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
-- 
1.6.4.3
