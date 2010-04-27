From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:52 +0530
Subject: [PATCH 14/14] ux500: add U5500 support
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-15-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for the U5500 platform.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Kconfig                 |   17 ++++++---
 arch/arm/mach-ux500/Makefile                |    2 +
 arch/arm/mach-ux500/board-u5500.c           |   41 ++++++++++++++++++++++
 arch/arm/mach-ux500/clock.c                 |    4 ++
 arch/arm/mach-ux500/cpu-db5500.c            |   50 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-db5500.c        |   46 ++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h  |    1 +
 arch/arm/mach-ux500/include/mach/hardware.h |    9 +++++
 arch/arm/mach-ux500/include/mach/setup.h    |    2 +
 9 files changed, 166 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-u5500.c
 create mode 100644 arch/arm/mach-ux500/cpu-db5500.c
 create mode 100644 arch/arm/mach-ux500/devices-db5500.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 8ad5ee8..6625e5b 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -13,19 +13,24 @@ config UX500_SOC_DB8500
 config UX500_SOC_DB5500
 	bool
 
-menu "ST-Ericsson platform type"
-
-comment "ST-Ericsson Multicore Mobile Platforms"
+choice
+	prompt "Ux500 target platform"
+	default MACH_U8500_MOP
 
 config MACH_U8500_MOP
-	bool "U8500 Early Development platform"
-	default y
+	bool "U8500 Development platform"
 	select UX500_SOC_DB8500
 	help
 	  Include support for mop500 development platform
 	  based on U8500 architecture. The platform is based
 	  on early drop silicon version of 8500.
-endmenu
+
+config MACH_U5500
+	bool "U5500 Development platform"
+	select UX500_SOC_DB5500
+	help
+	  Include support for the U5500 development platform.
+endchoice
 
 config UX500_DEBUG_UART
 	int "Ux500 UART to use for low-level debug"
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 2eb7685..c7bc419 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,6 +3,8 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o
+obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
+obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
new file mode 100644
index 0000000..4430e69
--- /dev/null
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <linux/gpio.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/hardware.h>
+#include <mach/devices.h>
+#include <mach/setup.h>
+
+static struct amba_device *amba_board_devs[] __initdata = {
+	&ux500_uart0_device,
+	&ux500_uart1_device,
+	&ux500_uart2_device,
+};
+
+static void __init u5500_init_machine(void)
+{
+	u5500_init_devices();
+
+	amba_add_devices(amba_board_devs, ARRAY_SIZE(amba_board_devs));
+}
+
+MACHINE_START(U8500, "ST-Ericsson U5500 Platform")
+	.phys_io	= UX500_UART0_BASE,
+	.io_pg_offst	= (IO_ADDRESS(UX500_UART0_BASE) >> 18) & 0xfffc,
+	.boot_params	= 0x00000100,
+	.map_io		= u5500_map_io,
+	.init_irq	= ux500_init_irq,
+	.timer		= &ux500_timer,
+	.init_machine	= u5500_init_machine,
+MACHINE_END
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index d16b8b5..c325dad 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -502,6 +502,10 @@ static int __init clk_init(void)
 	if (cpu_is_u8500ed()) {
 		clk_prcmu_ops.enable = clk_prcmu_ed_enable;
 		clk_prcmu_ops.disable = clk_prcmu_ed_disable;
+	} else if (cpu_is_u5500()) {
+		/* Clock tree for U5500 not implemented yet */
+		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
+		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
 	}
 
 	clkdev_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
new file mode 100644
index 0000000..6a3ac45
--- /dev/null
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <linux/io.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/devices.h>
+#include <mach/setup.h>
+
+static struct map_desc u5500_io_desc[] __initdata = {
+	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GPIO1_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GPIO2_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GPIO3_BASE, SZ_4K),
+	__IO_DEV_DESC(U5500_GPIO4_BASE, SZ_4K),
+};
+
+static struct platform_device *u5500_platform_devs[] __initdata = {
+	&u5500_gpio_devs[0],
+	&u5500_gpio_devs[1],
+	&u5500_gpio_devs[2],
+	&u5500_gpio_devs[3],
+	&u5500_gpio_devs[4],
+	&u5500_gpio_devs[5],
+	&u5500_gpio_devs[6],
+	&u5500_gpio_devs[7],
+};
+
+void __init u5500_map_io(void)
+{
+	ux500_map_io();
+
+	iotable_init(u5500_io_desc, ARRAY_SIZE(u5500_io_desc));
+}
+
+void __init u5500_init_devices(void)
+{
+	ux500_init_devices();
+
+	platform_add_devices(u5500_platform_devs,
+			     ARRAY_SIZE(u5500_platform_devs));
+}
diff --git a/arch/arm/mach-ux500/devices-db5500.c b/arch/arm/mach-ux500/devices-db5500.c
new file mode 100644
index 0000000..33e5b56
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-db5500.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+
+#include <mach/hardware.h>
+#include <mach/devices.h>
+
+static struct nmk_gpio_platform_data u5500_gpio_data[] = {
+	GPIO_DATA("GPIO-0-31", 0),
+	GPIO_DATA("GPIO-32-63", 32), /* 36..63 not routed to pin */
+	GPIO_DATA("GPIO-64-95", 64), /* 83..95 not routed to pin */
+	GPIO_DATA("GPIO-96-127", 96), /* 102..127 not routed to pin */
+	GPIO_DATA("GPIO-128-159", 128), /* 149..159 not routed to pin */
+	GPIO_DATA("GPIO-160-191", 160),
+	GPIO_DATA("GPIO-192-223", 192),
+	GPIO_DATA("GPIO-224-255", 224), /* 228..255 not routed to pin */
+};
+
+static struct resource u5500_gpio_resources[] = {
+	GPIO_RESOURCE(0),
+	GPIO_RESOURCE(1),
+	GPIO_RESOURCE(2),
+	GPIO_RESOURCE(3),
+	GPIO_RESOURCE(4),
+	GPIO_RESOURCE(5),
+	GPIO_RESOURCE(6),
+	GPIO_RESOURCE(7),
+};
+
+struct platform_device u5500_gpio_devs[] = {
+	GPIO_DEVICE(0),
+	GPIO_DEVICE(1),
+	GPIO_DEVICE(2),
+	GPIO_DEVICE(3),
+	GPIO_DEVICE(4),
+	GPIO_DEVICE(5),
+	GPIO_DEVICE(6),
+	GPIO_DEVICE(7),
+};
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 76b3569..0422af0 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -10,6 +10,7 @@
 struct platform_device;
 struct amba_device;
 
+extern struct platform_device u5500_gpio_devs[];
 extern struct platform_device u8500_gpio_devs[];
 
 extern struct amba_device ux500_pl031_device;
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 1353f17..8656379 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -114,6 +114,15 @@ static inline bool cpu_is_u8500v1(void)
 	return cpu_is_u8500() && (read_cpuid_id() & 15) == 1;
 }
 
+static inline bool cpu_is_u5500(void)
+{
+#ifdef CONFIG_UX500_SOC_DB5500
+	return 1;
+#else
+	return 0;
+#endif
+}
+
 #endif
 
 #endif				/* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index c730d07..e978dbd 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -15,9 +15,11 @@
 #include <linux/init.h>
 
 extern void __init ux500_map_io(void);
+extern void __init u5500_map_io(void);
 extern void __init u8500_map_io(void);
 
 extern void __init ux500_init_devices(void);
+extern void __init u5500_init_devices(void);
 extern void __init u8500_init_devices(void);
 
 extern void __init ux500_init_irq(void);
-- 
1.7.0
