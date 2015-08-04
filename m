From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  4 Aug 2015 14:45:32 +0000
Subject: [PATCH 7/7] clk: atlas7: fix pll missed divide NR in fraction mode
In-Reply-To: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
References: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438699532-13860-8-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <guo.zeng@csr.com>

PLL VCO frequency is given by Fvco = Fref * 2 * NF / NR
in integer-N mode, or by Fvco = Fref * SSN / NR in Spread
Spectrum (fractional-N) mode. Thus fix the missing part
of NR

Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index 4fc33da..19f417c 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -358,6 +358,7 @@ static unsigned long pll_clk_recalc_rate(struct clk_hw *hw,
 	if (regctrl0 & SIRFSOC_ABPLL_CTRL0_SSEN) {
 		rate = fin;
 		rate *= 1 << 24;
+		do_div(rate, nr);
 		do_div(rate, (256 * ((ssdiv >> ssdepth) << ssdepth)
 			+ (ssmod << ssdepth)));
 	} else {
-- 
1.9.1
