From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 16 Nov 2016 10:48:57 +0000
Subject: [PATCH 2/2] drm/i2c: tda998x: allow sharing of the CEC device accesses
Message-ID: <E1c6xlx-0006wl-Py@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cec_read() is non-atomic in the presence of other I2C bus transactions
to the same device.  This presents a problem when we add support for
the TDA9950 CEC engine part - both drivers can be trying to access the
device.

Avoid the inherent problems by switching to i2c_transfer() instead,
which allows us to perform more than one bus transaction atomically.

As this means we will be using I2C transactions rather than SMBUS, we
have to check that the host supports I2C functionality.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 53 +++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 74fb59a35269..f59d6664315d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -41,6 +41,7 @@ struct tda998x_priv {
 	struct i2c_client *hdmi;
 	struct mutex mutex;
 	u16 rev;
+	u8 cec_addr;
 	u8 current_page;
 	bool is_on;
 	bool supports_infoframes;
@@ -374,35 +375,46 @@ struct tda998x_priv {
 static void
 cec_write(struct tda998x_priv *priv, u16 addr, u8 val)
 {
-	struct i2c_client *client = priv->cec;
 	u8 buf[] = {addr, val};
+	struct i2c_msg msg = {
+		.addr = priv->cec_addr,
+		.len = 2,
+		.buf = buf,
+	};
 	int ret;
 
-	ret = i2c_master_send(client, buf, sizeof(buf));
+	ret = i2c_transfer(priv->hdmi->adapter, &msg, 1);
 	if (ret < 0)
-		dev_err(&client->dev, "Error %d writing to cec:0x%x\n", ret, addr);
+		dev_err(&priv->hdmi->dev, "Error %d writing to cec:0x%x\n",
+			ret, addr);
 }
 
 static u8
 cec_read(struct tda998x_priv *priv, u8 addr)
 {
-	struct i2c_client *client = priv->cec;
 	u8 val;
+	struct i2c_msg msg[2] = {
+		{
+			.addr = priv->cec_addr,
+			.len = 1,
+			.buf = &addr,
+		}, {
+			.addr = priv->cec_addr,
+			.flags = I2C_M_RD,
+			.len = 1,
+			.buf = &val,
+		},
+	};
 	int ret;
 
-	ret = i2c_master_send(client, &addr, sizeof(addr));
-	if (ret < 0)
-		goto fail;
-
-	ret = i2c_master_recv(client, &val, sizeof(val));
-	if (ret < 0)
-		goto fail;
+	ret = i2c_transfer(priv->hdmi->adapter, msg, ARRAY_SIZE(msg));
+	if (ret < 0) {
+		dev_err(&priv->hdmi->dev, "Error %d reading from cec:0x%x\n",
+			ret, addr);
+		val = 0;
+	}
 
 	return val;
-
-fail:
-	dev_err(&client->dev, "Error %d reading from cec:0x%x\n", ret, addr);
-	return 0;
 }
 
 static int
@@ -1471,17 +1483,16 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 	struct device_node *np = client->dev.of_node;
 	u32 video;
 	int rev_lo, rev_hi, ret;
-	unsigned short cec_addr;
 
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
+	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
+	priv->cec_addr = 0x34 + (client->addr & 0x03);
 	priv->current_page = 0xff;
 	priv->hdmi = client;
-	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
-	cec_addr = 0x34 + (client->addr & 0x03);
-	priv->cec = i2c_new_dummy(client->adapter, cec_addr);
+	priv->cec = i2c_new_dummy(client->adapter, priv->cec_addr);
 	if (!priv->cec)
 		return -ENODEV;
 
@@ -1722,6 +1733,10 @@ static const struct component_ops tda998x_ops = {
 static int
 tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_warn(&client->dev, "adapter does not support I2C\n");
+		return -EIO;
+	}
 	return component_add(&client->dev, &tda998x_ops);
 }
 
-- 
2.7.4
