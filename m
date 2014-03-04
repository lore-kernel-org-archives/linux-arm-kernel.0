From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  4 Mar 2014 18:51:47 +0100
Subject: [PATCH] ARM: mvebu: Add a SOC bus device entry
Message-ID: <1393955507-26436-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SoC Family, device ID and revision to /sys/bus/soc.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/Kconfig        |  1 +
 arch/arm/mach-mvebu/mvebu-soc-id.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 4cfc4d8abcac..16f3713654cf 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -10,6 +10,7 @@ config ARCH_MVEBU
 	select PINCTRL
 	select PLAT_ORION
 	select SPARSE_IRQ
+	select SOC_BUS
 	select CLKDEV_LOOKUP
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index f3d4cf53f746..72ea6b6d4ed2 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -23,6 +23,8 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include "mvebu-soc-id.h"
 
 #define PCIE_DEV_ID_OFF		0x0
@@ -118,3 +120,29 @@ clk_err:
 }
 core_initcall(mvebu_soc_id_init);
 
+static int __init mvebu_soc_device(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+
+	/* Also protects against running on non-mvebu systems */
+	if (!is_id_valid)
+		return;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Marvell");
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X", soc_rev);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%X", soc_dev_id);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+	}
+}
+postcore_initcall(mvebu_soc_device);
-- 
1.9.0
