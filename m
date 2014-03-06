From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:54 -0800
Subject: [PATCH 1/6] ARM: BCM63XX: add basic support for the Broadcom BCM63138
 DSL SoC
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for the Broadcom BCM63138 DSL SoC which is
using a dual-core Cortex A9 system. Add the very minimum required code
boot Linux on this SoC.

Due to the two specific register address spaces located at 0x8000_0000
and 0xfffe_0000, we need to setup a specific iotable descriptor for
those to be remapped at the expected virtual addresses.

Finally, the PL310 cache controller requires a bit of tweaking before
handing its initialization over l2x0_of_init(), this is also taken care
of to make sure that its size is properly configured.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/bcm63138.txt       |  9 +++
 arch/arm/mach-bcm/Kconfig                          | 20 +++++
 arch/arm/mach-bcm/Makefile                         |  2 +
 arch/arm/mach-bcm/bcm63xx.h                        | 29 +++++++
 arch/arm/mach-bcm/board_bcm63xx.c                  | 94 ++++++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
 create mode 100644 arch/arm/mach-bcm/bcm63xx.h
 create mode 100644 arch/arm/mach-bcm/board_bcm63xx.c

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
new file mode 100644
index 000000000000..bd49987a8812
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm63138.txt
@@ -0,0 +1,9 @@
+Broadcom BCM63138 DSL System-on-a-Chip device tree bindings
+-----------------------------------------------------------
+
+Boards compatible with the BCM63138 DSL System-on-a-Chip should have the
+following properties:
+
+Required root node property:
+
+compatible: should be "brcm,bcm63138"
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index b1aa6a9b3bd1..951e1ec47a04 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -32,6 +32,26 @@ config ARCH_BCM_MOBILE
 	  BCM11130, BCM11140, BCM11351, BCM28145 and
 	  BCM28155 variants.
 
+config ARCH_BCM_63XX
+	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
+	depends on MMU
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CACHE_L2X0
+	select COMMON_CLK
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_ARM_TWD if SMP
+	select HAVE_ARM_SCU if SMP
+	select HAVE_SMP
+	help
+	  This enables support for systems based on Broadcom DSL SoCs.
+	  It currently supports the 'BCM63XX' ARM-based family, which includes
+	  the BCM63138 variant.
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index c2ccd5a0f772..3bf068ac797a 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -13,3 +13,5 @@
 obj-$(CONFIG_ARCH_BCM_MOBILE)	:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
+
+obj-$(CONFIG_ARCH_BCM_63XX)	:= board_bcm63xx.o
diff --git a/arch/arm/mach-bcm/bcm63xx.h b/arch/arm/mach-bcm/bcm63xx.h
new file mode 100644
index 000000000000..95872c8131f6
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm63xx.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2014 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARM_BCM63XX_H
+#define __ARM_BCM63XX_H
+
+#define IO_ADDRESS(x)		(((x) & 0x00ffffff) + 0xfc000000)
+
+/* AHB register space */
+#define BCM63XX_AHB_PHYS	0x80001000
+#define BCM63XX_AHB_VIRT	IO_ADDRESS(BCM63XX_AHB_PHYS)
+#define BCM63XX_AHB_SIZE	0x800000
+
+/* PERIPH (legacy) register space */
+#define BCM63XX_PERIPH_PHYS	0xfffe8000
+#define BCM63XX_PERIPH_VIRT	IO_ADDRESS(BCM63XX_PERIPH_PHYS)
+#define BCM63XX_PERIPH_SIZE	0x10000
+
+#endif /* __ARM_BCM63XX_H */
diff --git a/arch/arm/mach-bcm/board_bcm63xx.c b/arch/arm/mach-bcm/board_bcm63xx.c
new file mode 100644
index 000000000000..a779aca673c4
--- /dev/null
+++ b/arch/arm/mach-bcm/board_bcm63xx.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2014 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_platform.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/clocksource.h>
+#include <linux/irqchip.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include "bcm63xx.h"
+
+static void __init bcm63xx_l2cc_init(void)
+{
+	u32 auxctl_val = 0, auxctl_msk = ~0UL;
+
+	/* 16-way cache */
+	auxctl_val |= (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT);
+	auxctl_msk &= ~(1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT);
+	/* 32 KB */
+	auxctl_val |= (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+	auxctl_msk &= ~(L2X0_AUX_CTRL_WAY_SIZE_MASK);
+
+	/*
+	 * Set bit 22 in the auxiliary control register. If this bit
+	 * is cleared, PL310 treats Normal Shared Non-cacheable
+	 * accesses as Cacheable no-allocate.
+	 */
+	auxctl_val |= (1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT);
+
+	/* Allow non-secure access */
+	auxctl_val |= (1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT);
+	/* Instruction prefetch */
+	auxctl_val |= (1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT);
+	/* Early BRESP */
+	auxctl_val |= (1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
+
+	l2x0_of_init(auxctl_val, auxctl_msk);
+}
+
+static void __init bcm63xx_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL,
+		&platform_bus);
+	bcm63xx_l2cc_init();
+}
+
+static const char * const bcm63xx_dt_compat[] = {
+	"brcm,bcm63138",
+	NULL
+};
+
+static struct map_desc bcm63xx_map_desc[] __initdata = {
+	/* AHB register space */
+	{
+		.virtual = BCM63XX_AHB_VIRT,
+		.pfn = __phys_to_pfn(BCM63XX_AHB_PHYS),
+		.length	= BCM63XX_AHB_SIZE,
+		.type = MT_DEVICE,
+	},
+	/* PERIPH register space */
+	{
+		.virtual = BCM63XX_PERIPH_VIRT,
+		.pfn = __phys_to_pfn(BCM63XX_PERIPH_PHYS),
+		.length = BCM63XX_PERIPH_SIZE,
+		.type = MT_DEVICE,
+	},
+};
+
+static void __init bcm63xx_map_io(void)
+{
+	iotable_init(bcm63xx_map_desc, ARRAY_SIZE(bcm63xx_map_desc));
+}
+
+DT_MACHINE_START(BCM63XXX_DT, "BCM63xx DSL SoC")
+	.map_io		= bcm63xx_map_io,
+	.init_machine	= bcm63xx_init,
+	.dt_compat	= bcm63xx_dt_compat,
+MACHINE_END
-- 
1.8.3.2
