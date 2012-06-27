From: stigge@antcom.de (Roland Stigge)
Date: Thu, 28 Jun 2012 00:26:13 +0200
Subject: [PATCH 3/8] ARM: LPC32xx: Remove wrong re-initialization of MMC clock
 register
In-Reply-To: <1340835978-20331-1-git-send-email-stigge@antcom.de>
References: <1340835978-20331-1-git-send-email-stigge@antcom.de>
Message-ID: <1340835978-20331-4-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bug, (wrongfully) resetting the value of
LPC32XX_CLKPWR_MS_CTRL back to its initial contents (after careful setup). This
was discovered only with a board/bootloader combination (EA3250) where the
contents of the respective register wasn't already at the correct value on
Linux boot.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

---
 arch/arm/mach-lpc32xx/clock.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -871,7 +871,7 @@ static unsigned long mmc_round_rate(stru
 
 static int mmc_set_rate(struct clk *clk, unsigned long rate)
 {
-	u32 oldclk, tmp;
+	u32 tmp;
 	unsigned long prate, div, crate = mmc_round_rate(clk, rate);
 
 	prate = clk->parent->get_rate(clk->parent);
@@ -879,16 +879,12 @@ static int mmc_set_rate(struct clk *clk,
 	div = prate / crate;
 
 	/* The MMC clock must be on when accessing an MMC register */
-	oldclk = __raw_readl(LPC32XX_CLKPWR_MS_CTRL);
-	__raw_writel(oldclk | LPC32XX_CLKPWR_MSCARD_SDCARD_EN,
-		LPC32XX_CLKPWR_MS_CTRL);
 	tmp = __raw_readl(LPC32XX_CLKPWR_MS_CTRL) &
 		~LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(0xf);
-	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(div);
+	tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(div) |
+		LPC32XX_CLKPWR_MSCARD_SDCARD_EN;
 	__raw_writel(tmp, LPC32XX_CLKPWR_MS_CTRL);
 
-	__raw_writel(oldclk, LPC32XX_CLKPWR_MS_CTRL);
-
 	return 0;
 }
 
