From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Jul 2014 15:13:35 +0100
Subject: [PATCHv4 3/5] common: dma-mapping: Introduce common remapping
 functions
In-Reply-To: <CAOesGMimCAYnqxkKoYpZ2ws7x9eH4K1Yw3LnLz9HC6MWyHEo3A@mail.gmail.com>
References: <1404324218-4743-1-git-send-email-lauraa@codeaurora.org>
 <1404324218-4743-4-git-send-email-lauraa@codeaurora.org>
 <CAOesGMimCAYnqxkKoYpZ2ws7x9eH4K1Yw3LnLz9HC6MWyHEo3A@mail.gmail.com>
Message-ID: <20140718141335.GC4608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 11:46:56PM +0100, Olof Johansson wrote:
> On Wed, Jul 2, 2014 at 11:03 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> > For architectures without coherent DMA, memory for DMA may
> > need to be remapped with coherent attributes. Factor out
> > the the remapping code from arm and put it in a
> > common location to reduced code duplication.
> >
> > Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> 
> Hm. The switch from ioremap to map_vm_area() here seems to imply that
> lib/ioremap can/should be reworked to use just wrap the vmalloc
> functions too?

ioremap_page_range() does not require the allocation of a map page array
and assumes that the mapped memory is physically contiguous. This would
be more efficient than the vmap() implementation which is generic enough
to allow non-contiguous memory allocations.

At some point, we'll have to support SMMU on arm64 and we can have 4
combinations of coherency and IOMMU. When an IOMMU is present, we don't
require physically contiguous memory but we may require non-cacheable
mappings, in which case vmap comes in handy.

-- 
Catalin
