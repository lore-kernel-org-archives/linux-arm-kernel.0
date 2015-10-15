From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 09:36:48 +0800
Subject: [PATCH v6 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1444873008-2589-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yiwei Cai <cain.cai@rock-chips.com>

Test with command -
arecord -D hw:0,0 /tmp/a.wav, there are the error dump:
dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(7)

This error is happening when no a multiple of burst size * burst
length are coming in. The root cause is pl330 dma controller on
Rockchips' platform cannot support DMAFLUSHP instruction which make
dma to flush the req of non-aligned or non-multiple of what we set
before. The saftest way is to set dma max burst to 1.

Signed-off-by: Yiwei Cai <cain.cai@rock-chips.com>
Fixes: 4495c89fc ("ASoC: add driver for Rockchip RK3xxx I2S")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
cc: Addy Ke <addy.ke@rock-chips.com>
cc: Jianqun Xu <xjq@rock-chips.com>
cc: Heiko Stuebner <heiko@sntech.de>
cc: Olof Johansson <olof@lixom.net>
cc: Doug Anderson <dianders@chromium.org>
cc: Sonny Rao <sonnyrao@chromium.org>

Acked-by: Mark Brown <broonie@kernel.org>
---

Changes in v6:
- remove quirks and get dma caps in order to limit burst

Changes in v5:
- use switch statement for dma_quirk's manipulation

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/rockchip/rockchip_i2s.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index b936102..f00200a 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -418,6 +418,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	struct rk_i2s_dev *i2s;
 	struct resource *res;
 	void __iomem *regs;
+	struct dma_slave_caps *dma_caps;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
@@ -459,11 +460,24 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 
 	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->playback_dma_data.maxburst = 4;
 
 	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->capture_dma_data.maxburst = 4;
+
+	if (snd_dmaengine_pcm_get_caps(&pdev->dev, &dma_caps) == 0) {
+		if (dma_caps.max_burst > 4) {
+			i2s->playback_dma_data.maxburst = 4;
+			i2s->capture_dma_data.maxburst = 4;
+		} else {
+			i2s->playback_dma_data.maxburst = 1;
+			i2s->capture_dma_data.maxburst = 1;
+		}
+	} else {
+		i2s->playback_dma_data.maxburst = 1;
+		i2s->capture_dma_data.maxburst = 1;
+		dev_info(&pdev->dev,
+			 "Can't get dma caps, default limit maxburst to 1.\n");
+	}
 
 	i2s->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, i2s);
-- 
2.3.7
