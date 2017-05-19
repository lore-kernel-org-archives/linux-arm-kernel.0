From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Fri, 19 May 2017 16:13:03 +0300
Subject: [PATCH 1/3] staging: fsl-mc: fix several checkpath.pl warnings
In-Reply-To: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
References: <20170519131305.5068-1-laurentiu.tudor@nxp.com>
Message-ID: <20170519131305.5068-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Remove several unneeded #includes, forward
declarations and fix several issues reported
by checkpatch.pl --strict, such as:
 - kfree(NULL) is safe and check is not required
 - macro argument reuse may cause possible side effects
 - enclose macro params in parens to avoid precedence issues
 - coding style

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp-cmd.h         |  2 +-
 drivers/staging/fsl-mc/bus/dpmcp-cmd.h        |  2 +-
 drivers/staging/fsl-mc/bus/dpmng-cmd.h        |  2 +-
 drivers/staging/fsl-mc/bus/dprc-cmd.h         |  2 +-
 drivers/staging/fsl-mc/bus/dprc-driver.c      | 10 +++++++---
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 11 +++++++----
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c       | 12 +++---------
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c       |  1 +
 drivers/staging/fsl-mc/bus/fsl-mc-private.h   |  1 -
 drivers/staging/fsl-mc/include/dprc.h         |  3 ---
 drivers/staging/fsl-mc/include/mc-sys.h       |  1 -
 11 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
index 8aa6545..5904836 100644
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
@@ -40,7 +40,7 @@
 #define DPBP_CMD_BASE_VERSION			1
 #define DPBP_CMD_ID_OFFSET			4
 
-#define DPBP_CMD(id)	((id << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
+#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
diff --git a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h b/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
index 384a13d..861b2a7 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
@@ -40,7 +40,7 @@
 #define DPMCP_CMD_BASE_VERSION		1
 #define DPMCP_CMD_ID_OFFSET		4
 
-#define DPMCP_CMD(id)	((id << DPMCP_CMD_ID_OFFSET) | DPMCP_CMD_BASE_VERSION)
+#define DPMCP_CMD(id)	(((id) << DPMCP_CMD_ID_OFFSET) | DPMCP_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPMCP_CMDID_CLOSE		DPMCP_CMD(0x800)
diff --git a/drivers/staging/fsl-mc/bus/dpmng-cmd.h b/drivers/staging/fsl-mc/bus/dpmng-cmd.h
index cdddfb8..d1f04ac 100644
--- a/drivers/staging/fsl-mc/bus/dpmng-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpmng-cmd.h
@@ -44,7 +44,7 @@
 #define DPMNG_CMD_BASE_VERSION		1
 #define DPMNG_CMD_ID_OFFSET		4
 
-#define DPMNG_CMD(id)	((id << DPMNG_CMD_ID_OFFSET) | DPMNG_CMD_BASE_VERSION)
+#define DPMNG_CMD(id)	(((id) << DPMNG_CMD_ID_OFFSET) | DPMNG_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPMNG_CMDID_GET_VERSION		DPMNG_CMD(0x831)
diff --git a/drivers/staging/fsl-mc/bus/dprc-cmd.h b/drivers/staging/fsl-mc/bus/dprc-cmd.h
index e9fdca4..d9b2dcd 100644
--- a/drivers/staging/fsl-mc/bus/dprc-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dprc-cmd.h
@@ -48,7 +48,7 @@
 #define DPRC_CMD_BASE_VERSION			1
 #define DPRC_CMD_ID_OFFSET			4
 
-#define DPRC_CMD(id)	((id << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
+#define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index d723c69..39c9a3b 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -21,9 +21,13 @@
 
 #define FSL_MC_DPRC_DRIVER_NAME    "fsl_mc_dprc"
 
-#define FSL_MC_DEVICE_MATCH(_mc_dev, _obj_desc) \
-	(strcmp((_mc_dev)->obj_desc.type, (_obj_desc)->type) == 0 && \
-	 (_mc_dev)->obj_desc.id == (_obj_desc)->id)
+#define FSL_MC_DEVICE_MATCH(_mc_dev, _obj_desc)				\
+({									\
+	struct fsl_mc_device *__mc_dev = _mc_dev;			\
+	struct dprc_obj_desc *__obj_desc = _obj_desc;			\
+	(strcmp(__mc_dev->obj_desc.type, __obj_desc->type) == 0 &&	\
+	__mc_dev->obj_desc.id == __obj_desc->id);			\
+})
 
 struct dprc_child_objs {
 	int child_count;
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index ce07096..d3def40 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -17,10 +17,13 @@
 #include "dpcon-cmd.h"
 #include "fsl-mc-private.h"
 
-#define FSL_MC_IS_ALLOCATABLE(_obj_type) \
-	(strcmp(_obj_type, "dpbp") == 0 || \
-	 strcmp(_obj_type, "dpmcp") == 0 || \
-	 strcmp(_obj_type, "dpcon") == 0)
+#define FSL_MC_IS_ALLOCATABLE(_obj_type)	\
+({						\
+	const char *__obj_type = _obj_type;	\
+	(strcmp(__obj_type, "dpbp") == 0 ||	\
+	 strcmp(__obj_type, "dpmcp") == 0 ||	\
+	 strcmp(__obj_type, "dpcon") == 0);	\
+})
 
 /**
  * fsl_mc_resource_pool_add_device - add allocatable object to a resource
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 50eb415..7b48ade 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -420,15 +420,11 @@ bool fsl_mc_is_root_dprc(struct device *dev)
 static void fsl_mc_device_release(struct device *dev)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
-	struct fsl_mc_bus *mc_bus = NULL;
 
 	kfree(mc_dev->regions);
 
 	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)
-		mc_bus = to_fsl_mc_bus(mc_dev);
-
-	if (mc_bus)
-		kfree(mc_bus);
+		kfree(to_fsl_mc_bus(mc_dev));
 	else
 		kfree(mc_dev);
 }
@@ -559,10 +555,8 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	kfree(mc_bus);
+	kfree(mc_dev);
 
 	return error;
 }
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index b8b2c86..a92fa5a 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include "../include/mc-bus.h"
+#include "../include/mc-cmd.h"
 #include "fsl-mc-private.h"
 
 /*
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
index 5c49c9d..01ef9329 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
@@ -11,7 +11,6 @@
 #define _FSL_MC_PRIVATE_H_
 
 #include "../include/mc.h"
-#include "../include/mc-bus.h"
 
 int __must_check fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
diff --git a/drivers/staging/fsl-mc/include/dprc.h b/drivers/staging/fsl-mc/include/dprc.h
index dc985cc..2f4a7a7 100644
--- a/drivers/staging/fsl-mc/include/dprc.h
+++ b/drivers/staging/fsl-mc/include/dprc.h
@@ -33,8 +33,6 @@
 #ifndef _FSL_DPRC_H
 #define _FSL_DPRC_H
 
-#include "mc-cmd.h"
-
 /*
  * Data Path Resource Container API
  * Contains DPRC API for managing and querying DPAA resources
@@ -51,7 +49,6 @@ int dprc_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token);
 
-
 /* IRQ */
 
 /* IRQ index */
diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
index dca7f90..b520370 100644
--- a/drivers/staging/fsl-mc/include/mc-sys.h
+++ b/drivers/staging/fsl-mc/include/mc-sys.h
@@ -46,7 +46,6 @@
  */
 #define FSL_MC_IO_ATOMIC_CONTEXT_PORTAL	0x0001
 
-struct fsl_mc_resource;
 struct mc_command;
 
 /**
-- 
2.9.4
