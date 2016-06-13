From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jun 2016 16:30:03 +0100
Subject: [PATCH 4/5] arm/arm64: KVM: Map the HYP text as read-only
In-Reply-To: <575ECE49.3070209@arm.com>
References: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
 <1465826449-14349-5-git-send-email-marc.zyngier@arm.com>
 <20160613150251.GB29783@leverpostej> <575ECE49.3070209@arm.com>
Message-ID: <20160613153003.GD29783@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:16:25PM +0100, Marc Zyngier wrote:
> On 13/06/16 16:02, Mark Rutland wrote:
> > On Mon, Jun 13, 2016 at 03:00:48PM +0100, Marc Zyngier wrote:
> >> There should be no reason for mapping the HYP text read/write.
> >>
> >> As such, let's have a new set of flags (PAGE_HYP_EXEC) that allows
> >> execution, but makes the page as read-only, and update the two call
> >> sites that deal with mapping code.
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm/include/asm/pgtable.h        | 1 +
> >>  arch/arm/kvm/arm.c                    | 2 +-
> >>  arch/arm/kvm/mmu.c                    | 2 +-
> >>  arch/arm64/include/asm/pgtable-prot.h | 1 +
> >>  4 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> >> index f332087..7487bf9 100644
> >> --- a/arch/arm/include/asm/pgtable.h
> >> +++ b/arch/arm/include/asm/pgtable.h
> >> @@ -98,6 +98,7 @@ extern pgprot_t		pgprot_s2_device;
> >>  #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
> >>  #define PAGE_KERNEL_EXEC	pgprot_kernel
> >>  #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
> >> +#define PAGE_HYP_EXEC		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY)
> >>  #define PAGE_HYP_RO		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY | L_PTE_XN)
> >>  #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
> >>  #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index 0b5099f..d7bf2dd 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -1285,7 +1285,7 @@ static int init_hyp_mode(void)
> >>  	 * Map the Hyp-code called directly from the host
> >>  	 */
> >>  	err = create_hyp_mappings(kvm_ksym_ref(__hyp_text_start),
> >> -				  kvm_ksym_ref(__hyp_text_end), PAGE_HYP);
> >> +				  kvm_ksym_ref(__hyp_text_end), PAGE_HYP_EXEC);
> > 
> > As far as I can tell, __hyp_text_{start,end} aren't guaranteed to be
> > page-aligned. Are we certain that we'll never share a page with
> > something that we'll subsequently want to map non-executable?
> 
> The HYP text sits firmly in the middle of the rest of the text, so I'm
> not too worried. We could force some additional alignment just in case
> we end-up moving things around, but I don't see it as a problem we can
> have today.

Sure, jsut though I should check.

Given that, FWIW, for the series:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
