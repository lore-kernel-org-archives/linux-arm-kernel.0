From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 24 Mar 2015 11:33:59 +0800
Subject: [PATCH v8 05/30] PCI: Introduce pci_host_assign_domain_nr() to assign
 domain
In-Reply-To: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1427168064-8657-6-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce pci_host_assign_domain_nr() to assign domain
number for pci_host_bridge. In the later patch, we would
assign domain in pci_create_host_bridge, clean up the
pci_bus_assign_domain_nr() and move this function into
drivers/pci/host-bridge.c.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.c |   21 ++++++++++++++++-----
 drivers/pci/pci.h |    4 ++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8..6677fac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4501,10 +4501,10 @@ int pci_get_new_domain_nr(void)
 }
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+static int pci_assign_domain_nr(struct device *dev)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = of_get_pci_domain_nr(dev->of_node);
 
 	/*
 	 * Check DT domain and use_dt_domains values.
@@ -4538,13 +4538,24 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
 	} else {
-		dev_err(parent, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node->full_name);
+		dev_err(dev, "Node %s has inconsistent \"linux,pci-domain\" property in DT\n",
+			dev->of_node->full_name);
 		domain = -1;
 	}
 
-	bus->domain_nr = domain;
+	return domain;
+}
+
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
+{
+	bus->domain_nr = pci_assign_domain_nr(parent);
 }
+
+void pci_host_assign_domain_nr(struct pci_host_bridge *host)
+{
+	host->domain = pci_assign_domain_nr(host->dev.parent);
+}
+
 #endif
 #endif
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba1bcce..1d3d2d1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -323,11 +323,15 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
+void pci_host_assign_domain_nr(struct pci_host_bridge *host);
 #else
 static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
 					struct device *parent)
 {
 }
+static inline void pci_host_assign_domain_nr(struct pci_host_bridge *host)
+{
+}
 #endif
 
 #endif /* DRIVERS_PCI_H */
-- 
1.7.1
