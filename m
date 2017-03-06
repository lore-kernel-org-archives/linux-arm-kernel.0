From: rrichter@cavium.com (Robert Richter)
Date: Mon,  6 Mar 2017 13:57:36 +0100
Subject: [PATCH v2 5/8] irqchip/gic-v3-its: Prevent its init ordering
 dependencies
In-Reply-To: <20170306125739.19445-1-rrichter@cavium.com>
References: <20170306125739.19445-1-rrichter@cavium.com>
Message-ID: <20170306125739.19445-6-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now its_init() must be called before pci and platform init.
Remove ordering dependencies to allow all initialization functions
being called with the same initcall type.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 4 +++-
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index dace9bc4ef8d..afe78f224181 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -77,6 +77,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 		return -EINVAL;
 
 	msi_info = msi_get_domain_info(domain->parent);
+	if (!msi_info)
+		return -ENODEV;
 
 	pdev = to_pci_dev(dev);
 	dev_alias.pdev = pdev;
@@ -113,7 +115,7 @@ static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
 	struct irq_domain *parent;
 
 	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
+	if (!parent) {
 		pr_err("%s: Unable to locate ITS domain\n", name);
 		return -ENXIO;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 7d8c19973766..22ba1dfed8ba 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -32,6 +32,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	int ret, index = 0;
 
 	msi_info = msi_get_domain_info(domain->parent);
+	if (!msi_info)
+		return -ENODEV;
 
 	/* Suck the DeviceID out of the msi-parent property */
 	do {
@@ -84,7 +86,7 @@ static int __init its_pmsi_init(void)
 			continue;
 
 		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
+		if (!parent) {
 			pr_err("%s: unable to locate ITS domain\n",
 			       np->full_name);
 			continue;
-- 
2.11.0
