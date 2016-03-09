From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Mar 2016 11:54:59 +0000
Subject: [PATCH] arm64: account for sparsemem section alignment when
 choosing vmemmap offset
In-Reply-To: <CAKv+Gu8nzi2pSyHdNVP9=kjSMNhGTEjuHYvvmOdomXKnuJ2n-w@mail.gmail.com>
References: <1457446169-23099-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160308151219.GD6192@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8nzi2pSyHdNVP9=kjSMNhGTEjuHYvvmOdomXKnuJ2n-w@mail.gmail.com>
Message-ID: <20160309115458.GL6192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 08:19:55AM +0700, Ard Biesheuvel wrote:
> On 8 March 2016 at 22:12, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Mar 08, 2016 at 09:09:29PM +0700, Ard Biesheuvel wrote:
> >> Commit dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear
> >> region") fixed an issue where the struct page array would overflow into the
> >> adjacent virtual memory region if system RAM was placed so high up in
> >> physical memory that its addresses were not representable in the build time
> >> configured virtual address size.
> >>
> >> However, the fix failed to take into account that the vmemmap region needs
> >> to be relatively aligned with respect to the sparsemem section size, so that
> >> a sequence of page structs corresponding with a sparsemem section in the
> >> linear region appears naturally aligned in the vmemmap region.
> >>
> >> So round up vmemmap to sparsemem section size. Since this essentially moves
> >> the projection of the linear region up in memory, also revert the reduction
> >> of the size of the vmemmap region.
> >>
> >> Fixes: dfd55ad85e4a ("arm64: vmemmap: use virtual projection of linear region")
> >> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/pgtable.h | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index f50608674580..819aff5d593f 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -40,7 +40,7 @@
> >>   * VMALLOC_END: extends to the available space below vmmemmap, PCI I/O space,
> >>   *   fixed mappings and modules
> >>   */
> >> -#define VMEMMAP_SIZE         ALIGN((1UL << (VA_BITS - PAGE_SHIFT - 1)) * sizeof(struct page), PUD_SIZE)
> >> +#define VMEMMAP_SIZE         ALIGN((1UL << (VA_BITS - PAGE_SHIFT)) * sizeof(struct page), PUD_SIZE)
> >
> > I think we could have extended the existing halved VMEMMAP_SIZE by
> > PAGES_PER_SECTION * sizeof(struct page) to cope with the alignment but I
> > don't think it's worth.
> 
> Indeed. But it is only temporary anyway, since the problem this patch
> solves does not exist anymore in for-next/core, considering that
> memstart_addr itself should be sufficiently aligned by construction.
> So I intend to propose a revert of this change, after -rc1 perhaps?

Sounds fine.

-- 
Catalin
