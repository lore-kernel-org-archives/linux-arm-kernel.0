From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 18:17:55 +0200
Subject: [PATCH 2/2] clk: meson: gxbb: fix protection against undefined clks
In-Reply-To: <20170727161755.10393-1-jbrunet@baylibre.com>
References: <20170727161755.10393-1-jbrunet@baylibre.com>
Message-ID: <20170727161755.10393-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gxbb clock driver gracefully handles case where the clkid is defined but
the clock hw pointer is not provided, as long as it is not at the end of
the hw_onecell_data array.

This patch ensure that the last entries are defined as well to handle
this particular case.

Fixes: a70c6e06ed7c ("clk: meson: gxbb: protect against holes in the onecell_data array")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index a897ea45327c..8409d86cda24 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1183,6 +1183,7 @@ static struct clk_hw_onecell_data gxbb_hw_onecell_data = {
 		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
 		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
 		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
+		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
 };
@@ -1305,6 +1306,7 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 		[CLKID_32K_CLK]		    = &gxbb_32k_clk.hw,
 		[CLKID_32K_CLK_SEL]	    = &gxbb_32k_clk_sel.hw,
 		[CLKID_32K_CLK_DIV]	    = &gxbb_32k_clk_div.hw,
+		[NR_CLKS]		    = NULL,
 	},
 	.num = NR_CLKS,
 };
-- 
2.9.4
