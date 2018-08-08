From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 8 Aug 2018 09:33:00 +0100
Subject: [RFC PATCH 08/16] KVM: arm64: Support dynamically hideable
 system registers
In-Reply-To: <20180807192010.GG5985@e113682-lin.lund.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-9-git-send-email-Dave.Martin@arm.com>
 <20180807192010.GG5985@e113682-lin.lund.arm.com>
Message-ID: <20180808083300.GK9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 09:20:10PM +0200, Christoffer Dall wrote:

[...]

> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index a436373..31a351a 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1840,7 +1840,7 @@ static int emulate_cp(struct kvm_vcpu *vcpu,
> >  
> >  	r = find_reg(params, table, num);
> >  
> > -	if (r) {
> > +	if (likely(r) && sys_reg_present(vcpu, r)) {
> >  		perform_access(vcpu, params, r);
> >  		return 0;
> >  	}
> > @@ -2016,7 +2016,7 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
> >  	if (!r)
> >  		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
> >  
> > -	if (likely(r)) {
> > +	if (likely(r) && sys_reg_present(vcpu, r)) {
> >  		perform_access(vcpu, params, r);
> >  	} else {
> >  		kvm_err("Unsupported guest sys_reg access at: %lx\n",
> 
> This looks a bit fishy, because it seems that now a guest can be
> configured in such a way that it can access non-present emulated system
> registers and get the host to tell the operator that the KVM instance
> running on the system doesn't really support the hardware...

Hmmm, looks like I just blindly adapted the if () condition without
looking at the context here.

I'll take a look at it.

[...]

Cheers
---Dave
