From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 16 Jan 2017 10:06:00 +0100
Subject: [PATCH 2/2] spi: pca2xx-pci: Allow MSI
In-Reply-To: <cover.1484557560.git.jan.kiszka@siemens.com>
References: <cover.1484557560.git.jan.kiszka@siemens.com>
Message-ID: <4061bba80ecc632b219b56d8a8cd25d62658d48a.1484557560.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core is ready for edge-triggered interrupts, we can safely
allow the PCI versions that provide this to enable the feature and,
thus, have less shared interrupts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 58d2d48..e7e5b08 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -203,16 +203,24 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
-	ssp->irq = dev->irq;
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;
 
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
 	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
 					   c->max_clk_rate);
-	 if (IS_ERR(ssp->clk))
+	if (IS_ERR(ssp->clk))
 		return PTR_ERR(ssp->clk);
 
+	pci_set_master(dev);
+
+	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		clk_unregister(ssp->clk);
+		return ret;
+	}
+	ssp->irq = pci_irq_vector(dev, 0);
+
 	memset(&pi, 0, sizeof(pi));
 	pi.fwnode = dev->dev.fwnode;
 	pi.parent = &dev->dev;
@@ -224,6 +232,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	pdev = platform_device_register_full(&pi);
 	if (IS_ERR(pdev)) {
 		clk_unregister(ssp->clk);
+		pci_free_irq_vectors(dev);
 		return PTR_ERR(pdev);
 	}
 
@@ -241,6 +250,7 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 
 	platform_device_unregister(pdev);
 	clk_unregister(spi_pdata->ssp.clk);
+	pci_free_irq_vectors(dev);
 }
 
 static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
-- 
2.1.4
