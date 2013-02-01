From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 31 Jan 2013 22:35:47 -0500 (EST)
Subject: [PATCH v4 02/13] ARM: LPAE: use phys_addr_t in
 alloc_init_pud()
In-Reply-To: <510B327E.3050502@gmail.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
 <1359669512-31276-3-git-send-email-cyril@ti.com> <510B327E.3050502@gmail.com>
Message-ID: <alpine.LFD.2.02.1301312218270.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Feb 2013, Hui Wang wrote:

> Cyril Chemparathy wrote:
> > From: Vitaly Andrianov <vitalya@ti.com>
> > 
> > This patch fixes the alloc_init_pud() function to use phys_addr_t instead of
> > unsigned long when passing in the phys argument.
> > 
> > This is an extension to commit 97092e0c56830457af0639f6bd904537a150ea4a
> > (ARM:
> > pgtable: use phys_addr_t for physical addresses), which applied similar
> > changes
> > elsewhere in the ARM memory management code.
> > 
> > Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> > Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm/mm/mmu.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 9f06102..ef43689 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -612,7 +612,8 @@ static void __init alloc_init_section(pud_t *pud,
> > unsigned long addr,
> >  }
> >   static void __init alloc_init_pud(pgd_t *pgd, unsigned long addr,
> > -	unsigned long end, unsigned long phys, const struct mem_type *type)
> > +				  unsigned long end, phys_addr_t phys,
> > +				  const struct mem_type *type)
> >   
> The change is correct but seems useless so far. This function only be called
> from map_lowmem and devicemaps_init, from i know neither lowmem nor device io
> registers of existing platforms exceed 32bit address.

It is not because you are not aware of any existing platforms with RAM 
or device IO above the 4GB mark that they don't exist.

For example, some LPAE systems have all their RAM located above the 4G 
physical address mark. A simple (potentially non DMA capable) alias 
exists in the low 32-bit address space to allow the system to boot and 
switch to the real physical RAM addresses once the MMU is turned on.  
Some of that RAM is still qualified as "low mem" i.e. the portion of RAM 
that the kernel keeps permanently mapped in the 32-bit virtual space 
even if all of it is above the 4G mark in physical space.


Nicolas
