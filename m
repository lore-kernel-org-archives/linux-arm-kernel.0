From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 08 Dec 2015 11:33:43 +0100
Subject: [PATCH v2 2/3] soc: dove: add legacy support to PMU driver
In-Reply-To: <3338599.KHgeg6bT8F@wuerfel> (Arnd Bergmann's message of "Tue, 08
 Dec 2015 00:15:26 +0100")
References: <E1a5j6Q-000879-GO@rmk-PC.arm.linux.org.uk>
 <20151207211656.GZ8644@n2100.arm.linux.org.uk>
 <878u569ck5.fsf@free-electrons.com> <3338599.KHgeg6bT8F@wuerfel>
Message-ID: <87vb898c1k.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 On mar., d?c. 08 2015, Arnd Bergmann <arnd@arndb.de> wrote:

> On Monday 07 December 2015 22:24:58 Gregory CLEMENT wrote:
>> Hi Russell King,
>>  
>>  On lun., d?c. 07 2015, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> 
>> > On Mon, Dec 07, 2015 at 10:09:27PM +0100, Gregory CLEMENT wrote:
>> >> Hi Russell,
>> >>  
>> >>  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> >> 
>> >> >  On lun., d?c. 07 2015, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>> >> >
>> >> >> Hi Russell,
>> >> >>  
>> >> >>  On lun., d?c. 07 2015, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> >> >>
>> >> >>> Add support for legacy non-DT Dove to the PMU driver, so that we can
>> >> >>> transition the legacy support over.
>> >> >>>
>> >> >>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> >> >>
>> >> >> Applied on mvebu/soc (and fixed a conflict in drivers/soc/Makefile)
>> >> >
>> >> > Eventually I applied it on mvebu/drivers rather than mvebu/soc
>> >> 
>> >> Actually I was too optimitic. It doesn't build on mvebu/soc (based on
>> >> 4.4-rc1).
>> >> 
>> >> First pm_genpd_poweroff_unused() had been removed since bb4b72fc63d4 "PM
>> >> / Domains: Remove pm_genpd_poweroff_unused() API ".
>> >> 
>> >> Then, even by removing the call this function to go furthetr I got other
>> >> errors such as: drivers/soc/dove/pmu.c:344:46: error:
>> >> ?IRQ_DOVE_PMU_START? undeclared (first use in this function)
>> >
>> > I guess that's with Arnd's patches?  Sigh, okay, it'll have to wait yet
>> > _another_ kernel cycle then.
>> 
>> Yes I think the breakage comes from "ARM: orion: use SPARSE_IRQ
>> everywhere". With this one mach/irqs.h is no more visible by
>> drivers/soc/dove/pmu.c. But I am sure we can find a solution. It could
>> not be the first time there is such issue when moving to multiplatform.
>> 
>> Arnd, do you have some suggestion?
>
> It should be enough to add
>
> #ifdef ARCH_DOVE
> #include <mach/irqs.h>
> #endif
>
Russell,

if you agree I can amend your patch by adding the following chunk and my
removing the pm_genpd_poweroff_unused() call. Fot this last one the
similar removal was done in the commit 2376692416b7 "soc: dove: Let
genpd deal with disabling of unused PM domains".

#ifdef CONFIG_ARCH_DOVE
#include <mach/irqs.h>
#endif

The resulting patch would be the following

--------
Subject: [PATCH] soc: dove: add legacy support to PMU driver

Add support for legacy non-DT Dove to the PMU driver, so that we can
transition the legacy support over.

[gregory.clement at free-electrons.com: removed pm_genpd_poweroff_unused]
[gregory.clement at free-electrons.com: added include of mach/irqs.h if
CONFIG_ARCH_DOVE was defined]

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/soc/Makefile         |  1 +
 drivers/soc/dove/pmu.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/dove/pmu.h | 18 +++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index f2ba2e932ae1..d52872680f86 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_SOC_BRCMSTB)	+= brcmstb/
+obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index abd087917f80..5e2e660ed086 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -16,6 +16,10 @@
 #include <linux/soc/dove/pmu.h>
 #include <linux/spinlock.h>
 
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/irqs.h>
+#endif
+
 #define NR_PMU_IRQS		7
 
 #define PMC_SW_RST		0x30
@@ -305,6 +309,48 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
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
+
+	ret = dove_init_pmu_irq(pmu, initdata->irq);
+	if (ret)
+		pr_err("dove_init_pmu_irq() failed: %d\n", ret);
+
+	if (pmu->irq_domain)
+		irq_domain_associate_many(pmu->irq_domain, IRQ_DOVE_PMU_START,
+					  0, NR_PMU_IRQS);
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
2.5.0

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
