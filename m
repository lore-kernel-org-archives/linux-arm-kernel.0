From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Sep 2015 17:51:02 +0100
Subject: [PATCH] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset macro
In-Reply-To: <20150902102454.GG25720@arm.com>
References: <1440915599-18485-1-git-send-email-yalin.wang2010@gmail.com>
 <20150902102454.GG25720@arm.com>
Message-ID: <20150904165102.GA25257@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 11:24:54AM +0100, Will Deacon wrote:
> On Sun, Aug 30, 2015 at 07:19:59AM +0100, yalin wang wrote:
> > This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
> > the default version doesn't work on arm64, because arm64 kernel address
> > is below the PAGE_OFFSET, like module address and vmemmap address are
> > all below PAGE_OFFSET address.
> > 
> > Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> > ---
> >  arch/arm64/include/asm/pgtable.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index d374191..ef1ed5c 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -660,6 +660,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
> >  
> >  #define update_mmu_cache_pmd(vma, address, pmd) do { } while (0)
> >  
> > +#define	kc_vaddr_to_offset(v) ((v) & ((1UL << VA_BITS) - 1))
> > +#define	kc_offset_to_vaddr(o) ((o) | ~((1UL << VA_BITS) - 1))
> 
> I think it would be cleaner to define something like VIRTUAL_BASE, and
> then define the vmalloc area in terms of that as well as these kcore
> macros.

The KASan patches were doing this, defining VA_START and defining
VMALLOC_START in terms of it. But they missed the merging window.

-- 
Catalin
