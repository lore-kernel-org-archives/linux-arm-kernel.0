From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:41 +0100
Subject: [PATCH v4 13/24] drm/i2c: tda998x: add DT support
In-Reply-To: <cover.1390646891.git.moinejf@free.fr>
References: <cover.1390646891.git.moinejf@free.fr>
Message-ID: <20140125181441.52161a91@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support to the tda998x.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index a3ebc08..0231e44 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1164,6 +1164,8 @@ tda998x_encoder_init(struct i2c_client *client,
 		    struct drm_encoder_slave *encoder_slave)
 {
 	struct tda998x_priv *priv;
+	struct device_node *np = client->dev.of_node;
+	u32 video;
 	int ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -1232,6 +1234,17 @@ tda998x_encoder_init(struct i2c_client *client,
 	cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL,
 			CEC_FRO_IM_CLK_CTRL_GHOST_DIS | CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
 
+	if (!np)
+		return 0;		/* non-DT */
+
+	/* get the optional video properties */
+	ret = of_property_read_u32(np, "video-ports", &video);
+	if (ret == 0) {
+		priv->vip_cntrl_0 = video >> 16;
+		priv->vip_cntrl_1 = video >> 8;
+		priv->vip_cntrl_2 = video;
+	}
+
 	return 0;
 
 fail:
@@ -1246,6 +1259,14 @@ fail:
 	return -ENXIO;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id tda998x_dt_ids[] = {
+	{ .compatible = "nxp,tda998x", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tda998x_dt_ids);
+#endif
+
 static struct i2c_device_id tda998x_ids[] = {
 	{ "tda998x", 0 },
 	{ }
@@ -1258,6 +1279,7 @@ static struct drm_i2c_encoder_driver tda998x_driver = {
 		.remove = tda998x_remove,
 		.driver = {
 			.name = "tda998x",
+			.of_match_table = of_match_ptr(tda998x_dt_ids),
 		},
 		.id_table = tda998x_ids,
 	},
-- 
1.8.5.3
