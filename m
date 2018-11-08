From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 8 Nov 2018 19:14:22 +0000
Subject: [PATCH 1/4] KVM: arm64: Rework detection of SVE, !VHE systems
In-Reply-To: <20181106075251.GE12057@e113682-lin.lund.arm.com>
References: <20181105143617.120602-1-marc.zyngier@arm.com>
 <20181105143617.120602-2-marc.zyngier@arm.com>
 <20181106075251.GE12057@e113682-lin.lund.arm.com>
Message-ID: <20181108191421.GG3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 08:52:51AM +0100, Christoffer Dall wrote:
> On Mon, Nov 05, 2018 at 02:36:13PM +0000, Marc Zyngier wrote:
> > An SVE system is so far the only case where we mandate VHE. As we're
> > starting to grow this requirements, let's slightly rework the way we
> > deal with that situation, allowing for easy extension of this check.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/include/asm/kvm_host.h   |  2 +-
> >  arch/arm64/include/asm/kvm_host.h |  7 ++-----
> >  virt/kvm/arm/arm.c                | 12 +++++++-----
> >  3 files changed, 10 insertions(+), 11 deletions(-)
> > 

[...]

> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 52fbc823ff8c..ca1714148400 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -422,17 +422,14 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
> >  	}
> >  }
> >  
> > -static inline bool kvm_arch_check_sve_has_vhe(void)
> > +static inline bool kvm_arch_sve_requires_vhe(void)
> >  {
> >  	/*
> >  	 * The Arm architecture specifies that implementation of SVE
> >  	 * requires VHE also to be implemented.  The KVM code for arm64
> >  	 * relies on this when SVE is present:
> >  	 */
> > -	if (system_supports_sve())
> > -		return has_vhe();
> > -	else
> > -		return true;
> > +	return system_supports_sve();
> >  }
> 
> nit: Can we call this function 'kvm_arch_requires_vhe()' and let it test
> for all the cases (maybe that's coming in future patches though).  I
> just find this naming confusing.

Agreed.  I was never keen on my original name, and the logic was
somewhat backwards anyway.

"kvm_arch_requires_vhe()" is a reasonable name for a function that
returns true iff the kernel needs VHE as a consequence of some other
prior runtime decision.

> >  
> >  static inline void kvm_arch_hardware_unsetup(void) {}
> > diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> > index 23774970c9df..66de2efddfca 100644
> > --- a/virt/kvm/arm/arm.c
> > +++ b/virt/kvm/arm/arm.c
> > @@ -1640,9 +1640,13 @@ int kvm_arch_init(void *opaque)
> >  		return -ENODEV;
> >  	}
> >  
> > -	if (!kvm_arch_check_sve_has_vhe()) {
> > -		kvm_pr_unimpl("SVE system without VHE unsupported.  Broken cpu?");
> > -		return -ENODEV;
> > +	in_hyp_mode = is_kernel_in_hyp_mode();
> > +
> > +	if (!in_hyp_mode) {
> > +		if (kvm_arch_sve_requires_vhe()) {

Can we just have

	if (!in_hyp_mode && kvm_arch_requires_vhe()) {

That's less nesty but still readable (for me, at least).

Otherwise, Ack.


[...]

Cheers
---Dave
