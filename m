From: mporter@linaro.org (Matt Porter)
Date: Tue,  4 Feb 2014 07:19:07 -0500
Subject: [PATCH 1/6] i2c: bcm-kona: register with subsys_initcall
In-Reply-To: <1391516352-32359-1-git-send-email-mporter@linaro.org>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Message-ID: <1391516352-32359-2-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Voltage regulators are needed very early due to deferred probe
being incompatible with built-in USB gadget drivers. In order to
have the PMU driver available before USB UDC, make i2c available
during subsys_initcall.

Signed-off-by: Matt Porter <mporter@linaro.org>
Reviewed-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 drivers/i2c/busses/i2c-bcm-kona.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 18a74a6..bfd4056 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -901,7 +901,19 @@ static struct platform_driver bcm_kona_i2c_driver = {
 	.probe = bcm_kona_i2c_probe,
 	.remove = bcm_kona_i2c_remove,
 };
-module_platform_driver(bcm_kona_i2c_driver);
+
+static int __init bcm_kona_i2c_init_driver(void)
+{
+	return platform_driver_register(&bcm_kona_i2c_driver);
+}
+/* PMU access is needed early so use subsys init */
+subsys_initcall(bcm_kona_i2c_init_driver);
+
+static void __exit bcm_kona_i2c_exit_driver(void)
+{
+	platform_driver_unregister(&bcm_kona_i2c_driver);
+}
+module_exit(bcm_kona_i2c_exit_driver);
 
 MODULE_AUTHOR("Tim Kryger <tkryger@broadcom.com>");
 MODULE_DESCRIPTION("Broadcom Kona I2C Driver");
-- 
1.8.4
