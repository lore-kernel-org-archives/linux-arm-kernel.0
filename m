From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 26 Aug 2014 09:47:51 +0200
Subject: [PATCH 2/2 v2] input: cros_ec_keyb: Add of match table
In-Reply-To: <1409039271-10687-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1409039271-10687-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1409039271-10687-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable the cros_ec_keyb driver to be auto-loaded when build as
module add an of match table (and export it) to match the modalias
information passed on to userspace as the Cros EC MFD driver registers
the MFD subdevices with an of_compatibility string.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 Changes in v2: none

 drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 791781a..e1903ec 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -342,10 +342,19 @@ static int cros_ec_keyb_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id cros_ec_keyb_of_match[] = {
+	{ .compatible = "google,cros-ec-keyb" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
+#endif
+
 static struct platform_driver cros_ec_keyb_driver = {
 	.probe = cros_ec_keyb_probe,
 	.driver = {
 		.name = "cros-ec-keyb",
+		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
 		.pm	= &cros_ec_keyb_pm_ops,
 	},
 };
-- 
2.1.0
