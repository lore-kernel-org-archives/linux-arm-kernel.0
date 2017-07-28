From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 28 Jul 2017 15:17:26 +0200
Subject: [PATCH 2/2] char: xilinx_hwicap: Fix warnings in the driver
In-Reply-To: <6da0afe2afd2c7a21d16da9a9c7acab09385ae2c.1501247838.git.michal.simek@xilinx.com>
References: <6da0afe2afd2c7a21d16da9a9c7acab09385ae2c.1501247838.git.michal.simek@xilinx.com>
Message-ID: <79e2e616a8b7dbf38eb72ba0b620230017dcbc65.1501247838.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch fixes the below warning
        --> Use #include <linux/io.h> instead of <asm/io.h>
        --> Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
        --> please, no space before tabs
        --> Block comments use a trailing */ on a separate line
        --> Possible unnecessary 'out of memory' message
        --> Block comments use * on subsequent lines
        --> Block comments use a trailing */ on a separate line
        --> braces {} are not necessary for any arm of this statement
        --> DT compatible string "xlnx,opb-hwicap-1.00.b"
	    appears un-documented
        --> DT compatible string "xlnx,xps-hwicap-1.00.a"
            appears un-documented

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/xilinx.txt |  2 ++
 drivers/char/xilinx_hwicap/xilinx_hwicap.c   | 35 ++++++++++++++--------------
 drivers/char/xilinx_hwicap/xilinx_hwicap.h   |  6 +++--
 3 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/xilinx.txt b/Documentation/devicetree/bindings/xilinx.txt
index 299d0923537b..1d11b9002ef8 100644
--- a/Documentation/devicetree/bindings/xilinx.txt
+++ b/Documentation/devicetree/bindings/xilinx.txt
@@ -281,6 +281,8 @@
                       capabilities of the underlying ICAP hardware
                       differ between different families.  May be
                       'virtex2p', 'virtex4', or 'virtex5'.
+		- compatible : should contain "xlnx,xps-hwicap-1.00.a" or
+				"xlnx,opb-hwicap-1.00.b".
 
       vi) Xilinx Uart 16550
 
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 5e5c8ee23a5b..067396bedf22 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -86,8 +86,7 @@
 #include <linux/cdev.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/uaccess.h>
 
 #ifdef CONFIG_OF
@@ -253,8 +252,8 @@ static int hwicap_command_desync(struct hwicap_drvdata *drvdata)
  * hwicap_get_configuration_register - Query a configuration register.
  * @drvdata: a pointer to the drvdata.
  * @reg: a constant which represents the configuration
- *		register value to be returned.
- * 		Examples:  XHI_IDCODE, XHI_FLR.
+ * register value to be returned.
+ * Examples: XHI_IDCODE, XHI_FLR.
  * @reg_data: returns the value of the register.
  *
  * Returns: '0' on success and failure value on error
@@ -324,7 +323,8 @@ static int hwicap_initialize_hwicap(struct hwicap_drvdata *drvdata)
 	dev_dbg(drvdata->dev, "initializing\n");
 
 	/* Abort any current transaction, to make sure we have the
-	 * ICAP in a good state. */
+	 * ICAP in a good state.
+	 */
 	dev_dbg(drvdata->dev, "Reset...\n");
 	drvdata->config->reset(drvdata);
 
@@ -636,7 +636,6 @@ static int hwicap_setup(struct device *dev, int id,
 
 	drvdata = kzalloc(sizeof(struct hwicap_drvdata), GFP_KERNEL);
 	if (!drvdata) {
-		dev_err(dev, "Couldn't allocate device private record\n");
 		retval = -ENOMEM;
 		goto failed0;
 	}
@@ -763,20 +762,20 @@ static int hwicap_of_probe(struct platform_device *op,
 	id = of_get_property(op->dev.of_node, "port-number", NULL);
 
 	/* It's most likely that we're using V4, if the family is not
-	   specified */
+	 * specified
+	 */
 	regs = &v4_config_registers;
 	family = of_get_property(op->dev.of_node, "xlnx,family", NULL);
 
 	if (family) {
-		if (!strcmp(family, "virtex2p")) {
+		if (!strcmp(family, "virtex2p"))
 			regs = &v2_config_registers;
-		} else if (!strcmp(family, "virtex4")) {
+		else if (!strcmp(family, "virtex4"))
 			regs = &v4_config_registers;
-		} else if (!strcmp(family, "virtex5")) {
+		else if (!strcmp(family, "virtex5"))
 			regs = &v5_config_registers;
-		} else if (!strcmp(family, "virtex6")) {
+		else if (!strcmp(family, "virtex6"))
 			regs = &v6_config_registers;
-		}
 	}
 	return hwicap_setup(&op->dev, id ? *id : -1, &res, config,
 			regs);
@@ -806,20 +805,20 @@ static int hwicap_drv_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* It's most likely that we're using V4, if the family is not
-	   specified */
+	 * specified
+	 */
 	regs = &v4_config_registers;
 	family = pdev->dev.platform_data;
 
 	if (family) {
-		if (!strcmp(family, "virtex2p")) {
+		if (!strcmp(family, "virtex2p"))
 			regs = &v2_config_registers;
-		} else if (!strcmp(family, "virtex4")) {
+		else if (!strcmp(family, "virtex4"))
 			regs = &v4_config_registers;
-		} else if (!strcmp(family, "virtex5")) {
+		else if (!strcmp(family, "virtex5"))
 			regs = &v5_config_registers;
-		} else if (!strcmp(family, "virtex6")) {
+		else if (!strcmp(family, "virtex6"))
 			regs = &v6_config_registers;
-		}
 	}
 
 	return hwicap_setup(&pdev->dev, pdev->id, res,
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
index 1f687a71e36e..6b963d1c8ba3 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.h
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
@@ -62,11 +62,13 @@ struct hwicap_drvdata {
 
 struct hwicap_driver_config {
 	/* Read configuration data given by size into the data buffer.
-	   Return 0 if successful. */
+	 * Return 0 if successful.
+	 */
 	int (*get_configuration)(struct hwicap_drvdata *drvdata, u32 *data,
 			u32 size);
 	/* Write configuration data given by size from the data buffer.
-	   Return 0 if successful. */
+	 * Return 0 if successful.
+	 */
 	int (*set_configuration)(struct hwicap_drvdata *drvdata, u32 *data,
 			u32 size);
 	/* Get the status register, bit pattern given by:
-- 
1.9.1
