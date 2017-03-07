From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 7 Mar 2017 20:40:00 +0800
Subject: [PATCH v9 05/15] irqchip: gicv3-its: platform-msi: refactor
 its_pmsi_prepare()
In-Reply-To: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1488890410-15503-6-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

By adding ACPI support for platform MSI, the gicv3 driver has to
provide code to retrieve the dev id through ACPI instead of device
tree bindings; given that its_pmsi_prepare() allows already to get
the dev id but it is OF dependent, factor OF related code out into
a single function to make its_pmsi_prepare() ready to be used with
other firmware interfaces.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
[lorenzo.pieralisi at arm.com: rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
