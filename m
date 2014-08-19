From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 19 Aug 2014 16:37:52 +0200
Subject: [PATCH v4] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <53F35995.8010008@amd.com>
References: <20140811203823.2828.36074.stgit@joelaarch64.amd.com>
 <20140812160521.GO10550@cbox> <53F26282.5010103@amd.com>
 <20140819122236.GB31086@cbox> <53F35995.8010008@amd.com>
Message-ID: <20140819143752.GD31086@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:05:09AM -0500, Joel Schopp wrote:
> 
> On 08/19/2014 07:22 AM, Christoffer Dall wrote:
> > On Mon, Aug 18, 2014 at 03:30:58PM -0500, Joel Schopp wrote:
> >>  #endif /* __ARM_KVM_MMU_H__ */
> >> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> >> index 16e7994..70f0f02 100644
> >> --- a/arch/arm/kvm/mmu.c
> >> +++ b/arch/arm/kvm/mmu.c
> >> @@ -521,6 +521,7 @@ int create_hyp_io_mappings(void *from, void *to, phys_addr_t phys_addr)
> >>   */
> >>  int kvm_alloc_stage2_pgd(struct kvm *kvm)
> >>  {
> >> +	unsigned int s2_pgds, s2_pgd_order;
> >>  	pgd_t *pgd;
> >>  
> >>  	if (kvm->arch.pgd != NULL) {
> >> @@ -528,10 +529,18 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> -	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
> >> +	s2_pgds = (1 << (kvm_get_phys_addr_shift() - PGDIR_SHIFT));
> >> +	s2_pgd_order = get_order(s2_pgds * sizeof(pgd_t));
> >> +
> >> +	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, s2_pgd_order);
> >>  	if (!pgd)
> >>  		return -ENOMEM;
> >>  
> >> +	if ((unsigned long)pgd & ~vttbr_baddr_mask) {
> >> +		kvm_err("Stage-2 pgd not correctly aligned: %p\n", pgd);
> >> +		return -EFAULT;
> >> +	}
> >>
> >>
> >> There are two problems that I've found here.  The first problem is that
> >> vttbr_baddr_mask isn't allocated yet at this point in the code.
> > allocated? you mean assigned?
> > aren't you setting vttbr_baddr_mask in kvm_arch_init()?  that's
> > certainly called before kvm_arch_init_vm().
> Yes, I mean assigned, at least I got the first letter correct :)  All I
> know is that vttbr_baddr_mask was still zero and checking for zero and
> calling the set function gave it a value.

that sounds.... weird and wrong.  Hum.  Mind sticking a few prints in
there and figuring out what's causing this?

> >
> >
> >> The
> >> second problem is that pgd is a virtual address, ie pgd ==
> >> 0xfffffe03bbb40000 while the vttbr masks off the high bits for a
> >> physical address, ie vttbr_baddr_mask=0x00007ffffffe0000 .  Even
> >> correcting for those issues I haven't been able to make this check work
> >> properly.  I'll resend v5 the patch with all the other suggested changes.
> >>
> > What are the issues that you face?  Iow. what is the alignment of the
> > returned physical address?
> >
> > (You should be able to just to virt_to_phys(pgd) and use that to test
> > for the vttbr_baddr_mask).
> The addresses above are actually from my system, 64K page aligned on a
> 64K page kernel.  I did use virt_to_phys() and the kernel got a null
> dereference and paniced, I didn't trace down where the panic was occuring.
> 
virt_to_phys() directly caused the null dereference?  That sounds bad!

Would you mind trying to trace this down?  I'll be happy to provide as
much help as I can along the way.

-Christoffer
