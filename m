From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:22:08 -0500
Subject: [PATCH v4 11/15] drivers/bus: add ARM CCI support
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On ARM multi-cluster systems coherency between cores running on
different clusters is managed by the cache-coherent interconnect (CCI).
It allows broadcasting of TLB invalidates and memory barriers and it
guarantees cache coherency at system level.

This patch enables the basic infrastructure required in Linux to
handle and programme the CCI component. The first implementation is
based on a platform device, its relative DT compatible property and
a simple programming interface.

Very basic for now.  More functionalities will come later.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/bus/Kconfig     |   4 ++
 drivers/bus/Makefile    |   2 +
 drivers/bus/arm-cci.c   | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/arm-cci.h |  30 +++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 drivers/bus/arm-cci.c
 create mode 100644 include/linux/arm-cci.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0f51ed687d..d032f74ff2 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -19,4 +19,8 @@ config OMAP_INTERCONNECT
 
 	help
 	  Driver to enable OMAP interconnect error handling driver.
+
+config ARM_CCI
+       bool "ARM CCI driver support"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 45d997c854..55aac809e5 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -6,3 +6,5 @@ obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
+
+obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
new file mode 100644
index 0000000000..11c1513440
--- /dev/null
+++ b/drivers/bus/arm-cci.c
@@ -0,0 +1,112 @@
+/*
+ * ARM Cache Coherency Interconnect (CCI400) support
+ *
+ * Copyright (C) 2012-2013 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/arm-cci.h>
+
+
+#define CCI_STATUS_OFFSET	0xc
+#define STATUS_CHANGE_PENDING	(1 << 0)
+
+#define CCI_SLAVE_OFFSET(n)	(0x1000 + 0x1000 * (n))
+#define CCI400_EAG_OFFSET       CCI_SLAVE_OFFSET(3)
+#define CCI400_KF_OFFSET        CCI_SLAVE_OFFSET(4)
+
+#define DRIVER_NAME	"CCI"
+struct cci_drvdata {
+	void __iomem *baseaddr;
+};
+
+static struct cci_drvdata *info;
+
+void disable_cci(int cluster)
+{
+	u32 slave_reg = cluster ? CCI400_KF_OFFSET : CCI400_EAG_OFFSET;
+	writel_relaxed(0x0, info->baseaddr + slave_reg);
+
+	while (readl_relaxed(info->baseaddr + CCI_STATUS_OFFSET)
+						& STATUS_CHANGE_PENDING)
+			barrier();
+}
+EXPORT_SYMBOL_GPL(disable_cci);
+
+static int cci_driver_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret = 0;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		dev_err(&pdev->dev, "unable to allocate mem\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No memory resource\n");
+		ret = -EINVAL;
+		goto mem_free;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+				dev_name(&pdev->dev))) {
+		dev_err(&pdev->dev, "address 0x%x in use\n", (u32) res->start);
+		ret = -EBUSY;
+		goto mem_free;
+	}
+
+	info->baseaddr = ioremap(res->start, resource_size(res));
+	if (!info->baseaddr) {
+		ret = -EADDRNOTAVAIL;
+		goto ioremap_err;
+	}
+
+	platform_set_drvdata(pdev, info);
+
+	pr_info("CCI loaded at %p\n", info->baseaddr);
+	return ret;
+
+ioremap_err:
+	release_region(res->start, resource_size(res));
+mem_free:
+	kfree(info);
+
+	return ret;
+}
+
+static const struct of_device_id arm_cci_matches[] = {
+	{.compatible = "arm,cci"},
+	{},
+};
+
+static struct platform_driver cci_platform_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+		   .of_match_table = arm_cci_matches,
+		  },
+	.probe = cci_driver_probe,
+};
+
+static int __init cci_init(void)
+{
+	return platform_driver_register(&cci_platform_driver);
+}
+
+core_initcall(cci_init);
diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
new file mode 100644
index 0000000000..86ae587817
--- /dev/null
+++ b/include/linux/arm-cci.h
@@ -0,0 +1,30 @@
+/*
+ * CCI support
+ *
+ * Copyright (C) 2012-2013 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LINUX_ARM_CCI_H
+#define __LINUX_ARM_CCI_H
+
+#ifdef CONFIG_ARM_CCI
+extern void disable_cci(int cluster);
+#else
+static inline void disable_cci(int cluster) { }
+#endif
+
+#endif
-- 
1.8.1.2
