From: eltshanli@gmail.com (Li Jie)
Date: Mon, 14 Dec 2009 15:29:42 +0800
Subject: [PATCH] ARM: NUC900: Add cpufreq driver for nuc900 CPUs
Message-ID: <8fb2581d0912132329k1b1a52c8sdabfc4af3266c1e5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan ZongShun:

This patch add cpufreq support for nuc900 CPUs.

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-w90x900/Makefile  |    2 +-
 arch/arm/mach-w90x900/cpu.c     |    4 +-
 arch/arm/mach-w90x900/cpufreq.c |  146 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf8a99f..60186fe 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -539,6 +539,7 @@ config ARCH_W90X900
 	select COMMON_CLKDEV
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_CPUFREQ
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
diff --git a/arch/arm/mach-w90x900/Makefile b/arch/arm/mach-w90x900/Makefile
index 828c032..7f114fb 100644
--- a/arch/arm/mach-w90x900/Makefile
+++ b/arch/arm/mach-w90x900/Makefile
@@ -5,7 +5,7 @@
 # Object file lists.

 obj-y				:= irq.o time.o mfp.o gpio.o clock.o
-obj-y				+= clksel.o dev.o cpu.o
+obj-y				+= clksel.o dev.o cpu.o cpufreq.o
 # W90X900 CPU support files

 obj-$(CONFIG_CPU_W90P910)	+= nuc910.o
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 921cef9..7b608b8 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -107,7 +107,7 @@ struct platform_device nuc900_serial_device = {
 };

 /*Set NUC900 series cpu frequence*/
-static int __init nuc900_set_clkval(unsigned int cpufreq)
+int nuc900_set_clkval(unsigned int cpufreq)
 {
 	unsigned int pllclk, ahbclk, apbclk, val;

@@ -156,6 +156,8 @@ static int __init nuc900_set_clkval(unsigned int cpufreq)

 	return 	0;
 }
+EXPORT_SYMBOL(nuc900_set_clkval);
+
 static int __init nuc900_set_cpufreq(char *str)
 {
 	unsigned long cpufreq, val;
diff --git a/arch/arm/mach-w90x900/cpufreq.c b/arch/arm/mach-w90x900/cpufreq.c
new file mode 100644
index 0000000..07b8685
--- /dev/null
+++ b/arch/arm/mach-w90x900/cpufreq.c
@@ -0,0 +1,146 @@
+/* linux/arch/arm/mach-w90x900/cpufreq.c
+ *
+ * NUC900 CPUfreq Support
+ *
+ * Li Jie <eltshanli@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <asm/io.h>
+#include <mach/hardware.h>
+#include <mach/regs-clock.h>
+
+extern int nuc900_set_clkval(unsigned int cpufreq);
+
+static struct cpufreq_frequency_table nuc900_freq_table[] = {
+	{ 0,  66000 },
+	{ 1, 100000 },
+	{ 2, 120000 },
+	{ 3, 166000 },
+	{ 4, 200000 },
+	{ 5, CPUFREQ_TABLE_END },
+};
+
+static int nuc900_cpufreq_verify_speed(struct cpufreq_policy *policy)
+{
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	return cpufreq_frequency_table_verify(policy, nuc900_freq_table);
+}
+
+static unsigned int nuc900_cpufreq_get_speed(unsigned int cpu)
+{
+	int pllclk;
+
+	if (cpu != 0)
+		return 0;
+
+	pllclk = __raw_readl(REG_PLLCON0);
+
+	switch (pllclk) {
+	case PLL_66MHZ:
+		return 66 * 1000;
+	case PLL_100MHZ:
+		return 100 * 1000;
+	case PLL_120MHZ:
+		return 120 * 1000;
+	case PLL_166MHZ:
+		return 166 * 1000;
+	case PLL_200MHZ:
+		return 200 * 1000;
+	}
+
+	pr_err("cpufreq: Failed to get frequency: %X\n", pllclk);
+	return 0;
+}
+
+static int nuc900_cpufreq_set_target(struct cpufreq_policy *policy,
+				      unsigned int target_freq,
+				      unsigned int relation)
+{
+	int ret;
+	unsigned int i;
+	struct cpufreq_freqs freqs;
+
+	ret = cpufreq_frequency_table_target(policy, nuc900_freq_table,
+					     target_freq, relation, &i);
+	if (ret != 0)
+		return ret;
+
+	freqs.cpu = 0;
+	freqs.old = nuc900_cpufreq_get_speed(0);
+	freqs.new = nuc900_freq_table[i].frequency;
+	freqs.flags = 0;
+
+	if (freqs.old == freqs.new)
+		return 0;
+
+	pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	nuc900_set_clkval(freqs.new / 1000);
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
+}
+
+static int __init nuc900_cpufreq_driver_init(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	policy->cur = nuc900_cpufreq_get_speed(0);
+
+	policy->cpuinfo.transition_latency = 2 * 1000; /* FIXME, assumed */
+	policy->cpuinfo.min_freq = 66000;	       /* khz */
+	policy->cpuinfo.max_freq = 200000;
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+
+	ret = cpufreq_frequency_table_cpuinfo(policy, nuc900_freq_table);
+	if (ret != 0)
+		pr_err("cpufreq: Failed to configure frequency table: %d\n",
+		       ret);
+
+	return ret;
+}
+
+static struct cpufreq_driver nuc900_cpufreq_driver = {
+	.owner		= THIS_MODULE,
+	.flags          = 0,
+	.verify		= nuc900_cpufreq_verify_speed,
+	.target		= nuc900_cpufreq_set_target,
+	.get		= nuc900_cpufreq_get_speed,
+	.init		= nuc900_cpufreq_driver_init,
+	.name		= "nuc900",
+};
+
+static int __init nuc900_cpufreq_init(void)
+{
+	return cpufreq_register_driver(&nuc900_cpufreq_driver);
+}
+
+static void __exit nuc900_cpufreq_exit(void)
+{
+	cpufreq_unregister_driver(&nuc900_cpufreq_driver);
+}
+
+MODULE_AUTHOR ("Li Jie <eltshanli@gmail.com>");
+MODULE_DESCRIPTION ("cpufreq driver for NUC900");
+MODULE_LICENSE ("GPL");
+
+module_init(nuc900_cpufreq_init);
+module_exit(nuc900_cpufreq_exit);
-- 
1.6.5.4
