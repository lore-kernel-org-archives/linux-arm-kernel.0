From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 16:43:08 +0900
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
Message-ID: <20140115074308.8471.64824.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out the R-Car SYSC power management code from
the r8a7779 SoC code. With this new shared R-Car SYSC
code base it is possible to hook in Generation 2 SoCs
as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

Developed on top of renesas-devel-v3.13-rc8-20140115

 arch/arm/mach-shmobile/Makefile               |    2 
 arch/arm/mach-shmobile/include/mach/pm-rcar.h |   15 ++
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   13 --
 arch/arm/mach-shmobile/pm-r8a7779.c           |  131 +----------------------
 arch/arm/mach-shmobile/pm-rcar.c              |  142 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7779.c          |   17 +-
 6 files changed, 177 insertions(+), 143 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-01-15 13:30:37.000000000 +0900
@@ -52,7 +52,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
-obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
--- /dev/null
+++ work/arch/arm/mach-shmobile/include/mach/pm-rcar.h	2014-01-15 13:30:38.000000000 +0900
@@ -0,0 +1,15 @@
+#ifndef PM_RCAR_H
+#define PM_RCAR_H
+
+struct rcar_sysc_ch {
+	unsigned long chan_offs;
+	unsigned int chan_bit;
+	unsigned int isr_bit;
+};
+
+int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
+bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
+void __iomem *rcar_sysc_init(phys_addr_t base);
+
+#endif /* PM_RCAR_H */
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2014-01-15 13:30:37.000000000 +0900
@@ -3,6 +3,7 @@
 
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
+#include <mach/pm-rcar.h>
 
 /* HPB-DMA slave IDs */
 enum {
@@ -11,18 +12,12 @@ enum {
 	HPBDMA_SLAVE_SDHI0_RX,
 };
 
-struct r8a7779_pm_ch {
-	unsigned long chan_offs;
-	unsigned int chan_bit;
-	unsigned int isr_bit;
-};
-
 struct r8a7779_pm_domain {
 	struct generic_pm_domain genpd;
-	struct r8a7779_pm_ch ch;
+	struct rcar_sysc_ch ch;
 };
 
-static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
+static inline struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 {
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
@@ -41,8 +36,6 @@ extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 extern void r8a7779_register_twd(void);
-extern int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch);
-extern int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch);
 
 #ifdef CONFIG_PM
 extern void __init r8a7779_init_pm_domains(void);
--- 0001/arch/arm/mach-shmobile/pm-r8a7779.c
+++ work/arch/arm/mach-shmobile/pm-r8a7779.c	2014-01-15 13:30:37.000000000 +0900
@@ -20,132 +20,22 @@
 #include <linux/console.h>
 #include <asm/io.h>
 #include <mach/common.h>
+#include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
 
-static void __iomem *r8a7779_sysc_base;
-
 /* SYSC */
-#define SYSCSR 0x00
-#define SYSCISR 0x04
-#define SYSCISCR 0x08
 #define SYSCIER 0x0c
 #define SYSCIMR 0x10
-#define PWRSR0 0x40
-#define PWRSR1 0x80
-#define PWRSR2 0xc0
-#define PWRSR3 0x100
-#define PWRSR4 0x140
-
-#define PWRSR_OFFS 0x00
-#define PWROFFCR_OFFS 0x04
-#define PWRONCR_OFFS 0x0c
-#define PWRER_OFFS 0x14
-
-#define SYSCSR_RETRIES 100
-#define SYSCSR_DELAY_US 1
-
-#define SYSCISR_RETRIES 1000
-#define SYSCISR_DELAY_US 1
 
 #if defined(CONFIG_PM) || defined(CONFIG_SMP)
 
