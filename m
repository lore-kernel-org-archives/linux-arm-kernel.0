From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:59:57 +0100
Subject: [PATCH 7/7] ARM: dove: convert legacy dove to PMU support
In-Reply-To: <20150715185859.GC7557@n2100.arm.linux.org.uk>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFRuP-0003mY-6U@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Dove has non-DT support, convert the legacy support to use the new
PMU driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                     |   1 +
 arch/arm/mach-dove/common.c          |  25 +++++++++
 arch/arm/mach-dove/include/mach/pm.h |  17 ------
 arch/arm/mach-dove/irq.c             |  87 ------------------------------
 drivers/soc/Makefile                 |   1 +
 drivers/soc/dove/pmu.c               | 100 +++++++++++++++++++++++++++++++++++
 include/linux/soc/dove/pmu.h         |  18 +++++++
 7 files changed, 145 insertions(+), 104 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48ba0b12..5e52c00bbf80 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -514,6 +514,7 @@ config ARCH_DOVE
 	select PINCTRL
 	select PINCTRL_DOVE
 	select PLAT_ORION_LEGACY
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d1a89298ece..6f3887217674 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/dma-mv_xor.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <linux/platform_device.h>
+#include <linux/soc/dove/pmu.h>
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -375,6 +376,29 @@ void __init dove_setup_cpu_wins(void)
 				    DOVE_SCRATCHPAD_SIZE);
 }
 
+static const struct dove_pmu_domain_initdata pmu_domains[] __initconst = {
+	{
+		.pwr_mask = PMU_PWR_VPU_PWR_DWN_MASK,
+		.rst_mask = PMU_SW_RST_VIDEO_MASK,
+		.iso_mask = PMU_ISO_VIDEO_MASK,
+		.name = "vpu-domain",
+	}, {
+		.pwr_mask = PMU_PWR_GPU_PWR_DWN_MASK,
+		.rst_mask = PMU_SW_RST_GPU_MASK,
+		.iso_mask = PMU_ISO_GPU_MASK,
+		.name = "gpu-domain",
+	}, {
+		/* sentinel */
+	},
+};
+
+static const struct dove_pmu_initdata pmu_data __initconst = {
+	.pmc_base = DOVE_PMU_VIRT_BASE,
+	.pmu_base = DOVE_PMU_VIRT_BASE + 0x8000,
+	.irq = IRQ_DOVE_PMU,
+	.domains = pmu_domains,
+};
+
 void __init dove_init(void)
 {
 	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
@@ -389,6 +413,7 @@ void __init dove_init(void)
 	dove_clk_init();
 
 	/* internal devices that every board has */
+	dove_init_pmu_legacy(&pmu_data);
 	dove_rtc_init();
 	dove_xor0_init();
 	dove_xor1_init();
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-dove/include/mach/pm.h
index b47f75038686..625a89c15c1f 100644
--- a/arch/arm/mach-dove/include/mach/pm.h
+++ b/arch/arm/mach-dove/include/mach/pm.h
@@ -51,22 +51,5 @@
 #define  CLOCK_GATING_GIGA_PHY_MASK	(1 << CLOCK_GATING_BIT_GIGA_PHY)
 
 #define PMU_INTERRUPT_CAUSE	(DOVE_PMU_VIRT_BASE + 0x50)
-#define PMU_INTERRUPT_MASK	(DOVE_PMU_VIRT_BASE + 0x54)
-
-static inline int pmu_to_irq(int pin)
-{
-	if (pin < NR_PMU_IRQS)
-		return pin + IRQ_DOVE_PMU_START;
-
-	return -EINVAL;
-}
-
-static inline int irq_to_pmu(int irq)
-{
-	if (IRQ_DOVE_PMU_START <= irq && irq < NR_IRQS)
-		return irq - IRQ_DOVE_PMU_START;
-
-	return -EINVAL;
-}
 
 #endif
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 4a5a7aedcb76..924d8afe4597 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -7,86 +7,14 @@
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
-#include <asm/mach/arch.h>
 #include <plat/irq.h>
-#include <asm/mach/irq.h>
-#include <mach/pm.h>
 #include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include "common.h"
 
-static void pmu_irq_mask(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	u = readl(PMU_INTERRUPT_MASK);
-	u &= ~(1 << (pin & 31));
-	writel(u, PMU_INTERRUPT_MASK);
-}
-
-static void pmu_irq_unmask(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	u = readl(PMU_INTERRUPT_MASK);
-	u |= 1 << (pin & 31);
-	writel(u, PMU_INTERRUPT_MASK);
-}
-
-static void pmu_irq_ack(struct irq_data *d)
-{
-	int pin = irq_to_pmu(d->irq);
-	u32 u;
-
-	/*
-	 * The PMU mask register is not RW0C: it is RW.  This means that
-	 * the bits take whatever value is written to them; if you write
-	 * a '1', you will set the interrupt.
-	 *
-	 * Unfortunately this means there is NO race free way to clear
-	 * these interrupts.
-	 *
-	 * So, let's structure the code so that the window is as small as
-	 * possible.
-	 */
-	u = ~(1 << (pin & 31));
-	u &= readl_relaxed(PMU_INTERRUPT_CAUSE);
-	writel_relaxed(u, PMU_INTERRUPT_CAUSE);
-}
-
-static struct irq_chip pmu_irq_chip = {
-	.name		= "pmu_irq",
-	.irq_mask	= pmu_irq_mask,
-	.irq_unmask	= pmu_irq_unmask,
-	.irq_ack	= pmu_irq_ack,
-};
-
-static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
-
-	cause &= readl(PMU_INTERRUPT_MASK);
-	if (cause == 0) {
-		do_bad_IRQ(irq, desc);
-		return;
-	}
-
-	for (irq = 0; irq < NR_PMU_IRQS; irq++) {
-		if (!(cause & (1 << irq)))
-			continue;
-		irq = pmu_to_irq(irq);
-		generic_handle_irq(irq);
-	}
-}
-
 static int __initdata gpio0_irqs[4] = {
 	IRQ_DOVE_GPIO_0_7,
 	IRQ_DOVE_GPIO_8_15,
@@ -142,8 +70,6 @@ __exception_irq_entry dove_legacy_handle_irq(struct pt_regs *regs)
 
 void __init dove_init_irq(void)
 {
-	int i;
-
 	orion_irq_init(0, IRQ_VIRT_BASE + IRQ_MASK_LOW_OFF);
 	orion_irq_init(32, IRQ_VIRT_BASE + IRQ_MASK_HIGH_OFF);
 
@@ -162,17 +88,4 @@ void __init dove_init_irq(void)
 
 	orion_gpio_init(NULL, 64, 8, DOVE_GPIO2_VIRT_BASE, 0,
 			IRQ_DOVE_GPIO_START + 64, gpio2_irqs);
-
-	/*
-	 * Mask and clear PMU interrupts
-	 */
-	writel(0, PMU_INTERRUPT_MASK);
-	writel(0, PMU_INTERRUPT_CAUSE);
-
-	for (i = IRQ_DOVE_PMU_START; i < NR_IRQS; i++) {
-		irq_set_chip_and_handler(i, &pmu_irq_chip, handle_level_irq);
-		irq_set_status_flags(i, IRQ_LEVEL);
-		set_irq_flags(i, IRQF_VALID);
-	}
-	irq_set_chained_handler(IRQ_DOVE_PMU, pmu_irq_handler);
 }
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index e01d9856d7a1..17da329d609b 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 6792aae9e2e5..7072fdbe8f8b 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -305,6 +305,106 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
 	return 0;
 }
 
