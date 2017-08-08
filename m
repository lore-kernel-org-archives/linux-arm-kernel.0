From: rrichter@cavium.com (Robert Richter)
Date: Tue,  8 Aug 2017 14:22:55 +0200
Subject: [PATCH v3 5/8] irqchip/gic-v3-its: Prevent its init ordering
 dependencies
In-Reply-To: <20170808122259.6299-1-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
Message-ID: <20170808122259.6299-6-rrichter@cavium.com>
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
index 5940fdf0036e..7a8fbb74f2eb 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -72,6 +72,8 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 		return -EINVAL;
 
 	msi_info = msi_get_domain_info(domain->parent);
+	if (!msi_info)
+		return -ENODEV;
 
 	pdev = to_pci_dev(dev);
 	/*
@@ -112,7 +114,7 @@ static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
 	struct irq_domain *parent;
 
 	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
+	if (!parent) {
 		pr_err("%s: Unable to locate ITS domain\n", name);
 		return -ENXIO;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 6ebc871ac63f..999d3bdc17a6 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -61,6 +61,8 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	int ret;
 
 	msi_info = msi_get_domain_info(domain->parent);
+	if (!msi_info)
+		return -ENODEV;
 
 	if (dev->of_node)
 		ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
@@ -97,7 +99,7 @@ static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
 	struct irq_domain *parent;
 
 	parent = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
+	if (!parent) {
 		pr_err("%s: unable to locate ITS domain\n", name);
 		return -ENXIO;
 	}
-- 
2.11.0
