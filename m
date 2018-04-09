From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 9 Apr 2018 11:57:19 +0100
Subject: [RFC PATCH v2 3/3] KVM: arm64: Optimise FPSIMD handling to
 reduce guest/host thrashing
In-Reply-To: <20180409094818.GB10904@cbox>
References: <1523026864-15413-1-git-send-email-Dave.Martin@arm.com>
 <1523026864-15413-4-git-send-email-Dave.Martin@arm.com>
 <20180409094818.GB10904@cbox>
Message-ID: <20180409105719.GV16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 11:48:18AM +0200, Christoffer Dall wrote:
> On Fri, Apr 06, 2018 at 04:01:04PM +0100, Dave Martin wrote:

[...]

> > diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> > index 8605e04..797b259 100644
> > --- a/arch/arm64/kvm/hyp/switch.c
> > +++ b/arch/arm64/kvm/hyp/switch.c
> > @@ -27,6 +27,7 @@
> >  #include <asm/kvm_mmu.h>
> >  #include <asm/fpsimd.h>
> >  #include <asm/debug-monitors.h>
> > +#include <asm/thread_info.h>
> >  
> >  static bool __hyp_text __fpsimd_enabled_nvhe(void)
> >  {
> > @@ -47,24 +48,40 @@ bool __hyp_text __fpsimd_enabled(void)
> >  	return __fpsimd_is_enabled()();
> >  }
> >  
> > -static void __hyp_text __activate_traps_vhe(void)
> > +static bool update_fp_enabled(struct kvm_vcpu *vcpu)
> > +{
> > +	if (vcpu->arch.host_thread_info->flags & _TIF_FOREIGN_FPSTATE) {
> > +		vcpu->arch.host_fpsimd_state = NULL;
> 
> I can't see where host_fpsimd_state gets set to anything else than NULL,
> what am I missing?

Ah, *now* I understand what was missing from this posting.

Please see RFC v3.

Cheers
---Dave
