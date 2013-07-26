From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Fri, 26 Jul 2013 21:22:17 +0800
Subject: [PATCH v4 1/2] i2c: designware: use module_platform_driver
In-Reply-To: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1374844938-25505-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of use platform_driver_probe, use module_platform_driver
To support deferred probing
Also subsys_initcall may too early to auto set pinctl

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/i2c/busses/i2c-designware-platdrv.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4c5fada..36ceebc 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -236,6 +236,7 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
+	.probe		= dw_i2c_probe,
 	.remove		= dw_i2c_remove,
 	.driver		= {
 		.name	= "i2c_designware",
@@ -245,18 +246,7 @@ static struct platform_driver dw_i2c_driver = {
 		.pm	= &dw_i2c_dev_pm_ops,
 	},
 };
-
-static int __init dw_i2c_init_driver(void)
-{
-	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
-}
-subsys_initcall(dw_i2c_init_driver);
-
-static void __exit dw_i2c_exit_driver(void)
-{
-	platform_driver_unregister(&dw_i2c_driver);
-}
-module_exit(dw_i2c_exit_driver);
+module_platform_driver(dw_i2c_driver);
 
 MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
 MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
-- 
1.7.9.5
