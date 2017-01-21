From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Sat, 21 Jan 2017 10:06:39 +0100
Subject: [PATCH v3 2/2] spi: pca2xx-pci: Allow MSI
In-Reply-To: <cover.1484989599.git.jan.kiszka@siemens.com>
References: <cover.1484989599.git.jan.kiszka@siemens.com>
Message-ID: <21af25da8245335ee5be55b3cb9527ce53c652fa.1484989599.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the core is ready for edge-triggered interrupts, we can safely
allow the PCI versions that provide this to enable the feature and,
thus, have less shared interrupts.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 868452d..869f188 100644
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
2.1.4
