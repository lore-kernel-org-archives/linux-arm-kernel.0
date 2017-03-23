From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 12:10:17 +0000
Subject: [RFC PATCH v2 28/41] arm64: KVM: Treat SVE use by guests as
 undefined instruction execution
In-Reply-To: <20170322170658.GF19950@leverpostej>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
 <1490194274-30569-29-git-send-email-Dave.Martin@arm.com>
 <20170322170658.GF19950@leverpostej>
Message-ID: <20170323121016.GG3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 05:06:58PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Mar 22, 2017 at 02:50:58PM +0000, Dave Martin wrote:
> > We don't currently support context-switching of Scalable Vector
> > Extension context between vcpus, and the SVE access exception is
> > thus left masked by default at EL2 when running a vcpu.
> > 
> > However, there's nothing to stop a guest trying to use SVE.  If it
> > does, we'll get an SVE access exception to EL2 which will cause KVM
> > to panic since this exception isn't yet recognised.
> > 
> > This patch adds knowledge to KVM about the SVE access exception,
> > translating it into an undefined instruction exception injected to
> > the vcpu.
> > 
> > This prevents a malicious guest from panicking the host by
> > attempted SVE use.
> > 
> > SVE-enabled guests will still not work properly for now, but they
> > won't take the host down.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kvm/handle_exit.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> As a heads-up, this is handled implicitly by kvm_handle_unknown_ec()
> since commit ba4dd156eabdca93 ("arm64: KVM: Survive unknown traps from
> guests"). That also logs a (ratelimited) warning regarding the
> unimplemented trap handling.
> 
> Given that, I think we can drop this patch until actual support lands.

Agreed.

I wasn't sure that we wanted the verbose printks for this case, but since guests using SVE are currently broken it's better to have it.

I'll drop this pending proper KVM support.

Cheers
---Dave

> 
> Thanks,
> Mark.
> 
> > 
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index fa1b18e..e43b147 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -146,6 +146,13 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >  	return 1;
> >  }
> >  
> > +static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
> > +{
> > +	/* Until SVE is supported for guests: */
> > +	kvm_inject_undefined(vcpu);
> > +	return 1;
> > +}
> > +
> >  static exit_handle_fn arm_exit_handlers[] = {
> >  	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
> >  	[ESR_ELx_EC_WFx]	= kvm_handle_wfx,
> > @@ -159,6 +166,7 @@ static exit_handle_fn arm_exit_handlers[] = {
> >  	[ESR_ELx_EC_HVC64]	= handle_hvc,
> >  	[ESR_ELx_EC_SMC64]	= handle_smc,
> >  	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
> > +	[ESR_ELx_EC_SVE]	= handle_sve,
> >  	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
> >  	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
> >  	[ESR_ELx_EC_SOFTSTP_LOW]= kvm_handle_guest_debug,
> > -- 
> > 2.1.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
