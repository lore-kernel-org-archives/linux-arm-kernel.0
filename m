From: joel@jms.id.au (Joel Stanley)
Date: Thu, 21 Apr 2016 17:34:08 +0930
Subject: [PATCH v2 10/11] arm: Add Aspeed machine
In-Reply-To: <1461225849-28074-1-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
Message-ID: <1461225849-28074-11-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aspeed devices are a common Baseboard Management Controller (BMC)
system on chip containing an ARM9 or ARM11 core, off-chip DDR RAM and
support for a large number of peripherals.

This patch adds basic support for the ast2400 and ast2500 machines,
capable of booting to a prompt in QEMU (-M palmetto-bmc), on an
Palmetto OpenPower development machine, and on the ast2500 EVB.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS                   |  8 +++++
 arch/arm/Kconfig              |  2 ++
 arch/arm/Makefile             |  1 +
 arch/arm/mach-aspeed/Kconfig  | 28 +++++++++++++++
 arch/arm/mach-aspeed/Makefile |  3 ++
 arch/arm/mach-aspeed/aspeed.c | 83 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/Kconfig
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/aspeed.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a323a6b2cf..d0a1962f7753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,14 @@ F:	arch/arm/mach-artpec
 F:	arch/arm/boot/dts/artpec6*
 F:	drivers/clk/clk-artpec6.c
 
+ARM/ASPEED MACHINE SUPPORT
+M:	Joel Stanley <joel@jms.id.au>
+S:	Maintained
+F:	arch/arm/mach-aspeed/
+F:	arch/arm/boot/dts/aspeed-*
+F:	arch/arm/boot/dts/ast2400.dtsi
+F:	drivers/*/*aspeed*
+
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
 M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..c4512f6b77f6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -775,6 +775,8 @@ source "arch/arm/mach-meson/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
 
+source "arch/arm/mach-aspeed/Kconfig"
+
 source "arch/arm/mach-mv78xx0/Kconfig"
 
 source "arch/arm/mach-imx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c3ce2ac44c4..8ab09fb78e1c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -184,6 +184,7 @@ machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MOXART)		+= moxart
+machine-$(CONFIG_ARCH_ASPEED)		+= aspeed
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
new file mode 100644
index 000000000000..30bafc0bbd8b
--- /dev/null
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -0,0 +1,28 @@
+menuconfig ARCH_ASPEED
+	bool "Aspeed BMC architectures"
+	select OF
+	select SRAM
+	help
+	  Say Y here if you want to run your kernel on hardware with an
+	  ASpeed BMC SoC.
+
+if ARCH_ASPEED
+
+config MACH_AST_G4
+	bool "Aspeed SoC 4th Generation" if ARCH_MULTI_V5
+	depends on ARCH_ASPEED
+	select CPU_ARM926T
+	help
+	 Say yes if you intend to run on an Aspeed ast2400 or similar
+	 fourth generation BMCs, such as those used by OpenPower Power8
+	 systems.
+
+config MACH_AST_G5
+	bool "Aspeed SoC 5th Generation" if ARCH_MULTI_V6
+	depends on ARCH_ASPEED
+	select CPU_V6
+	help
+	 Say yes if you intend to run on an Aspeed ast2500 or similar
+	 fifth generation Aspeed BMCs.
+
+endif
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
new file mode 100644
index 000000000000..3a4f025dd520
--- /dev/null
+++ b/arch/arm/mach-aspeed/Makefile
@@ -0,0 +1,3 @@
+# Object file lists.
+
+obj-$(CONFIG_ARCH_ASPEED)	+= aspeed.o
diff --git a/arch/arm/mach-aspeed/aspeed.c b/arch/arm/mach-aspeed/aspeed.c
new file mode 100644
index 000000000000..822939113d95
--- /dev/null
+++ b/arch/arm/mach-aspeed/aspeed.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright IBM Corporation 2016
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#define AST_BASE_WDT		0x1E785000 /* Watchdog Timer (WDT) */
+#define AST_BASE_SCU		0x1E6E2000 /* System Control Unit (SCU) */
+
+static void __init aspeed_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+#define AST_IO_VA	0xf0000000
+#define AST_IO_PA	0x1e600000
+#define AST_IO_SZ	0x00200000
+
+#define AST_IO(__pa)	((void __iomem *)(((__pa) & 0x001fffff) | AST_IO_VA))
+
+static struct map_desc aspeed_io_desc[] __initdata __maybe_unused = {
+	{
+		.virtual	=  AST_IO_VA,
+		.pfn		= __phys_to_pfn(AST_IO_PA),
+		.length		= AST_IO_SZ,
+		.type		= MT_DEVICE
+	},
+};
+
+#define SCU_PASSWORD	0x1688A8A8
+
+static void __init aspeed_init_early(void)
+{
+	u32 reg;
+
+	/*
+	 * Unlock SCU
+	 */
+	writel(SCU_PASSWORD, AST_IO(AST_BASE_SCU));
+
+	/* We enable the UART clock divisor in the SCU's misc control
+	 * register, as the baud rates in aspeed.dtb all assume that the
+	 * divisor is active
+	 */
+	reg = readl(AST_IO(AST_BASE_SCU | 0x2c));
+	writel(reg | 0x00001000, AST_IO(AST_BASE_SCU | 0x2c));
+
+	/*
+	 * Disable the watchdogs
+	 */
+	writel(0, AST_IO(AST_BASE_WDT | 0x0c));
+	writel(0, AST_IO(AST_BASE_WDT | 0x2c));
+}
+
+static void __init aspeed_map_io(void)
+{
+	debug_ll_io_init();
+	iotable_init(aspeed_io_desc, ARRAY_SIZE(aspeed_io_desc));
+}
+
+static const char *const aspeed_dt_match[] __initconst = {
+	"aspeed,ast2400",
+	"aspeed,ast2500",
+	NULL,
+};
+
+DT_MACHINE_START(aspeed_dt, "ASpeed SoC")
+	.map_io		= aspeed_map_io,
+	.init_early	= aspeed_init_early,
+	.init_machine	= aspeed_dt_init,
+	.dt_compat	= aspeed_dt_match,
+MACHINE_END
-- 
2.7.4
