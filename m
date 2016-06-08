From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 8 Jun 2016 22:33:31 +0800
Subject: [PATCH 02/11] clk: imx: correct AV PLL rate formula
In-Reply-To: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1465396420-27064-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anson Huang <b20788@freescale.com>

The audio/video PLL's rate calculation is as below in RM:

Fref * (DIV_SELECT + NUM / DENOM), in origin clk-pllv3's
code, below code is used:

(parent_rate * div) + ((parent_rate / mfd) * mfn

as it does NOT consider the float data using div, so below
formula should be used as a decent method:

(parent_rate * div) + ((parent_rate * mfn) / mfd)

and we also need to consider parent_rate * mfd may overflow
a 32 bit value, 64 bit value should be used.

After updating this formula, the dram PLL's rate is
1066MHz, which is correct, while the old formula gets
1056MHz.

[Aisheng: fix clk_pllv3_av_round_rate too]

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-pllv3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 44d294a336f0..eea2b1b3791e 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -218,8 +218,12 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
 	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
 	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
 	u32 div = readl_relaxed(pll->base) & pll->div_mask;
+	u64 temp64 = (u64)parent_rate;
 
-	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
+	temp64 *= mfn;
+	do_div(temp64, mfd);
+
+	return (parent_rate * div) + (u32)temp64;
 }
 
 static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -243,7 +247,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	do_div(temp64, parent_rate);
 	mfn = temp64;
 
-	return parent_rate * div + parent_rate / mfd * mfn;
+	return parent_rate * div + parent_rate * mfn / mfd;
 }
 
 static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
1.9.1
