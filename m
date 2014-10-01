From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  1 Oct 2014 09:32:05 +0200
Subject: [PATCH 1/2] ARM: realview: basic device tree implementation
Message-ID: <1412148725-24519-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements basic device tree boot support for the RealView
platforms, with a basic device tree for ARM PB1176 as an example.

The implementation is done with a new DT-specific board file
using only pre-existing bindings for the basic IRQ, timer and
serial port drivers. A new compatible type is added to the GIC
for the ARM1176.

This implementation uses the MFD syscon handle from day one to
access the system controller registers, and register the devices
using the SoC bus.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v6->v7:
- Split in two patches, one with the machine changes, one with
  the device tree and binding portions.
---
 arch/arm/mach-realview/Kconfig       | 13 +++++++++++++
 arch/arm/mach-realview/Makefile      |  1 +
 arch/arm/mach-realview/realview-dt.c | 32 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c            |  2 ++
 4 files changed, 48 insertions(+)
 create mode 100644 arch/arm/mach-realview/realview-dt.c

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 9db2029aa632..565925f37dc5 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,6 +1,19 @@
 menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
+config REALVIEW_DT
+	bool "Support RealView(R) Device Tree based boot"
+	select ARM_GIC
+	select MFD_SYSCON
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
+	select SOC_REALVIEW
+	select USE_OF
+	help
+	  Include support for booting the ARM(R) RealView(R) evaluation
+	  boards using a device tree machine description.
+
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 541fa4c109ef..e07fdf7ae8a7 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y					:= core.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
new file mode 100644
index 000000000000..cc28b89dd48f
--- /dev/null
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "core.h"
+
+static const char *realview_dt_platform_compat[] __initconst = {
+	"arm,realview-eb",
+	"arm,realview-pb1176",
+	"arm,realview-pb11mp",
+	"arm,realview-pba8",
+	"arm,realview-pbx",
+	NULL,
+};
+
+DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_256M,
+#endif
+	.dt_compat	= realview_dt_platform_compat,
+	.l2c_aux_val = 0x0,
+	.l2c_aux_mask = ~0x0,
+MACHINE_END
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4b959e606fe8..4e75e3f24a97 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1022,6 +1022,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
+IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
+IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
-- 
1.9.3
