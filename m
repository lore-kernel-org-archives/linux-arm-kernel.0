From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:04 +0200
Subject: [PATCH 01/48] clk: at91: replace usleep() by udelay() calls
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Fix the main and slow clock .prepare() implementations which used to call
usleep() when the scheduler wasn't ready yet.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-main.c | 2 +-
 drivers/clk/at91/clk-slow.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
index 58b5baca670c..12c5062aeb92 100644
--- a/drivers/clk/at91/clk-main.c
+++ b/drivers/clk/at91/clk-main.c
@@ -342,7 +342,7 @@ static int clk_main_probe_frequency(struct regmap *regmap)
 		regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
 		if (mcfr & AT91_PMC_MAINRDY)
 			return 0;
-		usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
+		udelay(MAINF_LOOP_MIN_WAIT);
 	} while (time_before(prep_time, timeout));
 
 	return -ETIMEDOUT;
diff --git a/drivers/clk/at91/clk-slow.c b/drivers/clk/at91/clk-slow.c
index 61090b1146cf..612e893ce994 100644
--- a/drivers/clk/at91/clk-slow.c
+++ b/drivers/clk/at91/clk-slow.c
@@ -76,7 +76,7 @@ static int clk_slow_osc_prepare(struct clk_hw *hw)
 
 	writel(tmp | AT91_SCKC_OSC32EN, sckcr);
 
-	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	udelay(osc->startup_usec);
 
 	return 0;
 }
@@ -195,7 +195,7 @@ static int clk_slow_rc_osc_prepare(struct clk_hw *hw)
 
 	writel(readl(sckcr) | AT91_SCKC_RCEN, sckcr);
 
-	usleep_range(osc->startup_usec, osc->startup_usec + 1);
+	udelay(osc->startup_usec);
 
 	return 0;
 }
@@ -304,7 +304,7 @@ static int clk_sam9x5_slow_set_parent(struct clk_hw *hw, u8 index)
 
 	writel(tmp, sckcr);
 
-	usleep_range(SLOWCK_SW_TIME_USEC, SLOWCK_SW_TIME_USEC + 1);
+	udelay(SLOWCK_SW_TIME_USEC);
 
 	return 0;
 }
-- 
2.8.1
