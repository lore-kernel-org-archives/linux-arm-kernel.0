From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  9 Jun 2017 16:52:47 +0800
Subject: [PATCH v1 2/4] ASoC: rockchip: i2s: add support for i2s bclk fs
 configuration
In-Reply-To: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1496998369-30556-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add support for i2s bclk fs configuration, we can
configure bclk_fs by devicetree as required.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 ++
 sound/soc/rockchip/rockchip_i2s.c                        | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 206aba1..de3cbbe 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -23,6 +23,7 @@ Required properties:
    - "i2s_clk" : clock for I2S controller
 - rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
+- rockchip,bclk-fs: configure the i2s bclk fs.
 
 Required properties for controller which support multi channels
 playback/capture:
@@ -41,4 +42,5 @@ i2s at ff890000 {
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <2>;
+	rockchip,bclk-fs = <128>;
 };
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f548433..220232b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -51,6 +51,7 @@ struct rk_i2s_dev {
 	bool rx_start;
 	bool is_master_mode;
 	const struct rk_i2s_pins *pins;
+	unsigned int bclk_fs;
 };
 
 static int i2s_runtime_suspend(struct device *dev)
@@ -254,7 +255,7 @@ static int rockchip_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	if (i2s->is_master_mode) {
 		mclk_rate = clk_get_rate(i2s->mclk);
-		bclk_rate = 2 * 32 * params_rate(params);
+		bclk_rate = i2s->bclk_fs * params_rate(params);
 		if (bclk_rate && mclk_rate % bclk_rate)
 			return -EINVAL;
 
@@ -633,6 +634,12 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			soc_dai->capture.channels_max = val;
 	}
 
+	i2s->bclk_fs = 64;
+	if (!of_property_read_u32(node, "rockchip,bclk-fs", &val)) {
+		if ((val >= 32) && (val % 2 == 0))
+			i2s->bclk_fs = val;
+	}
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rockchip_i2s_component,
 					      soc_dai, 1);
-- 
1.9.1
