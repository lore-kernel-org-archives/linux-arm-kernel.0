From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jan 2017 11:29:40 +0200
Subject: [PATCH 2/2] spi: pca2xx-pci: Allow MSI
In-Reply-To: <4061bba80ecc632b219b56d8a8cd25d62658d48a.1484557560.git.jan.kiszka@siemens.com>
References: <cover.1484557560.git.jan.kiszka@siemens.com>
 <4061bba80ecc632b219b56d8a8cd25d62658d48a.1484557560.git.jan.kiszka@siemens.com>
Message-ID: <1484558980.2133.134.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-01-16 at 10:06 +0100, Jan Kiszka wrote:
> Now that the core is ready for edge-triggered interrupts, we can
> safely
> allow the PCI versions that provide this to enable the feature and,
> thus, have less shared interrupts.
> 

My comments below.

> -	?if (IS_ERR(ssp->clk))
> +	if (IS_ERR(ssp->clk))
> ?		return PTR_ERR(ssp->clk);

This doesn't belong to the patch.
?
> +	pci_set_master(dev);
> +
> +	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (ret < 0) {
> +		clk_unregister(ssp->clk);
> +		return ret;
> +	}
> +	ssp->irq = pci_irq_vector(dev, 0);
> +

This looks good, though I would put it closer to the initial place of
ssp->irq assignment, i.e. before clock registering.

> +		pci_free_irq_vectors(dev);
> +	pci_free_irq_vectors(dev);

You know my answer, right? So, please be sure that we are using
pcim_alloc_irq_vectors().

Yes, I know there is (was?) no such API, needs to be created. Currently
this might make a mess on ->remove().

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
