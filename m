From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 06 Jun 2016 18:04:52 -0500
Subject: [PATCH v1 01/25] PCI: Add devm_request_pci_bus_resources()
In-Reply-To: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160606230452.20936.28937.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several host bridge drivers iterate through the list of bridge windows to
request resources.  Several others don't request the window resources at
all.

Add a devm_request_pci_bus_resources() interface to make it easier for
drivers to request all the window resources.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c   |   29 ++++++++++++++++++++++++++++-
 include/linux/pci.h |    5 ++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dd7cdbe..78b90c7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -91,6 +91,34 @@ void pci_bus_remove_resources(struct pci_bus *bus)
 	}
 }
 
+int devm_request_pci_bus_resources(struct device *dev,
+				   struct list_head *resources)
+{
+	struct resource_entry *win;
+	struct resource *parent, *res;
+	int err;
+
+	resource_list_for_each_entry(win, resources) {
+		res = win->res;
+		switch (resource_type(res)) {
+		case IORESOURCE_IO:
+			parent = &ioport_resource;
+			break;
+		case IORESOURCE_MEM:
+			parent = &iomem_resource;
+			break;
+		default:
+			continue;
+		}
+
+		err = devm_request_resource(dev, parent, res);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
 #ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
@@ -397,4 +425,3 @@ void pci_bus_put(struct pci_bus *bus)
 		put_device(&bus->dev);
 }
 EXPORT_SYMBOL(pci_bus_put);
-
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..6ac8360 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1143,9 +1143,12 @@ void pci_add_resource(struct list_head *resources, struct resource *res);
 void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 			     resource_size_t offset);
 void pci_free_resource_list(struct list_head *resources);
-void pci_bus_add_resource(struct pci_bus *bus, struct resource *res, unsigned int flags);
+void pci_bus_add_resource(struct pci_bus *bus, struct resource *res,
+			  unsigned int flags);
 struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
 void pci_bus_remove_resources(struct pci_bus *bus);
+int devm_request_pci_bus_resources(struct device *dev,
+				   struct list_head *resources);
 
 #define pci_bus_for_each_resource(bus, res, i)				\
 	for (i = 0;							\
