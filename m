From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 19 Sep 2013 20:20:08 +0100
Subject: [PATCH v3 1/4] ARM: KVM: Implement kvm_vcpu_preferred_target()
 function
In-Reply-To: <523B09EA.9050408@arm.com>
References: <1379596302-21522-1-git-send-email-anup.patel@linaro.org>
 <1379596302-21522-2-git-send-email-anup.patel@linaro.org>
 <523B09EA.9050408@arm.com>
Message-ID: <20130919192008.GL7623@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 03:27:54PM +0100, Marc Zyngier wrote:
> On 19/09/13 14:11, Anup Patel wrote:
> > This patch implements kvm_vcpu_preferred_target() function for
> > KVM ARM which will help us implement KVM_ARM_PREFERRED_TARGET ioctl
> > for user space.
> > 
> > Signed-off-by: Anup Patel <anup.patel@linaro.org>
> > Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> > ---
> >  arch/arm/kvm/guest.c              |   20 ++++++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h |    1 +
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
> > index 152d036..b407e6c 100644
> > --- a/arch/arm/kvm/guest.c
> > +++ b/arch/arm/kvm/guest.c
> > @@ -222,6 +222,26 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
> >  	return kvm_reset_vcpu(vcpu);
> >  }
> >  
> > +int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
> > +{
> > +	int target = kvm_target_cpu();
> > +
> > +	if (target < 0)
> > +		return -ENODEV;
> > +
> > +	memset(init, 0, sizeof(*init));
> > +
> > +	/* 
> > +	 * For now, we return all optional features are available
> > +	 * for preferred target. In future, we might have features
> > +	 * available based on underlying host.
> > +	 */
> > +	init->target = (__u32)target;
> > +	init->features[0] |= (1 << KVM_ARM_VCPU_POWER_OFF);
> 
> I'm in two minds about this feature reporting. I see they serve a
> purpose, but they also duplicate capabilities, which is the standard way
> to advertise what KVM can do.
> 
> It means we end up having to sync two reporting mechanism, and I feel
> this is in general a bad idea.
> 
> Furthermore, KVM_ARM_VCPU_POWER_OFF is hardly a feature of the HW, but
> rather a firmware emulation thing.
> 
> Peter, Christoffer: Thoughts?
> 
I wanted to return the full kvm_vcpu_init instead of just a target int,
so we did not have to come up with yet another ioctl if we need to
return more information about the capabilities of the host CPU in the
future.

But perhaps we can formulate the API, to say only the (currently empty)
following list of features can only be enabled if the corresponding bit
is enabled, or something along those lines.

-Christoffer
