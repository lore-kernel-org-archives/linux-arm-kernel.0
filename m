From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Oct 2018 13:30:02 +0100 (BST)
Subject: Applied "spi: pxa2xx: fix PCI dependency" to the spi tree
In-Reply-To: <20181017185128.2634666-1-arnd@arndb.de>
Message-ID: <20181019123002.196D21122548@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: fix PCI dependency

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 23aa9fdea2d364924fadf3dcc1509bd578ac1f00 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 20:50:52 +0200
Subject: [PATCH] spi: pxa2xx: fix PCI dependency

The code reorganization broke building without CONFIG_PCI:

drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]

Add back an #ifdef around the code block that requires it.

Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
