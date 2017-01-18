From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 18 Jan 2017 20:54:55 +0800
Subject: [PATCH v8 05/15] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_prepare()
In-Reply-To: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1484744105-53140-6-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Adding ACPI support for platform MSI, we need to retrieve the
dev id in ACPI way instead of device tree, we already have
a well formed function its_pmsi_prepare() to get the dev id
but it's OF dependent, so collect OF related code and put them
into a single function to make its_pmsi_prepare() more friendly
to ACPI later.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Tested-by: Ming Lei <ming.lei@canonical.com>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Tested-by: Sinan Kaya <okaya@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 470b4aa..3c94278 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -24,15 +24,11 @@
 	.name			= "ITS-pMSI",
 };
 
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+				  u32 *dev_id)
 {
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
 	int ret, index = 0;
 
-	msi_info = msi_get_domain_info(domain->parent);
-
 	/* Suck the DeviceID out of the msi-parent property */
 	do {
 		struct of_phandle_args args;
@@ -43,11 +39,24 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 		if (args.np == irq_domain_get_of_node(domain)) {
 			if (WARN_ON(args.args_count != 1))
 				return -EINVAL;
-			dev_id = args.args[0];
+			*dev_id = args.args[0];
 			break;
 		}
 	} while (!ret);
 
+	return ret;
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	msi_info = msi_get_domain_info(domain->parent);
+
+	ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
 	if (ret)
 		return ret;
 
-- 
1.7.12.4
