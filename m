From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 21 Apr 2015 19:34:23 +0800
Subject: [PATCH v10 04/29] PCI: Move pci_bus_assign_domain_nr() declaration
 into drivers/pci/pci.h
In-Reply-To: <1429616088-10249-1-git-send-email-wangyijing@huawei.com>
References: <1429616088-10249-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1429616088-10249-5-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_bus_assign_domain_nr() is only called in probe.c,
Move pci_bus_assign_domain_nr() declaration into
drivers/pci/pci.h.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pci.h   |    9 +++++++++
 include/linux/pci.h |    6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index d72f849..dbf1ac0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -323,4 +323,13 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 
 struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
+#ifdef CONFIG_PCI_DOMAINS_GENERIC
+void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
+#else
+static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
+					struct device *parent)
+{
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1a0f8d2..0bdc639 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1331,12 +1331,6 @@ static inline int pci_domain_nr(struct pci_bus *bus)
 {
 	return bus->domain_nr;
 }
-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent);
-#else
-static inline void pci_bus_assign_domain_nr(struct pci_bus *bus,
-					struct device *parent)
-{
-}
 #endif
 
 /* some architectures require additional setup to direct VGA traffic */
-- 
1.7.1
