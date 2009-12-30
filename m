From: eltshanli@gmail.com (Li Jie)
Date: Wed, 30 Dec 2009 13:55:44 +0800
Subject: [PATCH v3] ARM: NUC900: Add cpufreq driver for NUC900
Message-ID: <8fb2581d0912292155k36c4a48m989f247b6e85d8c6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Wan:

This patch fix bugs in v2:

1. before change the PLL0,
CPU should use external clock as clk source,
and come back after PLL0 becomes stable.

2. if CONFIG_CPU_FRRQ is not enable, do not compile cpufreq.c

Signed-off-by: lijie <eltshanli@gmail.com>
---
 arch/arm/Kconfig                |    1 +
 arch/arm/mach-w90x900/Makefile  |    4 +
 arch/arm/mach-w90x900/cpu.c     |   33 +++++----
 arch/arm/mach-w90x900/cpu.h     |    1 +
 arch/arm/mach-w90x900/cpufreq.c |  154 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-w90x900/cpufreq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..600b313 100644
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
index 828c032..0bba8c3 100644
--- a/arch/arm/mach-w90x900/Makefile
+++ b/arch/arm/mach-w90x900/Makefile
@@ -8,6 +8,10 @@ obj-y				:= irq.o time.o mfp.o gpio.o clock.o
 obj-y				+= clksel.o dev.o cpu.o
 # W90X900 CPU support files

+ifeq ($(CONFIG_CPU_FREQ),y)
+obj-y				+= cpufreq.o
+endif
+
 obj-$(CONFIG_CPU_W90P910)	+= nuc910.o
 obj-$(CONFIG_CPU_NUC950)	+= nuc950.o
 obj-$(CONFIG_CPU_NUC960)	+= nuc960.o
diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
index 20dc0c9..3ebba15 100644
--- a/arch/arm/mach-w90x900/cpu.c
+++ b/arch/arm/mach-w90x900/cpu.c
@@ -108,7 +108,7 @@ struct platform_device nuc900_serial_device = {
 };

 /*Set NUC900 series cpu frequence*/
-static int __init nuc900_set_clkval(unsigned int cpufreq)
+int nuc900_set_clkval(unsigned int cpufreq)
 {
 	unsigned int pllclk, ahbclk, apbclk, val;

@@ -116,6 +116,10 @@ static int __init nuc900_set_clkval(unsigned int cpufreq)
 	ahbclk = 0;
 	apbclk = 0;

+	/* Before change PLL0,
+	 * must select another clk source for CPU */
+	nuc900_clock_source(NULL, "ext");
+
 	switch (cpufreq) {
 	case 66:
 		pllclk = PLL_66MHZ;
@@ -155,30 +159,29 @@ static int __init nuc900_set_clkval(unsigned int cpufreq)
 	val |= (ahbclk << 24 | apbclk << 26);
 	__raw_writel(val, REG_CLKDIV);

+	/* Wait PLL0 to be stable */
+	mdelay(1);
+
+	val = __raw_readl(REG_CKSKEW);
+	val &= ~0xff;
+	val |= DEFAULTSKEW;
+	__raw_writel(val, REG_CKSKEW);
+
+	/* Done, back to PLL0 */
+	nuc900_clock_source(NULL, "pll0");
 	return 	0;
 }
+EXPORT_SYMBOL(nuc900_set_clkval);
+
 static int __init nuc900_set_cpufreq(char *str)
 {
-	unsigned long cpufreq, val;
+	unsigned long cpufreq;

 	if (!*str)
 		return 0;

 	strict_strtoul(str, 0, &cpufreq);
-
-	nuc900_clock_source(NULL, "ext");
-
 	nuc900_set_clkval(cpufreq);
-
-	mdelay(1);
-
-	val = __raw_readl(REG_CKSKEW);
-	val &= ~0xff;
-	val |= DEFAULTSKEW;
-	__raw_writel(val, REG_CKSKEW);
-
-	nuc900_clock_source(NULL, "pll0");
-
 	return 1;
 }

diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
index 4d58ba1..ca0bce5 100644
--- a/arch/arm/mach-w90x900/cpu.h
+++ b/arch/arm/mach-w90x900/cpu.h
@@ -49,6 +49,7 @@ extern void nuc900_clock_source(struct device *dev,
unsigned char *src);
 extern void nuc900_init_clocks(void);
 extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
 extern void nuc900_board_init(struct platform_device **device, int size);
+extern int nuc900_set_clkval(unsigned int cpufreq);

 /* for either public between 910 and 920, or between 920 and 950 */

diff --git a/arch/arm/mach-w90x900/cpufreq.c b/arch/arm/mach-w90x900/cpufreq.c
new file mode 100644
index 0000000..27d4c17
--- /dev/null
+++ b/arch/arm/mach-w90x900/cpufreq.c
@@ -0,0 +1,154 @@
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
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach/map.h>
+#include <mach/hardware.h>
+#include <mach/regs-clock.h>
+
+#include "cpu.h"
+
+#define	CPUFREQ_66M	66000
+#define	CPUFREQ_100M	100000
+#define	CPUFREQ_120M	120000
+#define	CPUFREQ_166M	166000
+#define	CPUFREQ_200M	200000
+
+static struct cpufreq_frequency_table nuc900_freq_table[] = {
+	{ 0, CPUFREQ_66M  },
+	{ 1, CPUFREQ_100M },
+	{ 2, CPUFREQ_120M },
+	{ 3, CPUFREQ_166M },
+	{ 4, CPUFREQ_200M },
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
+		return CPUFREQ_66M;
+	case PLL_100MHZ:
+		return CPUFREQ_100M;
+	case PLL_120MHZ:
+		return CPUFREQ_120M;
+	case PLL_166MHZ:
+		return CPUFREQ_166M;
+	case PLL_200MHZ:
+		return CPUFREQ_200M;
+	}
+
+	pr_err("cpufreq: Failed to get frequency: %x\n", pllclk);
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
+	.name		= "nuc900-cpufreq",
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
+module_init(nuc900_cpufreq_init);
+module_exit(nuc900_cpufreq_exit);
+
+MODULE_AUTHOR("Li Jie <eltshanli@gmail.com>");
+MODULE_DESCRIPTION("cpufreq driver for NUC900");
+MODULE_LICENSE("GPL");
-- 
1.6.5.7
