From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 27 Jul 2017 18:17:54 +0200
Subject: [PATCH 1/2] clk: meson: meson8b: fix protection against undefined clks
In-Reply-To: <20170727161755.10393-1-jbrunet@baylibre.com>
References: <20170727161755.10393-1-jbrunet@baylibre.com>
Message-ID: <20170727161755.10393-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

meson8b clock driver gracefully handles case where the clkid is defined
but the clock hw pointer is not provided, as long as it is not at the end
of the hw_onecell_data array.

This patch ensure that the last entries are defined as well to handle
this particular case.

Fixes: e92f7cca446e ("clk: meson8b: clean up fixed rate clocks")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index bb3f1de876b1..7629aa09472a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -585,6 +585,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MPLL0]		    = &meson8b_mpll0.hw,
 		[CLKID_MPLL1]		    = &meson8b_mpll1.hw,
 		[CLKID_MPLL2]		    = &meson8b_mpll2.hw,
+		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
 };
-- 
2.9.4
