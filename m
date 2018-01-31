From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 31 Jan 2018 08:59:20 +0000
Subject: [PATCH 1/3] KVM: arm/arm64: Fix incorrect timer_is_pending logic
In-Reply-To: <20180130124206.12262-2-christoffer.dall@linaro.org>
References: <20180130124206.12262-1-christoffer.dall@linaro.org>
 <20180130124206.12262-2-christoffer.dall@linaro.org>
Message-ID: <7aec2a2b-874c-10cf-468b-62cf982f71e3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/01/18 12:42, Christoffer Dall wrote:
> After the recently introduced support for level-triggered mapped
> interrupt, I accidentally left the VCPU thread busily going back and
> forward between the guest and the hypervisor whenever the guest was
> blocking, because I would always incorrectly report that a timer
> interrupt was pending.
> 
> This is because the timer->irq.level field is not valid for mapped
> interrupts, where we offload the level state to the hardware, and as a
> result this field is always true.
> 
> Luckily the problem can be relatively easily solved by not checking the
> cached signal state of either timer in kvm_timer_should_fire() but
> instead compute the timer state on the fly, which we do already if the
> cached signal state wasn't high.  In fact, the only reason for checking
> the cached signal state was a tiny optimization which would only be
> potentially faster when the polling loop detects a pending timer
> interrupt, which is quite unlikely.
> 
> Instead of duplicating the logic from kvm_arch_timer_handler(), we
> enlighten kvm_timer_should_fire() to report something valid when the
> timer state is loaded onto the hardware.  We can then call this from
> kvm_arch_timer_handler() as well and avoid the call to
> __timer_snapshot_state() in kvm_arch_timer_get_input_level().
> 
> Reported-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
