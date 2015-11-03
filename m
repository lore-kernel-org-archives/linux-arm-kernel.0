From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 15:08:33 +0100
Subject: [PATCH] PCI: altera: add OF_PCI dependency
Message-ID: <38421064.oVjju5M930@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added altera PCI driver fails to build when CONFIG_OF
is disabled:

drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
drivers/pci/host/pcie-altera.c:420:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]

This adds a dependency on OF_PCI for clarity, this is the symbol
that guards the implementation of of_pci_get_host_bridge_resources.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6bb4dd154ae8 ("PCI: altera: Add Altera PCIe host controller driver")
---
Found on ARM randconfig builds yesterday

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 9e24075d83f7..f131ba947dc6 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -150,6 +150,7 @@ config PCIE_IPROC_BCMA
 config PCIE_ALTERA
 	bool "Altera PCIe controller"
 	depends on ARM || NIOS2
+	depends on OF_PCI
 	select PCI_DOMAINS
 	help
 	  Say Y here if you want to enable PCIe controller support on Altera
