From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 16:02:41 +0100
Subject: [PATCH] PCI: provide of_pci_get_host_bridge_resources helper
Message-ID: <8759253.sZisGJ6Km3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcie-rcar driver can be built for any ARM platform (for COMPILE_TEST)
including those without CONFIG_OF enabled, and that results in a compile-time
error:

drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_parse_request_of_pci_ranges':
drivers/pci/host/pcie-rcar.c:939:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
  err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, &iobase);

In order to allow compile-testing on all platforms, this adds a
of_pci_get_host_bridge_resources() helper stub function that gets
used when CONFIG_OF_ADDRESS is disabled. This mirrors what we do for
other OF-specific functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")

diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 2c51ee78b1c0..874d68f50a40 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -59,6 +59,14 @@ static inline void of_pci_check_probe_only(void) { }
 int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base);
+#else
+static inline
+int of_pci_get_host_bridge_resources(struct device_node *dev,
+			unsigned char busno, unsigned char bus_max,
+			struct list_head *resources, resource_size_t *io_base)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
