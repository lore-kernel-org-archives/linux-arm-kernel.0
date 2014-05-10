From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:36 -0500
Subject: [PATCH 1/6] clk: sunxi: Remove calls to clk_put
In-Reply-To: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399692821-20988-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Callers of clk_put must disable the clock first. This also means that as long
as the clock is enabled the driver should hold a reference to that clock.
Hence, the call to clk_put here are bogus and should be removed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index bd7dc733c1ca..b1fde0f89bc1 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1297,17 +1297,13 @@ static void __init sunxi_clock_protect(void)
 
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
1.9.1
