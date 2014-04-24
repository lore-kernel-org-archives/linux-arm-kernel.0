From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 24 Apr 2014 20:18:36 +0530
Subject: [PATCH] i2c: exynos5: Initialise Samsung High Speed I2C controller
 early
Message-ID: <1398350916-885-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves initialization code to subsys_initcall() to ensure
that the i2c bus is available early so the regulators can be quickly
probed and available for other devices on their probe() call.

Such solution has been proposed by Mark Brown to fix the problem of
the regulators not beeing available on the peripheral device probe():
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/i2c/busses/i2c-exynos5.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 00af0a0..20e3077 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -762,8 +762,18 @@ static struct platform_driver exynos5_i2c_driver = {
 	},
 };
 
-module_platform_driver(exynos5_i2c_driver);
+static int __init i2c_adap_exynos5_init(void)
+{
+	return platform_driver_register(&exynos5_i2c_driver);
+}
+subsys_initcall(i2c_adap_exynos5_init);
+
+static void __exit i2c_adap_exynos5_exit(void)
+{
+	platform_driver_unregister(&exynos5_i2c_driver);
+}
 
+module_exit(i2c_adap_exynos5_exit);
 MODULE_DESCRIPTION("Exynos5 HS-I2C Bus driver");
 MODULE_AUTHOR("Naveen Krishna Chatradhi, <ch.naveen@samsung.com>");
 MODULE_AUTHOR("Taekgyun Ko, <taeggyun.ko@samsung.com>");
-- 
1.7.9.5
