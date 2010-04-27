From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:44 +0530
Subject: [PATCH 06/14] ux500: put common devices into devices.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-7-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce devices.c, for placing devices common among Ux500 SoCs.  Start
with the PL031 device.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile               |    2 +-
 arch/arm/mach-ux500/board-mop500.c         |   13 ----------
 arch/arm/mach-ux500/cpu-u8500.c            |    2 +
 arch/arm/mach-ux500/cpu.c                  |   10 +++++++
 arch/arm/mach-ux500/devices.c              |   37 ++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |   15 +++++++++++
 arch/arm/mach-ux500/include/mach/setup.h   |    6 ++++-
 7 files changed, 70 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-ux500/devices.c
 create mode 100644 arch/arm/mach-ux500/include/mach/devices.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 6deee85..e5b9f74 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= clock.o cpu.o
+obj-y				:= clock.o cpu.o devices.o
 obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9ca4709..cc52d53 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -107,18 +107,6 @@ static struct amba_device pl022_device = {
 	.periphid = SSP_PER_ID,
 };
 
-static struct amba_device pl031_device = {
-	.dev = {
-		.init_name = "pl031",
-	},
-	.res = {
-		.start = U8500_RTC_BASE,
-		.end = U8500_RTC_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {IRQ_RTC_RTT, NO_IRQ},
-};
-
 #define U8500_I2C_RESOURCES(id, size)		\
 static struct resource u8500_i2c_resources_##id[] = {	\
 	[0] = {					\
@@ -188,7 +176,6 @@ static struct amba_device *amba_devs[] __initdata = {
 	&uart1_device,
 	&uart2_device,
 	&pl022_device,
-	&pl031_device,
 };
 
 /* add any platform devices here - TODO */
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index c80beca..730d020 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -106,6 +106,8 @@ void __init u8500_map_io(void)
  */
 void __init u8500_init_devices(void)
 {
+	ux500_init_devices();
+
 	/* Register the platform devices */
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e6a8058..05615c0 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -16,6 +16,7 @@
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
+#include <mach/devices.h>
 
 #include "clock.h"
 
@@ -41,11 +42,20 @@ static struct map_desc ux500_io_desc[] __initdata = {
 	__IO_DEV_DESC(UX500_BACKUPRAM0_BASE, SZ_8K),
 };
 
+static struct amba_device *ux500_amba_devs[] __initdata = {
+	&ux500_pl031_device,
+};
+
 void __init ux500_map_io(void)
 {
 	iotable_init(ux500_io_desc, ARRAY_SIZE(ux500_io_desc));
 }
 
+void __init ux500_init_devices(void)
+{
+	amba_add_devices(ux500_amba_devs, ARRAY_SIZE(ux500_amba_devs));
+}
+
 void __init ux500_init_irq(void)
 {
 	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
new file mode 100644
index 0000000..eef686a
--- /dev/null
+++ b/arch/arm/mach-ux500/devices.c
@@ -0,0 +1,37 @@
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
+struct amba_device ux500_pl031_device = {
+	.dev = {
+		.init_name = "pl031",
+	},
+	.res = {
+		.start	= UX500_RTC_BASE,
+		.end	= UX500_RTC_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	.irq = {IRQ_RTC_RTT, NO_IRQ},
+};
+
+void __init amba_add_devices(struct amba_device *devs[], int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		struct amba_device *d = devs[i];
+		amba_device_register(d, &iomem_resource);
+	}
+}
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
new file mode 100644
index 0000000..5bca7c6
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __ASM_ARCH_DEVICES_H__
+#define __ASM_ARCH_DEVICES_H__
+
+struct platform_device;
+struct amba_device;
+
+extern struct amba_device ux500_pl031_device;
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 6c4c348..6187eff 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -17,11 +17,15 @@
 extern void __init ux500_map_io(void);
 extern void __init u8500_map_io(void);
 
-extern void u8500_init_devices(void);
+extern void __init ux500_init_devices(void);
+extern void __init u8500_init_devices(void);
+
 extern void __init ux500_init_irq(void);
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
+extern void __init amba_add_devices(struct amba_device *devs[], int num);
+
 struct sys_timer;
 extern struct sys_timer u8500_timer;
 
-- 
1.7.0
