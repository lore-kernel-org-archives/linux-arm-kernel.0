From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:34:15 +0800
Subject: [PATCH v6 18/30] PCI: Remove weak pcibios_root_bridge_prepare()
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425868467-9667-19-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now no one use weak pcibios_root_bridge_prepare(),
we could remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   16 +---------------
 include/linux/pci.h |    2 --
 2 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 99f17e3..1080eff 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1845,18 +1845,6 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
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
@@ -1889,11 +1877,9 @@ static struct pci_bus *__pci_create_root_bus(
 
 	bridge->bus = b;
 	b->bridge = get_device(&bridge->dev);
+
 	if (bridge->ops && bridge->ops->set_root_bus_speed)
 		bridge->ops->set_root_bus_speed(bridge);
-	error = pcibios_root_bridge_prepare(bridge);
-	if (error)
-		goto err_out;
 
 	device_enable_async_suspend(b->bridge);
 	pci_set_bus_of_node(b);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28eafb5..cfaf217 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -424,8 +424,6 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
 
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
-
 /*
  * The first PCI_BRIDGE_RESOURCE_NUM PCI bus resources (those that correspond
  * to P2P or CardBus bridge windows) go in a table.  Additional ones (for
-- 
1.7.1
