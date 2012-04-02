From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  2 Apr 2012 14:57:01 +0800
Subject: [PATCH] regulator: anatop: fix 'anatop_regulator' name collision
Message-ID: <1333349821-5844-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a name collision between 'struct platform_driver
anatop_regulator' and 'struct anatop_regulator', which causes some
section mismatch warnings like below.

WARNING: vmlinux.o(.data+0x154d4): Section mismatch in reference from the variable anatop_regulator to the function .devinit.text:anatop_regulator_probe()
The variable anatop_regulator references
the function __devinit anatop_regulator_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Rename 'struct platform_driver anatop_regulator' to
'struct platform_driver anatop_regulator_driver' to fix the warnings.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 drivers/regulator/anatop-regulator.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 17499a5..e365d11 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -213,7 +213,7 @@ static struct of_device_id __devinitdata of_anatop_regulator_match_tbl[] = {
 	{ /* end */ }
 };
 
-static struct platform_driver anatop_regulator = {
+static struct platform_driver anatop_regulator_driver = {
 	.driver = {
 		.name	= "anatop_regulator",
 		.owner  = THIS_MODULE,
@@ -225,13 +225,13 @@ static struct platform_driver anatop_regulator = {
 
 static int __init anatop_regulator_init(void)
 {
-	return platform_driver_register(&anatop_regulator);
+	return platform_driver_register(&anatop_regulator_driver);
 }
 postcore_initcall(anatop_regulator_init);
 
 static void __exit anatop_regulator_exit(void)
 {
-	platform_driver_unregister(&anatop_regulator);
+	platform_driver_unregister(&anatop_regulator_driver);
 }
 module_exit(anatop_regulator_exit);
 
-- 
1.7.5.4
