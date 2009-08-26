From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Wed, 26 Aug 2009 21:33:24 +0200
Subject: [RFC] AT91 cpufreq support
Message-ID: <20090826193324.GB7084@pc-ras4041.res.insa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

Here is an updated version of the patch that brings cpufreq support on AT91.
This one is more generic that the previous one: instead of using fixed values,
it gets the current prescaler value and builds the frequency table accordingly.

It fixes a couple mistakes from the previous iteration, making it work more
reliably, at least there. I also added a cpufreq notifier to atmel_serial, so
that we don't lose the console over a frequency change (I'll move it to a
separate patch in a further update, and will add such support for the macb
driver too).
As there's no cpufreq notifier in the macb driver (yet), using cpufreq with a
NFS root filesystem will fail (obviously, other uses of the network will
probably fail too, but at least they don't make the system unusable)

On a Calao USB-A9263 board, switching from 180MHz to 11MHz reduces the current
consumption by roughly 65mA

Testing/feedback would be very much welcome

Regards,
Albin

---
 arch/arm/Kconfig                  |   10 ++-
 arch/arm/mach-at91/Makefile       |    1 +
 arch/arm/mach-at91/cpufreq-at91.c |  197 +++++++++++++++++++++++++++++++++++++
 drivers/serial/atmel_serial.c     |   81 +++++++++++++++
 4 files changed, 288 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-at91/cpufreq-at91.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aef63c8..d47f8ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1241,7 +1241,7 @@ endmenu
 
 menu "CPU Power Management"
 
-if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_PXA || ARCH_S3C64XX)
+if (ARCH_SA1100 || ARCH_INTEGRATOR || ARCH_OMAP || ARCH_PXA || ARCH_S3C64XX || ARCH_AT91)
 
 source "drivers/cpufreq/Kconfig"
 
@@ -1276,6 +1276,14 @@ config CPU_FREQ_S3C64XX
 	bool "CPUfreq support for Samsung S3C64XX CPUs"
 	depends on CPU_FREQ && CPU_S3C6410
 
