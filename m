From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  7 Jan 2015 15:29:29 +0000
Subject: [RFC PATCH 1/3] drivers: of: fix resources freeing in
 of_pci_get_host_bridge_resources()
In-Reply-To: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1420644571-18928-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the function of_pci_get_host_bridge_resources() if the parsing of
ranges fails, previously allocated resources inclusive of bus_range
are not freed and are not expected to be freed by the function caller
on error return.

This patch fixes the issues by adding code that properly frees resources
and bus_range before exiting the function with an error return value.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/of/of_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 88471d3..6fbfe99 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -146,6 +146,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	struct of_pci_range_parser parser;
 	char range_type[4];
 	int err;
+	struct pci_host_bridge_window *window;
 
 	if (io_base)
 		*io_base = (resource_size_t)OF_BAD_ADDR;
@@ -225,7 +226,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 conversion_failed:
 	kfree(res);
 parse_failed:
+	list_for_each_entry(window, resources, list)
+		kfree(window->res);
 	pci_free_resource_list(resources);
+	kfree(bus_range);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.2.1
