From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  1 Feb 2013 15:31:33 +0100
Subject: [PATCH v4 1/3] cpufreq: kirkwood: Add a cpufreq driver for Marvell
 Kirkwood SoCs
In-Reply-To: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
References: <1359729096-15371-1-git-send-email-andrew@lunn.ch>
Message-ID: <1359729096-15371-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
CPU can either use the a high speed cpu clock, or the slower DDR
clock. Add a driver to swap between these two clock sources.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---

To be commited by: Rafael J. Wysocki

 drivers/clk/mvebu/clk-gating-ctrl.c |    1 +
 drivers/cpufreq/Kconfig.arm         |    6 +
 drivers/cpufreq/Makefile            |    1 +
 drivers/cpufreq/kirkwood-cpufreq.c  |  277 +++++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+)
 create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index 8fa5408..ebf141d 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -193,6 +193,7 @@ static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
 	{ "runit", NULL, 7 },
 	{ "xor0", NULL, 8 },
 	{ "audio", NULL, 9 },
+	{ "powersave", "cpuclk", 11 },
 	{ "sata0", NULL, 14 },
 	{ "sata1", NULL, 15 },
 	{ "xor1", NULL, 16 },
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a0b3661..80c8229 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -77,6 +77,12 @@ config ARM_EXYNOS5250_CPUFREQ
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
 
+config ARM_KIRKWOOD_CPUFREQ
+	def_bool ARCH_KIRKWOOD && OF
+	help
+	  This adds the CPUFreq driver for Marvell Kirkwood
+	  SoCs.
+
 config ARM_SPEAR_CPUFREQ
 	bool "SPEAr CPUFreq support"
 	depends on PLAT_SPEAR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index fadc4d4..39a0ffe 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
+obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
new file mode 100644
index 0000000..8923689
--- /dev/null
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -0,0 +1,277 @@
+/*
+ *	kirkwood_freq.c: cpufreq driver for the Marvell kirkwood
+ *
+ *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm/proc-fns.h>
+
+#define CPU_SW_INT_BLK BIT(28)
+
+static struct priv
+{
+	struct clk *cpu_clk;
+	struct clk *ddr_clk;
+	struct clk *powersave_clk;
+	struct device *dev;
+	void __iomem *base;
+} priv;
+
+#define STATE_CPU_FREQ 0x01
+#define STATE_DDR_FREQ 0x02
+
+/*
+ * Kirkwood can swap the clock to the CPU between two clocks:
+ *
+ * - cpu clk
+ * - ddr clk
+ *
+ * The frequencies are set at runtime before registering this *
+ * table.
+ */
+static struct cpufreq_frequency_table kirkwood_freq_table[] = {
+	{STATE_CPU_FREQ,	0}, /* CPU uses cpuclk */
+	{STATE_DDR_FREQ,	0}, /* CPU uses ddrclk */
+	{0,			CPUFREQ_TABLE_END},
+};
+
+static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
+{
+	if (__clk_is_enabled(priv.powersave_clk))
+		return kirkwood_freq_table[1].frequency;
+	return kirkwood_freq_table[0].frequency;
+}
+
+static void kirkwood_cpufreq_set_cpu_state(unsigned int index)
+{
+	struct cpufreq_freqs freqs;
+	unsigned int state = kirkwood_freq_table[index].index;
+	unsigned long reg;
+
+	freqs.old = kirkwood_cpufreq_get_cpu_frequency(0);
+	freqs.new = kirkwood_freq_table[index].frequency;
+	freqs.cpu = 0; /* Kirkwood is UP */
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	dev_dbg(priv.dev, "Attempting to set frequency to %i KHz\n",
+		kirkwood_freq_table[index].frequency);
+	dev_dbg(priv.dev, "old frequency was %i KHz\n",
+		kirkwood_cpufreq_get_cpu_frequency(0));
+
+	if (freqs.old != freqs.new) {
+		local_irq_disable();
+
+		/* Disable interrupts to the CPU */
+		reg = readl_relaxed(priv.base);
+		reg |= CPU_SW_INT_BLK;
+		writel_relaxed(reg, priv.base);
+
+		switch (state) {
+		case STATE_CPU_FREQ:
+			clk_disable(priv.powersave_clk);
+			break;
+		case STATE_DDR_FREQ:
+			clk_enable(priv.powersave_clk);
+			break;
+		}
+
+		/* Wait-for-Interrupt, while the hardware changes frequency */
+		cpu_do_idle();
+
+		/* Enable interrupts to the CPU */
+		reg = readl_relaxed(priv.base);
+		reg &= ~CPU_SW_INT_BLK;
+		writel_relaxed(reg, priv.base);
+
+		local_irq_enable();
+	}
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+};
+
+static int kirkwood_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, kirkwood_freq_table);
+}
+
+static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
+			    unsigned int target_freq,
+			    unsigned int relation)
+{
+	unsigned int index = 0;
+
+	if (cpufreq_frequency_table_target(policy, kirkwood_freq_table,
+				target_freq, relation, &index))
+		return -EINVAL;
+
+	kirkwood_cpufreq_set_cpu_state(index);
+
+	return 0;
+}
+
+/* Module init and exit code */
+static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	int result;
+
+	/* cpuinfo and default policy values */
+	policy->cpuinfo.transition_latency = 5000; /* 5uS */
+	policy->cur = kirkwood_cpufreq_get_cpu_frequency(0);
+
+	result = cpufreq_frequency_table_cpuinfo(policy, kirkwood_freq_table);
+	if (result)
+		return result;
+
+	cpufreq_frequency_table_get_attr(kirkwood_freq_table, policy->cpu);
+
+	return 0;
+}
+
+static int kirkwood_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	cpufreq_frequency_table_put_attr(policy->cpu);
+	return 0;
+}
+
+static struct freq_attr *kirkwood_cpufreq_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL,
+};
+
+static struct cpufreq_driver kirkwood_cpufreq_driver = {
+	.get	= kirkwood_cpufreq_get_cpu_frequency,
+	.verify	= kirkwood_cpufreq_verify,
+	.target	= kirkwood_cpufreq_target,
+	.init	= kirkwood_cpufreq_cpu_init,
+	.exit	= kirkwood_cpufreq_cpu_exit,
+	.name	= "kirkwood-cpufreq",
+	.owner	= THIS_MODULE,
+	.attr	= kirkwood_cpufreq_attr,
+};
+
+static int kirkwood_cpufreq_probe(struct platform_device *pdev)
+{
+	struct device_node *np_core = of_find_compatible_node(
+		NULL, NULL, "marvell,kirkwood-core-clock");
+	struct device_node *np_gating = of_find_compatible_node(
+		NULL, NULL, "marvell,kirkwood-gating-clock");
+	struct of_phandle_args clkspec;
+	struct resource *res;
+	int err;
+
+	if (!np_core || !np_gating) {
+		if (np_core)
+			of_node_put(np_core);
+		if (np_gating)
+			of_node_put(np_gating);
+		return -ENODEV;
+	}
+	
+	priv.dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Cannot get memory resource\n");
+		return -ENODEV;
+	}
+	priv.base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!priv.base) {
+		dev_err(&pdev->dev, "Cannot ioremap\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	clkspec.np = np_core;
+	clkspec.args_count = 1;
+	clkspec.args[0] = 1;
+
+	priv.cpu_clk = of_clk_get_from_provider(&clkspec);
+	if (IS_ERR(priv.cpu_clk)) {
+		dev_err(priv.dev, "Unable to get cpuclk");
+		return PTR_ERR(priv.cpu_clk);
+	}
+
+	clk_prepare_enable(priv.cpu_clk);
+	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
+
+	clkspec.args[0] = 3;
+	priv.ddr_clk = of_clk_get_from_provider(&clkspec);
+	if (IS_ERR(priv.ddr_clk)) {
+		dev_err(priv.dev, "Unable to get ddrclk");
+		err = PTR_ERR(priv.ddr_clk);
+		goto out_cpu;
+	}
+
+	clk_prepare_enable(priv.ddr_clk);
+	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
+
+	clkspec.np = np_gating;
+	clkspec.args[0] = 11;
+	priv.powersave_clk = of_clk_get_from_provider(&clkspec);
+	if (IS_ERR(priv.powersave_clk)) {
+		dev_err(priv.dev, "Unable to get powersave");
+		err = PTR_ERR(priv.powersave_clk);
+		goto out_ddr;
+	}
+	clk_prepare(priv.powersave_clk);
+
+	of_node_put(np_core);
+	np_core = NULL;
+	of_node_put(np_gating);
+	np_gating = NULL;
+
+	err = cpufreq_register_driver(&kirkwood_cpufreq_driver);
+	if (!err)
+		return 0;
+
+	dev_err(priv.dev, "Failed to register cpufreq driver");
+
+	clk_disable_unprepare(priv.powersave_clk);
+out_ddr:
+	clk_disable_unprepare(priv.ddr_clk);
+out_cpu:
+	clk_disable_unprepare(priv.cpu_clk);
+	of_node_put(np_core);
+	of_node_put(np_gating);
+
+	return err;
+}
+
+static int kirkwood_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&kirkwood_cpufreq_driver);
+
+	clk_disable_unprepare(priv.powersave_clk);
+	clk_disable_unprepare(priv.ddr_clk);
+	clk_disable_unprepare(priv.cpu_clk);
+
+	return 0;
+}
+
+static struct platform_driver kirkwood_cpufreq_platform_driver = {
+	.probe = kirkwood_cpufreq_probe,
+	.remove = kirkwood_cpufreq_remove,
+	.driver = {
+		.name = "kirkwood-cpufreq",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(kirkwood_cpufreq_platform_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
+MODULE_DESCRIPTION("cpufreq driver for Marvell's kirkwood CPU");
+MODULE_ALIAS("platform:kirkwood-cpufreq");
-- 
1.7.10.4
