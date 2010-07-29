From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Thu, 29 Jul 2010 09:04:13 -0700
Subject: [PATCH 6/7] ARM: LPC32xx: Remove MMC peripheral clock enable/disable
	code
In-Reply-To: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
References: <1280419454-1089-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1280419454-1089-7-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The MMC clock rate set and get functions had extra code to force
the high level peripheral clock to enable prior to register
accesses. This isn't needed.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 5c3ac73..e562d1b 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -738,14 +738,9 @@ static int mmc_onoff_enable(struct clk *clk, int enable)
 
 static unsigned long mmc_get_rate(struct clk *clk)
 {
-	u32 div, rate, oldclk;
+	u32 div, rate;
 
-	/* The MMC clock must be on when accessing an MMC register */
-	oldclk = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
-	__raw_writel(oldclk | LPC32XX_CLKPWR_MSCARD_SDCARD_EN,
-		LPC32XX_CLKPWR_MS_CTRL);
 	div = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
-	__raw_writel(oldclk, LPC32XX_CLKPWR_MS_CTRL);
 
 	/* Get the parent clock rate */
 	rate = clk->parent->get_rate(clk->parent);
@@ -778,7 +773,7 @@ static unsigned long mmc_round_rate(struct clk *clk, unsigned long rate)
 
 static int mmc_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 oldclk, tmp;
+	u32 tmp;
 	unsigned long prate, div, crate = mmc_round_rate(clk, rate);
 
 	prate = clk->parent->get_rate(clk->parent);
@@ -786,16 +781,11 @@ static int mmc_set_rate(struct clk *clk, unsigned long rate)
 	div = prate / crate;
 
 	/* The MMC clock must be on when accessing an MMC register */
-	oldclk = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
-	__raw_writel(oldclk | LPC32XX_CLKPWR_MSCARD_SDCARD_EN,
-		LPC32XX_CLKPWR_MS_CTRL);
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL) &
 		~LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(0xf);
 	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(div);
 	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
 
-	__raw_writel(oldclk, LPC32XX_CLKPWR_MS_CTRL);
-
 	return 0;
 }
 
-- 
1.7.1.1