+config CPU_FREQ_AT91
+	bool "CPUfreq driver from ATMEL AT91 ARM CPUs (EXPERIMENTAL)"
+	depends on CPU_FREQ && ARCH_AT91 && EXPERIMENTAL
+	help
+	  This enables the CPUfreq driver for ARM AT91 CPUs.
+
+	  If in doubt, say N.
+
 endif
 
 source "drivers/cpuidle/Kconfig"
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index c69ff23..d4b4e16 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -67,6 +67,7 @@ obj-y				+= leds.o
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
+obj-$(CONFIG_CPU_FREQ_AT91) += cpufreq-at91.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/arch/arm/mach-at91/cpufreq-at91.c b/arch/arm/mach-at91/cpufreq-at91.c
new file mode 100644
index 0000000..32e955b
--- /dev/null
+++ b/arch/arm/mach-at91/cpufreq-at91.c
@@ -0,0 +1,197 @@
+/*
+ * Copyright (C) 2009
+ * Albin Tonnerre, Free Electrons <albin.tonnerre@free-electrons.com>
+ *
+ * Based on linux/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+ * Copyright (C) 2008 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/cpufreq.h>
+#include <linux/clk.h>
+
+#include <mach/hardware.h>
+#include <mach/at91_pmc.h>
+#include <mach/cpu.h>
+#include <linux/delay.h>
+#include "clock.h"
+
+struct at91_freq_info {
+	unsigned int cpufreq_khz;
+	u32          mckr_pres;
+};
+
+static struct at91_freq_info *at91_freqs;
+static struct cpufreq_frequency_table *at91_freqs_table;
+
+static int setup_freqs_table(struct cpufreq_policy *policy,
+			     struct at91_freq_info *freqs, int num)
+{
+	struct cpufreq_frequency_table *table;
+	int i;
+
+	table = kzalloc((num + 1) * sizeof(*table), GFP_KERNEL);
+	if (table == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		table[i].index = i;
+		table[i].frequency = freqs[i].cpufreq_khz;
+	}
+	table[num].frequency = i;
+	table[num].frequency = CPUFREQ_TABLE_END;
+
+	at91_freqs = freqs;
+	at91_freqs_table = table;
+
+	return cpufreq_frequency_table_cpuinfo(policy, table);
+}
+
+static void __update_core_freq(struct clk *clk, struct at91_freq_info *info)
+{
+	u32 mckr, cur_mdiv;
+
+	cur_mdiv = at91_sys_read(AT91_PMC_MCKR) & AT91_PMC_MDIV;
+	mckr = info->mckr_pres | cur_mdiv | AT91_PMC_CSS_PLLA;
+
+	at91_sys_write(AT91_PMC_MCKR, mckr);
+	while(!(at91_sys_read(AT91_PMC_SR) & AT91_PMC_MCKRDY))
+		cpu_relax();
+
+	clk->rate_hz = (info->cpufreq_khz * 1000) >> (cur_mdiv >> 8);
+}
+
+static int at91_cpufreq_verify(struct cpufreq_policy *policy)
+{
+	return cpufreq_frequency_table_verify(policy, at91_freqs_table);
+}
+
+static unsigned int at91_cpufreq_get(unsigned int cpu)
+{
+	u32 mdiv;
+
+	mdiv = 1 << ((at91_sys_read(AT91_PMC_MCKR) & AT91_PMC_MDIV) >> 8);
+	return mdiv * clk_get_rate(clk_get(NULL, "mck")) / 1000;
+}
+
+static int at91_cpufreq_set(struct cpufreq_policy *policy,
+			      unsigned int target_freq,
+			      unsigned int relation)
+{
+	struct at91_freq_info *next;
+	struct cpufreq_freqs freqs;
+	unsigned long flags;
+	int idx;
+	struct clk *clk;
+
+	if (policy->cpu != 0)
+		return -EINVAL;
+
+	/* don't do anything if the master clock source is not PLLA */
+	clk = clk_get(NULL, "mck");
+	if (strcmp(clk->parent->name, "plla"))
+		return -EINVAL;
+
+	/* Lookup the next frequency */
+	if (cpufreq_frequency_table_target(policy, at91_freqs_table,
+				target_freq, relation, &idx))
+		return -EINVAL;
+
+	next = &at91_freqs[idx];
+
+	freqs.old = policy->cur;
+	freqs.new = next->cpufreq_khz;
+	freqs.cpu = policy->cpu;
+
+	printk("CPU frequency from %d MHz to %d MHz%s\n",
+			freqs.old / 1000, freqs.new / 1000,
+			(freqs.old == freqs.new) ? " (skipped)" : "");
+
+	if (freqs.old == target_freq)
+		return 0;
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+
+	local_irq_save(flags);
+	__update_core_freq(clk, next);
+	local_irq_restore(flags);
+
+	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+
+	return 0;
+}
+
+static __init int at91_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret = -EINVAL, nfreqs, i;
+	u32 pres;
+	struct clk *clk;
+	struct at91_freq_info *at91_freqs;
+
+	/* don't do anything if the master clock source is not PLLA */
+	clk = clk_get(NULL, "mck");
+	if (strcmp(clk->parent->name, "plla"))
+		return -EINVAL;
+
+	/* set default policy and cpuinfo */
+	policy->cpuinfo.min_freq = (clk->rate_hz / 1000) / AT91_PMC_PRES_16;
+	policy->cpuinfo.max_freq = clk->rate_hz / 1000;
+	policy->cpuinfo.transition_latency = 1000000; /* FIXME: 1 ms, assumed */
+	policy->cur = policy->min = policy->max = at91_cpufreq_get(policy->cpu);
+
+	pres = at91_sys_read(AT91_PMC_MCKR) & AT91_PMC_PRES;
+	nfreqs = (AT91_PMC_PRES_16 - pres) >> 2;
+	nfreqs = (nfreqs > 0) ? nfreqs + 1 : 1;
+	at91_freqs = kmalloc(sizeof(struct at91_freq_info) * nfreqs, GFP_KERNEL);
+
+	for(i = 0; i < nfreqs; i++)
+	{
+		at91_freqs[i].cpufreq_khz = policy->cur >> (pres >> 2);
+		at91_freqs[i].mckr_pres = pres;
+		pres += 1 << 2;
+	}
+
+	ret = setup_freqs_table(policy, at91_freqs, nfreqs);
+
+	if (ret) {
+		pr_err("failed to setup frequency table\n");
+		kfree(at91_freqs);
+		return ret;
+	}
+
+	pr_info("CPUFREQ support for AT91 initialized\n");
+	return 0;
+}
+
+static struct cpufreq_driver at91_cpufreq_driver = {
+	.verify		= at91_cpufreq_verify,
+	.target		= at91_cpufreq_set,
+	.init		= at91_cpufreq_init,
+	.get		= at91_cpufreq_get,
+	.name		= "at91-cpufreq",
+};
+
+static int __init cpufreq_init(void)
+{
+	return cpufreq_register_driver(&at91_cpufreq_driver);
+}
+module_init(cpufreq_init);
+
+static void __exit cpufreq_exit(void)
+{
+	kfree(at91_freqs);
+	cpufreq_unregister_driver(&at91_cpufreq_driver);
+}
+module_exit(cpufreq_exit);
+
+MODULE_DESCRIPTION("CPU frequency scaling driver for AT91");
+MODULE_LICENSE("GPL");
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 607d43a..5f38b90 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -38,6 +38,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/atmel_pdc.h>
 #include <linux/atmel_serial.h>
