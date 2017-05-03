From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 May 2017 15:12:21 +0100
Subject: [PATCH] arm64: Do not leave an invalid area->pages pointer in
 dma_common_contiguous_remap()
In-Reply-To: <9ae0fc6b-1da5-760b-9e92-f03bfcf77cd3@arm.com>
References: <1493144543-2497-1-git-send-email-catalin.marinas@arm.com>
 <9ae0fc6b-1da5-760b-9e92-f03bfcf77cd3@arm.com>
Message-ID: <20170503141221.GA23620@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 01:10:26PM +0100, Robin Murphy wrote:
> On 25/04/17 19:22, Catalin Marinas wrote:
> > The dma_common_pages_remap() function allocates a vm_struct object and
> > initialises the pages pointer to value passed as argument. However, when
> > this function is called dma_common_contiguous_remap(), the pages array
> > is only temporarily allocated, being freed shortly after
> > dma_common_contiguous_remap() returns. Architecture code checking the
> > validity of an area->pages pointer would incorrectly dereference already
> > freed pointers. This has been exposed by the arm64 commit 44176bb38fa4
> > ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU").
> > 
> > Fixes: 513510ddba96 ("common: dma-mapping: introduce common remapping functions")
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> > 
> > This is for correctness since once the arm64's mmap and get_sgtable ops
> > are fixed for DMA_ATTR_FORCE_CONTIGUOUS, we would no longer see the
> > issue. Anyway, it's better to get this fixed in case others trip over a
> > similar issue. I added a "Fixes" tag for completeness but I'm not sure
> > it's worth back-porting.
> > 
> >  drivers/base/dma-mapping.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> > index efd71cf4fdea..ab7071041141 100644
> > --- a/drivers/base/dma-mapping.c
> > +++ b/drivers/base/dma-mapping.c
> > @@ -277,8 +277,8 @@ EXPORT_SYMBOL(dma_common_mmap);
> >   * remaps an array of PAGE_SIZE pages into another vm_area
> >   * Cannot be used in non-sleeping contexts
> >   */
> 
> Nit: the above comment ends up in the wrong place now (it should still
> belong to dma_common_pages_remap()).

Good point, thanks. I'll send a v2 to Greg as we don't really have a
dependency on this on arm64 (once the DMA_ATTR_FORCE_CONTIGUOUS patch is
fixed or reverted).

-- 
Catalin
