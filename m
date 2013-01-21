From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:16:03 +0000
Subject: [PATCH 10/15] mfd/vexpress: export vexpress_config_func_{put,get}
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Message-ID: <1358788568-11137-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced vexpress mfd driver in linux-3.8-rc
provides access to configuration functions, but the
interfaces are not exported to modules, which breaks
when the vexpress regulator driver tries to use them.

Without this patch, building allmodconfig results in:

ERROR: "__vexpress_config_func_get" [drivers/regulator/vexpress.ko] undefined!
ERROR: "vexpress_config_func_put" [drivers/regulator/vexpress.ko] undefined!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/vexpress-config.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/vexpress-config.c b/drivers/mfd/vexpress-config.c
index fae15d8..3cb34aa 100644
--- a/drivers/mfd/vexpress-config.c
+++ b/drivers/mfd/vexpress-config.c
@@ -142,6 +142,7 @@ struct vexpress_config_func *__vexpress_config_func_get(struct device *dev,
 
 	return func;
 }
+EXPORT_SYMBOL_GPL(__vexpress_config_func_get);
 
 void vexpress_config_func_put(struct vexpress_config_func *func)
 {
@@ -149,7 +150,7 @@ void vexpress_config_func_put(struct vexpress_config_func *func)
 	of_node_put(func->bridge->node);
 	kfree(func);
 }
-
+EXPORT_SYMBOL_GPL(vexpress_config_func_put);
 
 struct vexpress_config_trans {
 	struct vexpress_config_func *func;
-- 
1.7.10.4