-static DEFINE_SPINLOCK(r8a7779_sysc_lock); /* SMP CPUs + I/O devices */
-
-static int r8a7779_sysc_pwr_on_off(struct r8a7779_pm_ch *r8a7779_ch,
-				   int sr_bit, int reg_offs)
-{
-	int k;
-
-	for (k = 0; k < SYSCSR_RETRIES; k++) {
-		if (ioread32(r8a7779_sysc_base + SYSCSR) & (1 << sr_bit))
-			break;
-		udelay(SYSCSR_DELAY_US);
-	}
-
-	if (k == SYSCSR_RETRIES)
-		return -EAGAIN;
-
-	iowrite32(1 << r8a7779_ch->chan_bit,
-		  r8a7779_sysc_base + r8a7779_ch->chan_offs + reg_offs);
-
-	return 0;
-}
-
-static int r8a7779_sysc_pwr_off(struct r8a7779_pm_ch *r8a7779_ch)
-{
-	return r8a7779_sysc_pwr_on_off(r8a7779_ch, 0, PWROFFCR_OFFS);
-}
-
-static int r8a7779_sysc_pwr_on(struct r8a7779_pm_ch *r8a7779_ch)
-{
-	return r8a7779_sysc_pwr_on_off(r8a7779_ch, 1, PWRONCR_OFFS);
-}
-
-static int r8a7779_sysc_update(struct r8a7779_pm_ch *r8a7779_ch,
-			       int (*on_off_fn)(struct r8a7779_pm_ch *))
-{
-	unsigned int isr_mask = 1 << r8a7779_ch->isr_bit;
-	unsigned int chan_mask = 1 << r8a7779_ch->chan_bit;
-	unsigned int status;
-	unsigned long flags;
-	int ret = 0;
-	int k;
-
-	spin_lock_irqsave(&r8a7779_sysc_lock, flags);
-
-	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
-
-	do {
-		ret = on_off_fn(r8a7779_ch);
-		if (ret)
-			goto out;
-
-		status = ioread32(r8a7779_sysc_base +
-				  r8a7779_ch->chan_offs + PWRER_OFFS);
-	} while (status & chan_mask);
-
-	for (k = 0; k < SYSCISR_RETRIES; k++) {
-		if (ioread32(r8a7779_sysc_base + SYSCISR) & isr_mask)
-			break;
-		udelay(SYSCISR_DELAY_US);
-	}
-
-	if (k == SYSCISR_RETRIES)
-		ret = -EIO;
-
-	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
-
- out:
-	spin_unlock_irqrestore(&r8a7779_sysc_lock, flags);
-
-	pr_debug("r8a7779 power domain %d: %02x %02x %02x %02x %02x -> %d\n",
-		 r8a7779_ch->isr_bit, ioread32(r8a7779_sysc_base + PWRSR0),
-		 ioread32(r8a7779_sysc_base + PWRSR1),
-		 ioread32(r8a7779_sysc_base + PWRSR2),
-		 ioread32(r8a7779_sysc_base + PWRSR3),
-		 ioread32(r8a7779_sysc_base + PWRSR4), ret);
-	return ret;
-}
-
-int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch)
-{
-	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_off);
-}
-
-int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch)
-{
-	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_on);
-}
-
 static void __init r8a7779_sysc_init(void)
 {
-	r8a7779_sysc_base = ioremap_nocache(0xffd85000, PAGE_SIZE);
-	if (!r8a7779_sysc_base)
-		panic("unable to ioremap r8a7779 SYSC hardware block\n");
+	void __iomem *base = rcar_sysc_init(0xffd85000);
 
 	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x0131000e, r8a7779_sysc_base + SYSCIER);
-	iowrite32(0, r8a7779_sysc_base + SYSCIMR);
+	iowrite32(0x0131000e, base + SYSCIER);
+	iowrite32(0, base + SYSCIMR);
 }
 
 #else /* CONFIG_PM || CONFIG_SMP */
