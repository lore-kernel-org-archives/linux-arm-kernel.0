From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 17 Sep 2010 11:54:29 +0200
Subject: [PATCH 11/16] ARM: mx5/clock-mx51: refactor ccgr callbacks to use
	common code
In-Reply-To: <20100917095247.GB30441@pengutronix.de>
References: <20100917095247.GB30441@pengutronix.de>
Message-ID: <1284717274-12850-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/clock-mx51.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 57c10a9..fe658bf 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -41,34 +41,36 @@ static struct clk usboh3_clk;
 
 #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
 
-static int _clk_ccgr_enable(struct clk *clk)
+static void _clk_ccgr_setclk(struct clk *clk, unsigned mode)
 {
-	u32 reg;
+	u32 reg = __raw_readl(clk->enable_reg);
+
+	reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
+	reg |= mode << clk->enable_shift;
 
-	reg = __raw_readl(clk->enable_reg);
-	reg |= MXC_CCM_CCGRx_MOD_ON << clk->enable_shift;
 	__raw_writel(reg, clk->enable_reg);
+}
 
+static int _clk_ccgr_enable(struct clk *clk)
+{
+	_clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_ON);
 	return 0;
 }
 
 static void _clk_ccgr_disable(struct clk *clk)
 {
-	u32 reg;
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
+	_clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_OFF);
+}
 
+static int _clk_ccgr_enable_inrun(struct clk *clk)
+{
+	_clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_IDLE);
+	return 0;
 }
 
 static void _clk_ccgr_disable_inwait(struct clk *clk)
 {
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
-	reg |= MXC_CCM_CCGRx_MOD_IDLE << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
+	_clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_IDLE);
 }
 
 /*
-- 
1.7.2.3
