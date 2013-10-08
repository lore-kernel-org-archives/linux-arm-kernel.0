From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:33 +0200
Subject: [PATCH 1/9] i2c: i2c-designware-platdrv: replace
 platform_driver_probe to support deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 4c1b605..0aa0113 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -270,7 +270,8 @@ static SIMPLE_DEV_PM_OPS(dw_i2c_dev_pm_ops, dw_i2c_suspend, dw_i2c_resume);
 MODULE_ALIAS("platform:i2c_designware");
 
 static struct platform_driver dw_i2c_driver = {
-	.remove		= dw_i2c_remove,
+	.probe = dw_i2c_probe,
+	.remove = dw_i2c_remove,
 	.driver		= {
 		.name	= "i2c_designware",
 		.owner	= THIS_MODULE,
@@ -282,7 +283,7 @@ static struct platform_driver dw_i2c_driver = {
 
 static int __init dw_i2c_init_driver(void)
 {
-	return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
+	return platform_driver_register(&dw_i2c_driver);
 }
 subsys_initcall(dw_i2c_init_driver);
 
-- 
1.8.4.rc3
