From: drjones@redhat.com (Andrew Jones)
Date: Thu, 9 Apr 2015 14:56:07 +0200
Subject: [PATCH v2 05/10] KVM: arm: introduce kvm_arch_setup/clear_debug()
In-Reply-To: <20150401182855.4650b14a@thinkpad-w530>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-6-git-send-email-alex.bennee@linaro.org>
 <20150401182855.4650b14a@thinkpad-w530>
Message-ID: <20150409125607.GD3212@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 06:28:55PM +0200, David Hildenbrand wrote:
> > This is a precursor for later patches which will need to do more to
> > setup debug state before entering the hyp.S switch code. The existing
> > functionality for setting mdcr_el2 has been moved out of hyp.S and now
> > uses the value kept in vcpu->arch.mdcr_el2.
> > 
> > This also moves the conditional setting of the TDA bit from the hyp code
> > into the C code.
> > 
> > Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> > 
> >  create mode 100644 arch/arm64/kvm/debug.c
> > 
> > diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> > index 41008cd..8c01c97 100644
> > --- a/arch/arm/include/asm/kvm_host.h
> > +++ b/arch/arm/include/asm/kvm_host.h
> > @@ -242,5 +242,7 @@ static inline void kvm_arch_hardware_unsetup(void) {}
> >  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
> >  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
> >  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
> > +static inline void kvm_arch_setup_debug(struct kvm_vcpu *vcpu) {}
> > +static inline void kvm_arch_clear_debug(struct kvm_vcpu *vcpu) {}
> 
> Do you really want to call these functions "kvm_arch.." although they are not
> defined for other arch and not triggered by common code?
>

Agreed. If other arches want something similar we can rename/refactor
later. If these are arm-only functions, then we don't need the generic
prefix, which is actually even a bit confusing.

drew 