@@ -158,24 +48,17 @@ static inline void r8a7779_sysc_init(voi
 
 static int pd_power_down(struct generic_pm_domain *genpd)
 {
-	return r8a7779_sysc_power_down(to_r8a7779_ch(genpd));
+	return rcar_sysc_power_down(to_r8a7779_ch(genpd));
 }
 
 static int pd_power_up(struct generic_pm_domain *genpd)
 {
-	return r8a7779_sysc_power_up(to_r8a7779_ch(genpd));
+	return rcar_sysc_power_up(to_r8a7779_ch(genpd));
 }
 
 static bool pd_is_off(struct generic_pm_domain *genpd)
 {
-	struct r8a7779_pm_ch *r8a7779_ch = to_r8a7779_ch(genpd);
-	unsigned int st;
-
-	st = ioread32(r8a7779_sysc_base + r8a7779_ch->chan_offs + PWRSR_OFFS);
-	if (st & (1 << r8a7779_ch->chan_bit))
-		return true;
-
-	return false;
+	return rcar_sysc_power_is_off(to_r8a7779_ch(genpd));
 }
 
 static bool pd_active_wakeup(struct device *dev)
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-rcar.c	2014-01-15 13:30:38.000000000 +0900
@@ -0,0 +1,142 @@
+/*
+ * R-Car SYSC Power management support
+ *
+ * Copyright (C) 2014  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
+#include <mach/pm-rcar.h>
+
+static void __iomem *rcar_sysc_base;
+
+/* SYSC */
+#define SYSCSR 0x00
+#define SYSCISR 0x04
+#define SYSCISCR 0x08
+
+#define PWRSR_OFFS 0x00
+#define PWROFFCR_OFFS 0x04
+#define PWRONCR_OFFS 0x0c
+#define PWRER_OFFS 0x14
+
+#define SYSCSR_RETRIES 100
+#define SYSCSR_DELAY_US 1
+
+#define SYSCISR_RETRIES 1000
+#define SYSCISR_DELAY_US 1
+
+#if defined(CONFIG_PM) || defined(CONFIG_SMP)
+
+static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
+
+static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
+				int sr_bit, int reg_offs)
+{
+	int k;
+
+	for (k = 0; k < SYSCSR_RETRIES; k++) {
+		if (ioread32(rcar_sysc_base + SYSCSR) & (1 << sr_bit))
+			break;
+		udelay(SYSCSR_DELAY_US);
+	}
+
+	if (k == SYSCSR_RETRIES)
+		return -EAGAIN;
+
+	iowrite32(1 << sysc_ch->chan_bit,
+		  rcar_sysc_base + sysc_ch->chan_offs + reg_offs);
+
+	return 0;
+}
+
+static int rcar_sysc_pwr_off(struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_pwr_on_off(sysc_ch, 0, PWROFFCR_OFFS);
+}
+
+static int rcar_sysc_pwr_on(struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_pwr_on_off(sysc_ch, 1, PWRONCR_OFFS);
+}
+
+static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
+			    int (*on_off_fn)(struct rcar_sysc_ch *))
+{
+	unsigned int isr_mask = 1 << sysc_ch->isr_bit;
+	unsigned int chan_mask = 1 << sysc_ch->chan_bit;
+	unsigned int status;
+	unsigned long flags;
+	int ret = 0;
+	int k;
+
+	spin_lock_irqsave(&rcar_sysc_lock, flags);
+
+	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
+
+	do {
+		ret = on_off_fn(sysc_ch);
+		if (ret)
+			goto out;
+
+		status = ioread32(rcar_sysc_base +
+				  sysc_ch->chan_offs + PWRER_OFFS);
+	} while (status & chan_mask);
+
+	for (k = 0; k < SYSCISR_RETRIES; k++) {
+		if (ioread32(rcar_sysc_base + SYSCISR) & isr_mask)
+			break;
+		udelay(SYSCISR_DELAY_US);
+	}
+
+	if (k == SYSCISR_RETRIES)
+		ret = -EIO;
+
+	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
+
+ out:
+	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
+
+	pr_debug("sysc power domain %d: %08x -> %d\n",
+		 sysc_ch->isr_bit, ioread32(rcar_sysc_base + SYSCISR), ret);
+	return ret;
+}
+
+int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_off);
+}
+
+int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch)
+{
+	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_on);
+}
+
+bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch)
+{
+	unsigned int st;
+
+	st = ioread32(rcar_sysc_base + sysc_ch->chan_offs + PWRSR_OFFS);
+	if (st & (1 << sysc_ch->chan_bit))
+		return true;
+
+	return false;
+}
+
+void __iomem *rcar_sysc_init(phys_addr_t base)
+{
+	rcar_sysc_base = ioremap_nocache(base, PAGE_SIZE);
+	if (!rcar_sysc_base)
+		panic("unable to ioremap R-Car SYSC hardware block\n");
+
+	return rcar_sysc_base;
+}
+
+#endif /* CONFIG_PM || CONFIG_SMP */
--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2014-01-15 15:10:30.000000000 +0900
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <mach/common.h>
+#include <mach/pm-rcar.h>
 #include <mach/r8a7779.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
@@ -33,25 +34,25 @@
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
 
-static struct r8a7779_pm_ch r8a7779_ch_cpu1 = {
+static struct rcar_sysc_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 1, /* ARM1 */
 	.isr_bit = 1, /* ARM1 */
 };
 
-static struct r8a7779_pm_ch r8a7779_ch_cpu2 = {
+static struct rcar_sysc_ch r8a7779_ch_cpu2 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 2, /* ARM2 */
 	.isr_bit = 2, /* ARM2 */
 };
 
-static struct r8a7779_pm_ch r8a7779_ch_cpu3 = {
+static struct rcar_sysc_ch r8a7779_ch_cpu3 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 3, /* ARM3 */
 	.isr_bit = 3, /* ARM3 */
 };
 
-static struct r8a7779_pm_ch *r8a7779_ch_cpu[4] = {
+static struct rcar_sysc_ch *r8a7779_ch_cpu[4] = {
 	[1] = &r8a7779_ch_cpu1,
 	[2] = &r8a7779_ch_cpu2,
 	[3] = &r8a7779_ch_cpu3,
@@ -67,7 +68,7 @@ void __init r8a7779_register_twd(void)
 
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
-	struct r8a7779_pm_ch *ch = NULL;
+	struct rcar_sysc_ch *ch = NULL;
 	int ret = -EIO;
 
 	cpu = cpu_logical_map(cpu);
@@ -76,14 +77,14 @@ static int r8a7779_platform_cpu_kill(uns
 		ch = r8a7779_ch_cpu[cpu];
 
 	if (ch)
-		ret = r8a7779_sysc_power_down(ch);
+		ret = rcar_sysc_power_down(ch);
 
 	return ret ? ret : 1;
 }
 
 static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	struct r8a7779_pm_ch *ch = NULL;
+	struct rcar_sysc_ch *ch = NULL;
 	unsigned int lcpu = cpu_logical_map(cpu);
 	int ret;
 
@@ -91,7 +92,7 @@ static int r8a7779_boot_secondary(unsign
 		ch = r8a7779_ch_cpu[lcpu];
 
 	if (ch)
-		ret = r8a7779_sysc_power_up(ch);
+		ret = rcar_sysc_power_up(ch);
 	else
 		ret = -EIO;
 
