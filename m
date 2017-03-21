From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Mar 2017 16:38:21 +0800
Subject: [PATCH 1/3] clk: zte: set CLK_SET_RATE_PARENT for a few zx296718
 clocks
In-Reply-To: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
References: <1490085503-15713-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1490085503-15713-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

To support VOU VGA display driver with different modes, we need to set
flag for a few clocks, so that clk_set_rate() call in VOU driver can get
VGA device desired pixel rate.

While at it, the divider between pll_vga and clk_vga gets corrected, as
it's 1:1 instead of 1:2.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index 2f7c668643fe..f2e1e8b3a8d5 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -409,7 +409,7 @@
 	FFACTOR(0, "clk54m",		"pll_mm1", 1, 24, 0),
 	/* vga */
 	FFACTOR(0, "pll_vga_1800m",	"pll_vga", 1, 1, 0),
-	FFACTOR(0, "clk_vga",		"pll_vga", 1, 2, 0),
+	FFACTOR(0, "clk_vga",		"pll_vga", 1, 1, CLK_SET_RATE_PARENT),
 	/* pll ddr */
 	FFACTOR(0, "clk466m",		"pll_ddr", 1, 2, 0),
 
@@ -458,8 +458,8 @@
 	MUX(0, "sappu_a_mux",	 sappu_aclk_p,	  TOP_CLK_MUX5,  4, 2),
 	MUX(0, "sappu_w_mux",	 sappu_wclk_p,	  TOP_CLK_MUX5,  8, 3),
 	MUX(0, "vou_a_mux",	 vou_aclk_p,	  TOP_CLK_MUX7,  0, 3),
-	MUX(0, "vou_main_w_mux", vou_main_wclk_p, TOP_CLK_MUX7,  4, 3),
-	MUX(0, "vou_aux_w_mux",	 vou_aux_wclk_p,  TOP_CLK_MUX7,  8, 3),
+	MUX_F(0, "vou_main_w_mux", vou_main_wclk_p, TOP_CLK_MUX7,  4, 3, CLK_SET_RATE_PARENT, 0),
+	MUX_F(0, "vou_aux_w_mux",  vou_aux_wclk_p,  TOP_CLK_MUX7,  8, 3, CLK_SET_RATE_PARENT, 0),
 	MUX(0, "vou_ppu_w_mux",	 vou_ppu_wclk_p,  TOP_CLK_MUX7, 12, 3),
 	MUX(0, "vga_i2c_mux",	 vga_i2c_wclk_p,  TOP_CLK_MUX7, 16, 1),
 	MUX(0, "viu_m0_a_mux",	 viu_m0_aclk_p,	  TOP_CLK_MUX6,  0, 3),
-- 
1.9.1
