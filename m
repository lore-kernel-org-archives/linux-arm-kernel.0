From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 28 Oct 2015 13:02:34 +0000
Subject: [PATCH v5 3/7] vfio: platform: introduce module_vfio_reset_handler
 macro
In-Reply-To: <1446037358-2079-1-git-send-email-eric.auger@linaro.org>
References: <1446037358-2079-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1446037358-2079-4-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The module_vfio_reset_handler macro
- define a module alias
- implement module init/exit function which respectively registers
  and unregisters the reset function.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>

---
v4 -> v5:
- add Arnd's R-b

v3 -> v4:
- pass reset to vfio_platform_unregister_reset

v2 -> v3:
- use vfio_platform_register_reset macro

v1 -> v2:
- remove vfio_platform_reset_private.h and move back the macro to
  vfio_platform_private.h header: removed reset_module_register &
  unregister (symbol_get)
- defines the module_vfio_reset_handler macro as suggested by Arnd
  (formerly in vfio_platform_reset_private.h)
---
 drivers/vfio/platform/vfio_platform_private.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index c563940..fd262be 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -110,4 +110,18 @@ static struct vfio_platform_reset_node __reset ## _node = {	\
 };								\
 __vfio_platform_register_reset(&__reset ## _node)
 
+#define module_vfio_reset_handler(compat, reset)		\
+MODULE_ALIAS("vfio-reset:" compat);				\
+static int __init reset ## _module_init(void)			\
+{								\
+	vfio_platform_register_reset(compat, reset);		\
+	return 0;						\
+};								\
+static void __exit reset ## _module_exit(void)			\
+{								\
+	vfio_platform_unregister_reset(compat, reset);		\
+};								\
+module_init(reset ## _module_init);				\
+module_exit(reset ## _module_exit)
+
 #endif /* VFIO_PLATFORM_PRIVATE_H */
-- 
1.9.1
