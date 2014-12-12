From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 11:23:35 +0000
Subject: [PATCH 5/5] arm/arm64: KVM: Initialize the vgic on-demand when
 injecting IRQs
In-Reply-To: <20141212111411.GJ28388@cbox>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-6-git-send-email-christoffer.dall@linaro.org>
 <5489E3FC.2000304@arm.com> <20141212111411.GJ28388@cbox>
Message-ID: <548AD037.4060000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/14 11:14, Christoffer Dall wrote:
> On Thu, Dec 11, 2014 at 06:35:40PM +0000, Marc Zyngier wrote:
>> On 09/12/14 15:44, Christoffer Dall wrote:
>>> Userspace assumes that it can wire up IRQ injections after having
>>> created all VCPUs and after having created the VGIC, but potentially
>>> before starting the first VCPU.  This can currently lead to lost IRQs
>>> because the state of that IRQ injection is not stored anywhere and we
>>> don't return an error to userspace.
>>>
>>> We haven't seen this problem manifest itself yet, presumably because
>>> guests reset the devices on boot, but this could cause issues with
>>> migration and other non-standard startup configurations.
>>>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>> ---
>>>  virt/kvm/arm/vgic.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>> index c98cc6b..feef015 100644
>>> --- a/virt/kvm/arm/vgic.c
>>> +++ b/virt/kvm/arm/vgic.c
>>> @@ -1693,8 +1693,13 @@ out:
>>>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>>  			bool level)
>>>  {
>>> -	if (likely(vgic_ready(kvm)) &&
>>> -	    vgic_update_irq_pending(kvm, cpuid, irq_num, level))
>>> +	if (unlikely(!vgic_initialized(kvm))) {
>>> +		mutex_lock(&kvm->lock);
>>> +		vgic_init(kvm);
>>
>> What if this fails?
>>
> yeah, not good.  The thing is that we also don't check the return value
> from kvm_vgic_inject_irq(), so we can do two things:
> 
> (1) change this function to a void, carry out the check for
> vgic_initialized in kvm_vm_ioctl_irq_line() in arm.c and export
> vgic_init() outside of vgic.c.
> 
> (2) just error out if vgic_init() fails and print a kernel error (or
> even a BUG_ON?) in kvm_timer_inject_irq() in arch_timer.c.
> 
> In both cases we need to make sure that we never configure the timer to
> begin injecting IRQs before the vgic is initialized, as Eric pointed out
> before.
> 
> What do you think?

I'd favour option two.

My reasoning is that the timer interrupt is triggered by the HW. If it
has fired, that's because we've programmed it to trigger, with means a
vcpu has run. At that point, the vgic would better be initialized, or we
have something much nastier on our hands.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny...
