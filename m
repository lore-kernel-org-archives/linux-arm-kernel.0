From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:50 +0800
Subject: [PATCH v3 3/9] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sonny Rao <sonnyrao@chromium.org>

We need to claim the clock which is driving the codec so that when we
enable clock gating, we continue to clock the codec when needed.
I make this an optional clock since there might be some applications
where we don't need it but can still use the I2S block.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- As the perious discuss on https://patchwork.kernel.org/patch/5427131/,
  I think Mark likes do it in codec driver, I have to say I agree this
  patch in here since that's the i2s block output. I don't know if the
  Mark has changed his mind.
- Add the suspend/resume handle the clock.

 sound/soc/rockchip/rockchip_i2s.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 58ee645..5889bba 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -28,6 +28,7 @@ struct rk_i2s_dev {
 
 	struct clk *hclk;
 	struct clk *mclk;
+	struct clk *oclk;
 
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
@@ -47,6 +48,9 @@ static int i2s_runtime_suspend(struct device *dev)
 {
 	struct rk_i2s_dev *i2s = dev_get_drvdata(dev);
 
+	if (i2s->oclk)
+		clk_disable_unprepare(i2s->oclk);
+
 	clk_disable_unprepare(i2s->mclk);
 
 	return 0;
@@ -63,6 +67,14 @@ static int i2s_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	if (i2s->oclk) {
+		ret = clk_prepare_enable(i2s->oclk);
+		if (ret) {
+			dev_err(i2s->dev, "oclk enable failed %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -480,6 +492,15 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
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
@@ -552,6 +573,9 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
+	if (i2s->oclk)
+		clk_disable_unprepare(i2s->oclk);
+
 	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 
-- 
1.9.1
