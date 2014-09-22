From: zyw@rock-chips.com (Chris Zhong)
Date: Mon, 22 Sep 2014 15:24:35 +0800
Subject: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
Message-ID: <1411370675-27866-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some device using this bus, such as regulators, they should register
as early as possible, so the I2C bus master needs to be loaded early.
Therefore initialize via subsys_initcall() is better.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 drivers/i2c/busses/i2c-rk3x.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index e637c32..5b91901 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -760,7 +760,18 @@ static struct platform_driver rk3x_i2c_driver = {
 	},
 };
 
-module_platform_driver(rk3x_i2c_driver);
+static int __init rk3x_i2c_init_driver(void)
+{
+	return platform_driver_register(&rk3x_i2c_driver);
+}
+
+static void __exit rk3x_i2c_exit_driver(void)
+{
+	platform_driver_unregister(&rk3x_i2c_driver);
+}
+
+subsys_initcall(rk3x_i2c_init_driver);
+module_exit(rk3x_i2c_exit_driver);
 
 MODULE_DESCRIPTION("Rockchip RK3xxx I2C Bus driver");
 MODULE_AUTHOR("Max Schwarz <max.schwarz@online.de>");
-- 
1.7.9.5
