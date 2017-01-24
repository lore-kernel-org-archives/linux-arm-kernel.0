From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Jan 2017 18:39:48 +0000
Subject: Applied "spi: pca2xx-pci: Allow MSI" to the spi tree
In-Reply-To: <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <E1cW60S-0006m9-O2@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pca2xx-pci: Allow MSI

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 64e02cb0bdfc7cef0a01e2ad4d567fdc0a74450e Mon Sep 17 00:00:00 2001
From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Sat, 21 Jan 2017 10:06:39 +0100
Subject: [PATCH] spi: pca2xx-pci: Allow MSI

Now that the core is ready for edge-triggered interrupts, we can safely
allow the PCI versions that provide this to enable the feature and,
thus, have less shared interrupts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 868452d8e3e1..869f188b02eb 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -227,10 +227,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
-	ssp->irq = dev->irq;
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;
 
+	pci_set_master(dev);
+
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+	ssp->irq = pci_irq_vector(dev, 0);
+
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
 	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
 					   c->max_clk_rate);
-- 
2.11.0
