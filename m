From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 16 Aug 2012 17:31:48 +0800
Subject: [PATCH V3 1/6] ARM: tegra: introduce tegra_cpu_car_ops structures
In-Reply-To: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
References: <1345109513-21553-1-git-send-email-josephl@nvidia.com>
Message-ID: <1345109513-21553-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tegra_cpu_car_ops provide the interface for CPU to control
it's clock gating and reset status. The other drivers should use
this for CPU control. And should not directly access CAR registers
to control CPU.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* no change

 arch/arm/mach-tegra/clock.c               |    4 +
 arch/arm/mach-tegra/tegra20_clocks.c      |   70 +++++++++++++++++++++++
 arch/arm/mach-tegra/tegra20_clocks_data.c |    2 +
 arch/arm/mach-tegra/tegra30_clocks.c      |   72 ++++++++++++++++++++++++
 arch/arm/mach-tegra/tegra30_clocks_data.c |    3 +
 arch/arm/mach-tegra/tegra_cpu_car.h       |   87 +++++++++++++++++++++++++++++
 6 files changed, 238 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra_cpu_car.h

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 632133f..fd82085 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -31,6 +31,10 @@
 
 #include "board.h"
 #include "clock.h"
+#include "tegra_cpu_car.h"
+
+/* Global data of Tegra CPU CAR ops */
+struct tegra_cpu_car_ops *tegra_cpu_car_ops;
 
 /*
  * Locking:
diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index b9124af..ee6922b 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -33,6 +33,7 @@
 #include "clock.h"
 #include "fuse.h"
 #include "tegra2_emc.h"
+#include "tegra_cpu_car.h"
 
 #define RST_DEVICES			0x004
 #define RST_DEVICES_SET			0x300
@@ -152,6 +153,14 @@
 #define PMC_BLINK_TIMER_DATA_OFF_SHIFT	16
 #define PMC_BLINK_TIMER_DATA_OFF_MASK	0xffff
 
+/* Tegra CPU clock and reset control regs */
+#define TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX		0x4c
+#define TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET	0x340
+#define TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR	0x344
+
+#define CPU_CLOCK(cpu)	(0x1 << (8 + cpu))
+#define CPU_RESET(cpu)	(0x1111ul << (cpu))
+
 static void __iomem *reg_clk_base = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
 static void __iomem *reg_pmc_base = IO_ADDRESS(TEGRA_PMC_BASE);
 
@@ -1534,3 +1543,64 @@ struct clk_ops tegra_cdev_clk_ops = {
 	.disable = tegra20_cdev_clk_disable,
 	.recalc_rate = tegra20_cdev_recalc_rate,
 };
