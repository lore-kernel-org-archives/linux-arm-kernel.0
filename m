From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed,  3 Dec 2014 15:18:38 +0800
Subject: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
In-Reply-To: <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sonny Rao <sonnyrao@chromium.org>

We need to claim the clock which is driving the codec so that when we enable
clock gating, we continue to clock the codec when needed.  I make this an
optional clock since there might be some applications where we don't need it
but can still use the I2S block.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index c74ba37..fd144ac 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -28,6 +28,7 @@ struct rk_i2s_dev {
 
 	struct clk *hclk;
 	struct clk *mclk;
+	struct clk *oclk;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
@@ -439,6 +440,15 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(i2s->mclk);
 	}
 
+	i2s->oclk = devm_clk_get(&pdev->dev, "i2s_clk_out");
+	if (IS_ERR(i2s->oclk)) {
+		dev_dbg(&pdev->dev, "Didn't find output clock\n");
+		i2s->oclk = NULL;
+	}
+
+	if (i2s->oclk)
+		ret = clk_prepare_enable(i2s->oclk);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
@@ -505,6 +515,9 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
+	if (i2s->oclk)
+		clk_disable_unprepare(i2s->oclk);
+
 	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 	snd_dmaengine_pcm_unregister(&pdev->dev);
-- 
1.9.1
