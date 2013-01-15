From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 15 Jan 2013 08:14:14 -0000
Subject: [v3 9/9] ARM: tegra: Add initial support for Tegra 114 SoC.
In-Reply-To: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
References: <1358237598-32413-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1358237598-32413-10-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new Tegra 114 SoC support.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/Kconfig             |   10 +++++++
 arch/arm/mach-tegra/Makefile            |    1 +
 arch/arm/mach-tegra/board-dt-tegra114.c |   48 +++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/common.c            |    1 +
 4 files changed, 60 insertions(+)
 create mode 100644 arch/arm/mach-tegra/board-dt-tegra114.c

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 1ec7f80..d976ef2 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -44,6 +44,16 @@ config ARCH_TEGRA_3x_SOC
 	  Support for NVIDIA Tegra T30 processor family, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
 
+config ARCH_TEGRA_114_SOC
+	bool "Enable support for Tegra114 family"
+	select ARM_GIC
+	select CPU_V7
+	select ARM_L1_CACHE_SHIFT_6
+	select ARM_ARCH_TIMER
+	help
+	  Support for NVIDIA Tegra T114 processor family, based on the
+	  ARM CortexA15MP CPU
+
 config TEGRA_PCI
 	bool "PCI Express support"
 	depends on ARCH_TEGRA_2x_SOC
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 660ee03..219c2ed 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-dt-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
+obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= board-dt-tegra114.o
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra114.c b/arch/arm/mach-tegra/board-dt-tegra114.c
new file mode 100644
index 0000000..4c36dd0
--- /dev/null
+++ b/arch/arm/mach-tegra/board-dt-tegra114.c
@@ -0,0 +1,48 @@
+/*
+ * NVIDIA Tegra114 device tree board support
+ *
+ * Copyright (C) 2012 NVIDIA Corporation
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
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/clocksource.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+
+#include "board.h"
+#include "common.h"
+
+static void __init tegra114_dt_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char * const tegra114_dt_board_compat[] = {
+	"nvidia,tegra114",
+	NULL,
+};
+
+DT_MACHINE_START(TEGRA114_DT, "NVIDIA Tegra114 (Flattened Device Tree)")
+	.smp		= smp_ops(tegra_smp_ops),
+	.map_io		= tegra_map_common_io,
+	.init_early	= tegra30_init_early,
+	.init_irq	= tegra_dt_init_irq,
+	.handle_irq	= gic_handle_irq,
+	.init_time	= clocksource_of_init,
+	.init_machine	= tegra114_dt_init,
+	.init_late	= tegra_init_late,
+	.restart	= tegra_assert_system_reset,
+	.dt_compat	= tegra114_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 3efe80b..b6bfc0c 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -59,6 +59,7 @@ u32 tegra_uart_config[4] = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id tegra_dt_irq_match[] __initconst = {
+	{ .compatible = "arm,cortex-a15-gic", .data = gic_of_init },
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init },
 	{ }
 };
-- 
1.7.9.5
