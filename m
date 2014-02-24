From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Feb 2014 17:22:45 +0100
Subject: [PATCH 3/5] clk: sun6i: Protect SDRAM gating bit
In-Reply-To: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393258967-4843-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevent the SDRAM controller from being gated by force-enabling it in the clock
driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 6cfcd23..d9b4a41 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1302,6 +1302,13 @@ static void __init sunxi_clock_protect(void)
 		clk_put(clk);
 	}
 
+	/* DDR Gating clock - sun6i */
+	clk = clk_get(NULL, "ahb1_sdram");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+
 	/* CPU clocks - sun6i */
 	clk = clk_get(NULL, "cpu");
 	if (!IS_ERR(clk)) {
-- 
1.9.0
