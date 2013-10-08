From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:36 +0200
Subject: [PATCH 4/9] i2c: i2c-stu300: replace platform_driver_probe to support
 deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-stu300.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index f8f6f2e..04a17b9 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -859,8 +859,7 @@ static const struct i2c_algorithm stu300_algo = {
 	.functionality	= stu300_func,
 };
 
-static int __init
-stu300_probe(struct platform_device *pdev)
+static int stu300_probe(struct platform_device *pdev)
 {
 	struct stu300_dev *dev;
 	struct i2c_adapter *adap;
@@ -966,8 +965,7 @@ static SIMPLE_DEV_PM_OPS(stu300_pm, stu300_suspend, stu300_resume);
 #define STU300_I2C_PM	NULL
 #endif
 
-static int __exit
-stu300_remove(struct platform_device *pdev)
+static int stu300_remove(struct platform_device *pdev)
 {
 	struct stu300_dev *dev = platform_get_drvdata(pdev);
 
@@ -989,13 +987,14 @@ static struct platform_driver stu300_i2c_driver = {
 		.pm	= STU300_I2C_PM,
 		.of_match_table = stu300_dt_match,
 	},
-	.remove		= __exit_p(stu300_remove),
+	.probe = stu300_probe,
+	.remove = stu300_remove,
 
 };
 
 static int __init stu300_init(void)
 {
-	return platform_driver_probe(&stu300_i2c_driver, stu300_probe);
+	return platform_driver_register(&stu300_i2c_driver);
 }
 
 static void __exit stu300_exit(void)
-- 
1.8.4.rc3
