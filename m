From: bogdan.purcareata@nxp.com (Bogdan Purcareata)
Date: Fri,  2 Mar 2018 04:23:59 -0600
Subject: [PATCH v2 2/2] staging: fsl-mc: Move DPCON out of staging
In-Reply-To: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
References: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
Message-ID: <20180302102359.16979-3-bogdan.purcareata@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the source files out of staging into their final locations:
- dpcon.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpcon-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpcon.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPCON stands for Data Path Concentrator - an interface between DPIO
(Data Path IO) and its users (e.g. dpaa2-eth). You can read more about
DPIO in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v1 -> v2:
- properly refactor #include line (Laurentiu)

 drivers/bus/fsl-mc/Makefile                        |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                | 48 +++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  1 -
 drivers/staging/fsl-mc/bus/Makefile                |  1 -
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             | 53 ---------------
 drivers/staging/fsl-mc/include/dpcon.h             | 79 ----------------------
 include/linux/fsl/mc.h                             | 66 ++++++++++++++++++
 8 files changed, 117 insertions(+), 136 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index da26e52..3c518c7 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -10,6 +10,7 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
 		      dpbp.o \
+		      dpcon.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpcon.c
rename to drivers/bus/fsl-mc/dpcon.c
index 021b425..a1ba819 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpcon.h"
+#include <linux/fsl/mc.h>
 
-#include "dpcon-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpcon_open() - Open a control session for the specified object
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 4ef8d7e..52c069d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -418,6 +418,54 @@ struct dpbp_rsp_get_attributes {
 	__le16 version_minor;
 };
 
+/*
+ * Data Path Concentrator (DPCON) API
+ */
+
+/* DPCON Version */
+#define DPCON_VER_MAJOR				3
+#define DPCON_VER_MINOR				2
+
+/* Command versioning */
+#define DPCON_CMD_BASE_VERSION			1
+#define DPCON_CMD_ID_OFFSET			4
+
+#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
+#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
+
+#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
+#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
+#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
+#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
+
+#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
+
+struct dpcon_cmd_open {
+	__le32 dpcon_id;
+};
+
+#define DPCON_ENABLE			1
+
+struct dpcon_rsp_get_attr {
+	/* response word 0 */
+	__le32 id;
+	__le16 qbman_ch_id;
+	u8 num_priorities;
+	u8 pad;
+};
+
+struct dpcon_cmd_set_notification {
+	/* cmd word 0 */
+	__le32 dpio_id;
+	u8 priority;
+	u8 pad[3];
+	/* cmd word 1 */
+	__le64 user_ctx;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index ce864ee..b8990cf 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -39,7 +39,6 @@
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index ea6479f..21d8ebc 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,7 +4,6 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpcon-cmd.h b/drivers/staging/fsl-mc/bus/dpcon-cmd.h
deleted file mode 100644
index 27fa098..0000000
--- a/drivers/staging/fsl-mc/bus/dpcon-cmd.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPCON_CMD_H
-#define _FSL_DPCON_CMD_H
-
-/* DPCON Version */
-#define DPCON_VER_MAJOR				3
-#define DPCON_VER_MINOR				2
-
-/* Command versioning */
-#define DPCON_CMD_BASE_VERSION			1
-#define DPCON_CMD_ID_OFFSET			4
-
-#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
-#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
-
-#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
-#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
-#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
-#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
-
-#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
-
-struct dpcon_cmd_open {
-	__le32 dpcon_id;
-};
-
-#define DPCON_ENABLE			1
-
-struct dpcon_rsp_get_attr {
-	/* response word 0 */
-	__le32 id;
-	__le16 qbman_ch_id;
-	u8 num_priorities;
-	u8 pad;
-};
-
-struct dpcon_cmd_set_notification {
-	/* cmd word 0 */
-	__le32 dpio_id;
-	u8 priority;
-	u8 pad[3];
-	/* cmd word 1 */
-	__le64 user_ctx;
-};
-
-#endif /* _FSL_DPCON_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpcon.h b/drivers/staging/fsl-mc/include/dpcon.h
deleted file mode 100644
index 062e90a..0000000
--- a/drivers/staging/fsl-mc/include/dpcon.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPCON_H
-#define __FSL_DPCON_H
-
-/* Data Path Concentrator API
- * Contains initialization APIs and runtime control APIs for DPCON
- */
-
-struct fsl_mc_io;
-
-/** General DPCON macros */
-
-/**
- * Use it to disable notifications; see dpcon_set_notification()
- */
-#define DPCON_INVALID_DPIO_ID		(int)(-1)
-
-int dpcon_open(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       int dpcon_id,
-	       u16 *token);
-
-int dpcon_close(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpcon_enable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpcon_disable(struct fsl_mc_io *mc_io,
-		  u32 cmd_flags,
-		  u16 token);
-
-int dpcon_reset(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-/**
- * struct dpcon_attr - Structure representing DPCON attributes
- * @id: DPCON object ID
- * @qbman_ch_id: Channel ID to be used by dequeue operation
- * @num_priorities: Number of priorities for the DPCON channel (1-8)
- */
-struct dpcon_attr {
-	int id;
-	u16 qbman_ch_id;
-	u8 num_priorities;
-};
-
-int dpcon_get_attributes(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 token,
-			 struct dpcon_attr *attr);
-
-/**
- * struct dpcon_notification_cfg - Structure representing notification params
- * @dpio_id:	DPIO object ID; must be configured with a notification channel;
- *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
- * @priority:	Priority selection within the DPIO channel; valid values
- *		are 0-7, depending on the number of priorities in that channel
- * @user_ctx:	User context value provided with each CDAN message
- */
-struct dpcon_notification_cfg {
-	int dpio_id;
-	u8 priority;
-	u64 user_ctx;
-};
-
-int dpcon_set_notification(struct fsl_mc_io *mc_io,
-			   u32 cmd_flags,
-			   u16 token,
-			   struct dpcon_notification_cfg *cfg);
-
-#endif /* __FSL_DPCON_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 66118e1..cfb1fbf 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -493,4 +493,70 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr);
 
+/* Data Path Concentrator (DPCON) API
+ * Contains initialization APIs and runtime control APIs for DPCON
+ */
+
+/**
+ * Use it to disable notifications; see dpcon_set_notification()
+ */
+#define DPCON_INVALID_DPIO_ID		(int)(-1)
+
+int dpcon_open(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       int dpcon_id,
+	       u16 *token);
+
+int dpcon_close(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpcon_enable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpcon_disable(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token);
+
+int dpcon_reset(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+/**
+ * struct dpcon_attr - Structure representing DPCON attributes
+ * @id: DPCON object ID
+ * @qbman_ch_id: Channel ID to be used by dequeue operation
+ * @num_priorities: Number of priorities for the DPCON channel (1-8)
+ */
+struct dpcon_attr {
+	int id;
+	u16 qbman_ch_id;
+	u8 num_priorities;
+};
+
+int dpcon_get_attributes(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 struct dpcon_attr *attr);
+
+/**
+ * struct dpcon_notification_cfg - Structure representing notification params
+ * @dpio_id:	DPIO object ID; must be configured with a notification channel;
+ *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
+ * @priority:	Priority selection within the DPIO channel; valid values
+ *		are 0-7, depending on the number of priorities in that channel
+ * @user_ctx:	User context value provided with each CDAN message
+ */
+struct dpcon_notification_cfg {
+	int dpio_id;
+	u8 priority;
+	u64 user_ctx;
+};
+
+int dpcon_set_notification(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   struct dpcon_notification_cfg *cfg);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4
