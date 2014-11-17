From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 17 Nov 2014 18:21:44 +0800
Subject: [RFC PATCH 10/16] PCI: Add of_scan_bus() to pci_host_info
In-Reply-To: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1416219710-26088-11-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add of_scan_bus() to support some platforms
scan bus by of_node.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host-bridge.c |    1 +
 drivers/pci/probe.c       |   10 +++++++---
 include/linux/pci.h       |    3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 872cae1..1a1f81b 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -52,6 +52,7 @@ struct pci_host_bridge *pci_create_host_bridge(
 		return NULL;
 
 	host->sysdata = info->arg;
+	host->node = info->node;
 	host->busnum = PCI_BUSNUM(db);
 	host->domain = PCI_DOMAIN(db);
 	host->ops = ops;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 42158fd..2729c41 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2126,9 +2126,13 @@ struct pci_host_bridge *pci_scan_host_bridge(
 		pci_bus_insert_busn_res(host->bus, host->busnum, 255);
 	}
 
-	max = pci_scan_child_bus(host->bus);
-	if (!found)
-		pci_bus_update_busn_res_end(host->bus, max);
+	if (info->of_scan_bus) {
+		info->of_scan_bus(host);
+	} else {
+		max = pci_scan_child_bus(host->bus);
+		if (!found)
+			pci_bus_update_busn_res_end(host->bus, max);
+	}
 
 	return host;
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index af1ee86..c4f4438 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -407,6 +407,7 @@ struct pci_host_bridge {
 	int busnum;
 	int domain;
 	void *sysdata;
+	struct device_node *node;
 	struct pci_ops *ops;
 	struct msi_controller *(*get_msi_ctrl)(struct pci_dev *pdev);
 	void (*release_fn)(struct pci_host_bridge *);
@@ -416,10 +417,12 @@ struct pci_host_bridge {
 struct pci_host_info {
 	u8 res_type;
 	void *arg;
+	struct device_node *node;
 	struct list_head *resources; /*just for build, will clean up later */
 	struct msi_controller *(*get_msi_ctrl)(struct pci_dev *pdev);
 	int (*init_res)(struct pci_host_bridge *host, 
 			struct pci_host_info *info);
+	void (*of_scan_bus)(struct pci_host_bridge *host);
 };
 
 static inline void init_pci_host_info(struct pci_host_info *info)
-- 
1.7.1
