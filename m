From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 29 Aug 2017 15:58:37 +0800
Subject: [PATCH 1/2] clk: hi6220: change watchdog clock source
Message-ID: <1503993518-24428-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old code uses tcxo (19.2MHz) as watchdog clock but actually the
watchdog uses 32K clock, as result the watchdog timeout cannot be set
correctly and delay long time to reset SoC.

So this patch is to use 'ref32k' as clock source for watchdog.

Fixes: 72ea48610d43 ("clk: hi6220: Clock driver support for Hisilicon hi6220 SoC")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/clk/hisilicon/clk-hi6220.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index 4181b68..e786d71 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -55,9 +55,9 @@ static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
 };
 
 static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
-	{ HI6220_WDT0_PCLK,   "wdt0_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 12, 0, },
-	{ HI6220_WDT1_PCLK,   "wdt1_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 13, 0, },
-	{ HI6220_WDT2_PCLK,   "wdt2_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 14, 0, },
+	{ HI6220_WDT0_PCLK,   "wdt0_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 12, 0, },
+	{ HI6220_WDT1_PCLK,   "wdt1_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 13, 0, },
+	{ HI6220_WDT2_PCLK,   "wdt2_pclk",   "ref32k",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 14, 0, },
 	{ HI6220_TIMER0_PCLK, "timer0_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 15, 0, },
 	{ HI6220_TIMER1_PCLK, "timer1_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 16, 0, },
 	{ HI6220_TIMER2_PCLK, "timer2_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 17, 0, },
-- 
2.7.4
