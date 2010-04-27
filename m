From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:45 +0530
Subject: [PATCH 07/14] ux500: put DB8500-specific devices in devices-db8500.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-8-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devices-db8500.c for DB8500-specific devices, starting
with SSP0.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile               |    2 +-
 arch/arm/mach-ux500/board-mop500.c         |   21 +++---------------
 arch/arm/mach-ux500/devices-db8500.c       |   30 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |    1 +
 4 files changed, 36 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/mach-ux500/devices-db8500.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index e5b9f74..55651e0 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,6 +3,6 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o
-obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o
+obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index cc52d53..6bb9a3d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -24,6 +24,7 @@
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
+#include <mach/devices.h>
 
 #define __MEM_4K_RESOURCE(x) \
 	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
@@ -91,22 +92,6 @@ static struct pl022_ssp_controller ssp0_platform_data = {
 	.num_chipselect = 5,
 };
 
-static struct amba_device pl022_device = {
-	.dev = {
-		.coherent_dma_mask = ~0,
-		.init_name = "ssp0",
-		.platform_data = &ssp0_platform_data,
-	},
-	.res = {
-		.start = U8500_SSP0_BASE,
-		.end   = U8500_SSP0_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {IRQ_SSP0, NO_IRQ },
-	/* ST-Ericsson modified id */
-	.periphid = SSP_PER_ID,
-};
-
 #define U8500_I2C_RESOURCES(id, size)		\
 static struct resource u8500_i2c_resources_##id[] = {	\
 	[0] = {					\
@@ -175,7 +160,7 @@ static struct amba_device *amba_devs[] __initdata = {
 	&uart0_device,
 	&uart1_device,
 	&uart2_device,
-	&pl022_device,
+	&u8500_ssp0_device,
 };
 
 /* add any platform devices here - TODO */
@@ -190,6 +175,8 @@ static void __init u8500_init_machine(void)
 {
 	int i;
 
+	u8500_ssp0_device.dev.platform_data = &ssp0_platform_data;
+
 	/* Register the active AMBA devices on this board */
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
new file mode 100644
index 0000000..f4a2dda
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/amba/bus.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+
+struct amba_device u8500_ssp0_device = {
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.init_name = "ssp0",
+	},
+	.res = {
+		.start = U8500_SSP0_BASE,
+		.end   = U8500_SSP0_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	.irq = {IRQ_SSP0, NO_IRQ },
+	/* ST-Ericsson modified id */
+	.periphid = SSP_PER_ID,
+};
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 5bca7c6..90229b1 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -11,5 +11,6 @@ struct platform_device;
 struct amba_device;
 
 extern struct amba_device ux500_pl031_device;
+extern struct amba_device u8500_ssp0_device;
 
 #endif
-- 
1.7.0
