From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri,  2 Mar 2018 04:23:58 -0600
Subject: [PATCH v2 1/2] staging: fsl-mc: Move DPBP out of staging
In-Reply-To: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
References: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
Message-ID: <20180302102359.16979-2-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the source files out of staging into their final locations:
- dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPBP stands for Data Path Buffer Pool - you can read more about the
object in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v1 -> v2:
- properly refactor #include line (Laurentiu)

 drivers/bus/fsl-mc/Makefile                       |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h               | 39 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
 drivers/staging/fsl-mc/bus/Makefile               |  3 +-
 drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 -------------------
 drivers/staging/fsl-mc/include/dpbp.h             | 53 -----------------------
 include/linux/fsl/mc.h                            | 42 ++++++++++++++++++
 8 files changed, 86 insertions(+), 102 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 6a97f2c..da26e52 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
 mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
+		      dpbp.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpbp.c
rename to drivers/bus/fsl-mc/dpbp.c
index 85735bb..0aeacc5 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpbp.h"
+#include <linux/fsl/mc.h>
 
-#include "dpbp-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpbp_open() - Open a control session for the specified object.
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index bed990c..4ef8d7e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -379,6 +379,45 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  int *container_id);
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ */
+
+/* DPBP Version */
+#define DPBP_VER_MAJOR				3
+#define DPBP_VER_MINOR				2
+
+/* Command versioning */
+#define DPBP_CMD_BASE_VERSION			1
+#define DPBP_CMD_ID_OFFSET			4
+
+#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
+#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
+
+#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
+#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
+#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
+#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
+
+struct dpbp_cmd_open {
+	__le32 dpbp_id;
+};
+
+#define DPBP_ENABLE			0x1
+
+struct dpbp_rsp_get_attributes {
+	/* response word 0 */
+	__le16 pad;
+	__le16 bpid;
+	__le32 id;
+	/* response word 1 */
+	__le16 version_major;
+	__le16 version_minor;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index e577410..ce864ee 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -35,10 +35,10 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/fsl/mc.h>
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpbp.h"
 #include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index b67889e..ea6479f 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,8 +4,7 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
-			    dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
deleted file mode 100644
index 3340021..0000000
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPBP_CMD_H
-#define _FSL_DPBP_CMD_H
-
-/* DPBP Version */
-#define DPBP_VER_MAJOR				3
-#define DPBP_VER_MINOR				2
-
-/* Command versioning */
-#define DPBP_CMD_BASE_VERSION			1
-#define DPBP_CMD_ID_OFFSET			4
-
-#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
-#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
-
-#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
-#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
-#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
-#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
-
-struct dpbp_cmd_open {
-	__le32 dpbp_id;
-};
-
-#define DPBP_ENABLE			0x1
-
-struct dpbp_rsp_get_attributes {
-	/* response word 0 */
-	__le16 pad;
-	__le16 bpid;
-	__le32 id;
-	/* response word 1 */
-	__le16 version_major;
-	__le16 version_minor;
-};
-
-#endif /* _FSL_DPBP_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
deleted file mode 100644
index 7b9f7ad..0000000
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPBP_H
-#define __FSL_DPBP_H
-
-/*
- * Data Path Buffer Pool API
- * Contains initialization APIs and runtime control APIs for DPBP
- */
-
-struct fsl_mc_io;
-
-int dpbp_open(struct fsl_mc_io *mc_io,
-	      u32 cmd_flags,
-	      int dpbp_id,
-	      u16 *token);
-
-int dpbp_close(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-int dpbp_enable(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpbp_disable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpbp_reset(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-/**
- * struct dpbp_attr - Structure representing DPBP attributes
- * @id:		DPBP object ID
- * @bpid:	Hardware buffer pool ID; should be used as an argument in
- *		acquire/release operations on buffers
- */
-struct dpbp_attr {
-	int id;
-	u16 bpid;
-};
-
-int dpbp_get_attributes(struct fsl_mc_io *mc_io,
-			u32 cmd_flags,
-			u16 token,
-			struct dpbp_attr *attr);
-
-#endif /* __FSL_DPBP_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 765ba41..66118e1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -451,4 +451,46 @@ static inline bool is_fsl_mc_bus_dprtc(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dprtc_type;
 }
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ * Contains initialization APIs and runtime control APIs for DPBP
+ */
+
+int dpbp_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpbp_id,
+	      u16 *token);
+
+int dpbp_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+int dpbp_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpbp_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpbp_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+/**
+ * struct dpbp_attr - Structure representing DPBP attributes
+ * @id:		DPBP object ID
+ * @bpid:	Hardware buffer pool ID; should be used as an argument in
+ *		acquire/release operations on buffers
+ */
+struct dpbp_attr {
+	int id;
+	u16 bpid;
+};
+
+int dpbp_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpbp_attr *attr);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4
