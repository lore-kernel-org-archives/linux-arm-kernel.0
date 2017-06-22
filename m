From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:58 +0300
Subject: [PATCH 12/14] staging: fsl-mc: move mc-sys.h contents in the public
 header
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-13-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

mc-sys.h contains the API to send commands to the MC and is used
by drivers. Move it to the public headers and get rid of the mc-sys.h
header.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpni.c      |  2 +-
 drivers/staging/fsl-mc/bus/dpbp.c              |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c             |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpmcp.c             |  2 +-
 drivers/staging/fsl-mc/bus/dprc-driver.c       |  2 +-
 drivers/staging/fsl-mc/bus/dprc.c              |  1 -
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c  |  2 +-
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c        |  1 -
 drivers/staging/fsl-mc/bus/mc-io.c             |  2 +-
 drivers/staging/fsl-mc/bus/mc-sys.c            |  1 -
 drivers/staging/fsl-mc/include/mc-sys.h        | 98 --------------------------
 drivers/staging/fsl-mc/include/mc.h            | 53 ++++++++++++++
 14 files changed, 61 insertions(+), 110 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/include/mc-sys.h

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 1f89274..b9a0a31 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -40,7 +40,6 @@
 #include <linux/iommu.h>
 
 #include "../../fsl-mc/include/mc.h"
-#include "../../fsl-mc/include/mc-sys.h"
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index 2c4b1a8..160eaf8 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -32,7 +32,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include "../../fsl-mc/include/mc-sys.h"
+#include "../../fsl-mc/include/mc.h"
 #include "../../fsl-mc/include/mc-cmd.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index e92d887..b714673 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 #include "../include/mc-cmd.h"
 #include "../include/dpbp.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index 20df185..2272a9c 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 #include "../include/mc-cmd.h"
 #include "../include/dpcon.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index a18ca89..48dce4a 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -31,7 +31,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../../include/mc-sys.h"
+#include "../../include/mc.h"
 #include "../../include/mc-cmd.h"
 
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/staging/fsl-mc/bus/dpmcp.c
index 66011e8..7b3dd19 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/staging/fsl-mc/bus/dpmcp.c
@@ -30,7 +30,7 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/kernel.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 #include "../include/mc-cmd.h"
 
 #include "dpmcp.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index 142dfa7..8e17cd8 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -13,7 +13,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 
 #include "dprc-cmd.h"
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/staging/fsl-mc/bus/dprc.c
index e5dfc33..f93fe00 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/staging/fsl-mc/bus/dprc.c
@@ -31,7 +31,6 @@
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
-#include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 #include "../include/dprc.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index e6a2857..8ea3920 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -10,7 +10,7 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 75f8dc3..166604e 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -20,7 +20,6 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
-#include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/staging/fsl-mc/bus/mc-io.c
index ec2835f..35221a17 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/staging/fsl-mc/bus/mc-io.c
@@ -31,7 +31,7 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc-sys.h"
+#include "../include/mc.h"
 
 #include "fsl-mc-private.h"
 #include "dpmcp.h"
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index 4d82802..c537bf8 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -37,7 +37,6 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include "../include/mc-sys.h"
 #include "../include/mc-cmd.h"
 #include "../include/mc.h"
 
diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
deleted file mode 100644
index b520370..0000000
--- a/drivers/staging/fsl-mc/include/mc-sys.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- * Interface of the I/O services to send MC commands to the MC hardware
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copyright
- *       notice, this list of conditions and the following disclaimer in the
- *       documentation and/or other materials provided with the distribution.
- *     * Neither the name of the above-listed copyright holders nor the
- *       names of any contributors may be used to endorse or promote products
- *       derived from this software without specific prior written permission.
- *
- *
- * ALTERNATIVELY, this software may be distributed under the terms of the
- * GNU General Public License ("GPL") as published by the Free Software
- * Foundation, either version 2 of that License or (at your option) any
- * later version.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
- * POSSIBILITY OF SUCH DAMAGE.
- */
-
-#ifndef _FSL_MC_SYS_H
-#define _FSL_MC_SYS_H
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-
-/**
- * Bit masks for a MC I/O object (struct fsl_mc_io) flags
- */
-#define FSL_MC_IO_ATOMIC_CONTEXT_PORTAL	0x0001
-
-struct mc_command;
-
-/**
- * struct fsl_mc_io - MC I/O object to be passed-in to mc_send_command()
- * @dev: device associated with this Mc I/O object
- * @flags: flags for mc_send_command()
- * @portal_size: MC command portal size in bytes
- * @portal_phys_addr: MC command portal physical address
- * @portal_virt_addr: MC command portal virtual address
- * @dpmcp_dev: pointer to the DPMCP device associated with the MC portal.
- *
- * Fields are only meaningful if the FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is not
- * set:
- * @mutex: Mutex to serialize mc_send_command() calls that use the same MC
- * portal, if the fsl_mc_io object was created with the
- * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag off. mc_send_command() calls for this
- * fsl_mc_io object must be made only from non-atomic context.
- *
- * Fields are only meaningful if the FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is
- * set:
- * @spinlock: Spinlock to serialize mc_send_command() calls that use the same MC
- * portal, if the fsl_mc_io object was created with the
- * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag on. mc_send_command() calls for this
- * fsl_mc_io object can be made from atomic or non-atomic context.
- */
-struct fsl_mc_io {
-	struct device *dev;
-	u16 flags;
-	u16 portal_size;
-	phys_addr_t portal_phys_addr;
-	void __iomem *portal_virt_addr;
-	struct fsl_mc_device *dpmcp_dev;
-	union {
-		/*
-		 * This field is only meaningful if the
-		 * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is not set
-		 */
-		struct mutex mutex; /* serializes mc_send_command() */
-
-		/*
-		 * This field is only meaningful if the
-		 * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is set
-		 */
-		spinlock_t spinlock;	/* serializes mc_send_command() */
-	};
-};
-
-int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd);
-
-#endif /* _FSL_MC_SYS_H */
diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/include/mc.h
index d37e2c7..33bb3b8 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -23,6 +23,7 @@ struct msi_domain_info;
 
 struct fsl_mc_device;
 struct fsl_mc_io;
+struct mc_command;
 
 /**
  * struct fsl_mc_driver - MC object device driver object
@@ -201,6 +202,58 @@ struct fsl_mc_device {
 #define to_fsl_mc_device(_dev) \
 	container_of(_dev, struct fsl_mc_device, dev)
 
+/**
+ * Bit masks for a MC I/O object (struct fsl_mc_io) flags
+ */
+#define FSL_MC_IO_ATOMIC_CONTEXT_PORTAL	0x0001
+
+/**
+ * struct fsl_mc_io - MC I/O object to be passed-in to mc_send_command()
+ * @dev: device associated with this Mc I/O object
+ * @flags: flags for mc_send_command()
+ * @portal_size: MC command portal size in bytes
+ * @portal_phys_addr: MC command portal physical address
+ * @portal_virt_addr: MC command portal virtual address
+ * @dpmcp_dev: pointer to the DPMCP device associated with the MC portal.
+ *
+ * Fields are only meaningful if the FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is not
+ * set:
+ * @mutex: Mutex to serialize mc_send_command() calls that use the same MC
+ * portal, if the fsl_mc_io object was created with the
+ * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag off. mc_send_command() calls for this
+ * fsl_mc_io object must be made only from non-atomic context.
+ *
+ * Fields are only meaningful if the FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is
+ * set:
+ * @spinlock: Spinlock to serialize mc_send_command() calls that use the same MC
+ * portal, if the fsl_mc_io object was created with the
+ * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag on. mc_send_command() calls for this
+ * fsl_mc_io object can be made from atomic or non-atomic context.
+ */
+struct fsl_mc_io {
+	struct device *dev;
+	u16 flags;
+	u16 portal_size;
+	phys_addr_t portal_phys_addr;
+	void __iomem *portal_virt_addr;
+	struct fsl_mc_device *dpmcp_dev;
+	union {
+		/*
+		 * This field is only meaningful if the
+		 * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is not set
+		 */
+		struct mutex mutex; /* serializes mc_send_command() */
+
+		/*
+		 * This field is only meaningful if the
+		 * FSL_MC_IO_ATOMIC_CONTEXT_PORTAL flag is set
+		 */
+		spinlock_t spinlock;	/* serializes mc_send_command() */
+	};
+};
+
+int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd);
+
 #ifdef CONFIG_FSL_MC_BUS
 #define dev_is_fsl_mc(_dev) ((_dev)->bus == &fsl_mc_bus_type)
 #else
-- 
2.9.4
