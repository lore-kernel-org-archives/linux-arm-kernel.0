From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 21 Aug 2012 14:59:45 +0200
Subject: [PATCHv6 2/2] ARM: dma-mapping: remove custom consistent dma
 region
In-Reply-To: <20120821123451.GV18957@n2100.arm.linux.org.uk>
References: <1343636899-19508-3-git-send-email-m.szyprowski@samsung.com><20120821142235.97984abc9ad98d01015a3338@nvidia.com><20120821123451.GV18957@n2100.arm.linux.org.uk>
Message-ID: <20120821.155945.1711711797763144039.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote @ Tue, 21 Aug 2012 14:34:51 +0200:

> On Tue, Aug 21, 2012 at 02:22:35PM +0300, Hiroshi Doyu wrote:
> > The following "__get_vm_area_node()" can take gfp_mask, it means that
> > this function is expected to be called from atomic context, but why
> > it's _NOT_ allowed _ONLY_ from interrupt context?
> 
> One reason is it takes read/write locks without using the IRQ safe
> versions for starters (vmap_area_lock and vmlist_lock).  I don't see
> any other reasons in that bit of code though.

IIRC, if *_{irqsave,irqrestore} versions were introduced to protect
from IRQ context, could we remove this BUG_ON(in_interrupt()) in
__get_vm_area_node() at least? Or is it not encouraged from
performance POV?

It seems that the solution to allow IOMMU'able device driver to
allocate from ISR are:
(1) To provide the pre-allocate area like arm_dma_alloc() does,
or
(2) __get_vm_area_node() can be called from ISR.
