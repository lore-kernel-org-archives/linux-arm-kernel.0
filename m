From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:30 +0300
Subject: [PATCH v2 10/15] staging: fsl-mc: move rest of mc-bus.h to private
 header
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <20170627144135.15599-11-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

All the mc-bus.h contents is only used privately in the bus driver so
move everything to the private header and get rid of the mc-bus.h
header file.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v2:
 - no changes

 drivers/staging/fsl-mc/bus/dprc-driver.c           |  1 -
 drivers/staging/fsl-mc/bus/fsl-mc-allocator.c      |  1 -
 drivers/staging/fsl-mc/bus/fsl-mc-bus.c            |  1 -
 drivers/staging/fsl-mc/bus/fsl-mc-msi.c            |  1 -
 drivers/staging/fsl-mc/bus/fsl-mc-private.h        | 61 +++++++++++++++++
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  1 -
 drivers/staging/fsl-mc/bus/mc-io.c                 |  1 -
 drivers/staging/fsl-mc/include/mc-bus.h            | 77 ----------------------
 8 files changed, 61 insertions(+), 83 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/include/mc-bus.h

diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
index adf2ffb..7c6c4ac 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
 #include "../include/mc-sys.h"
 
 #include "dprc-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
index d9a06b9..04ae2cc 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
@@ -10,7 +10,6 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
 #include "../include/mc-sys.h"
 
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index 60b2a40..3dec3e9 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -20,7 +20,6 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
-#include "../include/mc-bus.h"
 #include "../include/dpmng.h"
 #include "../include/mc-sys.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index a92fa5a..81dca7a 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -16,7 +16,6 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
 #include "../include/mc-cmd.h"
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
index 7f5406f..e583999 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
@@ -11,6 +11,53 @@
 #define _FSL_MC_PRIVATE_H_
 
 #include "../include/mc.h"
+#include <linux/mutex.h>
+
+/**
+ * Maximum number of total IRQs that can be pre-allocated for an MC bus'
+ * IRQ pool
+ */
+#define FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS	256
+
+/**
+ * struct fsl_mc_resource_pool - Pool of MC resources of a given
+ * type
+ * @type: type of resources in the pool
+ * @max_count: maximum number of resources in the pool
+ * @free_count: number of free resources in the pool
+ * @mutex: mutex to serialize access to the pool's free list
+ * @free_list: anchor node of list of free resources in the pool
+ * @mc_bus: pointer to the MC bus that owns this resource pool
+ */
+struct fsl_mc_resource_pool {
+	enum fsl_mc_pool_type type;
+	int max_count;
+	int free_count;
+	struct mutex mutex;	/* serializes access to free_list */
+	struct list_head free_list;
+	struct fsl_mc_bus *mc_bus;
+};
+
+/**
+ * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
+ * @mc_dev: fsl-mc device for the bus device itself.
+ * @resource_pools: array of resource pools (one pool per resource type)
+ * for this MC bus. These resources represent allocatable entities
+ * from the physical DPRC.
+ * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
+ * @scan_mutex: Serializes bus scanning
+ * @dprc_attr: DPRC attributes
+ */
+struct fsl_mc_bus {
+	struct fsl_mc_device mc_dev;
+	struct fsl_mc_resource_pool resource_pools[FSL_MC_NUM_POOL_TYPES];
+	struct fsl_mc_device_irq *irq_resources;
+	struct mutex scan_mutex;    /* serializes bus scanning */
+	struct dprc_attributes dprc_attr;
+};
+
+#define to_fsl_mc_bus(_mc_dev) \
+	container_of(_mc_dev, struct fsl_mc_bus, mc_dev)
 
 int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
@@ -27,6 +74,10 @@ int __init fsl_mc_allocator_driver_init(void);
 
 void fsl_mc_allocator_driver_exit(void);
 
+void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
+
+void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
+
 int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
 					  enum fsl_mc_pool_type pool_type,
 					  struct fsl_mc_resource
@@ -43,6 +94,14 @@ int __init its_fsl_mc_msi_init(void);
 
 void its_fsl_mc_msi_cleanup(void);
 
+int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
+			   struct irq_domain **mc_msi_domain);
+
+int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
+			     unsigned int irq_count);
+
+void fsl_mc_cleanup_irq_pool(struct fsl_mc_bus *mc_bus);
+
 int __must_check fsl_create_mc_io(struct device *dev,
 				  phys_addr_t mc_portal_phys_addr,
 				  u32 mc_portal_size,
@@ -51,4 +110,6 @@ int __must_check fsl_create_mc_io(struct device *dev,
 
 void fsl_destroy_mc_io(struct fsl_mc_io *mc_io);
 
+bool fsl_mc_is_root_dprc(struct device *dev);
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 49127ac..865d385 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -16,7 +16,6 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include "../include/mc-bus.h"
 #include "fsl-mc-private.h"
 
 static struct irq_chip its_msi_irq_chip = {
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/staging/fsl-mc/bus/mc-io.c
index d66b87f..ec2835f 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/staging/fsl-mc/bus/mc-io.c
@@ -31,7 +31,6 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc-bus.h"
 #include "../include/mc-sys.h"
 
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/drivers/staging/fsl-mc/include/mc-bus.h
deleted file mode 100644
index a79a679..0000000
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Freescale Management Complex (MC) bus declarations
- *
- * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Author: German Rivera <German.Rivera@freescale.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef _FSL_MC_MCBUS_H_
-#define _FSL_MC_MCBUS_H_
-
-#include "../include/mc.h"
-#include <linux/mutex.h>
-
-/**
- * Maximum number of total IRQs that can be pre-allocated for an MC bus'
- * IRQ pool
- */
-#define FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS	256
-
-/**
- * struct fsl_mc_resource_pool - Pool of MC resources of a given
- * type
- * @type: type of resources in the pool
- * @max_count: maximum number of resources in the pool
- * @free_count: number of free resources in the pool
- * @mutex: mutex to serialize access to the pool's free list
- * @free_list: anchor node of list of free resources in the pool
- * @mc_bus: pointer to the MC bus that owns this resource pool
- */
-struct fsl_mc_resource_pool {
-	enum fsl_mc_pool_type type;
-	int max_count;
-	int free_count;
-	struct mutex mutex;	/* serializes access to free_list */
-	struct list_head free_list;
-	struct fsl_mc_bus *mc_bus;
-};
-
-/**
- * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
- * @mc_dev: fsl-mc device for the bus device itself.
- * @resource_pools: array of resource pools (one pool per resource type)
- * for this MC bus. These resources represent allocatable entities
- * from the physical DPRC.
- * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
- * @scan_mutex: Serializes bus scanning
- * @dprc_attr: DPRC attributes
- */
-struct fsl_mc_bus {
-	struct fsl_mc_device mc_dev;
-	struct fsl_mc_resource_pool resource_pools[FSL_MC_NUM_POOL_TYPES];
-	struct fsl_mc_device_irq *irq_resources;
-	struct mutex scan_mutex;    /* serializes bus scanning */
-	struct dprc_attributes dprc_attr;
-};
-
-#define to_fsl_mc_bus(_mc_dev) \
-	container_of(_mc_dev, struct fsl_mc_bus, mc_dev)
-
-int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
-			   struct irq_domain **mc_msi_domain);
-
-int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
-			     unsigned int irq_count);
-
-void fsl_mc_cleanup_irq_pool(struct fsl_mc_bus *mc_bus);
-
-void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
-
-void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
-
-bool fsl_mc_is_root_dprc(struct device *dev);
-
-#endif /* _FSL_MC_MCBUS_H_ */
-- 
2.9.4
