From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 17 May 2017 12:10:16 -0500
Subject: [PATCH v6 1/3] of/pci/dma: fix DMA configuration for PCI masters
In-Reply-To: <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
References: <1494912127-12890-1-git-send-email-oza.oza@broadcom.com>
 <1494912127-12890-2-git-send-email-oza.oza@broadcom.com>
Message-ID: <20170517171016.GE31462@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 10:52:05AM +0530, Oza Pawandeep wrote:
> current device framework and OF framework integration assumes

s/current/The current/

> dma-ranges in a way where memory-mapped devices define their
> dma-ranges. (child-bus-address, parent-bus-address, length).
> 
> of_dma_configure is specifically written to take care of memory
> mapped devices. but no implementation exists for pci to take
> care of pcie based memory ranges.

s/pci/PCI/	(also other occurrences below)
s/pcie/PCIe/

I don't see how PCIe is relevant here.  The bridge might support PCIe,
but I don't think anything here is actually specific to PCIe.  If
that's the case, I think it's confusing to mention PCIe.

> for e.g. iproc based SOCs and other SOCs(suc as rcar) have PCI
> world dma-ranges.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> 
> this patch serves following:
> 
> 1) exposes interface to the pci host driver for their
> inbound memory ranges
> 
> 2) provide an interface to callers such as of_dma_get_ranges.
> so then the returned size get best possible (largest) dma_mask.
> because PCI RC drivers do not call APIs such as
> dma_set_coherent_mask() and hence rather it shows its addressing
> capabilities based on dma-ranges.
> for e.g.
> dma-ranges = <0x43000000 0x00 0x00 0x00 0x00 0x80 0x00>;
> we should get dev->coherent_dma_mask=0x7fffffffff.
> 
> 3) this patch handles multiple inbound windows and dma-ranges.
> it is left to the caller, how it wants to use them.
> the new function returns the resources in a standard and unform way
> 
> 4) this way the callers of for e.g. of_dma_get_ranges
> does not need to change.

Please start sentences with a capital letter.
