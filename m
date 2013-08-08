From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu,  8 Aug 2013 10:00:37 -0700
Subject: [PATCH] ARM: pxa: make pwm driver module_platform_driver
Message-ID: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 76abbdde2d95a3807d0dc6bf9f84d03d0dbd4f3d

    pwm: Add sysfs interface

causes a kernel oops due to a null pointer dereference on pxa platforms.  This
happens because the class added by the patch is registered in a subsys_initcall
(initcall4), but the pxa pwm driver is registered in arch_initcall (initcall3).
If the class is not registered before the driver probe function runs, the oops
occurs in device_add() when the uninitialized pointers in struct class are
dereferenced.  I don't see a reason that the driver must be an arch_initcall, so
this patch makes it a regular module_platform_driver (initcall6), preventing the
oops.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 drivers/pwm/pwm-pxa.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index dc97175..a4d2164 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -182,16 +182,6 @@ static struct platform_driver pwm_driver = {
 	.id_table	= pwm_id_table,
 };
 
-static int __init pwm_init(void)
-{
-	return platform_driver_register(&pwm_driver);
-}
-arch_initcall(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&pwm_driver);
-}
-module_exit(pwm_exit);
+module_platform_driver(pwm_driver);
 
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.5
