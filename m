From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 28 Nov 2014 18:28:26 +0800
Subject: [PATCH 3/4] media: ov2640: add a master clock for sensor
In-Reply-To: <1417170507-11172-1-git-send-email-josh.wu@atmel.com>
References: <1417170507-11172-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1417170507-11172-4-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The master clock can be optional. It's a common clock framework clock.
It can make sensor output a pixel clock to the camera interface.

If you just use a external oscillator clock as the master clock, then,
just don't need set 'mck' in dt node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/media/i2c/soc_camera/ov2640.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/i2c/soc_camera/ov2640.c b/drivers/media/i2c/soc_camera/ov2640.c
index 6506126..06c2aa9 100644
--- a/drivers/media/i2c/soc_camera/ov2640.c
+++ b/drivers/media/i2c/soc_camera/ov2640.c
@@ -13,6 +13,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -31,6 +32,8 @@
 
 #define VAL_SET(x, mask, rshift, lshift)  \
 		((((x) >> rshift) & mask) << lshift)
+#define DEFAULT_MASTER_CLK_FREQ		25000000
+
 /*
  * DSP registers
  * register offset for BANK_SEL == BANK_SEL_DSP
@@ -284,6 +287,7 @@ struct ov2640_priv {
 	struct v4l2_ctrl_handler	hdl;
 	u32	cfmt_code;
 	struct v4l2_clk			*clk;
+	struct clk			*master_clk;
 	const struct ov2640_win_size	*win;
 
 	struct soc_camera_subdev_desc	ssdd_dt;
@@ -746,6 +750,7 @@ static int ov2640_s_power(struct v4l2_subdev *sd, int on)
 	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
 	struct ov2640_priv *priv = to_ov2640(client);
 	struct v4l2_clk *clk;
+	int ret = 0;
 
 	if (!priv->clk) {
 		clk = v4l2_clk_get(&client->dev, "mclk");
@@ -755,6 +760,16 @@ static int ov2640_s_power(struct v4l2_subdev *sd, int on)
 			priv->clk = clk;
 	}
 
+	if (!IS_ERR(priv->master_clk)) {
+		if (on)
+			ret = clk_prepare_enable(priv->master_clk);
+		else
+			clk_disable_unprepare(priv->master_clk);
+
+		if (ret)
+			return ret;
+	}
+
 	return soc_camera_set_power(&client->dev, ssdd, priv->clk, on);
 }
 
@@ -1153,6 +1168,16 @@ static int ov2640_probe(struct i2c_client *client,
 		}
 	}
 
+	priv->master_clk = devm_clk_get(&client->dev, "mck");
+	if (!IS_ERR(priv->master_clk)) {
+		/* Set ISI_MCK's frequency, it should be faster than pixel
+		 * clock.
+		 */
+		ret = clk_set_rate(priv->master_clk, DEFAULT_MASTER_CLK_FREQ);
+		if (ret < 0)
+			return ret;
+	}
+
 	v4l2_i2c_subdev_init(&priv->subdev, client, &ov2640_subdev_ops);
 	v4l2_ctrl_handler_init(&priv->hdl, 2);
 	v4l2_ctrl_new_std(&priv->hdl, &ov2640_ctrl_ops,
-- 
1.9.1
