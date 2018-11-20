From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 20 Nov 2018 14:19:12 +0000
Subject: [RFC PATCH v2 20/23] KVM: arm64: Add arch vm ioctl hook
In-Reply-To: <20181120105852.GJ3835@e113682-lin.lund.arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
 <1538141967-15375-21-git-send-email-Dave.Martin@arm.com>
 <20181102083227.GU12057@e113682-lin.lund.arm.com>
 <20181115180421.GS3505@e103592.cambridge.arm.com>
 <20181120105852.GJ3835@e113682-lin.lund.arm.com>
Message-ID: <20181120141911.GA3505@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 11:58:52AM +0100, Christoffer Dall wrote:
> On Thu, Nov 15, 2018 at 06:04:22PM +0000, Dave Martin wrote:
> > On Fri, Nov 02, 2018 at 09:32:27AM +0100, Christoffer Dall wrote:
> > > On Fri, Sep 28, 2018 at 02:39:24PM +0100, Dave Martin wrote:
> > > > To enable arm64-specific vm ioctls to be added cleanly, this patch
> > > > adds a kvm_arm_arch_vm_ioctl() hook so that these don't pollute the
> > > > common code.
> > > 
> > > Hmmm, I don't really see the strenght of that argument, and have the
> > > same concern as before.  I'd like to avoid the additional indirection
> > > and instead just follow the existing pattern with a dummy implementation
> > > on the 32-bit side that returns an error.
> > 
> > So for this and the similar comment on patch 18, this was premature (or
> > at least, overzealous) factoring on my part.
> > 
> > I'm happy to merge this back together for arm and arm64 as you prefer.
> > 
> > Do we have a nice way of writing the arch check, e.g.
> > 
> > 	case KVM_ARM_SVE_CONFIG:
> > 		if (!IS_ENABLED(ARM64))
> > 			return -EINVAL;
> > 		else
> > 			return kvm_vcpu_sve_config(NULL, userp);
> > 
> > should work, but looks a bit strange.  Maybe I'm just being fussy.
> 
> I prefer just doing:
> 
> 	case KVM_ARM_SVE_CONFIG:
> 		return kvm_vcpu_sve_config(NULL, userp);
> 
> 
> And having this in arch/arm/include/asm/kvm_foo.h:
> 
> static inline int kvm_vcpu_sve_config(...)
> {
> 	return -EINVAL;
> }

Sure, I can do that if you prefer.  I was a little uneasy about
littering arm64 junk all over the arch/arm headers, but we already have
precedent for this and it keeps the call sites clean.

Cheers
---Dave
