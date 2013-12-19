From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:49:56 -0800
Subject: [PATCH 6/6] clk: tegra: add Tegra114 FCPU DFLL clocksource platform
 driver
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219124949.3226.94812.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic platform driver support for the fast CPU cluster DFLL
clocksource found on Tegra114 SoCs.  This small driver selects the
appropriate Tegra114-specific characterization data and integration
code.  It relies on the DFLL common code to do most of the work.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Aleksandr Frid <afrid@nvidia.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/clk/tegra/Kconfig                  |    9 +
 drivers/clk/tegra/Makefile                 |    5 +
 drivers/clk/tegra/clk-tegra114-dfll-fcpu.c |  169 ++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/tegra/clk-tegra114-dfll-fcpu.c

diff --git a/drivers/clk/tegra/Kconfig b/drivers/clk/tegra/Kconfig
index 5c5d1a841ef8..b5b5069017de 100644
--- a/drivers/clk/tegra/Kconfig
+++ b/drivers/clk/tegra/Kconfig
@@ -5,5 +5,14 @@ config CLK_TEGRA_DFLL
 	tristate
 	depends on COMMON_CLK
 
+config CLK_TEGRA114_DFLL_FCPU
+	tristate "Clock driver for the Tegra T114 DFLL FCPU"
+	select CLK_TEGRA_DFLL
+	---help---
+	  Select this if you'd like to use the DFLL root clocksource
+	  present on NVIDIA Tegra114 chips.  This DFLL clocksource can
+	  be used to clock the fast CPU cluster.  Say 'y' or 'm' here
+	  if you're building a kernel intended for use on T114 chips.
+
 endmenu
 
diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 03277f640bfe..9b4b7357b97d 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -16,10 +16,13 @@ obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
 obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
 obj-$(CONFIG_CLK_TEGRA_DFLL)		+= clk-dfll.o
+obj-$(CONFIG_CLK_TEGRA114_DFLL_FCPU)	+= clk-tegra114-dfll-fcpu.o
 
 # XXX -Wno-sign-compare is only needed due to problems with
 # some non-clock-related Linux header files, and can be removed
 # once those headers are fixed
 CFLAGS_clk-dfll.o			+= -Wall -Wextra -Wno-unused-parameter \
 					   -Wno-sign-compare
