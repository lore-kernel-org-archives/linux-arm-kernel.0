From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon,  2 Oct 2017 14:27:41 +0200
Subject: [PATCH 1/3] mmc: meson-gx: make sure the clock is rounded down
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Message-ID: <20171002122743.32334-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using CLK_DIVIDER_ROUND_CLOSEST is unsafe as the mmc clock could be
rounded to a rate higher the specified rate. Removing this flag ensure
that, if the rate needs to be rounded, it will be rounded down.

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c885c2d4b904..421c8719c202 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -531,8 +531,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	div->shift = __ffs(CLK_DIV_MASK);
 	div->width = __builtin_popcountl(CLK_DIV_MASK);
 	div->hw.init = &init;
-	div->flags = (CLK_DIVIDER_ONE_BASED |
-		      CLK_DIVIDER_ROUND_CLOSEST);
+	div->flags = CLK_DIVIDER_ONE_BASED;
 
 	clk = devm_clk_register(host->dev, &div->hw);
 	if (WARN_ON(IS_ERR(clk)))
-- 
2.13.5