+
+/* Tegra20 CPU clock and reset control functions */
+static void tegra20_wait_cpu_in_reset(u32 cpu)
+{
+	unsigned int reg;
+
+	do {
+		reg = readl(reg_clk_base +
+			    TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
+		cpu_relax();
+	} while (!(reg & (1 << cpu)));	/* check CPU been reset or not */
+
+	return;
+}
+
+static void tegra20_put_cpu_in_reset(u32 cpu)
+{
+	writel(CPU_RESET(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
+	dmb();
+}
+
+static void tegra20_cpu_out_of_reset(u32 cpu)
+{
+	writel(CPU_RESET(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR);
+	wmb();
+}
+
+static void tegra20_enable_cpu_clock(u32 cpu)
+{
+	unsigned int reg;
+
+	reg = readl(reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	writel(reg & ~CPU_CLOCK(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	barrier();
+	reg = readl(reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+}
+
+static void tegra20_disable_cpu_clock(u32 cpu)
+{
+	unsigned int reg;
+
+	reg = readl(reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	writel(reg | CPU_CLOCK(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+}
+
+static struct tegra_cpu_car_ops tegra20_cpu_car_ops = {
+	.wait_for_reset	= tegra20_wait_cpu_in_reset,
+	.put_in_reset	= tegra20_put_cpu_in_reset,
+	.out_of_reset	= tegra20_cpu_out_of_reset,
+	.enable_clock	= tegra20_enable_cpu_clock,
+	.disable_clock	= tegra20_disable_cpu_clock,
+};
+
+void __init tegra20_cpu_car_ops_init(void)
+{
+	tegra_cpu_car_ops = &tegra20_cpu_car_ops;
+}
diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
index 6516beb..b9cb82b 100644
--- a/arch/arm/mach-tegra/tegra20_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra20_clocks_data.c
@@ -34,6 +34,7 @@
 #include "fuse.h"
 #include "tegra2_emc.h"
 #include "tegra20_clocks.h"
+#include "tegra_cpu_car.h"
 
 /* Clock definitions */
 
@@ -1106,4 +1107,5 @@ void __init tegra2_init_clocks(void)
 	}
 
 	init_audio_sync_clock_mux();
+	tegra20_cpu_car_ops_init();
 }
diff --git a/arch/arm/mach-tegra/tegra30_clocks.c b/arch/arm/mach-tegra/tegra30_clocks.c
index 3129c2f..7dad44d 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.c
+++ b/arch/arm/mach-tegra/tegra30_clocks.c
@@ -35,6 +35,7 @@
 
 #include "clock.h"
 #include "fuse.h"
+#include "tegra_cpu_car.h"
 
 #define USE_PLL_LOCK_BITS 0
 
@@ -299,6 +300,16 @@
 /* FIXME: recommended safety delay after lock is detected */
 #define PLL_POST_LOCK_DELAY		100
 
+/* Tegra CPU clock and reset control regs */
+#define TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX		0x4c
+#define TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET	0x340
+#define TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR	0x344
+#define TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR	0x34c
+#define TEGRA30_CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
+
+#define CPU_CLOCK(cpu)	(0x1 << (8 + cpu))
+#define CPU_RESET(cpu)	(0x1111ul << (cpu))
+
 /**
 * Structure defining the fields for USB UTMI clocks Parameters.
 */
@@ -2221,3 +2232,64 @@ struct clk_ops tegra_cml_clk_ops = {
 struct clk_ops tegra_pciex_clk_ops = {
 	.recalc_rate = tegra30_clk_fixed_recalc_rate,
 };
+
+/* Tegra30 CPU clock and reset control functions */
+static void tegra30_wait_cpu_in_reset(u32 cpu)
+{
+	unsigned int reg;
+
+	do {
+		reg = readl(reg_clk_base +
+			    TEGRA30_CLK_RST_CONTROLLER_CPU_CMPLX_STATUS);
+		cpu_relax();
+	} while (!(reg & (1 << cpu)));	/* check CPU been reset or not */
+
+	return;
+}
+
+static void tegra30_put_cpu_in_reset(u32 cpu)
+{
+	writel(CPU_RESET(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
+	dmb();
+}
+
+static void tegra30_cpu_out_of_reset(u32 cpu)
+{
+	writel(CPU_RESET(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR);
+	wmb();
+}
+
+static void tegra30_enable_cpu_clock(u32 cpu)
+{
+	unsigned int reg;
+
+	writel(CPU_CLOCK(cpu),
+	       reg_clk_base + TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
+	reg = readl(reg_clk_base +
+		    TEGRA30_CLK_RST_CONTROLLER_CLK_CPU_CMPLX_CLR);
+}
+
+static void tegra30_disable_cpu_clock(u32 cpu)
+{
+
+	unsigned int reg;
+
+	reg = readl(reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+	writel(reg | CPU_CLOCK(cpu),
+	       reg_clk_base + TEGRA_CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
+}
+
+static struct tegra_cpu_car_ops tegra30_cpu_car_ops = {
+	.wait_for_reset	= tegra30_wait_cpu_in_reset,
+	.put_in_reset	= tegra30_put_cpu_in_reset,
+	.out_of_reset	= tegra30_cpu_out_of_reset,
+	.enable_clock	= tegra30_enable_cpu_clock,
+	.disable_clock	= tegra30_disable_cpu_clock,
+};
+
+void __init tegra30_cpu_car_ops_init(void)
+{
+	tegra_cpu_car_ops = &tegra30_cpu_car_ops;
+}
diff --git a/arch/arm/mach-tegra/tegra30_clocks_data.c b/arch/arm/mach-tegra/tegra30_clocks_data.c
index 643a6cc..3d2e553 100644
--- a/arch/arm/mach-tegra/tegra30_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra30_clocks_data.c
@@ -32,6 +32,7 @@
 #include "clock.h"
 #include "fuse.h"
 #include "tegra30_clocks.h"
+#include "tegra_cpu_car.h"
 
 #define DEFINE_CLK_TEGRA(_name, _rate, _ops, _flags,		\
 		   _parent_names, _parents, _parent)		\
@@ -1372,4 +1373,6 @@ void __init tegra30_init_clocks(void)
 
 	for (i = 0; i < ARRAY_SIZE(tegra_clk_out_list); i++)
 		tegra30_init_one_clock(tegra_clk_out_list[i]);
+
+	tegra30_cpu_car_ops_init();
 }
diff --git a/arch/arm/mach-tegra/tegra_cpu_car.h b/arch/arm/mach-tegra/tegra_cpu_car.h
new file mode 100644
index 0000000..30d063a
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra_cpu_car.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __MACH_TEGRA_CPU_CAR_H
+#define __MACH_TEGRA_CPU_CAR_H
+
+/*
+ * Tegra CPU clock and reset control ops
+ *
+ * wait_for_reset:
+ *	keep waiting until the CPU in reset state
+ * put_in_reset:
+ *	put the CPU in reset state
+ * out_of_reset:
+ *	release the CPU from reset state
+ * enable_clock:
+ *	CPU clock un-gate
+ * disable_clock:
+ *	CPU clock gate
+ */
+struct tegra_cpu_car_ops {
+	void (*wait_for_reset)(u32 cpu);
+	void (*put_in_reset)(u32 cpu);
+	void (*out_of_reset)(u32 cpu);
+	void (*enable_clock)(u32 cpu);
+	void (*disable_clock)(u32 cpu);
+};
+
+extern struct tegra_cpu_car_ops *tegra_cpu_car_ops;
+
+static inline void tegra_wait_cpu_in_reset(u32 cpu)
+{
+	if (WARN_ON(!tegra_cpu_car_ops->wait_for_reset))
+		return;
+
+	tegra_cpu_car_ops->wait_for_reset(cpu);
+}
+
+static inline void tegra_put_cpu_in_reset(u32 cpu)
+{
+	if (WARN_ON(!tegra_cpu_car_ops->put_in_reset))
+		return;
+
+	tegra_cpu_car_ops->put_in_reset(cpu);
+}
+
+static inline void tegra_cpu_out_of_reset(u32 cpu)
+{
+	if (WARN_ON(!tegra_cpu_car_ops->out_of_reset))
+		return;
+
+	tegra_cpu_car_ops->out_of_reset(cpu);
+}
+
+static inline void tegra_enable_cpu_clock(u32 cpu)
+{
+	if (WARN_ON(!tegra_cpu_car_ops->enable_clock))
+		return;
+
+	tegra_cpu_car_ops->enable_clock(cpu);
+}
+
+static inline void tegra_disable_cpu_clock(u32 cpu)
+{
+	if (WARN_ON(!tegra_cpu_car_ops->disable_clock))
+		return;
+
+	tegra_cpu_car_ops->disable_clock(cpu);
+}
+
+void tegra20_cpu_car_ops_init(void);
+void tegra30_cpu_car_ops_init(void);
+
+#endif /* __MACH_TEGRA_CPU_CAR_H */
-- 
1.7.0.4
