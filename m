From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 31 Jul 2015 09:37:23 -0600
Subject: [PATCH 03/10] coresight: replicator: Use builtin_platform_driver()
In-Reply-To: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
References: <1438357050-22486-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1438357050-22486-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vaishali Thakkar <vthakkar1994@gmail.com>

Macro builtin_platform_driver can be used for builtin drivers
that don't do anything in driver init. This file depends on
Kconfig CONFIG_CORESIGHT_LINKS_AND_SINKS which eventually
depends on CORESIGHT. Both CONFIG_CORESIGHT_LINKS_AND_SINKS and
CORESIGHT are bool. So, use builtin_platform_driver and remove
some boilerplate code.

Also, remove header file init.h as functionality like module_init
and module_exit is now relocated to module.h.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Suggested-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-replicator.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 7974b7c3da6b..963ac197c253 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -184,17 +183,7 @@ static struct platform_driver replicator_driver = {
 	},
 };
 
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
+builtin_platform_driver(replicator_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("CoreSight Replicator driver");
-- 
1.9.1
