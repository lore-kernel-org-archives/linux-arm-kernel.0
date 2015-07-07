From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Tue, 7 Jul 2015 10:56:24 +0530
Subject: [PATCH] coresight: replicator: Use module_platform_driver
Message-ID: <20150707052624.GA8718@vaishali-Ideapad-Z570>
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
 drivers/hwtracing/coresight/coresight-replicator.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 7974b7c..df45932 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -183,18 +183,7 @@ static struct platform_driver replicator_driver = {
 		.pm	= &replicator_dev_pm_ops,
 	},
 };
-
-static int __init replicator_init(void)
-{
-	return platform_driver_register(&replicator_driver);
-}
-module_init(replicator_init);
-
-static void __exit replicator_exit(void)
-{
-	platform_driver_unregister(&replicator_driver);
-}
-module_exit(replicator_exit);
+module_platform_driver(replicator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Replicator driver");
-- 
1.9.1
