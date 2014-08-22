From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sat, 23 Aug 2014 01:03:01 +0200
Subject: [PATCH 1/2] i2c: cros-ec-tunnel: Add of match table
In-Reply-To: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1408748582-29029-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1408748582-29029-2-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable the cros-ec-tunnel driver to be auto-loaded when build as a
module add an of match table (and export it) to match the modalias
information passed on to userspace as the Cros EC MFD driver registers
the MFD subdevices with an of_compatibility string.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 05e033c..3c15dcc 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -310,11 +310,20 @@ static int ec_i2c_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_i2c_of_match[] = {
+	{ .compatible = "google,cros-ec-i2c-tunnel" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
+#endif
+
 static struct platform_driver ec_i2c_tunnel_driver = {
 	.probe = ec_i2c_probe,
 	.remove = ec_i2c_remove,
 	.driver = {
 		.name = "cros-ec-i2c-tunnel",
+		.of_match_table = of_match_ptr (cros_ec_i2c_of_match),
 	},
 };
 
-- 
2.1.0
