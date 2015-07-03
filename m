From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Fri, 3 Jul 2015 17:40:45 +0530
Subject: [PATCH] ARM: mact-pxa: Use module_platform_driver
Message-ID: <20150703114656.GA6871@vaishali-Ideapad-Z570>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use module_platform_driver for drivers whose init and exit functions
only register and unregister, respectively.

A simplified version of the Coccinelle semantic patch that performs
this transformation is as follows:

@a@
identifier f, x;
@@
-static f(...) { return platform_driver_register(&x); }

@b depends on a@
identifier e, a.x;
@@
-static e(...) { platform_driver_unregister(&x); }

@c depends on a && b@
identifier a.f;
declarer name module_init;
@@
-module_init(f);

@d depends on a && b && c@
identifier b.e, a.x;
declarer name module_exit;
declarer name module_platform_driver;
@@
-module_exit(e);
+module_platform_driver(x);

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 arch/arm/mach-pxa/tosa-bt.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa-bt.c b/arch/arm/mach-pxa/tosa-bt.c
index 685deff..e0a5320 100644
--- a/arch/arm/mach-pxa/tosa-bt.c
+++ b/arch/arm/mach-pxa/tosa-bt.c
@@ -131,17 +131,4 @@ static struct platform_driver tosa_bt_driver = {
 		.name = "tosa-bt",
 	},
 };
-
-
-static int __init tosa_bt_init(void)
-{
-	return platform_driver_register(&tosa_bt_driver);
-}
-
-static void __exit tosa_bt_exit(void)
-{
-	platform_driver_unregister(&tosa_bt_driver);
-}
-
-module_init(tosa_bt_init);
-module_exit(tosa_bt_exit);
+module_platform_driver(tosa_bt_driver);
-- 
1.9.1
