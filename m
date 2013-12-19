From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:37:14 -0800
Subject: [PATCH 3/6] clk: tegra: add library for the DFLL clocksource
 (open-loop mode)
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219123701.3226.91986.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add shared code to support the Tegra DFLL clocksource in open-loop
mode.  This root clocksource is present on the Tegra114 and Tegra124
SoCs.  It's used to generate a clock for the fast CPU cluster.  Future
patches will add support for closed-loop mode.

This code was originally created by Aleksandr Frid <afrid@nvidia.com>.
It's been converted to use DT and integrated into the common clock
framework, and a few minor functional changes have been implemented.

Subsequent patches will add drivers for the Tegra114 and Tegra124 fast
CPU cluster DFLL devices, which rely on this code.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Aleksandr Frid <afrid@nvidia.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Tezaswi Raja <traja@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/Kconfig          |    2 
 drivers/clk/tegra/Kconfig    |    9 
 drivers/clk/tegra/Makefile   |    8 
 drivers/clk/tegra/clk-dfll.c | 1229 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h |   54 ++
 5 files changed, 1302 insertions(+)
 create mode 100644 drivers/clk/tegra/Kconfig
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3089f05ba661..ecf004e71a75 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -117,6 +117,8 @@ config COMMON_CLK_KEYSTONE
           Supports clock drivers for Keystone based SOCs. These SOCs have local
 	  a power sleep control module that gate the clock to the IPs and PLLs.
 
