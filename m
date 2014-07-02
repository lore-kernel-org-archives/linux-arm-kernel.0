From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Wed, 2 Jul 2014 10:33:44 +0100
Subject: drm/i2c: tda998x: Set CEC I2C address from TDA I2C address
Message-ID: <53B3D1F8.7080106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two LSBs of the TDA998x's I2C address are set by pins on the
chip.  The associated CEC peripheral's I2C address is set in the
same way, so base the CEC address on that of the TDA998x.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>

---
 drivers/gpu/drm/i2c/tda998x_drv.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index c2a690d..08a2a26 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1260,6 +1260,7 @@ tda998x_encoder_init(struct i2c_client *client,
        struct device_node *np = client->dev.of_node;
        u32 video;
        int rev_lo, rev_hi, ret;
+       unsigned short cec_addr;

        priv = kzalloc(sizeof(*priv), GFP_KERNEL);
        if (!priv)
@@ -1274,9 +1275,9 @@ tda998x_encoder_init(struct i2c_client *client,

        priv->current_page = 0xff;
        priv->hdmi = client;
-       priv->cec = i2c_new_dummy(client->adapter, 0x34);
-       if (!priv->cec)
-               priv->cec = i2c_new_dummy(client->adapter, 0x35);
+       /* CEC I2C address bound to TDA998x I2C addr by configuration pins */
+       cec_addr = 0x34 + (client->addr & 3);
+       priv->cec = i2c_new_dummy(client->adapter, cec_addr);
        if (!priv->cec) {
                kfree(priv);
                return -ENODEV;
--
1.7.1

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
