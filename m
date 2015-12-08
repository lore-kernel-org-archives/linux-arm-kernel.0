From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 08 Dec 2015 10:43:28 +0000
Subject: [PATCH v3 2/3] soc: dove: add legacy support to PMU driver
Message-ID: <E1a6Fk0-0004mw-Rg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for legacy non-DT Dove to the PMU driver, so that we can
transition the legacy support over.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
v3: add irq_domain_start to init data to kill build error in dove/pmu.c

 drivers/soc/Makefile         |  1 +
 drivers/soc/dove/pmu.c       | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/dove/pmu.h | 19 +++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 0b12d777d3c4..c99192f30679 100644
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
index 052aecf29893..10c00be2c198 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -305,6 +305,50 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
 	return 0;
 }
 
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
+		irq_domain_associate_many(pmu->irq_domain,
+					  initdata->irq_domain_start,
+					  0, NR_PMU_IRQS);
+
+	return 0;
+}
+
 /*
  * pmu: power-manager at d0000 {
  *	compatible = "marvell,dove-pmu";
diff --git a/include/linux/soc/dove/pmu.h b/include/linux/soc/dove/pmu.h
index 9c99f84bcc0e..765386972b55 100644
--- a/include/linux/soc/dove/pmu.h
+++ b/include/linux/soc/dove/pmu.h
@@ -1,6 +1,25 @@
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
+	int irq_domain_start;
+	const struct dove_pmu_domain_initdata *domains;
+};
+
+int dove_init_pmu_legacy(const struct dove_pmu_initdata *);
+
 int dove_init_pmu(void);
 
 #endif
-- 
2.1.0
