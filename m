From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 25 Jul 2014 10:15:59 +0800
Subject: [PATCH] i2c: pca954x: put the mux to disconnected state after resume
Message-ID: <1406254559-5615-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pca954x may be power lost during suspend, so after resume we also suffer
the issue fixed by commit cd823db8b1161ef0d756514d280715a576d65cc3,

 "pca954x power-on default is channel 0 connected. If multiple pca954x
 muxes are connected to the same physical I2C bus, the parent bus will
 see channel 0 devices behind both muxes by default."

What's more, when resume bootloader may also operate the mux, so the
the channel connected after that may not be the one driver thought.

We fix this problem by putting the mux to disconnected state and
clearing last_chan in the resume hook.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 9bd4212..c8c3d58 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -273,9 +273,23 @@ static int pca954x_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int pca954x_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pca954x *data = i2c_get_clientdata(client);
+
+	data->last_chan = 0;
+	return i2c_smbus_write_byte(client, 0);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pca954x_pm, NULL, pca954x_resume);
+
 static struct i2c_driver pca954x_driver = {
 	.driver		= {
 		.name	= "pca954x",
+		.pm	= &pca954x_pm,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= pca954x_probe,
-- 
2.0.1