+static void pmu_add_genpd_name(const char *name, struct device *dev)
+{
+	while (1) {
+		if (pm_genpd_name_add_device(name, dev) != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static void pmu_remove_genpd(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pm_genpd_lookup_dev(dev);
+
+	if (!genpd)
+		return;
+
+	while (1) {
+		if (pm_genpd_remove_device(genpd, dev) != -EAGAIN)
+			break;
+		cond_resched();
+	}
+}
+
+static int pmu_platform_call(struct notifier_block *nb,
+	unsigned long event, void *data)
+{
+	struct device *dev = data;
+	const char *name = NULL;
+
+	if (dev->of_node)
+		return NOTIFY_OK;
+
+	if (strcmp(dev_name(dev), "ap510-vmeta.0") == 0 ||
+	    strcmp(dev_name(dev), "ap510-vmeta") == 0)
+		name = "vpu-domain";
+	else if (strcmp(dev_name(dev), "galcore.0") == 0)
+		name = "gpu-domain";
+
+	switch (event) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		if (name)
+			pmu_add_genpd_name(name, dev);
+		break;
+
+	case BUS_NOTIFY_DEL_DEVICE:
+		pmu_remove_genpd(dev);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block platform_nb = {
+	.notifier_call = pmu_platform_call,
+};
+
+int __init dove_init_pmu_legacy(const struct dove_pmu_initdata *initdata)
+{
+	const struct dove_pmu_domain_initdata *domain_initdata;
+	struct pmu_data *pmu;
+	int ret;
+
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	spin_lock_init(&pmu->lock);
+	pmu->pmc_base = initdata->pmc_base;
+	pmu->pmu_base = initdata->pmu_base;
+
+	pmu_reset_init(pmu);
+	for (domain_initdata = initdata->domains; domain_initdata->name;
+	     domain_initdata++) {
+		struct pmu_domain *domain;
+
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain) {
+			domain->pmu = pmu;
+			domain->pwr_mask = domain_initdata->pwr_mask;
+			domain->rst_mask = domain_initdata->rst_mask;
+			domain->iso_mask = domain_initdata->iso_mask;
+			domain->base.name = domain_initdata->name;
+
+			__pmu_domain_register(domain, NULL);
+		}
+	}
+	pm_genpd_poweroff_unused();
+
+	ret = dove_init_pmu_irq(pmu, initdata->irq);
+	if (ret)
+		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
+
+	if (pmu->irq_domain)
+		irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
+					  0, NR_PMU_IRQS);
+
+	bus_register_notifier(&platform_bus_type, &platform_nb);
+
+	return 0;
+}
+
 /*
  * pmu: power-manager at d0000 {
  *	compatible = "marvell,dove-pmu";
diff --git a/include/linux/soc/dove/pmu.h b/include/linux/soc/dove/pmu.h
index 9c99f84bcc0e..431dfac595e7 100644
--- a/include/linux/soc/dove/pmu.h
+++ b/include/linux/soc/dove/pmu.h
@@ -1,6 +1,24 @@
 #ifndef LINUX_SOC_DOVE_PMU_H
 #define LINUX_SOC_DOVE_PMU_H
 
+#include <linux/types.h>
+
+struct dove_pmu_domain_initdata {
+	u32 pwr_mask;
+	u32 rst_mask;
+	u32 iso_mask;
+	const char *name;
+};
+
+struct dove_pmu_initdata {
+	void __iomem *pmc_base;
+	void __iomem *pmu_base;
+	int irq;
+	const struct dove_pmu_domain_initdata *domains;
+};
+
+int dove_init_pmu_legacy(const struct dove_pmu_initdata *);
+
 int dove_init_pmu(void);
 
 #endif
-- 
2.1.0
