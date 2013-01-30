From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 11:32:46 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130130113245.GH23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 07:56:28PM +0100, Thomas Petazzoni wrote:
> +static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
> +						 const struct resource *res,
> +						 resource_size_t start,
> +						 resource_size_t size,
> +						 resource_size_t align)
> +{
> +	if (!(res->flags & IORESOURCE_IO))
> +		return start;
> +
> +	/*
> +	 * The I/O regions must be 64K aligned, because the
> +	 * granularity of PCIe I/O address decoding windows is 64 K
> +	 */
> +	return round_up(start, SZ_64K);
> +}

You do realise that this will result in all PCI I/O BARs being rounded
up to 64K.

I've just been digging through the PCI code and have come across a
function - pcibios_window_alignment() - which the PCI code allows to be
overriden which allows you to increase the alignment requirement of
bridge windows.  It takes the PCI bus and window type as arguments.

I'd suggest using that, and checking whether the bus which is passed
corresponds with a bus which gives you problems, so that you don't
impose the 64K requirement on downstream bridges.
