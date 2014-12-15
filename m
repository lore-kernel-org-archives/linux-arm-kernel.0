From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 15 Dec 2014 11:43:37 +0100
Subject: [PATCH 5/5] arm/arm64: KVM: Initialize the vgic on-demand when
 injecting IRQs
In-Reply-To: <20141212110603.GI28388@cbox>
References: <1418139844-27892-1-git-send-email-christoffer.dall@linaro.org>
 <1418139844-27892-6-git-send-email-christoffer.dall@linaro.org>
 <5488407E.50506@linaro.org> <20141211120158.GG28388@cbox>
 <54899038.3050609@linaro.org> <20141212110603.GI28388@cbox>
Message-ID: <548EBB59.2060700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2014 12:06 PM, Christoffer Dall wrote:
> On Thu, Dec 11, 2014 at 01:38:16PM +0100, Eric Auger wrote:
>> On 12/11/2014 01:01 PM, Christoffer Dall wrote:
>>> On Wed, Dec 10, 2014 at 01:45:50PM +0100, Eric Auger wrote:
>>>> On 12/09/2014 04:44 PM, Christoffer Dall wrote:
>>>>> Userspace assumes that it can wire up IRQ injections after having
>>>>> created all VCPUs and after having created the VGIC, but potentially
>>>>> before starting the first VCPU.  This can currently lead to lost IRQs
>>>>> because the state of that IRQ injection is not stored anywhere and we
>>>>> don't return an error to userspace.
>>>>>
>>>>> We haven't seen this problem manifest itself yet, 
>>>> Actually we did with VFIO signaling setup before VGIC init!
>>>> presumably because
>>>
>>> well, not with code in mainline
>>>
>>>>> guests reset the devices on boot, but this could cause issues with
>>>>> migration and other non-standard startup configurations.
>>>>>
>>>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>>>> ---
>>>>>  virt/kvm/arm/vgic.c | 9 +++++++--
>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
>>>>> index c98cc6b..feef015 100644
>>>>> --- a/virt/kvm/arm/vgic.c
>>>>> +++ b/virt/kvm/arm/vgic.c
>>>>> @@ -1693,8 +1693,13 @@ out:
>>>>>  int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
>>>>>  			bool level)
>>>>>  {
>>>>> -	if (likely(vgic_ready(kvm)) &&
>>>>> -	    vgic_update_irq_pending(kvm, cpuid, irq_num, level))
>>>>> +	if (unlikely(!vgic_initialized(kvm))) {
>>>>> +		mutex_lock(&kvm->lock);
>>>>> +		vgic_init(kvm);
>>>>> +		mutex_unlock(&kvm->lock);
>>>>> +	}
>>>> I was previously encouraged to test the virtual interrupt controller
>>>> readiness when setting irqfd up(proposal made in
>>>> https://lkml.org/lkml/2014/12/3/601). I guess this becomes useless now,
>>>> correct? Reviewed-by on the whole series.
>>>>
>>> I think we should move to your userspace explicit init for all
>>> non-legacy userspace and only support gicv3 and vfio/irqfd stuff with
>>> userspace explicitly initializing the vgic.
>>
>> Hi Christoffer,
>>
>> The use case I have in mind still is VFIO+irqfd:
>> since we cannot preclude the user from ignoring the userspace explicit
>> init and setting up VFIO signaling+irqfd before vgic init, to me there
>> is a risk injection starts even before creation. Either we test
>> irqchip_in_kernel in kvm_vgic_inject_irq or we must have a test when
>> setting up irqfd as proposed in above patch.
> 
> yes, test if the vgic has been initialized when setting up irqfd and
> return an error if not.
> 
>>
>> Actually before being able to inject any virtual IRQ we weed even more:
>> if virtual IRQ settings were not yet defined by the guest we do not know
>> what to do with the IRQ. We must a least know whether it is level or
>> edge. Current irq_cfg bitmap might be insufficient to store the info
>> since it only has 2 states and by chance I use a level-sensitive IRQ and
>> my QEMU pieces pay attention to that sequencing. I guess the problem is
>> the same for user-space injection, isn't it?
>>
> that's no different from on the hardware is it?  We assume the interrupt
> is what it is (as per its default reset value in GICD_ICFGRn) and when
> the guest boots up, it must reconfigure the interrupt.
> 
> The higher level picture here is that we don't know when the guest is
> done configuring things, from some time before we run any vcpu to some
> time after we've run vcpus, and there is no error return path on
> injecting the IRQ to the VGIC for this sort of matter, so we just have
> to cope with things in the same way that hardware does.
> 
> My guess is that no sane guests will actually depend on these interrupts
> being raised/lowered before configuring the GIC will have any real
> effect, as all guests should configure the gic, clear that interrupt,
> unmask it, and only then care about things.

Hi Christoffer,

makes sense to me too, after reading the spec once more ;-)

Best Regards

Eric
> 
> -Christoffer
> 
