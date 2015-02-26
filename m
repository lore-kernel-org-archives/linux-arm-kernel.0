From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 26 Feb 2015 16:12:13 +0800
Subject: [PATCH v4 19/30] PCI: Remove weak pcibios_root_bridge_prepare()
In-Reply-To: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
References: <1424938344-4017-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1424938344-4017-20-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now no one use weak pcibios_root_bridge_prepare(),
we could remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |   15 ---------------
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b5f9ca4..356c90f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1844,18 +1844,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
 
-/**
- * pcibios_root_bridge_prepare - Platform-specific host bridge setup.
- * @bridge: Host bridge to set up.
- *
- * Default empty implementation.  Replace with an architecture-specific setup
- * routine, if necessary.
- */
-int __weak pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	return 0;
-}
-
 void __weak pcibios_add_bus(struct pci_bus *bus)
 {
 }
@@ -1890,9 +1878,6 @@ static struct pci_bus *__pci_create_root_bus(
 	b->bridge = get_device(&bridge->dev);
 	if (bridge->ops && bridge->ops->phb_set_root_bus_speed)
 		bridge->ops->phb_set_root_bus_speed(bridge);
-	error = pcibios_root_bridge_prepare(bridge);
-	if (error)
-		goto err_out;
 
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ef3a821..3c4413c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -423,8 +423,6 @@ struct pci_host_bridge {
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
-
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
 struct pci_host_bridge *pci_create_host_bridge(
 		struct device *parent, u32 dombus, struct list_head *resources, 
 		void *sysdata, struct pci_host_bridge_ops *ops);
-- 
1.7.1