+source "drivers/clk/tegra/Kconfig"
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
new file mode 100644
index 000000000000..5c5d1a841ef8
--- /dev/null
+++ b/drivers/clk/tegra/Kconfig
@@ -0,0 +1,9 @@
+menu "Tegra clock support"
+	depends on COMMON_CLK
+
+config CLK_TEGRA_DFLL
+	tristate
+	depends on COMMON_CLK
+
+endmenu
+
diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index f7dfb72884a4..03277f640bfe 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -15,3 +15,11 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
+obj-$(CONFIG_CLK_TEGRA_DFLL)		+= clk-dfll.o
+
+# XXX -Wno-sign-compare is only needed due to problems with
+# some non-clock-related Linux header files, and can be removed
+# once those headers are fixed
+CFLAGS_clk-dfll.o			+= -Wall -Wextra -Wno-unused-parameter \
+					   -Wno-sign-compare
+
diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
new file mode 100644
index 000000000000..83a907fd4798
--- /dev/null
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -0,0 +1,1229 @@
+/*
+ * clk-dfll.c - Tegra DFLL clock source common code
+ *
+ * Copyright (C) 2012-2013 NVIDIA Corporation.  All rights reserved.
+ *
+ * Aleksandr Frid <afrid@nvidia.com>
+ * Paul Walmsley <pwalmsley@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * ...
+ *
+ * This library is for the DVCO and DFLL IP blocks on the Tegra114
+ * SoC.  These IP blocks together are also known at NVIDIA as
+ * "CL-DVFS".  To try to avoid confusion, this code refers to them
+ * collectively as the "DFLL."
+ *
+ * The DFLL is a root clocksource which tolerates some amount of
+ * supply voltage noise.  Tegra114 uses it to clock the fast CPU
+ * complex when the target CPU speed is above a particular rate.  The
+ * DFLL can be operated in either open-loop mode or closed-loop mode.
+ * In open-loop mode, the DFLL generates an output clock appropriate
+ * to the supply voltage.  In closed-loop mode, when configured with a
+ * target frequency, the DFLL minimizes supply voltage while
+ * delivering an average frequency equal to the target.  (This driver
+ * currently only supports open-loop mode.)
+ *
+ * Devices clocked by the DFLL must be able to tolerate frequency
+ * variation.  In the case of the CPU, it's important to note that the
+ * CPU cycle time will vary.  This has implications for
+ * performance-measurement code and any code that relies on the CPU
+ * cycle time to delay for a certain length of time.
+ *
+ * To do:
+ * - Missing kerneldoc on the debugfs functions
+ */
+
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+
+#include <linux/tegra-soc.h>
+
+#include "clk.h"
+#include "clk-dfll.h"
+
+/*
+ * DFLL register offset & bitfield macros
+ */
+
+/* DFLL_CTRL: DFLL control register */
+#define DFLL_CTRL			0x00
+#define DFLL_CTRL_MODE_MASK		0x03
+
+/* DFLL_CONFIG: DFLL sample rate control */
+#define DFLL_CONFIG			0x04
+#define DFLL_CONFIG_DIV_MASK		0xff
+#define DFLL_CONFIG_DIV_PRESCALE	32
+
+/* DFLL_TUNE0: delay line configuration register 0 */
+#define DFLL_TUNE0			0x0c
+
+/* DFLL_TUNE1: delay line configuration register 1 */
+#define DFLL_TUNE1			0x10
+
+/* DFLL_FREQ_REQ: target DFLL frequency control */
+#define DFLL_FREQ_REQ			0x14
+#define DFLL_FREQ_REQ_FORCE_ENABLE	(0x1 << 28)
+#define DFLL_FREQ_REQ_FORCE_SHIFT	16
+#define DFLL_FREQ_REQ_FORCE_MASK	(0xfff << DFLL_FREQ_REQ_FORCE_SHIFT)
+#define FORCE_MAX			2047
+#define FORCE_MIN			-2048
+#define DFLL_FREQ_REQ_SCALE_SHIFT	8
+#define DFLL_FREQ_REQ_SCALE_MASK	(0xff << DFLL_FREQ_REQ_SCALE_SHIFT)
+#define DFLL_FREQ_REQ_SCALE_MAX		256
+#define DFLL_FREQ_REQ_FREQ_VALID	(0x1 << 7)
+#define DFLL_FREQ_REQ_FREQ_SHIFT	0
+#define DFLL_FREQ_REQ_FREQ_MASK		(0x7f << DFLL_FREQ_REQ_FREQ_SHIFT)
+#define FREQ_MAX			127
+
+/* DFLL_DROOP_CTRL: droop prevention control */
+#define DFLL_DROOP_CTRL			0x1c
+
+/* DFLL_MONITOR_CTRL: loop data source control */
+#define DFLL_MONITOR_CTRL		0x28
+#define DFLL_MONITOR_CTRL_FREQ		6
+
+/* DFLL_MONITOR_DATA: internal monitoring */
+#define DFLL_MONITOR_DATA		0x2c
+#define DFLL_MONITOR_DATA_NEW_MASK	(0x1 << 16)
+#define DFLL_MONITOR_DATA_VAL_SHIFT	0
+#define DFLL_MONITOR_DATA_VAL_MASK	(0xFFFF << DFLL_MONITOR_DATA_VAL_SHIFT)
+
+/* DFLL_I2C_CFG: I2C controller configuration register */
+#define DFLL_I2C_CFG			0x40
+#define DFLL_I2C_CFG_ARB_ENABLE		(0x1 << 20)
+#define DFLL_I2C_CFG_HS_CODE_SHIFT	16
+#define DFLL_I2C_CFG_HS_CODE_MASK	(0x7 << DFLL_I2C_CFG_HS_CODE_SHIFT)
+#define DFLL_I2C_CFG_PACKET_ENABLE	(0x1 << 15)
+#define DFLL_I2C_CFG_SIZE_SHIFT		12
+#define DFLL_I2C_CFG_SIZE_MASK		(0x7 << DFLL_I2C_CFG_SIZE_SHIFT)
+#define DFLL_I2C_CFG_SLAVE_ADDR_10	(0x1 << 10)
+#define DFLL_I2C_CFG_SLAVE_ADDR_SHIFT	0
+#define DFLL_I2C_CFG_SLAVE_ADDR_MASK	(0x3ff << DFLL_I2C_CFG_SLAVE_ADDR_SHIFT)
+
+/* DFLL_I2C_STS: I2C controller status */
+#define DFLL_I2C_STS			0x48
+#define DFLL_I2C_STS_I2C_LAST_SHIFT	1
+#define DFLL_I2C_STS_I2C_REQ_PENDING	0x1
+
+/* DFLL_INTR_STS: DFLL interrupt status register */
+#define DFLL_INTR_STS			0x5c
+
+/* DFLL_INTR_EN: DFLL interrupt enable register */
+#define DFLL_INTR_EN			0x60
+#define DFLL_INTR_MIN_MASK		0x1
+#define DFLL_INTR_MAX_MASK		0x2
+
+/* DFLL_I2C_CLK_DIVISOR: I2C controller clock divisor */
+#define DFLL_I2C_CLK_DIVISOR		0x16c
+#define DFLL_I2C_CLK_DIVISOR_MASK	0xffff
+#define DFLL_I2C_CLK_DIVISOR_FS_SHIFT	16
+#define DFLL_I2C_CLK_DIVISOR_HS_SHIFT	0
+#define DFLL_I2C_CLK_DIVISOR_PREDIV	8
+#define DFLL_I2C_CLK_DIVISOR_HSMODE_PREDIV	12
+
+/*
+ * DFLL_OUTPUT_LUT: Offset to the start of the 33x8-bit voltage lookup
+ *     table. 32-bit aligned.  Used in I2C mode only.
+ */
+#define DFLL_OUTPUT_LUT			0x200
+
+/*
+ * Other constants
+ */
+
+/* MAX_DFLL_VOLTAGES: number of LUT entries in the DFLL IP block */
+#define MAX_DFLL_VOLTAGES		33
+
+/*
+ * REF_CLK_CYC_PER_DVCO_SAMPLE: the number of ref_clk cycles that the hardware
+ *    integrates the DVCO counter over - used for debug rate monitoring and
+ *    droop control
+ */
+#define REF_CLK_CYC_PER_DVCO_SAMPLE	4
+
+/*
+ * REF_CLOCK_RATE: the DFLL reference clock rate currently supported by this
+ * driver, in Hz
+ */
+#define REF_CLOCK_RATE			51000000
+
+/*
+ * DEFAULT_DROOP_CTRL_VAL: the default voltage droop prevention
+ * control register value.  Assumes reference clock rate is
+ * REF_CLOCK_RATE.
+ */
+#define DEFAULT_DROOP_CTRL_VAL		0x00000F00
+
+/**
+ * enum dfll_ctrl_mode - DFLL hardware operating mode
+ * @DFLL_UNINITIALIZED: (uninitialized state - not in hardware bitfield)
+ * @DFLL_DISABLED: DFLL not generating an output clock
+ * @DFLL_OPEN_LOOP: DVCO running, but DFLL not adjusting voltage
+ *
+ * The integer corresponding to the last two states, minus one, is
+ * written to the DFLL hardware to change operating modes.
+ */
+enum dfll_ctrl_mode {
+	DFLL_UNINITIALIZED = 0,
+	DFLL_DISABLED = 1,
+	DFLL_OPEN_LOOP = 2,
+};
+
+/**
+ * enum dfll_tune_range - voltage range that the driver believes it's in
+ * @DFLL_TUNE_UNINITIALIZED: DFLL tuning not yet programmed
+ * @DFLL_TUNE_LOW: DFLL in the low-voltage range (or open-loop mode)
+ *
+ * Some DFLL tuning parameters may need to change depending on the
+ * DVCO's voltage; these states represent the ranges that the driver
+ * supports.  These are software states; these values are never
+ * written into registers.
+ */
+enum dfll_tune_range {
+	DFLL_TUNE_UNINITIALIZED = 0,
+	DFLL_TUNE_LOW = 1,
+};
+
+/**
+ * struct dfll_clk_hw - DFLL clk_hw wrapper for the clock framework
+ * @pdev: DFLL platform_device *
+ * @hw: struct clk_hw - for use by the clock framework
+ *
+ * The @pdev is used by the DFLL driver's clock framework interface
+ * functions, to retrieve the DFLL context.
+ */
+struct dfll_clk_hw {
+	struct platform_device		*pdev;
+	struct clk_hw			hw;
+};
+
+/**
+ * struct tegra_dfll - context for a DFLL platform_device *
+ * @soc: pointer to SoC integration and characterization information
+ * @base: virtual address that the DFLL IP block MMIO space is mapped to
+ * @soc_clk: DFLL logic clock input - 51MHz
+ * @ref_clk: Reference clock input - 51MHz
+ * @i2c_clk: PWR_I2C controller clock input
+ * @dfll_clk: our output clock - registered in dfll_init()
+ * @ref_rate: clock rate of @ref_clk.  Does not change once set
+ * @tune_range: current voltage range that the driver believes it's in
+ * @mode: current DFLL hardware operating mode
+ * @freq_req_regval: cache of the DFLL_FREQ_REQ register value
+ * @speedo_id: CPU Speedo ID - from process characterization
+ * @process_id: CPU process ID - from process characterization
+ * @max_reg_offs: maximum register address offset (from the base) in the DFLL
+ * @dent: dentry for DFLL debugfs (at /DRIVER_NAME)
+ * @dfll_clk_hw: CCF clk_hw wrapper for the DFLL output clock
+ * @lock: spinlock to protect accesses to DFLL registers and state
+ *
+ * XXX @freq_req_regval must be re-read after the DFLL IP block loses
+ * context.
+ */
+struct tegra_dfll {
+	struct tegra_dfll_soc_data	*soc;
+
+	void __iomem			*base;
+
+	struct clk			*soc_clk;
+	struct clk			*ref_clk;
+	struct clk			*i2c_clk;
+	struct clk			*dfll_clk;
+	unsigned long			ref_rate;
+
+	enum dfll_ctrl_mode		mode;
+	enum dfll_tune_range		tune_range;
+
+	u32				freq_req_regval;
+
+	u8				speedo_id;
+	u8				process_id;
+
+	u16				max_reg_offs;
+
+	struct dentry			*dent;
+
+	struct dfll_clk_hw		dfll_clk_hw;
+	spinlock_t			lock;	/* see kerneldoc above */
+};
+
+#define to_dfll_clk_hw(_hw) container_of(_hw, struct dfll_clk_hw, hw)
+
+/* mode_name: map numeric DFLL modes to names for friendly console messages */
+static const char * const mode_name[] = {
+	[DFLL_UNINITIALIZED] = "uninitialized",
+	[DFLL_DISABLED] = "disabled",
+	[DFLL_OPEN_LOOP] = "open_loop",
+};
+
+/* Static functions */
+
+static inline u32 dfll_readl(struct tegra_dfll *td, u32 offs)
+{
+	return __raw_readl(td->base + offs);
+}
+
+static inline void dfll_writel(struct tegra_dfll *td, u32 val, u32 offs)
+{
+	__raw_writel(val, td->base + offs);
+}
+
+/**
+ * dfll_wmb - ensure all MMIO writes from the CPU to the DFLL have completed
+ * @td: struct tegra_dfll * device context
+ *
+ * Ensure that all writes from the CPU to the memory-mapped I/O space
+ * of the DFLL IP block have completed.  Assumes that the CPU that
+ * this code is currently running on has excluded other CPUs on the
+ * system from accessing the DFLL IP block MMIO space.
+ */
+static inline void dfll_wmb(struct tegra_dfll *td)
+{
+	dfll_readl(td, DFLL_CTRL);
+}
+
+/**
+ * dfll_is_running - is the DFLL currently generating a clock?
+ * @pdev: pointer to the DFLL platform_device
+ *
+ * If the DFLL is currently generating an output clock signal, return
+ * true; otherwise return false.
+ */
+static bool dfll_is_running(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	return (td->mode == DFLL_DISABLED ||
+		td->mode == DFLL_UNINITIALIZED) ? false : true;
+}
+
+/*
+ * Runtime PM suspend/resume callbacks
+ */
+
+/**
+ * tegra_dfll_runtime_resume - enable all clocks needed by the DFLL
+ * @dev: DFLL device *
+ *
+ * Enable all clocks needed by the DFLL.  Assumes that clk_prepare()
+ * has already been called on all the clocks.  No return value.
+ *
+ * XXX Should also handle context restore when returning from off.
+ */
+int tegra_dfll_runtime_resume(struct device *dev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_enable(td->i2c_clk);
+	if (ret) {
+		dev_err(dev, "could not enable I2C clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(td->ref_clk);
+	if (ret) {
+		dev_err(dev, "could not enable ref clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(td->soc_clk);
+	if (ret) {
+		dev_err(dev, "could not enable register clock: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_runtime_resume);
+
+/**
+ * tegra_dfll_runtime_suspend - disable all clocks needed by the DFLL
+ * @dev: DFLL device *
+ *
+ * Disable all clocks needed by the DFLL.  Assumes that other code
+ * will later call clk_unprepare().  Returns 0.
+ */
+int tegra_dfll_runtime_suspend(struct device *dev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(dev);
+
+	clk_disable(td->soc_clk);
+	clk_disable(td->ref_clk);
+	clk_disable(td->i2c_clk);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_runtime_suspend);
+
+/*
+ * DFLL tuning operations (per-voltage-range tuning settings)
+ */
+
+/**
+ * dfll_set_tune_range - set the internal tune_range variable and log some debug
+ * @pdev: DFLL platform_device *
+ * @range: tune_range to change the internal state variable to
+ *
+ * Set the internal tune_range variable to @range, and optionally
+ * output some debug.  Does not affect the hardware.  No return value.
+ */
+static void dfll_set_tune_range(struct platform_device *pdev,
+				enum dfll_tune_range range)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	td->tune_range = range;
+	pr_debug("%s: set tune range %d\n", __func__, range);
+}
+
+/**
+ * dfll_tune_low - tune to DFLL and CPU settings valid for any voltage
+ * @pdev: DFLL platform_device *
+ *
+ * Tune the DFLL oscillator parameters and the CPU clock shaper for
+ * the low-voltage range.  These settings are valid for any voltage,
+ * but may not be optimal.  The top end of the low-voltage range is
+ * represented by the index (td->tune_high_out_start - 1).  No return
+ * value.
+ */
+static void dfll_tune_low(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	dfll_set_tune_range(pdev, DFLL_TUNE_LOW);
+
+	dfll_writel(td, td->soc->tune0_low, DFLL_TUNE0);
+	dfll_writel(td, td->soc->tune1, DFLL_TUNE1); /* XXX does not change */
+	dfll_wmb(td);
+
+	if (td->soc->set_clock_trimmers_low)
+		td->soc->set_clock_trimmers_low();
+}
+
+/*
+ * I2C output voltage forcing control
+ */
+
+/**
+ * dfll_disable_i2c_output_forcing - turn off I2C output forcing
+ * @pdev: DFLL platform_device *
+ *
+ * Prevent the DFLL's I2C voltage controller from forcing a specific
+ * target voltage value on the I2C bus, rather than using the target
+ * voltage from the control loop.  No return value.
+ */
+static void dfll_disable_i2c_output_forcing(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	if (!(td->freq_req_regval & DFLL_FREQ_REQ_FORCE_ENABLE))
+		return;
+
+	td->freq_req_regval &= ~DFLL_FREQ_REQ_FORCE_ENABLE;
+	dfll_writel(td, td->freq_req_regval, DFLL_FREQ_REQ);
+}
+
+/*
+ * Voltage droop control
+ */
+
+/**
+ * dfll_set_default_droop_ctrl - set the default droop control value
+ * @pdev: DFLL platform_device *
+ *
+ * Set the default voltage droop control value, a product of
+ * characterization.  Called during DFLL driver initialization, and
+ * upon recovery from a context loss event.  Returns 0 upon success or
+ * -ERANGE if the register bitfield value representing @min_rate
+ * cannot be programmed into the hardware.
+ */
+static void dfll_set_default_droop_ctrl(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	dfll_writel(td, DEFAULT_DROOP_CTRL_VAL, DFLL_DROOP_CTRL);
+	dfll_wmb(td);
+}
+
+/*
+ * Output clock scaler control
+ */
+
+/**
+ * dfll_disable_output_clock_scaler - directly output the clock from the DVCO
+ * @pdev: DFLL platform_device *
+ *
+ * Configure the output clock scaler (skipper 3) to not divide the
+ * DVCO output clock, if it's currently dividing the DVCO output
+ * clock.  No return value.
+ */
+static void dfll_disable_output_scaler(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	u32 v;
+
+	v = td->freq_req_regval >> DFLL_FREQ_REQ_SCALE_SHIFT;
+	v &= DFLL_FREQ_REQ_SCALE_MAX - 1;
+	if (v == DFLL_FREQ_REQ_SCALE_MAX - 1)
+		return;
+
+	td->freq_req_regval |= ((DFLL_FREQ_REQ_SCALE_MAX - 1) <<
+				DFLL_FREQ_REQ_SCALE_SHIFT);
+	dfll_writel(td, td->freq_req_regval, DFLL_FREQ_REQ);
+	dfll_wmb(td);
+}
+
+/**
+ * dfll_read_output_clock_scale - return the output clock scale
+ * @pdev: DFLL platform_device *
+ *
+ * Return the current output clock scaling dividend.  If this is equal
+ * to DFLL_FREQ_REQ_SCALE_MAX, then there's no scaling; otherwise, the
+ * DVCO's output rate will be scaled by the return value divided by
+ * DFLL_FREQ_REQ_SCALE_MAX.
+ */
+static u32 dfll_read_output_clock_scale(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	u32 s;
+
+	s = td->freq_req_regval;
+	s &= DFLL_FREQ_REQ_SCALE_MASK;
+	s >>= DFLL_FREQ_REQ_SCALE_SHIFT;
+	s += 1;
+
+	return s;
+}
+
+/*
+ * Monitor control
+ */
+
+/**
+ * dfll_calc_monitored_rate - convert DFLL_MONITOR_DATA_VAL rate into real freq
+ * @monitor_data: value read from the DFLL_MONITOR_DATA_VAL bitfield
+ * @ref_rate: DFLL reference clock rate
+ *
+ * Convert @monitor_data from DFLL_MONITOR_DATA_VAL units into cycles
+ * per second.  Returns the converted value.
+ */
+static u64  __attribute__((pure)) dfll_calc_monitored_rate(u32 monitor_data,
+							   unsigned long ref_rate)
+{
+	return monitor_data * (ref_rate / REF_CLK_CYC_PER_DVCO_SAMPLE);
+}
+
+/**
+ * dfll_read_monitor_rate - return the DFLL's output rate from internal monitor
+ * @pdev: DFLL platform_device *
+ *
+ * If the DFLL is enabled, return the last rate reported by the DFLL's
+ * internal monitoring hardware.  This works in both open-loop and
+ * closed-loop mode, and takes the output scaler setting into account.
+ * Assumes that the monitor was programmed to monitor frequency before
+ * the sample period started.  If the driver believes that the DFLL is
+ * currently uninitialized or disabled, it will return 0, since
+ * otherwise the DFLL monitor data register will return the last
+ * measured rate from when the DFLL was active.
+ */
+static u64 dfll_read_monitor_rate(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+	u32 v, s;
+	u64 pre_scaler_rate, post_scaler_rate;
+
+	if (td->mode == DFLL_DISABLED || td->mode == DFLL_UNINITIALIZED)
+		return 0;
+
+	spin_lock_irqsave(&td->lock, flags);
+
+	v = dfll_readl(td, DFLL_MONITOR_DATA);
+	v &= DFLL_MONITOR_DATA_VAL_MASK;
+	v >>= DFLL_MONITOR_DATA_VAL_SHIFT;
+	pre_scaler_rate = dfll_calc_monitored_rate(v, td->ref_rate);
+
+	s = dfll_read_output_clock_scale(pdev);
+	post_scaler_rate = (pre_scaler_rate * s) / DFLL_FREQ_REQ_SCALE_MAX;
+
+	spin_unlock_irqrestore(&td->lock, flags);
+
+	return post_scaler_rate;
+}
+
+
+/*
+ * DFLL mode switching
+ */
+
+/**
+ * dfll_set_open_loop_config - prepare to switch to open-loop mode
+ * @pdev: DFLL platform_device *
+ *
+ * Prepare to switch the DFLL to open-loop mode.  This switches the
+ * DFLL to the low-voltage tuning range, ensures that I2C output
+ * forcing is disabled, and disables the output clock rate scaler.
+ * The DFLL's low-voltage tuning range parameters must be
+ * characterized to keep the downstream device stable at any DVCO
+ * input voltage.  No return value.
+ */
+static void dfll_set_open_loop_config(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	/* always tune low (safe) in open loop */
+	if (td->tune_range != DFLL_TUNE_LOW)
+		dfll_tune_low(pdev);
+
+	dfll_disable_i2c_output_forcing(pdev);
+	dfll_disable_output_scaler(pdev);
+}
+
+/*
+ * DFLL enable/disable & open-loop <-> closed-loop transitions
+ */
+
+/**
+ * dfll_set_mode - change the DFLL control mode
+ * @pdev: DFLL platform_device *
+ * @mode: DFLL control mode (see enum dfll_ctrl_mode)
+ *
+ * Change the DFLL's operating mode between disabled, open-loop mode,
+ * and closed-loop mode, or vice versa.  No return value.
+ */
+static void dfll_set_mode(struct platform_device *pdev,
+			  enum dfll_ctrl_mode mode)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	td->mode = mode;
+	dfll_writel(td, mode - 1, DFLL_CTRL);
+	dfll_wmb(td);
+}
+
+/**
+ * dfll_disable - switch from open-loop mode to disabled mode
+ * @pdev: DFLL platform_device *
+ *
+ * Switch from OPEN_LOOP state to DISABLED state.  No return value.
+ */
+static void dfll_disable(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&td->lock, flags);
+
+	if (td->mode != DFLL_OPEN_LOOP) {
+		dev_err(&pdev->dev, "cannot disable DFLL in %s mode\n",
+			mode_name[td->mode]);
+		goto tdd_exit;
+	}
+
+	dfll_set_mode(pdev, DFLL_DISABLED);
+	pm_runtime_put_sync(&pdev->dev);
+
+tdd_exit:
+	spin_unlock_irqrestore(&td->lock, flags);
+}
+
+/**
+ * dfll_enable - switch a disabled DFLL to open-loop mode
+ * @pdev: DFLL platform_device *
+ *
+ * Switch from DISABLED state to OPEN_LOOP state.  Returns 0 upon success
+ * or -EPERM if the DFLL is not currently in open-loop mode.
+ */
+static int dfll_enable(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&td->lock, flags);
+
+	if (td->mode != DFLL_DISABLED) {
+		dev_err(&pdev->dev, "cannot enable DFLL in %s mode\n",
+			mode_name[td->mode]);
+		ret = -EPERM;
+		goto tde_exit;
+	}
+
+	pm_runtime_get_sync(&pdev->dev);
+	dfll_set_mode(pdev, DFLL_OPEN_LOOP);
+
+tde_exit:
+	spin_unlock_irqrestore(&td->lock, flags);
+	return ret;
+}
+
+/*
+ * DFLL initialization code
+ */
+
+/**
+ * dfll_init - Prepare the DFLL IP block for use
+ * @pdev: DFLL platform_device *
+ *
+ * Do everything necessary to prepare the DFLL IP block for use.  The
+ * DFLL will be left in DISABLED state.  Called by dfll_probe().
+ * Returns 0 upon success, or passes along the error from whatever
+ * function returned it.
+ */
+static int dfll_init(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (td->soc->deassert_dvco_reset)
+		td->soc->deassert_dvco_reset();
+
+	ret = clk_prepare(td->i2c_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable i2c_clk\n");
+		return ret;
+	}
+
+	/* Enable module clocks, release control logic reset */
+	ret = clk_prepare(td->ref_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable ref_clk\n");
+		goto di_err1;
+	}
+
+	ret = clk_prepare(td->soc_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable soc_clk\n");
+		goto di_err2;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	td->ref_rate = clk_get_rate(td->ref_clk);
+	if (td->ref_rate == 0) {
+		dev_err(&pdev->dev, "ref_clk rate cannot be 0\n");
+		ret = -EINVAL;
+		goto di_err3;
+	}
+
+	if (td->ref_rate != REF_CLOCK_RATE) {
+		dev_err(&pdev->dev, "driver does not yet support reference clk rates other than %ul\n", REF_CLOCK_RATE);
+		ret = -EINVAL;
+		goto di_err3;
+	}
+
+	dfll_set_mode(pdev, DFLL_DISABLED);
+
+	td->freq_req_regval = dfll_readl(td, DFLL_FREQ_REQ);
+
+	dfll_writel(td, DFLL_MONITOR_CTRL_FREQ, DFLL_MONITOR_CTRL);
+	dfll_wmb(td);
+
+	dfll_set_default_droop_ctrl(pdev);
+
+	if (td->soc->init_clock_trimmers)
+		td->soc->init_clock_trimmers();
+
+	dfll_set_open_loop_config(pdev);
+
+	spin_lock_init(&td->lock);
+
+	pm_runtime_put_sync(&pdev->dev);
+
+	return 0;
+di_err3:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(td->soc_clk);
+di_err2:
+	clk_unprepare(td->ref_clk);
+di_err1:
+	clk_unprepare(td->i2c_clk);
+
+	if (td->soc->assert_dvco_reset)
+		td->soc->assert_dvco_reset();
+
+	return ret;
+}
+
+/*
+ * Clock framework integration
+ */
+
+static int dfll_clk_is_enabled(struct clk_hw *hw)
+{
+	struct dfll_clk_hw *tdc = to_dfll_clk_hw(hw);
+
+	return dfll_is_running(tdc->pdev);
+}
+
+static int dfll_clk_enable(struct clk_hw *hw)
+{
+	struct dfll_clk_hw *tdc = to_dfll_clk_hw(hw);
+	struct platform_device *pdev = tdc->pdev;
+
+	return dfll_enable(pdev);
+}
+
+static void dfll_clk_disable(struct clk_hw *hw)
+{
+	struct dfll_clk_hw *tdc = to_dfll_clk_hw(hw);
+	struct platform_device *pdev = tdc->pdev;
+
+	dfll_disable(pdev);
+}
+
+static unsigned long dfll_clk_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct dfll_clk_hw *tdc = to_dfll_clk_hw(hw);
+	struct platform_device *pdev = tdc->pdev;
+	u64 rate;
+
+	/* XXX Return the target frequency instead in closed-loop mode? */
+	rate = dfll_read_monitor_rate(pdev);
+	WARN_ON(rate > ULONG_MAX);
+
+	return rate & ULONG_MAX;
+}
+
+static const struct clk_ops dfll_clk_ops = {
+	.is_enabled	= dfll_clk_is_enabled,
+	.enable		= dfll_clk_enable,
+	.disable	= dfll_clk_disable,
+	.recalc_rate	= dfll_clk_recalc_rate,
+};
+
+static const char *dfll_clk_parents[] = { "dfll_soc" };
+
+static struct clk_init_data dfll_clk_init_data = {
+	.ops		= &dfll_clk_ops,
+	.parent_names	= dfll_clk_parents,
+	.num_parents	= ARRAY_SIZE(dfll_clk_parents),
+};
+
+/**
+ * dfll_register_clk - register the DFLL output clock with the clock framework
+ * @pdev: DFLL platform_device *
+ *
+ * Register the DFLL's output clock (i.e., the clock source that the
+ * DVCO generates) with the Linux clock framework and clkdev.  Returns
+ * 0 upon success or -EINVAL upon failure.
+ */
+static int dfll_register_clk(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (!td->soc->output_clock_name) {
+		dev_err(&pdev->dev, "missing output clock name\n");
+		return -EINVAL;
+	}
+
+	dfll_clk_init_data.name = td->soc->output_clock_name;
+	td->dfll_clk_hw.pdev = pdev;
+	td->dfll_clk_hw.hw.init = &dfll_clk_init_data;
+
+	td->dfll_clk = clk_register(&pdev->dev, &td->dfll_clk_hw.hw);
+	if (IS_ERR(td->dfll_clk)) {
+		dev_err(&pdev->dev, "DFLL clock registration error\n");
+		return -EINVAL;
+	}
+
+	ret = clk_register_clkdev(td->dfll_clk, td->soc->output_clock_name,
+				  NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "DFLL clkdev registration error\n");
+		goto rdc_err;
+	}
+
+	return 0;
+rdc_err:
+	clk_unregister(td->dfll_clk);
+	return ret;
+}
+
+/**
+ * dfll_unregister_clk - unregister the DFLL output clock
+ * @pdev: DFLL platform_device *
+ *
+ * Unregister the DFLL's output clock from the Linux clock framework
+ * and from clkdev.  No return value.
+ */
+static void dfll_unregister_clk(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	/* XXX Why doesn't clk_unregister_clkdev() exist? */
+
+	clk_unregister(td->dfll_clk);
+	td->dfll_clk = NULL;
+}
+
+/*
+ * Debugfs interface
+ */
+
+#ifdef CONFIG_DEBUG_FS
+
+static int dfll_enable_get(void *data, u64 *val)
+{
+	struct platform_device *pdev = data;
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	*val = (td->mode == DFLL_OPEN_LOOP);
+
+	return 0;
+}
+static int dfll_enable_set(void *data, u64 val)
+{
+	struct platform_device *pdev = data;
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	if (val && !dfll_is_running(pdev))
+		clk_prepare_enable(td->dfll_clk);
+	else if (!val && dfll_is_running(pdev))
+		clk_disable_unprepare(td->dfll_clk);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(enable_fops, dfll_enable_get, dfll_enable_set,
+			"%llu\n");
+
+static int dfll_output_rate_get(void *data, u64 *val)
+{
+	struct platform_device *pdev = data;
+
+	*val = dfll_read_monitor_rate(pdev);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(output_rate_fops, dfll_output_rate_get, NULL, "%llu\n");
+
+static int dfll_register_show(struct seq_file *s, void *data)
+{
+	unsigned long flags;
+	u32 offs;
+	struct platform_device *pdev = s->private;
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	spin_lock_irqsave(&td->lock, flags);
+
+	seq_puts(s, "CONTROL REGISTERS:\n");
+	for (offs = 0; offs <= DFLL_MONITOR_DATA; offs += 4)
+		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
+			   dfll_readl(td, offs));
+
+	seq_puts(s, "\nI2C and INTR REGISTERS:\n");
+	for (offs = DFLL_I2C_CFG; offs <= DFLL_I2C_STS; offs += 4)
+		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
+			   dfll_readl(td, offs));
+
+	offs = DFLL_INTR_STS;
+	seq_printf(s, "[0x%02x] = 0x%08x\n", offs, dfll_readl(td, offs));
+	offs = DFLL_INTR_EN;
+	seq_printf(s, "[0x%02x] = 0x%08x\n", offs, dfll_readl(td, offs));
+	offs = DFLL_I2C_CLK_DIVISOR;
+	seq_printf(s, "[0x%02x] = 0x%08x\n", offs, dfll_readl(td, offs));
+
+	seq_puts(s, "\nLUT:\n");
+	for (offs = DFLL_OUTPUT_LUT;
+	     offs < DFLL_OUTPUT_LUT + 4 * MAX_DFLL_VOLTAGES;
+	     offs += 4)
+		seq_printf(s, "[0x%02x] = 0x%08x\n", offs,
+			   dfll_readl(td, offs));
+
+	spin_unlock_irqrestore(&td->lock, flags);
+
+	return 0;
+}
+
+static int dfll_register_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dfll_register_show, inode->i_private);
+}
+
+static ssize_t dfll_register_write(struct file *file,
+				   const char __user *userbuf, size_t count,
+				   loff_t *ppos)
+{
+	struct platform_device *pdev = file->f_path.dentry->d_inode->i_private;
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	char buf[80];
+	u32 offs, val;
+
+	if (sizeof(buf) <= count)
+		return -EINVAL;
+
+	if (copy_from_user(buf, userbuf, count))
+		return -EFAULT;
+
+	buf[count] = '\0';
+
+	if (sscanf(buf, "[0x%8x] = 0x%8x", &offs, &val) != 2)
+		return -EINVAL;
+
+	if (offs > td->max_reg_offs)
+		return -EINVAL;
+
+	/* avoid unaligned accesses */
+	if ((offs & (~0x3)) != offs)
+		return -EINVAL;
+
+	dfll_writel(td, val, offs);
+	dfll_wmb(td);
+
+	return count;
+}
+
+static const struct file_operations dfll_register_fops = {
+	.open		= dfll_register_open,
+	.read		= seq_read,
+	.write		= dfll_register_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int dfll_debug_init(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	if (!td || (td->mode == DFLL_UNINITIALIZED))
+		return 0;
+
+	td->dent = debugfs_create_dir(td->soc->driver_name, NULL);
+	if (!td->dent)
+		return -ENOMEM;
+
+	ret = -ENOMEM;
+
+	if (!debugfs_create_file("enable", S_IRUGO | S_IWUSR,
+				 td->dent, pdev, &enable_fops))
+		goto err_out;
+
+	if (!debugfs_create_file("output_rate", S_IRUGO,
+				 td->dent, pdev, &output_rate_fops))
+		goto err_out;
+
+	if (!debugfs_create_file("registers", S_IRUGO | S_IWUSR,
+				 td->dent, pdev, &dfll_register_fops))
+		goto err_out;
+
+	return 0;
+
+err_out:
+	debugfs_remove_recursive(td->dent);
+	return ret;
+}
+
+#endif		/* CONFIG_DEBUG_FS */
+
+/*
+ * DFLL initialization
+ */
+
+/**
+ * dfll_init_clks - clk_get() the DFLL source clocks
+ * @pdev: DFLL platform_device *
+ *
+ * Call clk_get() on the DFLL source clocks and save the pointers for later
+ * use.  Returns 0 upon success or -ENODEV if one or more of the clocks
+ * couldn't be looked up.
+ */
+static int dfll_init_clks(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	td->ref_clk = clk_get(&pdev->dev, "ref");
+	if (IS_ERR(td->ref_clk)) {
+		dev_err(&pdev->dev, "missing ref clock\n");
+		ret = -ENODEV;
+		goto tdic_err1;
+	}
+
+	td->soc_clk = clk_get(&pdev->dev, "soc");
+	if (IS_ERR(td->soc_clk)) {
+		dev_err(&pdev->dev, "missing soc clock\n");
+		ret = -ENODEV;
+		goto tdic_err2;
+	}
+
+	td->i2c_clk = clk_get(&pdev->dev, "i2c");
+	if (IS_ERR(td->i2c_clk)) {
+		dev_err(&pdev->dev, "missing i2c clock\n");
+		ret = -ENODEV;
+		goto tdic_err3;
+	}
+
+	return 0;
+
+tdic_err3:
+	clk_put(td->soc_clk);
+tdic_err2:
+	clk_put(td->ref_clk);
+tdic_err1:
+	return ret;
+}
+
+/*
+ * DT data fetch
+ */
+
+/*
+ * API exported to per-SoC platform drivers
+ */
+
+/**
+ * tegra_dfll_register - probe a Tegra DFLL device
+ * @pdev: DFLL platform_device *
+ * @soc: Per-SoC integration and characterization data for this DFLL instance
+ *
+ * Probe and initialize a DFLL device instance.  Intended to be called
+ * by a SoC-specific shim driver that passes in per-SoC integration
+ * and configuration data via @soc.  (The structure record pointed to
+ * by @soc is copied, so the caller can dispose of its own copy once
+ * tegra_dfll_register() returns.)  Returns 0 upon success, -EINVAL if
+ * @soc is null or if some resource data is missing, -ENOMEM if out of
+ * memory, or can pass along error codes from other functions.
+ */
+int tegra_dfll_register(struct platform_device *pdev,
+			struct tegra_dfll_soc_data *soc)
+{
+	struct resource *mem;
+	struct tegra_dfll *td;
+	int ret = -EINVAL;
+	int r;
+
+	if (!soc) {
+		dev_err(&pdev->dev, "missing SoC data\n");
+		return -EINVAL;
+	}
+
+	td = kzalloc(sizeof(*td), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	td->soc = kmemdup(soc, sizeof(struct tegra_dfll_soc_data), GFP_KERNEL);
+	if (!td->soc) {
+		ret = -ENOMEM;
+		goto tdr_err1;
+	}
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "missing register MMIO resource\n");
+		ret = -EINVAL;
+		goto tdr_err2;
+	}
+
+	td->base = ioremap(mem->start, resource_size(mem));
+	if (!td->base) {
+		dev_err(&pdev->dev, "couldn't ioremap() register MMIO area\n");
+		ret = -EINVAL;
+		goto tdr_err2;
+	}
+
+	td->max_reg_offs = resource_size(mem) - sizeof(u32);
+
+	td->speedo_id = tegra_get_cpu_speedo_id();
+	td->process_id = tegra_get_cpu_process_id();
+
+	platform_set_drvdata(pdev, td);
+
+	r = dfll_init_clks(pdev);
+	if (r) {
+		dev_err(&pdev->dev, "DFLL clock init error\n");
+		ret = r;
+		goto tdr_err3;
+	}
+
+	/* Enable the clocks and set the device up */
+	ret = dfll_init(pdev);
+	if (ret)
+		goto tdr_err4;
+
+	ret = dfll_register_clk(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "DFLL clk registration failed\n");
+		goto tdr_err4;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	dfll_debug_init(pdev);
+#endif
+
+	dev_info(&pdev->dev, "initialized\n");
+
+	return 0;
+
+tdr_err4:
+	clk_put(td->i2c_clk);
+	clk_put(td->soc_clk);
+	clk_put(td->ref_clk);
+tdr_err3:
+	iounmap(td->base);
+tdr_err2:
+	kfree(td->soc);
+tdr_err1:
+	kfree(td);
+	return ret;
+}
+EXPORT_SYMBOL(tegra_dfll_register);
+
+/**
+ * tegra_dfll_unregister - release all of the DFLL driver resources for a device
+ * @pdev: DFLL platform_device *
+ *
+ * Unbind this driver from the DFLL hardware device represented by
+ * @pdev.  The DFLL must be disabled for this to succeed.  Returns 0
+ * upon success or -EBUSY if the DFLL is still active.
+ */
+int tegra_dfll_unregister(struct platform_device *pdev)
+{
+	struct tegra_dfll *td = dev_get_drvdata(&pdev->dev);
+
+	/* Try to prevent removal while the DFLL is active */
+	if (td->mode != DFLL_DISABLED) {
+		dev_err(&pdev->dev,
+			"must disable DFLL before removing driver\n");
+		return -EBUSY;
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	dfll_unregister_clk(pdev);
+	if (td->soc->assert_dvco_reset)
+		td->soc->assert_dvco_reset();
+	clk_put(td->i2c_clk);
+	clk_put(td->soc_clk);
+	clk_put(td->ref_clk);
+	iounmap(td->base);
+	kfree(td->soc);
+	kfree(td);
+
+	return 0;
+}
+EXPORT_SYMBOL(tegra_dfll_unregister);
diff --git a/drivers/clk/tegra/clk-dfll.h b/drivers/clk/tegra/clk-dfll.h
new file mode 100644
index 000000000000..2e002c8ef597
--- /dev/null
+++ b/drivers/clk/tegra/clk-dfll.h
@@ -0,0 +1,54 @@
+/*
+ * clk-dfll.h - prototypes and macros for the Tegra DFLL clocksource driver
+ * Copyright (C) 2013 NVIDIA Corporation.  All rights reserved.
+ *
+ * Aleksandr Frid <afrid@nvidia.com>
+ * Paul Walmsley <pwalmsley@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef __DRIVERS_CLK_TEGRA_CLK_DFLL_H
+#define __DRIVERS_CLK_TEGRA_CLK_DFLL_H
+
+/**
+ * struct tegra_dfll_soc - SoC-specific hooks/integration for the DFLL driver
+ * @driver_name: name of the platform_driver representing the DFLL
+ * @output_clock_name: name of the DFLL's output clock
+ * @min_millivolts: minimum voltage (in mV) that the DFLL tuning is valid for
+ * @tune0_low: DFLL tuning register 0 (low voltage range)
+ * @tune0_high: DFLL tuning register 0 (high voltage range)
+ * @tune1: DFLL tuning register 1
+ * @assert_dvco_reset: fn ptr to place the DVCO in reset
+ * @deassert_dvco_reset: fn ptr to release the DVCO reset
+ * @set_clock_trimmers_high: fn ptr to tune clock trimmers for high voltage
+ * @set_clock_trimmers_low: fn ptr to tune clock trimmers for low voltage
+ */
+struct tegra_dfll_soc_data {
+	char *driver_name;
+	char *output_clock_name;
+	unsigned int min_millivolts;
+	u32 tune0_low;
+	u32 tune0_high;
+	u32 tune1;
+	void (*assert_dvco_reset)(void);
+	void (*deassert_dvco_reset)(void);
+	void (*init_clock_trimmers)(void);
+	void (*set_clock_trimmers_high)(void);
+	void (*set_clock_trimmers_low)(void);
+};
+
+int tegra_dfll_register(struct platform_device *pdev,
+			struct tegra_dfll_soc_data *soc);
+int tegra_dfll_unregister(struct platform_device *pdev);
+int tegra_dfll_runtime_suspend(struct device *dev);
+int tegra_dfll_runtime_resume(struct device *dev);
+
+#endif /* __DRIVERS_CLK_TEGRA_CLK_DFLL_H */
