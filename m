From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 11 Dec 2017 16:18:18 +0100
Subject: [PATCH v3 11/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
In-Reply-To: <20171211133943.236f18be.cohuck@redhat.com>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-12-cdall@kernel.org>
 <20171211133943.236f18be.cohuck@redhat.com>
Message-ID: <20171211151818.GI910@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 01:39:43PM +0100, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 21:35:33 +0100
> Christoffer Dall <cdall@kernel.org> wrote:
> 
> > From: Christoffer Dall <christoffer.dall@linaro.org>
> > 
> > Move vcpu_load() and vcpu_put() into the architecture specific
> > implementations of kvm_arch_vcpu_ioctl_set_guest_debug().
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm64/kvm/guest.c    | 15 ++++++++++++---
> >  arch/powerpc/kvm/book3s.c |  2 ++
> >  arch/powerpc/kvm/booke.c  | 19 +++++++++++++------
> >  arch/s390/kvm/kvm-s390.c  | 16 ++++++++++++----
> >  arch/x86/kvm/x86.c        |  4 +++-
> >  virt/kvm/kvm_main.c       |  2 --
> >  6 files changed, 42 insertions(+), 16 deletions(-)
> > 
> 
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 1b491b89cd43..7cb0e2677e60 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -2018,12 +2018,15 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  {
> >  	struct debug_reg *dbg_reg;
> >  	int n, b = 0, w = 0;
> > +	int ret = 0;
> > +
> > +	vcpu_load(vcpu);
> >  
> >  	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
> >  		vcpu->arch.dbg_reg.dbcr0 = 0;
> >  		vcpu->guest_debug = 0;
> >  		kvm_guest_protect_msr(vcpu, MSR_DE, false);
> > -		return 0;
> > +		goto out;
> >  	}
> >  
> >  	kvm_guest_protect_msr(vcpu, MSR_DE, true);
> > @@ -2055,8 +2058,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  #endif
> >  
> >  	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
> > -		return 0;
> > +		goto out;
> >  
> > +	ret = -EINVAL;
> >  	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
> >  		uint64_t addr = dbg->arch.bp[n].addr;
> >  		uint32_t type = dbg->arch.bp[n].type;
> > @@ -2067,21 +2071,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
> >  		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
> >  			     KVMPPC_DEBUG_WATCH_WRITE |
> >  			     KVMPPC_DEBUG_BREAKPOINT))
> > -			return -EINVAL;
> > +			goto out;
> >  
> >  		if (type & KVMPPC_DEBUG_BREAKPOINT) {
> >  			/* Setting H/W breakpoint */
> >  			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
> > -				return -EINVAL;
> > +				goto out;
> >  		} else {
> >  			/* Setting H/W watchpoint */
> >  			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
> >  							type, w++))
> > -				return -EINVAL;
> > +				goto out;
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	ret = 0;
> 
> I would probably set the -EINVAL in the individual branches (so it is
> clear that something is wrong, and it is not just a benign exit as in
> the cases above), but your code is correct as well.

I think that's better as well actually.  I got probably got a little
used to that pattern after looking the main dispatcher function for a
while.  I'm happy to change it.

> > +out:
> > +	vcpu_put(vcpu);
> > +	return ret;
> >  }
> >  
> >  void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> 
> In any case,
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!
-Christoffer
