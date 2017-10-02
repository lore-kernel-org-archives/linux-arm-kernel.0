From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Oct 2017 11:21:29 -0600
Subject: [PATCH v2] nvme-pci: Use PCI bus address for data/queues in CMB
In-Reply-To: <20171001074203.GA11115@lst.de>
References: <1506763722-10687-1-git-send-email-abhishek.shah@broadcom.com>
 <20171001074203.GA11115@lst.de>
Message-ID: <20171002172128.GV8463@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 01, 2017 at 09:42:03AM +0200, Christoph Hellwig wrote:
> This looks very convoluted, mostly because the existing code is
> doing weird things.  For one thing what is sq_dma_addr currently
> is not a DMA adddress - we either need the resource address
> for the ioremap, but we don't need to stash that away, and second
> the one programmed into the controller should be a pci_bus_addr_t.
> 
> Second we already have a nice PCI-layer helper called pci_bus_address
> to get the bus address for us and we should use it.
> 
> Something like the patch below should solve the issue:

Yah, calling this a DMA address was a misnomer and confusing.

> ---
> From b78f4164881125c4fecfdb87878d0120b2177c53 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Sun, 1 Oct 2017 09:37:35 +0200
> Subject: nvme-pci: Use PCI bus address for data/queues in CMB
> 
> Currently, NVMe PCI host driver is programming CMB dma address as
> I/O SQs addresses. This results in failures on systems where 1:1
> outbound mapping is not used (example Broadcom iProc SOCs) because
> CMB BAR will be progammed with PCI bus address but NVMe PCI EP will
> try to access CMB using dma address.
> 
> To have CMB working on systems without 1:1 outbound mapping, we
> program PCI bus address for I/O SQs instead of dma address. This
> approach will work on systems with/without 1:1 outbound mapping.
> 
> Based on a report and previous patch from Abhishek Shah.
> 
> Fixes: 8ffaadf7 ("NVMe: Use CMB for the IO SQes if available")
> Cc: stable at vger.kernel.org
> Reported-by: Abhishek Shah <abhishek.shah@broadcom.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
