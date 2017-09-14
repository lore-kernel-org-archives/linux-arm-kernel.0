From: john@metanate.com (John Keeping)
Date: Thu, 14 Sep 2017 16:58:55 +0100
Subject: [PATCH] ASoC: rockchip: i2s: fix unbalanced clk_disable
Message-ID: <20170914155855.28768-1-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mclk is enabled and disabled only in i2s_runtime_{resume,suspend}() and
we ensure that the device is runtime suspended before reaching this
clk_disable_unprepare() call, so it is wrong to call it again here.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b6590467fd14..908211e1d6fc 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -692,7 +692,6 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 
 	return 0;
-- 
2.14.1
