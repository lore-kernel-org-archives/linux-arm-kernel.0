From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 21 Jan 2015 08:30:08 +0800
Subject: [PATCH v2 13/30] PCI: Introduce new scan function
 pci_scan_root_bridge()
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1421800225-26230-14-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new scan function pci_scan_root_bridge() to
support host bridge drivers that need to provide platform
own pci_host_bridge_ops.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   21 +++++++++++++++++++++
 include/linux/pci.h |    3 +++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ca53c37..c23ca8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2064,6 +2064,27 @@ static struct pci_bus *__pci_scan_root_bus(
 	return b;
 }
 
+struct pci_host_bridge *pci_scan_root_bridge(struct device *parent,
+		u32 db, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct pci_host_bridge_ops *phb_ops)
+{
+	struct pci_host_bridge *host;
+	struct pci_bus *bus;
+
+	host = pci_create_host_bridge(parent, db, resources,
+			sysdata, phb_ops);
+	if (!host)
+		return NULL;
+
+	bus = __pci_scan_root_bus(host, ops);
+	if (!bus)
+		pci_free_host_bridge(host);
+
+	return host;
+}
+EXPORT_SYMBOL(pci_scan_root_bridge);
+
+
 struct pci_bus *pci_scan_root_bus(struct device *parent, u32 db,
 		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 817756a..e60c59a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -793,6 +793,9 @@ void pci_bus_release_busn_res(struct pci_bus *b);
 struct pci_bus *pci_scan_root_bus(struct device *parent, u32 dombus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
+struct pci_host_bridge *pci_scan_root_bridge(struct device *parent,
+		u32 dombus, struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct pci_host_bridge_ops *phb_ops);
 struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
 				int busnr);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
-- 
1.7.1
