From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jan 2017 21:08:38 +0200
Subject: [PATCH v2 3/3] spi: pca2xx-pci: Allow MSI
In-Reply-To: <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <9f5bc54a5842b383dc81fa8586d6774c03d2c452.1484592296.git.jan.kiszka@siemens.com>
Message-ID: <1484593718.2133.156.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 19:44 +0100, Jan Kiszka wrote:
> Now that the core is ready for edge-triggered interrupts, we can
> safely
> allow the PCI versions that provide this to enable the feature and,
> thus, have less shared interrupts.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>



>?drivers/spi/spi-pxa2xx-pci.c | 8 +++++++-
> ?1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-
> pci.c
> index 58d2d48..58dcadb 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -203,10 +203,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev
> *dev,
> ?	ssp = &spi_pdata.ssp;
> ?	ssp->phys_base = pci_resource_start(dev, 0);
> ?	ssp->mmio_base = pcim_iomap_table(dev)[0];
> -	ssp->irq = dev->irq;
> ?	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
> ?	ssp->type = c->type;
> ?
> +	pci_set_master(dev);
> +
> +	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0)
> +		return ret;

+ perhaps an empty line?

> +	ssp->irq = pci_irq_vector(dev, 0);
> +
> ?	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
> ?	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
?					???c->max_clk_rate);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
