From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 14 Oct 2018 10:16:56 +0200 (CEST)
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
In-Reply-To: <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
Message-ID: <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Oct 2018, Liran Alon wrote:
> > On 13 Oct 2018, at 17:53, lantianyu1986 at gmail.com wrote:
> > 
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > 
> > This patch is to add wrapper functions for tlb_remote_flush_with_range
> > callback.
> > 
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> > Change sicne V3:
> >       Remove code of updating "tlbs_dirty"
> > Change since V2:
> >       Fix comment in the kvm_flush_remote_tlbs_with_range()
> > ---
> > arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 40 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> > index c73d9f650de7..ff656d85903a 100644
> > --- a/arch/x86/kvm/mmu.c
> > +++ b/arch/x86/kvm/mmu.c
> > @@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
> > static union kvm_mmu_page_role
> > kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
> > 
> > +
> > +static inline bool kvm_available_flush_tlb_with_range(void)
> > +{
> > +	return kvm_x86_ops->tlb_remote_flush_with_range;
> > +}
> 
> Seems that kvm_available_flush_tlb_with_range() is not used in this patch?

What's wrong with that? 

It provides the implementation and later patches make use of it. It's a
sensible way to split patches into small, self contained entities.

Thanks,

	tglx
	
