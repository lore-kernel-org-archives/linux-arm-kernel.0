From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 2 Jul 2010 01:00:56 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C2D0FF1.6010206@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<1278012503.7738.17.camel@c-dwalke-linux.qualcomm.com>
	<20100701193850.GB3594@basil.fritz.box>
	<4C2D0FF1.6010206@codeaurora.org>
Message-ID: <20100701230056.GD3594@basil.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The VCMM provides a more abstract, global view with finer-grained
> control of each mapping a user wants to create. For instance, the
> symantics of iommu_map preclude its use in setting up just the IOMMU
> side of a mapping. With a one-sided map, two IOMMU devices can be

Hmm? dma_map_* does not change any CPU mappings. It only sets up
DMA mapping(s).

> Additionally, the current IOMMU interface does not allow users to
> associate one page table with multiple IOMMUs unless the user explicitly

That assumes that all the IOMMUs on the system support the same page table
format, right?

As I understand your approach would help if you have different
IOMMus with an different low level interface, which just 
happen to have the same pte format. Is that very likely?

I would assume if you have lots of copies of the same IOMMU
in the system then you could just use a single driver with multiple
instances that share some state for all of them.  That model
would fit in the current interfaces. There's no reason multiple
instances couldn't share the same allocation data structure.

And if you have lots of truly different IOMMUs then they likely
won't be able to share PTEs at the hardware level anyways, because
the formats are too different.

> The VCMM takes the long view. Its designed for a future in which the
> number of IOMMUs will go up and the ways in which these IOMMUs are
> composed will vary from system to system, and may vary at
> runtime. Already, there are ~20 different IOMMU map implementations in
> the kernel. Had the Linux kernel had the VCMM, many of those
> implementations could have leveraged the mapping and topology management
> of a VCMM, while focusing on a few key hardware specific functions (map
> this physical address, program the page table base register).

The standard Linux approach to such a problem is to write
a library that drivers can use for common functionality, not put a middle 
layer inbetween. Libraries are much more flexible than layers.

That said I'm not sure there's all that much duplicated code anyways.
A lot of the code is always IOMMU specific. The only piece
which might be shareable is the mapping allocation, but I don't
think that's very much of a typical driver

In my old pci-gart driver the allocation was all only a few lines of code, 
although given it was somewhat dumb in this regard because it only managed a 
small remapping window.

-Andi 
-- 
ak at linux.intel.com -- Speaking for myself only.