+#include <linux/cpufreq.h>
 
 #include <asm/io.h>
 
@@ -147,6 +148,9 @@ struct atmel_uart_port {
 	unsigned int		irq_status_prev;
 
 	struct circ_buf		rx_ring;
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block		freq_transition;
+#endif
 };
 
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
@@ -1525,6 +1529,79 @@ static int atmel_serial_resume(struct platform_device *pdev)
 #define atmel_serial_resume NULL
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+static int atmel_serial_cpufreq_transition(struct notifier_block *nb,
+					     unsigned long val, void *data)
+{
+	struct atmel_uart_port *port;
+	struct uart_port *uport;
+
+	port = container_of(nb, struct atmel_uart_port, freq_transition);
+	uport = &port->uart;
+
+	/* try and work out if the baudrate is changing, we can detect
+	 * a change in rate, but we do not have support for detecting
+	 * a disturbance in the clock-rate over the change.
+	 */
+
+	if (IS_ERR(port->clk))
+		goto exit;
+
+	if (val == CPUFREQ_PRECHANGE) {
+		/* we should really shut the port down whilst the
+		 * frequency change is in progress. */
+
+	} else if (val == CPUFREQ_POSTCHANGE) {
+		struct ktermios *termios;
+		struct tty_struct *tty;
+
+		if (uport->info == NULL)
+			goto exit;
+
+		tty = uport->info->port.tty;
+
+		if (tty == NULL)
+			goto exit;
+
+		termios = tty->termios;
+
+		if (termios == NULL) {
+			printk(KERN_WARNING "%s: no termios?\n", __func__);
+			goto exit;
+		}
+		uport->uartclk = clk_get_rate(port->clk);
+		atmel_set_termios(uport, termios, NULL);
+	}
+	return NOTIFY_OK;
+
+ exit:
+	return NOTIFY_BAD;
+}
+
+static inline int atmel_serial_cpufreq_register(struct atmel_uart_port *port)
+{
+	port->freq_transition.notifier_call = atmel_serial_cpufreq_transition;
+
+	return cpufreq_register_notifier(&port->freq_transition,
+					 CPUFREQ_TRANSITION_NOTIFIER);
+}
+
+static inline void atmel_serial_cpufreq_deregister(struct atmel_uart_port *port)
+{
+	cpufreq_unregister_notifier(&port->freq_transition,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+}
+#else
+static inline int atmel_serial_cpufreq_register(struct atmel_uart_port *port)
+{
+	return 0;
+}
+
+static inline void atmel_serial_cpufreq_deregister(struct atmel_uart_port *port)
+{
+}
+#endif
+
 static int __devinit atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *port;
@@ -1561,6 +1638,9 @@ static int __devinit atmel_serial_probe(struct platform_device *pdev)
 		clk_disable(port->clk);
 	}
 #endif
+	ret = atmel_serial_cpufreq_register(port);
+	if (ret < 0)
+		dev_err(&pdev->dev, "failed to add cpufreq notifier\n");
 
 	device_init_wakeup(&pdev->dev, 1);
 	platform_set_drvdata(pdev, port);
@@ -1589,6 +1669,7 @@ static int __devexit atmel_serial_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	ret = uart_remove_one_port(&atmel_uart, port);
+	atmel_serial_cpufreq_deregister(atmel_port);
 
 	tasklet_kill(&atmel_port->tasklet);
 	kfree(atmel_port->rx_ring.buf);
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
