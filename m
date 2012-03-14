From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 14:20:00 +0000
Subject: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331734803-17954-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a step in the right direction for future Device
Tree support. It will allow variant specific attributes
to be collected from a Device Tree without overloading
the MMCI core. It will also provide additional future
variants a cleaner way to add support.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/Makefile   |    2 +-
 drivers/mmc/host/mmci-arm.c |   65 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.c     |   61 ----------------------------------------
 3 files changed, 66 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mmc/host/mmci-arm.c

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 58e2bdc..0981787 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -2,7 +2,7 @@
 # Makefile for MMC/SD host controller drivers
 #
 
-obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o mmci-ux500.o
+obj-$(CONFIG_MMC_ARMMMCI)	+= mmci.o mmci-ux500.o mmci-arm.o
 obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_IMX)		+= imxmmc.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
diff --git a/drivers/mmc/host/mmci-arm.c b/drivers/mmc/host/mmci-arm.c
new file mode 100644
index 0000000..be78060
--- /dev/null
+++ b/drivers/mmc/host/mmci-arm.c
@@ -0,0 +1,65 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "mmci.h"
+
+static struct variant_data variant_arm = {
+	.fifosize		= 16 * 4,
+	.fifohalfsize		= 8 * 4,
+	.datalength_bits	= 16,
+};
+
+static struct variant_data variant_arm_extended_fifo = {
+	.fifosize		= 128 * 4,
+	.fifohalfsize		= 64 * 4,
+	.datalength_bits	= 16,
+};
+
+static struct amba_id mmci_arm_ids[] = {
+	{
+		.id	= 0x00041180,
+		.mask	= 0xff0fffff,
+		.data	= &variant_arm,
+	},
+	{
+		.id	= 0x01041180,
+		.mask	= 0xff0fffff,
+		.data	= &variant_arm_extended_fifo,
+	},
+	{
+		.id	= 0x00041181,
+		.mask	= 0x000fffff,
+		.data	= &variant_arm,
+	},
+	{ 0, 0 },
+};
+
+MODULE_DEVICE_TABLE(amba, mmci_arm_ids);
+
+static struct amba_driver mmci_arm_driver = {
+	.drv		= {
+		.name	= DRIVER_NAME,
+	},
+	.probe		= mmci_probe,
+	.remove		= __devexit_p(mmci_remove),
+	.suspend	= mmci_suspend,
+	.resume		= mmci_resume,
+	.id_table	= mmci_arm_ids,
+};
+
+static int __init mmci_arm_init(void)
+{
+	return amba_driver_register(&mmci_arm_driver);
+}
+
+static void __exit mmci_arm_exit(void)
+{
+	amba_driver_unregister(&mmci_arm_driver);
+}
+
+module_init(mmci_arm_init);
+module_exit(mmci_arm_exit);
+module_param(fmax, uint, 0444);
+
+MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index ff44586..23b41a5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -37,18 +37,6 @@
 
 #include "mmci.h"
 
-static struct variant_data variant_arm = {
-	.fifosize		= 16 * 4,
-	.fifohalfsize		= 8 * 4,
-	.datalength_bits	= 16,
-};
-
-static struct variant_data variant_arm_extended_fifo = {
-	.fifosize		= 128 * 4,
-	.fifohalfsize		= 64 * 4,
-	.datalength_bits	= 16,
-};
-
 /*
  * This must be called with host->lock held
  */
@@ -1412,52 +1400,3 @@ EXPORT_SYMBOL_GPL(mmci_resume);
 #define mmci_suspend	NULL
 #define mmci_resume	NULL
 #endif
-
-static struct amba_id mmci_ids[] = {
-	{
-		.id	= 0x00041180,
-		.mask	= 0xff0fffff,
-		.data	= &variant_arm,
-	},
-	{
-		.id	= 0x01041180,
-		.mask	= 0xff0fffff,
-		.data	= &variant_arm_extended_fifo,
-	},
-	{
-		.id	= 0x00041181,
-		.mask	= 0x000fffff,
-		.data	= &variant_arm,
-	},
-	{ 0, 0 },
-};
-
-MODULE_DEVICE_TABLE(amba, mmci_ids);
-
-static struct amba_driver mmci_driver = {
-	.drv		= {
-		.name	= DRIVER_NAME,
-	},
-	.probe		= mmci_probe,
-	.remove		= __devexit_p(mmci_remove),
-	.suspend	= mmci_suspend,
-	.resume		= mmci_resume,
-	.id_table	= mmci_ids,
-};
-
-static int __init mmci_init(void)
-{
-	return amba_driver_register(&mmci_driver);
-}
-
-static void __exit mmci_exit(void)
-{
-	amba_driver_unregister(&mmci_driver);
-}
-
-module_init(mmci_init);
-module_exit(mmci_exit);
-module_param(fmax, uint, 0444);
-
-MODULE_DESCRIPTION("ARM PrimeCell PL180/181 Multimedia Card Interface driver");
-MODULE_LICENSE("GPL");
-- 
1.7.5.4