-
+CFLAGS_clk-tegra114-dfll-fcpu.o		+= -Wall -Wextra -Wno-unused-parameter \
+					   -Wno-missing-field-initializers \
+					   -Wno-sign-compare
diff --git a/drivers/clk/tegra/clk-tegra114-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra114-dfll-fcpu.c
new file mode 100644
index 000000000000..1665f3cbebeb
--- /dev/null
+++ b/drivers/clk/tegra/clk-tegra114-dfll-fcpu.c
@@ -0,0 +1,169 @@
+/*
+ * clk-tegra114-dfll-fcpu.c - Tegra114 DFLL FCPU clock source driver
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
+ * To do:
+ * - add support for closed-loop mode
+ * - add support for characterization constant overrides via DT
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include <linux/tegra-soc.h>
+
+#include "clk.h"
+#include "clk-dfll.h"
+
+#define DRIVER_NAME			"tegra_dfll_fcpu"
+
+/*
+ * DFLL characterization values
+ */
+
+/*
+ * TUNE0_LOW_0_X_VAL: the value to be programmed into the DFLL's TUNE0
+ * register for T114 chips with a CPU Speedo ID of 0 while the DVCO is
+ * in the low-voltage range.  From device characterization.
+ */
+#define TUNE0_LOW_0_X_VAL		0x00b0019d
+
+/*
+ * MIN_MV_0_X_VAL: the minimum VDD_CPU voltage that the DFLL's
+ * characterization is valid for, for T114 chips with a CPU Speedo ID
+ * of 0.  Can be overridden by fuse settings; see MIN_MV_OVERRIDE_VAL.
+ */
+#define MIN_MV_0_X_VAL			1000
+
+/*
+ * MIN_MV_OVERRIDE_VAL: value to override the VDD_CPU DFLL voltage
+ * floor to, if the VDD_CPU DFLL minimum voltage override fuse is set
+ */
+#define MIN_MV_OVERRIDE_VAL		900
+
+/*
+ * TUNE0_LOW_X_X_VAL: the value to be programmed into the DFLL's TUNE0
+ * register for T114 chips with a nonzero Speedo ID while the DVCO is
+ * in the low-voltage range.  From device characterization.
+ */
+#define TUNE0_LOW_X_X_VAL		0x00b0039d
+
+/*
+ * MIN_MV_X_X_VAL: the minimum VDD_CPU voltage that the DFLL's
+ * characterization is valid for, for T114 chips with a nonzero CPU
+ * Speedo ID.  Can be overridden by fuse settings; see
+ * MIN_MV_OVERRIDE_VAL.
+ */
+#define MIN_MV_X_X_VAL			900
+
+/*
+ * TUNE1_VAL: the value to be programmed into the DFLL's TUNE1
+ * register, from device characterization.
+ */
+#define TUNE1_VAL			0x0000001f
+
+/*
+ * DROOP_RATE_MIN: the highest DVCO rate at which the DFLL's voltage
+ * droop protection activates
+ */
+#define DROOP_RATE_MIN			1000000
+
+
+/*
+ * Platform driver integration
+ */
+
+/**
+ * tegra114_dfll_fcpu_probe - probe the FCPU DFLL IP block
+ * @pdev: DFLL platform_device *
+ *
+ * Called when a DFLL device is bound to this driver by the driver
+ * core.  Takes characterization-specific tweaks into account and sets
+ * up an instance of the DFLL driver.  Returns 0 upon success, or
+ * -ENOMEM if memory couldn't be allocated, or passes along the error
+ * code from tegra_dfll_register().
+ */
+static int tegra114_dfll_fcpu_probe(struct platform_device *pdev)
+{
+	struct tegra_dfll_soc_data soc;
+	int r, speedo_id, process_id;
+
+	speedo_id = tegra_get_cpu_speedo_id();
+	process_id = tegra_get_cpu_process_id();
+
+	memset(&soc, 0, sizeof(soc));
+	soc.driver_name = DRIVER_NAME;
+	soc.tune1 = TUNE1_VAL;
+	soc.output_clock_name = "dfllCPU_out";
+	soc.assert_dvco_reset = tegra114_clock_assert_dfll_dvco_reset;
+	soc.deassert_dvco_reset = tegra114_clock_deassert_dfll_dvco_reset;
+	soc.init_clock_trimmers = tegra114_clock_tune_cpu_trimmers_low;
+	soc.set_clock_trimmers_low = tegra114_clock_tune_cpu_trimmers_low;
+	soc.set_clock_trimmers_high = tegra114_clock_tune_cpu_trimmers_high;
+
+	if ((speedo_id == 1 && (process_id == 0 || process_id == 1)) ||
+	    (speedo_id == 2)) {
+		soc.tune0_low = TUNE0_LOW_X_X_VAL;
+		soc.min_millivolts = MIN_MV_X_X_VAL;
+	} else {
+		if (speedo_id != 0)
+			dev_err(&pdev->dev, "Unrecognized SoC characterization - performance may be affected\n");
+		soc.tune0_low = TUNE0_LOW_0_X_VAL;
+		soc.min_millivolts = MIN_MV_0_X_VAL;
+	}
+
+	if (tegra114_fuse_read_min_vdd_cpu_override())
+		soc.min_millivolts = MIN_MV_OVERRIDE_VAL;
+
+	r = tegra_dfll_register(pdev, &soc);
+	if (!r)
+		return r;
+
+	return 0;
+}
+
+/* Match table for OF platform binding */
+static struct of_device_id tegra114_dfll_fcpu_of_match[] = {
+	{ .compatible = "nvidia,tegra114-dfll-fcpu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra114_dfll_fcpu_of_match);
+
+static const struct dev_pm_ops tegra114_dfll_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_dfll_runtime_suspend,
+			   tegra_dfll_runtime_resume, NULL)
+};
+
+static struct platform_driver tegra114_dfll_fcpu_driver = {
+	.probe		= tegra114_dfll_fcpu_probe,
+	.remove		= tegra_dfll_unregister,
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(tegra114_dfll_fcpu_of_match),
+		.pm		= &tegra114_dfll_pm_ops,
+	},
+};
+
+module_platform_driver(tegra114_dfll_fcpu_driver);
+
+MODULE_DESCRIPTION("Tegra114 DFLL clock source driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Aleksandr Frid <afrid@nvidia.com>");
+MODULE_AUTHOR("Paul Walmsley <pwalmsley@nvidia.com>");
