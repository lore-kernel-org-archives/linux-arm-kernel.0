From: jon.mason@broadcom.com (Jon Mason)
Date: Tue,  7 Jun 2016 17:08:33 -0400
Subject: [RFC 1/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1465333713-14339-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Query the CPU core clock in the device tree to determine the core clock
speed.  Output this clock rate in /proc/cpuinfo to match the output
from other architectures.  The output is intentionally patterned after
the x86 output, to match existing (and possibly expected) convention.

If any errors are encountered in querying the clock (or the speed is
erroneously zero), nothing will be printed out.  Thus any existing
devices that do not have CPU clocks defined in the device tree will
work as before.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/kernel/setup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 7b53500..0c3e25a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -33,6 +33,7 @@
 #include <linux/compiler.h>
 #include <linux/sort.h>
 #include <linux/psci.h>
+#include <linux/clk.h>
 
 #include <asm/unified.h>
 #include <asm/cp15.h>
@@ -1178,10 +1179,32 @@ static const char *hwcap2_str[] = {
 	NULL
 };
 
+static unsigned long cpu_freq(unsigned int core)
+{
+	struct device_node *np;
+	struct clk *c;
+	unsigned long rate = 0;
+
+	np = of_get_cpu_node(core, NULL);
+	if (!np)
+		goto err;
+
+	c = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(c))
+		goto err;
+
+	rate = clk_get_rate(c);
+
+	clk_put(c);
+err:
+	return rate;
+}
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
 	u32 cpuid;
+	unsigned long rate;
 
 	for_each_online_cpu(i) {
 		/*
@@ -1194,6 +1217,12 @@ static int c_show(struct seq_file *m, void *v)
 		seq_printf(m, "model name\t: %s rev %d (%s)\n",
 			   cpu_name, cpuid & 15, elf_platform);
 
+		rate = cpu_freq(i);
+		if (rate)
+			/* Change from Hz into MHz */
+			seq_printf(m, "cpu MHz\t\t: %lu.%03lu\n",
+				   rate / 1000000, rate / 1000 % 1000);
+
 #if defined(CONFIG_SMP)
 		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 			   per_cpu(cpu_data, i).loops_per_jiffy / (500000UL/HZ),
-- 
1.9.1
