From: kever.yang@rock-chips.com (Kever Yang)
Date: Thu,  9 Oct 2014 22:23:57 -0700
Subject: [PATCH] clk: rockchip: change PLL setting for better clock jitter
Message-ID: <1412918637-9843-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dclk_vop0/1 is the source of HDMI TMDS clock in rk3288, usually we
use 594MHz for clock source of dclk_vop0/1.

HDMI CTS 7-9 require TMDS Clock jitter is lower than 0.25*Tbit:
TMDS clock(MHz)		CTS require jitter (ps)
	297		84.2
	148.5		168
	74.25		336
	27		1247

PLL BW and VCO frequency effects the jitter of PLL output clock,
clock jitter is better if BW is lower or VCO frequency is higher.

If PLL use default setting of RK3066_PLL_RATE( 594000000, 2, 198, 4),
the TMDS Clock jitter is higher than 250ps, which means we can't
pass the test when TMDS clock is 297MHz or 148.5MHz.

If we use RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),
the TMDS Clock jitter is about 60ps and we can pass all test case.

So we need this patch to make hdmi si test pass.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 drivers/clk/rockchip/clk-rk3288.c | 2 +-
 drivers/clk/rockchip/clk.h        | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 7c30a5a..11a7376a 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -83,7 +83,7 @@ struct rockchip_pll_rate_table rk3288_pll_rates[] = {
 	RK3066_PLL_RATE( 742500000, 8, 495, 2),
 	RK3066_PLL_RATE( 696000000, 1, 58, 2),
 	RK3066_PLL_RATE( 600000000, 1, 50, 2),
-	RK3066_PLL_RATE( 594000000, 2, 198, 4),
+	RK3066_PLL_RATE_BWADJ(594000000, 1, 198, 8, 1),
 	RK3066_PLL_RATE( 552000000, 1, 46, 2),
 	RK3066_PLL_RATE( 504000000, 1, 84, 4),
 	RK3066_PLL_RATE( 500000000, 3, 125, 2),
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index f4791fb..fd7be53 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -62,6 +62,15 @@ enum rockchip_pll_type {
 	.bwadj = (_nf >> 1),			\
 }
 
+#define RK3066_PLL_RATE_BWADJ(_rate, _nr, _nf, _no, _bw)	\
+{								\
+	.rate	= _rate##U,					\
+	.nr = _nr,						\
+	.nf = _nf,						\
+	.no = _no,						\
+	.bwadj = _bw,						\
+}
+
 struct rockchip_pll_rate_table {
 	unsigned long rate;
 	unsigned int nr;
-- 
1.9.1
