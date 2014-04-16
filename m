From: anderson@redhat.com (Dave Anderson)
Date: Wed, 16 Apr 2014 09:35:37 -0400 (EDT)
Subject: [PATCH] Fix for the arm64 kern_addr_valid() function
In-Reply-To: <20140416075144.GA29754@arm.com>
References: <1397584404-28762-1-git-send-email-anderson@redhat.com>
 <20140416075144.GA29754@arm.com>
Message-ID: <1875820807.8849885.1397655337137.JavaMail.zimbra@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



----- Original Message -----
> Hi Dave,
> 
> On Tue, Apr 15, 2014 at 06:53:24PM +0100, Dave Anderson wrote:
> >  Fix for the arm64 kern_addr_valid() function to recognize
> >  virtual addresses in the kernel logical memory map.  The
> >  function fails as written because it does not check whether
> >  the addresses in that region are mapped at the pmd level to
> >  2MB or 512MB pages, continues the page table walk to the
> >  pte level, and issues a garbage value to pfn_valid().
> > 
> >  Tested on 4K-page and 64K-page kernels.
> > 
> > Signed-off-by: Dave Anderson <anderson@redhat.com>
> > ---
> >  arch/arm64/mm/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 6b7e895..0a472c4 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -374,6 +374,9 @@ int kern_addr_valid(unsigned long addr)
> >  	if (pmd_none(*pmd))
> >  		return 0;
> >  
> > +	if (pmd_sect(*pmd))
> > +		return pfn_valid(pmd_pfn(*pmd));
> > +
> >  	pte = pte_offset_kernel(pmd, addr);
> >  	if (pte_none(*pte))
> >  		return 0;
> 
> Whilst this patch looks fine to me, I wonder whether walking the page tables
> is really necessary for this function? The only user is fs/proc/kcore.c,
> which basically wants to know if a lowmem address is actually backed by
> physical memory. Our current implementation of kern_addr_valid will return
> true even for MMIO mappings, whilst I think we could actually just do
> something like:
> 
> 
> 	if ((((long)addr) >> VA_BITS) != -1UL)
> 		return 0;
> 
> 	return pfn_valid(__pa(addr) >> PAGE_SHIFT);
> 
> 
> Am I missing something here?
> 
> Will

Nope -- that works presuming read_kcore() is the only consumer.  That's
probably a safe bet, and also considering that 95% of the other arches just
define it as "(1)".

On a related note, the arm64 /proc/kcore PT_LOAD segments are incorrect
for all but the kernel logical memory map region because the default
kc_vaddr_to_offset() macro is this:

 #define kc_vaddr_to_offset(v) ((v) - PAGE_OFFSET)

So a 4K-page header has bogus file "Offset" values for the vmalloc, modules
and vmemmap regions:

 Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   NOTE           0x0000000000000158 0x0000000000000000 0x0000000000000000
                  0x0000000000000c4c 0x0000000000000000         0
   LOAD           0xffffffc000001000 0xffffff8000000000 0x0000000000000000
                  0x0000003bffff0000 0x0000003bffff0000  RWE    1000
   LOAD           0xfffffffffc001000 0xffffffbffc000000 0x0000000000000000
                  0x0000000004000000 0x0000000004000000  RWE    1000
   LOAD           0x0000000000001000 0xffffffc000000000 0x0000000000000000
                  0x0000000400000000 0x0000000400000000  RWE    1000
   LOAD           0xfffffffce0001000 0xffffffbce0000000 0x0000000000000000
                  0x000000000e000000 0x000000000e000000  RWE    1000

And a 64K-page header looks like this:

 Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   NOTE           0x0000000000000158 0x0000000000000000 0x0000000000000000
                  0x0000000000000c4c 0x0000000000000000         0
   LOAD           0xfffffe0000010000 0xfffffc0000000000 0x0000000000000000
                  0x000001fbffff0000 0x000001fbffff0000  RWE    10000
   LOAD           0xfffffffffc010000 0xfffffdfffc000000 0x0000000000000000
                  0x0000000004000000 0x0000000004000000  RWE    10000
   LOAD           0x0000000000010000 0xfffffe0000000000 0x0000000000000000
                  0x0000000400000000 0x0000000400000000  RWE    10000
   LOAD           0xfffffffc0e010000 0xfffffdfc0e000000 0x0000000000000000
                  0x0000000000e00000 0x0000000000e00000  RWE    10000

I was testing kern_addr_valid() with the crash utility using /proc/kcore,
which works OK because every user/kernel/vmalloc/vmemmap virtual address read
request is first translated to a physical address, and then to a kernel logical
memory map address.  And luckily that region's PT_LOAD segment does have a
correct Offset value.   

Dave





 

 
