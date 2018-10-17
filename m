From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Oct 2018 20:50:52 +0200
Subject: [PATCH] spi: pxa2xx: fix PCI dependency
Message-ID: <20181017185128.2634666-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code reorganization broke building without CONFIG_PCI:

drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]

Add back an #ifdef around the code block that requires it.

Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 612cc49db28f..c1c30109dd1f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1453,9 +1453,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_id = of_match_device(pdev->dev.driver->of_match_table,
 					&pdev->dev);
+#ifdef CONFIG_PCI
 	else if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
+#endif
 	else if (adev)
 		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
-- 
2.18.0
