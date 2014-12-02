From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 2 Dec 2014 15:33:05 +0100
Subject: [PATCH 1/5] arm/arm64: KVM: Correct KVM_ARM_VCPU_INIT power off
 option
In-Reply-To: <CAFEAcA_=2z+SkjTbU9NQkof-rVDS=fpG+XG4xEGVHkjoxrxrSg@mail.gmail.com>
References: <1417113660-23610-1-git-send-email-christoffer.dall@linaro.org>
 <1417113660-23610-2-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA_=2z+SkjTbU9NQkof-rVDS=fpG+XG4xEGVHkjoxrxrSg@mail.gmail.com>
Message-ID: <20141202143305.GG545@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 10:44:29PM +0000, Peter Maydell wrote:
> On 27 November 2014 at 18:40, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > The implementation of KVM_ARM_VCPU_INIT is currently not doing what
> > userspace expects, namely making sure that a vcpu which may have been
> > turned off using PSCI is returned to its initial state, which would be
> > powered on if userspace does not set the KVM_ARM_VCPU_POWER_OFF flag.
> >
> > Implment the expected functionality and clarify the ABI.
> 
> ("Implement", if you have to respin.)
> 
> > diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> > index 9e193c8..4dcc8c2 100644
> > --- a/arch/arm/kvm/arm.c
> > +++ b/arch/arm/kvm/arm.c
> > @@ -663,6 +663,8 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
> >          */
> >         if (__test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
> >                 vcpu->arch.pause = true;
> > +       else
> > +               vcpu->arch.pause = false;
> 
> Out of curiosity, why do we have to test-and-clear the bit rather than
> just testing it?
> 
No reason, I think we used to do this when we were always testing the
flag directly instead of through the pause flag.

I'll add a change of this.

-Christoffer
