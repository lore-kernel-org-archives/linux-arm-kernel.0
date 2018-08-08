From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 8 Aug 2018 09:23:35 +0100
Subject: [RFC PATCH 12/16] KVM: arm64/sve: Context switch the SVE registers
In-Reply-To: <20180807194338.GI5985@e113682-lin.lund.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-13-git-send-email-Dave.Martin@arm.com>
 <20180806131910.GC5985@e113682-lin.lund.arm.com>
 <20180807111526.GD9097@e103592.cambridge.arm.com>
 <20180807194338.GI5985@e113682-lin.lund.arm.com>
Message-ID: <20180808082333.GI9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 09:43:38PM +0200, Christoffer Dall wrote:
> On Tue, Aug 07, 2018 at 12:15:26PM +0100, Dave Martin wrote:
> > On Mon, Aug 06, 2018 at 03:19:10PM +0200, Christoffer Dall wrote:

[...]

> > > nit: this may also be folded nicely into a static bool
> > > __trap_fpsimd_sve_access() check.
> > 
> > It wouldn't hurt to make this look less fiddly, certainly.
> > 
> > Can you elaborate on precisely what you had in mind?
> 
> sure:
> 
> static bool __hyp_text __trap_is_fpsimd_sve_access(struct kvm_vcpu *vcpu)
> {
> 	/*
> 	 * Can we support SVE without FPSIMD? If not, this can be
> 	 * simplified by reversing the condition.
> 	 */
> 	if (system_supports_fpsimd() &&
> 	    kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_FP_ASIMD)
> 		return true;
> 
> 	if (guest_has_sve && kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_SVE)
> 		return true;
> 
> 	return false;
> }
> 
> 
> static bool __hyp_text fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
> {
> 	[...]
> 	if (__trap_is_fpsimd_sve_access(vcpu))
> 		return __hyp_switch_fpsimd(vcpu, guest_has_sve);
> 	[...]
> }
> 
> Of course not even compile-tested or anything like that.

Sure, I can do something along these line.  The conditions are indeed a
bit unwieldy today.

Cheers
---Dave
