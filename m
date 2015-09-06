From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sun,  6 Sep 2015 09:13:28 +0800
Subject: [PATCH v4 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
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
---

Changes in v4:
- use snd_dmaengine_pcm_get_quirks to get quirks

Changes in v3: None
Changes in v2: None
Changes in v1: None

 sound/soc/rockchip/rockchip_i2s.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acb5be5..b06e08a 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -23,6 +23,8 @@
 
 #define DRV_NAME "rockchip-i2s"
 
+#define ROCKCHIP_I2S_BROKEN_BURST_LEN (1<<0) /* broken burst len */
+
 struct rk_i2s_dev {
 	struct device *dev;
 
@@ -418,6 +420,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	struct rk_i2s_dev *i2s;
 	struct resource *res;
 	void __iomem *regs;
+	int dma_quirk;
 	int ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
@@ -460,7 +463,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
 	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->playback_dma_data.maxburst = 4;
-
 	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
 	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	i2s->capture_dma_data.maxburst = 4;
@@ -489,6 +491,18 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_pcm_register;
 	}
 
+	dma_quirk = snd_dmaengine_pcm_get_quirks(&pdev->dev);
+	if (dma_quirk == ROCKCHIP_I2S_BROKEN_BURST_LEN) {
+		/*
+		 * Unfortunately, we find broken burst len here,
+		 * just have to limit maxburst to ONE in order to avoid
+		 * non-multiple burst len access fail the dmaengine if
+		 * it can't support flush peripheral function.
+		 */
+		i2s->playback_dma_data.maxburst = 1;
+		i2s->capture_dma_data.maxburst = 1;
+	}
+
 	return 0;
 
 err_pcm_register:
-- 
2.3.7
