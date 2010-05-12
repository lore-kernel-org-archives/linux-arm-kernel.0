From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:30 -0700
Subject: [PATCH 01/25] msm: generalization to support multiple SOCs.
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory Bean <gbean@codeaurora.org>

devices.c is specific to the MSM7x00 series of SOCs.  Rename
appropriately in preparation to support more devices.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Makefile          |    5 +-
 arch/arm/mach-msm/devices-msm7x00.c |  346 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-msm/devices.c         |  346 -----------------------------------
 3 files changed, 348 insertions(+), 349 deletions(-)
 create mode 100644 arch/arm/mach-msm/devices-msm7x00.c
 delete mode 100644 arch/arm/mach-msm/devices.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 147339c..435d83c 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,5 +1,4 @@
 obj-y += io.o idle.o irq.o timer.o dma.o
-obj-y += devices.o
 obj-y += proc_comm.o
 obj-y += vreg.o
 obj-y += acpuclock-arm11.o
@@ -8,5 +7,5 @@ obj-y += clock.o clock-7x01a.o
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
-obj-$(CONFIG_MACH_TROUT) += board-trout.o
-obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o
+obj-$(CONFIG_MACH_TROUT) += board-trout.o devices-msm7x00.o
+obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
diff --git a/arch/arm/mach-msm/devices-msm7x00.c b/arch/arm/mach-msm/devices-msm7x00.c
new file mode 100644
index 0000000..982f1da
--- /dev/null
+++ b/arch/arm/mach-msm/devices-msm7x00.c
@@ -0,0 +1,346 @@
+/* linux/arch/arm/mach-msm/devices.c
+ *
+ * Copyright (C) 2008 Google, Inc.
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
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/msm_iomap.h>
+#include "devices.h"
+
+#include <asm/mach/flash.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <mach/mmc.h>
+
+static struct resource resources_uart1[] = {
+	{
+		.start	= INT_UART1,
+		.end	= INT_UART1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= MSM_UART1_PHYS,
+		.end	= MSM_UART1_PHYS + MSM_UART1_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart2[] = {
+	{
+		.start	= INT_UART2,
+		.end	= INT_UART2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= MSM_UART2_PHYS,
+		.end	= MSM_UART2_PHYS + MSM_UART2_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource resources_uart3[] = {
+	{
+		.start	= INT_UART3,
+		.end	= INT_UART3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= MSM_UART3_PHYS,
+		.end	= MSM_UART3_PHYS + MSM_UART3_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device msm_device_uart1 = {
+	.name	= "msm_serial",
+	.id	= 0,
+	.num_resources	= ARRAY_SIZE(resources_uart1),
+	.resource	= resources_uart1,
+};
+
+struct platform_device msm_device_uart2 = {
+	.name	= "msm_serial",
+	.id	= 1,
+	.num_resources	= ARRAY_SIZE(resources_uart2),
+	.resource	= resources_uart2,
+};
+
+struct platform_device msm_device_uart3 = {
+	.name	= "msm_serial",
+	.id	= 2,
+	.num_resources	= ARRAY_SIZE(resources_uart3),
+	.resource	= resources_uart3,
+};
+
+static struct resource resources_i2c[] = {
+	{
+		.start	= MSM_I2C_PHYS,
+		.end	= MSM_I2C_PHYS + MSM_I2C_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_PWB_I2C,
+		.end	= INT_PWB_I2C,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device msm_device_i2c = {
+	.name		= "msm_i2c",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(resources_i2c),
+	.resource	= resources_i2c,
+};
+
+static struct resource resources_hsusb[] = {
+	{
+		.start	= MSM_HSUSB_PHYS,
+		.end	= MSM_HSUSB_PHYS + MSM_HSUSB_SIZE,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_USB_HS,
+		.end	= INT_USB_HS,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device msm_device_hsusb = {
+	.name		= "msm_hsusb",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_hsusb),
+	.resource	= resources_hsusb,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct flash_platform_data msm_nand_data = {
+	.parts		= NULL,
+	.nr_parts	= 0,
+};
+
+static struct resource resources_nand[] = {
+	[0] = {
+		.start	= 7,
+		.end	= 7,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device msm_device_nand = {
+	.name		= "msm_nand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(resources_nand),
+	.resource	= resources_nand,
+	.dev		= {
+		.platform_data	= &msm_nand_data,
+	},
+};
+
+struct platform_device msm_device_smd = {
+	.name	= "msm_smd",
+	.id	= -1,
+};
+
+static struct resource resources_sdc1[] = {
+	{
+		.start	= MSM_SDC1_PHYS,
+		.end	= MSM_SDC1_PHYS + MSM_SDC1_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC1_0,
+		.end	= INT_SDC1_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+	{
+		.start	= INT_SDC1_1,
+		.end	= INT_SDC1_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc2[] = {
+	{
+		.start	= MSM_SDC2_PHYS,
+		.end	= MSM_SDC2_PHYS + MSM_SDC2_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC2_0,
+		.end	= INT_SDC2_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC2_1,
+		.end	= INT_SDC2_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc3[] = {
+	{
+		.start	= MSM_SDC3_PHYS,
+		.end	= MSM_SDC3_PHYS + MSM_SDC3_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC3_0,
+		.end	= INT_SDC3_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC3_1,
+		.end	= INT_SDC3_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc4[] = {
+	{
+		.start	= MSM_SDC4_PHYS,
+		.end	= MSM_SDC4_PHYS + MSM_SDC4_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC4_0,
+		.end	= INT_SDC4_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC4_1,
+		.end	= INT_SDC4_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device msm_device_sdc1 = {
+	.name		= "msm_sdcc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(resources_sdc1),
+	.resource	= resources_sdc1,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc2 = {
+	.name		= "msm_sdcc",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(resources_sdc2),
+	.resource	= resources_sdc2,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc3 = {
+	.name		= "msm_sdcc",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(resources_sdc3),
+	.resource	= resources_sdc3,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc4 = {
+	.name		= "msm_sdcc",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(resources_sdc4),
+	.resource	= resources_sdc4,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+static struct platform_device *msm_sdcc_devices[] __initdata = {
+	&msm_device_sdc1,
+	&msm_device_sdc2,
+	&msm_device_sdc3,
+	&msm_device_sdc4,
+};
+
+int __init msm_add_sdcc(unsigned int controller, struct mmc_platform_data *plat,
+			unsigned int stat_irq, unsigned long stat_irq_flags)
+{
+	struct platform_device	*pdev;
+	struct resource *res;
+
+	if (controller < 1 || controller > 4)
+		return -EINVAL;
+
+	pdev = msm_sdcc_devices[controller-1];
+	pdev->dev.platform_data = plat;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "status_irq");
+	if (!res)
+		return -EINVAL;
+	else if (stat_irq) {
+		res->start = res->end = stat_irq;
+		res->flags &= ~IORESOURCE_DISABLED;
+		res->flags |= stat_irq_flags;
+	}
+
+	return platform_device_register(pdev);
+}
+
diff --git a/arch/arm/mach-msm/devices.c b/arch/arm/mach-msm/devices.c
deleted file mode 100644
index 982f1da..0000000
--- a/arch/arm/mach-msm/devices.c
+++ /dev/null
@@ -1,346 +0,0 @@
-/* linux/arch/arm/mach-msm/devices.c
- *
- * Copyright (C) 2008 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/msm_iomap.h>
-#include "devices.h"
-
-#include <asm/mach/flash.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-
-#include <mach/mmc.h>
-
-static struct resource resources_uart1[] = {
-	{
-		.start	= INT_UART1,
-		.end	= INT_UART1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= MSM_UART1_PHYS,
-		.end	= MSM_UART1_PHYS + MSM_UART1_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource resources_uart2[] = {
-	{
-		.start	= INT_UART2,
-		.end	= INT_UART2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= MSM_UART2_PHYS,
-		.end	= MSM_UART2_PHYS + MSM_UART2_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct resource resources_uart3[] = {
-	{
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= MSM_UART3_PHYS,
-		.end	= MSM_UART3_PHYS + MSM_UART3_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device msm_device_uart1 = {
-	.name	= "msm_serial",
-	.id	= 0,
-	.num_resources	= ARRAY_SIZE(resources_uart1),
-	.resource	= resources_uart1,
-};
-
-struct platform_device msm_device_uart2 = {
-	.name	= "msm_serial",
-	.id	= 1,
-	.num_resources	= ARRAY_SIZE(resources_uart2),
-	.resource	= resources_uart2,
-};
-
-struct platform_device msm_device_uart3 = {
-	.name	= "msm_serial",
-	.id	= 2,
-	.num_resources	= ARRAY_SIZE(resources_uart3),
-	.resource	= resources_uart3,
-};
-
-static struct resource resources_i2c[] = {
-	{
-		.start	= MSM_I2C_PHYS,
-		.end	= MSM_I2C_PHYS + MSM_I2C_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_PWB_I2C,
-		.end	= INT_PWB_I2C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device msm_device_i2c = {
-	.name		= "msm_i2c",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(resources_i2c),
-	.resource	= resources_i2c,
-};
-
-static struct resource resources_hsusb[] = {
-	{
-		.start	= MSM_HSUSB_PHYS,
-		.end	= MSM_HSUSB_PHYS + MSM_HSUSB_SIZE,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_USB_HS,
-		.end	= INT_USB_HS,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device msm_device_hsusb = {
-	.name		= "msm_hsusb",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(resources_hsusb),
-	.resource	= resources_hsusb,
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct flash_platform_data msm_nand_data = {
-	.parts		= NULL,
-	.nr_parts	= 0,
-};
-
-static struct resource resources_nand[] = {
-	[0] = {
-		.start	= 7,
-		.end	= 7,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-struct platform_device msm_device_nand = {
-	.name		= "msm_nand",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(resources_nand),
-	.resource	= resources_nand,
-	.dev		= {
-		.platform_data	= &msm_nand_data,
-	},
-};
-
-struct platform_device msm_device_smd = {
-	.name	= "msm_smd",
-	.id	= -1,
-};
-
-static struct resource resources_sdc1[] = {
-	{
-		.start	= MSM_SDC1_PHYS,
-		.end	= MSM_SDC1_PHYS + MSM_SDC1_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_SDC1_0,
-		.end	= INT_SDC1_0,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "cmd_irq",
-	},
-	{
-		.start	= INT_SDC1_1,
-		.end	= INT_SDC1_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
-		.name	= "status_irq"
-	},
-	{
-		.start	= 8,
-		.end	= 8,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct resource resources_sdc2[] = {
-	{
-		.start	= MSM_SDC2_PHYS,
-		.end	= MSM_SDC2_PHYS + MSM_SDC2_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_SDC2_0,
-		.end	= INT_SDC2_0,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "cmd_irq",
-	},
-		{
-		.start	= INT_SDC2_1,
-		.end	= INT_SDC2_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
-		.name	= "status_irq"
-	},
-	{
-		.start	= 8,
-		.end	= 8,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct resource resources_sdc3[] = {
-	{
-		.start	= MSM_SDC3_PHYS,
-		.end	= MSM_SDC3_PHYS + MSM_SDC3_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_SDC3_0,
-		.end	= INT_SDC3_0,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "cmd_irq",
-	},
-		{
-		.start	= INT_SDC3_1,
-		.end	= INT_SDC3_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
-		.name	= "status_irq"
-	},
-	{
-		.start	= 8,
-		.end	= 8,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct resource resources_sdc4[] = {
-	{
-		.start	= MSM_SDC4_PHYS,
-		.end	= MSM_SDC4_PHYS + MSM_SDC4_SIZE - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= INT_SDC4_0,
-		.end	= INT_SDC4_0,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "cmd_irq",
-	},
-		{
-		.start	= INT_SDC4_1,
-		.end	= INT_SDC4_1,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "pio_irq",
-	},
-	{
-		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
-		.name	= "status_irq"
-	},
-	{
-		.start	= 8,
-		.end	= 8,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-struct platform_device msm_device_sdc1 = {
-	.name		= "msm_sdcc",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(resources_sdc1),
-	.resource	= resources_sdc1,
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device msm_device_sdc2 = {
-	.name		= "msm_sdcc",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(resources_sdc2),
-	.resource	= resources_sdc2,
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device msm_device_sdc3 = {
-	.name		= "msm_sdcc",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(resources_sdc3),
-	.resource	= resources_sdc3,
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-struct platform_device msm_device_sdc4 = {
-	.name		= "msm_sdcc",
-	.id		= 4,
-	.num_resources	= ARRAY_SIZE(resources_sdc4),
-	.resource	= resources_sdc4,
-	.dev		= {
-		.coherent_dma_mask	= 0xffffffff,
-	},
-};
-
-static struct platform_device *msm_sdcc_devices[] __initdata = {
-	&msm_device_sdc1,
-	&msm_device_sdc2,
-	&msm_device_sdc3,
-	&msm_device_sdc4,
-};
-
-int __init msm_add_sdcc(unsigned int controller, struct mmc_platform_data *plat,
-			unsigned int stat_irq, unsigned long stat_irq_flags)
-{
-	struct platform_device	*pdev;
-	struct resource *res;
-
-	if (controller < 1 || controller > 4)
-		return -EINVAL;
-
-	pdev = msm_sdcc_devices[controller-1];
-	pdev->dev.platform_data = plat;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "status_irq");
-	if (!res)
-		return -EINVAL;
-	else if (stat_irq) {
-		res->start = res->end = stat_irq;
-		res->flags &= ~IORESOURCE_DISABLED;
-		res->flags |= stat_irq_flags;
-	}
-
-	return platform_device_register(pdev);
-}
-
-- 
1.6.2.3
