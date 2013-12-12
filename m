From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Dec 2013 12:09:58 -0800
Subject: [PATCH] arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
In-Reply-To: <52A98074.9080103@arm.com>
References: <1384973499-30659-1-git-send-email-christoffer.dall@linaro.org>
 <20131211205315.GH2871@cbox> <52A98074.9080103@arm.com>
Message-ID: <20131212200958.GR2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:23:00AM +0000, Marc Zyngier wrote:
> Hi Christoffer,
> 
> On 11/12/13 20:53, Christoffer Dall wrote:
> > On Wed, Nov 20, 2013 at 10:51:39AM -0800, Christoffer Dall wrote:
> >> The current KVM implementation of PSCI returns INVALID_PARAMETERS if the
> >> waitqueue for the corresponding CPU is not active.  This does not seem
> >> correct, since KVM should not care what the specific thread is doing,
> >> for example, user space may not have called KVM_RUN on this VCPU yet or
> >> the thread may be busy looping to user space because it received a
> >> signal; this is really up to the user space implementation.  We should
> >> simply clear the pause flag on the CPU and wake up the thread if it
> >> happens to be blocked for us.
> 
> Coming back to the PSCI spec (v0.2), it is clearly said that an error
> should be returned if the CPU is already ON (the error code is
> different, as KVM only implements v0.1 so far, but still...).
> 

ok, so we should check if the pause flag is set and report and error if
it's not, but not check the waitqueue.

> >> Further, the implementation seems to be racy when executing multiple
> >> VCPU threads.  There really isn't a reasonable user space programming
> >> scheme to ensure all secondary CPUs have reached kvm_vcpu_first_run_init
> >> before turning on the boot CPU.
> 
> Agreed.
> 
> >> It also does not make much sense to
> >> call into the PSCI code for a CPU that is turned off - after all, it
> >> cannot do anything if it is turned off and PSCI code could reasonably be
> >> written with the assumption that the VCPU is actually up, in some shape
> >> or form.
> 
> I find this to be debatable. While I agree with you that doing a CPU_OFF
> on something that has never ran is not the most gracious thing ever, it
> helps (or helped) keeping the code relatively monimal, and without too
> many actors messing with the pause flag.
> 

It's certainly debatable.  I personally found that it was hiding
information that you had to look at anyhow to understand how things
worked, and that it wasn't really beneficial, but I may have been a
little over zealous about my general statement about calling into PSCI
code.

> >> Therefore, set the pause flag on the vcpu at VCPU init time (which can
> >> reasonably be expected to be completed for all CPUs by user space before
> >> running any VCPUs) and clear both this flag and the feature (in case the
> >> feature can somehow get set again in the future) and ping the waitqueue
> >> on turning on a VCPU using PSCI.
> 
> Fair enough. See my comments below:
> 
> >>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >> ---
> >>  arch/arm/kvm/arm.c  | 30 +++++++++++++++++++-----------
> >>  arch/arm/kvm/psci.c |  6 ++----
> >>  2 files changed, 21 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> >> index e312e4a..1140e0e 100644
> >> --- a/arch/arm/kvm/arm.c
> >> +++ b/arch/arm/kvm/arm.c
> >> @@ -478,15 +478,6 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
> >>  			return ret;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Handle the "start in power-off" case by calling into the
> >> -	 * PSCI code.
> >> -	 */
> >> -	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features)) {
> >> -		*vcpu_reg(vcpu, 0) = KVM_PSCI_FN_CPU_OFF;
> >> -		kvm_psci_call(vcpu);
> >> -	}
> >> -
> >>  	return 0;
> >>  }
> >>  
> >> @@ -700,6 +691,24 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
> >>  	return -EINVAL;
> >>  }
> >>  
> >> +static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
> >> +					 struct kvm_vcpu_init *init)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = kvm_vcpu_set_target(vcpu, init);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * Handle the "start in power-off" case by marking the VCPU as paused.
> >> +	 */
> >> +	if (test_and_clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features))
> >> +		vcpu->arch.pause = true;
> 
> Do we really need a test_and_clear? I know the original code used it,
> but I now fail to see a reason why.
> 

You mean why the atomic version?  I think it reads nicely, we need to
test a bit and we need to clear it, but we can use __test_and_clear_bit
instead if you prefer.

> >> +	return 0;
> >> +}
> >> +
> >>  long kvm_arch_vcpu_ioctl(struct file *filp,
> >>  			 unsigned int ioctl, unsigned long arg)
> >>  {
> >> @@ -713,8 +722,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> >>  		if (copy_from_user(&init, argp, sizeof(init)))
> >>  			return -EFAULT;
> >>  
> >> -		return kvm_vcpu_set_target(vcpu, &init);
> >> -
> >> +		return kvm_arch_vcpu_ioctl_vcpu_init(vcpu, &init);
> >>  	}
> >>  	case KVM_SET_ONE_REG:
> >>  	case KVM_GET_ONE_REG: {
> >> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
> >> index 0881bf1..2e72ef5 100644
> >> --- a/arch/arm/kvm/psci.c
> >> +++ b/arch/arm/kvm/psci.c
> >> @@ -59,10 +59,6 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
> >>  
> >>  	target_pc = *vcpu_reg(source_vcpu, 2);
> >>  
> >> -	wq = kvm_arch_vcpu_wq(vcpu);
> >> -	if (!waitqueue_active(wq))
> >> -		return KVM_PSCI_RET_INVAL;
> >> -
> 
> That I object to. Calling CPU_ON on a CPU that is already ON is an
> error, and should be reported as such.
> 

Good point, but that's not why I removed the check - see above.  The
check should be against the pause flag, not the state of the waitqueue.
I'll adjust the patch.

> >>  	kvm_reset_vcpu(vcpu);
> >>  
> >>  	/* Gracefully handle Thumb2 entry point */
> >> @@ -76,9 +72,11 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
> >>  		kvm_vcpu_set_be(vcpu);
> >>  
> >>  	*vcpu_pc(vcpu) = target_pc;
> >> +	clear_bit(KVM_ARM_VCPU_POWER_OFF, vcpu->arch.features);
> 
> Why do you clear that bit here? Given the above test_and_clear, it
> shouldn't be set anymore.
> 

No reason, it's unnecessary.  I'll remove it.

> >>  	vcpu->arch.pause = false;
> >>  	smp_mb();		/* Make sure the above is visible */
> >>  
> >> +	wq = kvm_arch_vcpu_wq(vcpu);
> >>  	wake_up_interruptible(wq);
> >>  
> >>  	return KVM_PSCI_RET_SUCCESS;
> >> -- 
> >> 1.8.4.3
> >>
> > 
> 
> Otherwise, I think this is a valuable cleanup.
> 

Thanks!
-- 
Christoffer
