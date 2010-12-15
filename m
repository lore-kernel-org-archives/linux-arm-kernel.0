From: nvishwan@codeaurora.org (Niranjana Vishwanathapura)
Date: Wed, 15 Dec 2010 10:54:09 -0800
Subject: [PATCH 4/5] msm: rpc: dog keepalive rpc server support
In-Reply-To: <1292439250-11985-1-git-send-email-nvishwan@codeaurora.org>
References: <1292439250-11985-1-git-send-email-nvishwan@codeaurora.org>
Message-ID: <1292439250-11985-5-git-send-email-nvishwan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dog keepalive rpc server to handle watchdog events
from remote processor.

Cc: Iliyan Malchev <ibm@android.com>
Signed-off-by: Niranjana Vishwanathapura <nvishwan@codeaurora.org>
---
 drivers/misc/Kconfig                        |    7 +++
 drivers/misc/Makefile                       |    1 +
 drivers/misc/msm_rpc_server_dog_keepalive.c |   56 +++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/msm_rpc_server_dog_keepalive.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 651836d..345e79c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -460,6 +460,13 @@ config MSM_ONCRPCROUTER
 	  Support for the MSM ONCRPC router for rpc communitation with
 	  baseband processor.
 
+config MSM_RPCSERVER_WATCHDOG
+	depends on MSM_ONCRPCROUTER
+	default n
+	bool "Watchdog RPC server"
+	help
+	  The dog_keepalive server handles watchdog events.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 8f1dbf4..432ad7f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_AB8500_PWM)	+= ab8500-pwm.o
 obj-$(CONFIG_MSM_ONCRPCROUTER)	+= msm_smd_rpcrouter.o
 obj-$(CONFIG_MSM_ONCRPCROUTER)	+= msm_smd_rpcrouter_device.o
 obj-$(CONFIG_MSM_ONCRPCROUTER)	+= msm_smd_rpcrouter_servers.o
+obj-$(CONFIG_MSM_RPCSERVER_WATCHDOG)	+= msm_rpc_server_dog_keepalive.o
diff --git a/drivers/misc/msm_rpc_server_dog_keepalive.c b/drivers/misc/msm_rpc_server_dog_keepalive.c
new file mode 100644
index 0000000..2525bc3
--- /dev/null
+++ b/drivers/misc/msm_rpc_server_dog_keepalive.c
@@ -0,0 +1,56 @@
+/* drivers/misc/msm_rpc_server_dog_keepalive.c
+ *
+ * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ * Author: Iliyan Malchev <ibm@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include "msm_rpcrouter.h"
+
+/* dog_keepalive server definitions */
+
+#define DOG_KEEPALIVE_PROG 0x30000015
+#define DOG_KEEPALIVE_VERS 0x00010001
+#define RPC_DOG_KEEPALIVE_NULL 0
+#define RPC_DOG_KEEPALIVE_BEACON 2
+
+static int handle_rpc_call(struct msm_rpc_server *server,
+			   struct rpc_request_hdr *req, unsigned len)
+{
+	switch (req->procedure) {
+	case RPC_DOG_KEEPALIVE_NULL:
+		return 0;
+	case RPC_DOG_KEEPALIVE_BEACON:
+		printk(KERN_DEBUG "DOG KEEPALIVE PING\n");
+		return 0;
+	default:
+		return -ENODEV;
+	}
+}
+
+static struct msm_rpc_server rpc_server = {
+	.prog = DOG_KEEPALIVE_PROG,
+	.vers = DOG_KEEPALIVE_VERS,
+	.rpc_call = handle_rpc_call,
+};
+
+static int __init rpc_server_init(void)
+{
+	return msm_rpc_create_server(&rpc_server);
+}
+
+
+module_init(rpc_server_init);
-- 
1.5.6.3

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
