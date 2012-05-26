From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 May 2012 09:48:19 +0100
Subject: [PATCH 6/6] serial: add amba-pl011-pci
In-Reply-To: <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
References: <cover.1337959750.git.rubini@gnudd.com>
 <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Message-ID: <20120526084819.GF24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One other point.

On Fri, May 25, 2012 at 05:48:57PM +0200, Alessandro Rubini wrote:
> +/* This is a template, copied every time a new pci device appears */
> +static AMBA_APB_DEVICE(pl011_pci_template, "pl011-pci", 0,
> +		       0 /* base */, {0} /* irqs */, NULL /* data */);

APB device.  It's a _peripheral_, it only has a _slave_ port which can't
initiate DMA, so:

> +	if (pdev->vendor == PCI_VENDOR_ID_STMICRO) {
> +		/* Under sta2x11, DMA is there but limited to 512M */
> +		adev->dma_mask = SZ_512M - 1;
> +		adev->dev.coherent_dma_mask = SZ_512M - 1;
> +	}

This is pointless and unnecessary.  The PL011 driver itself doesn't use
_this_ struct device for anything to do with DMA at all.  That's all
handled by the DMA engine's struct device.

That's true of all APB devices.  Only AHB devices with a master port can
initiate bus transactions, and hence cause accesses to other parts of the
system.
