From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Mar 2014 15:41:46 +0100
Subject: [PATCH v4 1/7] clk: sunxi: Remove calls to clk_put
In-Reply-To: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394462512-11620-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1394462512-11620-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Callers of clk_put must disable the clock first. This also means that as long
as the clock is enabled the driver should hold a reference to that clock.
Hence, the call to clk_put here are bogus and should be removed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 23baad9d934a..7119c02c9fa8 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1290,17 +1290,13 @@ static void __init sunxi_clock_protect(void)
 
 	/* memory bus clock - sun5i+ */
 	clk = clk_get(NULL, "mbus");
-	if (!IS_ERR(clk)) {
+	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
-		clk_put(clk);
-	}
 
 	/* DDR clock - sun4i+ */
 	clk = clk_get(NULL, "pll5_ddr");
-	if (!IS_ERR(clk)) {
+	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
-		clk_put(clk);
-	}
 }
 
 static void __init sunxi_init_clocks(void)
-- 
1.9.0
