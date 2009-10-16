From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:43 -0700
Subject: [PATCH 39/46] davinci: DA8xx: rename 'psc_ctlr' field into 'gpsc'
In-Reply-To: <1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
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
	<1255720190-7452-16-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-17-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-18-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-19-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-20-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-21-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-22-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-23-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-24-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-25-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-26-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-27-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-28-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-29-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-30-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-31-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-32-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-33-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-34-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-35-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-36-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-37-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-38-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-39-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-40-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-41-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Replace badly chosen 'psc_ctlr' name of the 'struct clk' field (PSC already
means "Power and Sleep Controller", so the '_ctlr' postfix makes the name
tautological) with technically correct 'gpsc' (Global PSC -- which contains
all the module registers).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   10 +++-----
 arch/arm/mach-davinci/clock.h |    2 +-
 arch/arm/mach-davinci/da830.c |   42 ++++++++++++++++++++--------------------
 arch/arm/mach-davinci/da850.c |   20 +++++++++---------
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 12ceeea..c882371 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -43,8 +43,7 @@ static void __clk_enable(struct clk *clk)
 	if (clk->parent)
 		__clk_enable(clk->parent);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
-		davinci_psc_config(psc_domain(clk), clk->psc_ctlr,
-				clk->lpsc, 1);
+		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 1);
 }
 
 static void __clk_disable(struct clk *clk)
@@ -52,8 +51,7 @@ static void __clk_disable(struct clk *clk)
 	if (WARN_ON(clk->usecount == 0))
 		return;
 	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL))
-		davinci_psc_config(psc_domain(clk), clk->psc_ctlr,
-				clk->lpsc, 0);
+		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc, 0);
 	if (clk->parent)
 		__clk_disable(clk->parent);
 }
@@ -226,11 +224,11 @@ static int __init clk_disable_unused(void)
 			continue;
 
 		/* ignore if in Disabled or SwRstDisable states */
-		if (!davinci_psc_is_clk_active(ck->psc_ctlr, ck->lpsc))
+		if (!davinci_psc_is_clk_active(ck->gpsc, ck->lpsc))
 			continue;
 
 		pr_info("Clocks: disable unused %s\n", ck->name);
-		davinci_psc_config(psc_domain(ck), ck->psc_ctlr, ck->lpsc, 0);
+		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc, 0);
 	}
 	spin_unlock_irq(&clockfw_lock);
 
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index d45dc69..c92d77a 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -70,7 +70,7 @@ struct clk {
 	unsigned long		rate;
 	u8			usecount;
 	u8			lpsc;
-	u8			psc_ctlr;
+	u8			gpsc;
 	u32			flags;
 	struct clk              *parent;
 	struct list_head	children; 	/* list of children */
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a2f2bdc..215d2ec 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -193,14 +193,14 @@ static struct clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART1,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk uart2_clk = {
 	.name		= "uart2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART2,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk spi0_clk = {
@@ -213,98 +213,98 @@ static struct clk spi1_clk = {
 	.name		= "spi1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_SPI1,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk ecap0_clk = {
 	.name		= "ecap0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk ecap1_clk = {
 	.name		= "ecap1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk ecap2_clk = {
 	.name		= "ecap2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_ECAP,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk pwm0_clk = {
 	.name		= "pwm0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk pwm1_clk = {
 	.name		= "pwm1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk pwm2_clk = {
 	.name		= "pwm2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_PWM,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk eqep0_clk = {
 	.name		= "eqep0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_EQEP,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk eqep1_clk = {
 	.name		= "eqep1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_EQEP,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_LCDC,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk mcasp0_clk = {
 	.name		= "mcasp0",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_McASP0,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk mcasp1_clk = {
 	.name		= "mcasp1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_McASP1,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk mcasp2_clk = {
 	.name		= "mcasp2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA830_LPSC1_McASP2,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk usb20_clk = {
 	.name		= "usb20",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_USB20,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk aemif_clk = {
@@ -332,36 +332,36 @@ static struct clk emac_clk = {
 	.name		= "emac",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_CPGMAC,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk gpio_clk = {
 	.name		= "gpio",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_GPIO,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk i2c1_clk = {
 	.name		= "i2c1",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_I2C,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk usb11_clk = {
 	.name		= "usb11",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_USB11,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk emif3_clk = {
 	.name		= "emif3",
 	.parent		= &pll0_sysclk5,
 	.lpsc		= DA8XX_LPSC1_EMIF3C,
+	.gpsc		= 1,
 	.flags		= ALWAYS_ENABLED,
-	.psc_ctlr	= 1,
 };
 
 static struct clk arm_clk = {
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 0e1027e..1d6d8b4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -224,16 +224,16 @@ static struct clk tpcc1_clk = {
 	.name		= "tpcc1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_TPCC1,
+	.gpsc		= 1,
 	.flags		= CLK_PSC | ALWAYS_ENABLED,
-	.psc_ctlr	= 1,
 };
 
 static struct clk tptc2_clk = {
 	.name		= "tptc2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA850_LPSC1_TPTC2,
+	.gpsc		= 1,
 	.flags		= ALWAYS_ENABLED,
-	.psc_ctlr	= 1,
 };
 
 static struct clk uart0_clk = {
@@ -246,16 +246,16 @@ static struct clk uart1_clk = {
 	.name		= "uart1",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART1,
+	.gpsc		= 1,
 	.flags		= DA850_CLK_ASYNC3,
-	.psc_ctlr	= 1,
 };
 
 static struct clk uart2_clk = {
 	.name		= "uart2",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_UART2,
+	.gpsc		= 1,
 	.flags		= DA850_CLK_ASYNC3,
-	.psc_ctlr	= 1,
 };
 
 static struct clk aintc_clk = {
@@ -269,22 +269,22 @@ static struct clk gpio_clk = {
 	.name		= "gpio",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_GPIO,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk i2c1_clk = {
 	.name		= "i2c1",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_I2C,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk emif3_clk = {
 	.name		= "emif3",
 	.parent		= &pll0_sysclk5,
 	.lpsc		= DA8XX_LPSC1_EMIF3C,
+	.gpsc		= 1,
 	.flags		= ALWAYS_ENABLED,
-	.psc_ctlr	= 1,
 };
 
 static struct clk arm_clk = {
@@ -305,21 +305,21 @@ static struct clk emac_clk = {
 	.name		= "emac",
 	.parent		= &pll0_sysclk4,
 	.lpsc		= DA8XX_LPSC1_CPGMAC,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk mcasp_clk = {
 	.name		= "mcasp",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_McASP0,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk lcdc_clk = {
 	.name		= "lcdc",
 	.parent		= &pll0_sysclk2,
 	.lpsc		= DA8XX_LPSC1_LCDC,
-	.psc_ctlr	= 1,
+	.gpsc		= 1,
 };
 
 static struct clk mmcsd_clk = {
-- 
1.6.4.3
