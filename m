From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Nov 2012 17:11:14 +0000
Subject: [PATCH v4 3/5] ARM: KVM: arch_timers: Add guest timer core support
In-Reply-To: <20121123170036.GN32200@mudshark.cambridge.arm.com>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154618.3274.53380.stgit@chazy-air>
 <20121123161759.GK32200@mudshark.cambridge.arm.com>
 <50AFA9BC.1010105@arm.com>
 <20121123170036.GN32200@mudshark.cambridge.arm.com>
Message-ID: <50AFAE32.2040603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/11/12 17:00, Will Deacon wrote:
> On Fri, Nov 23, 2012 at 04:52:12PM +0000, Marc Zyngier wrote:
>> On 23/11/12 16:17, Will Deacon wrote:
>>>> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
>>>> index b80256b..7463f5b 100644
>>>> --- a/arch/arm/kvm/reset.c
>>>> +++ b/arch/arm/kvm/reset.c
>>>> @@ -37,6 +37,12 @@ static struct kvm_regs a15_regs_reset = {
>>>>         .usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
>>>>  };
>>>>
>>>> +#ifdef CONFIG_KVM_ARM_TIMER
>>>> +static const struct kvm_irq_level a15_virt_timer_ppi = {
>>>> +       { .irq = 27 },  /* irq: A7/A15 specific */
>>>
>>> This should be parameterised by the vCPU type.
>>
>> This is already A15 specific, and assigned in an A15 specific code
>> section below.
> 
> Right, but we can take the interrupt number from the device-tree, like we do
> for the host anyway.

Certainly. I'll update this bit.

>>>> +static irqreturn_t kvm_arch_timer_handler(int irq, void *dev_id)
>>>> +{
>>>> +       struct kvm_vcpu *vcpu = *(struct kvm_vcpu **)dev_id;
>>>> +
>>>> +       /*
>>>> +        * We disable the timer in the world switch and let it be
>>>> +        * handled by kvm_timer_sync_from_cpu(). Getting a timer
>>>> +        * interrupt at this point is a sure sign of some major
>>>> +        * breakage.
>>>> +        */
>>>> +       pr_warn("Unexpected interrupt %d on vcpu %p\n", irq, vcpu);
>>>> +       return IRQ_HANDLED;
>>>
>>> IRQ_NONE?
>>
>> I don't think so. We're actually handling the interrupt (admittedly in a
>> very basic way), and as it is a per-cpu interrupt, there will be noone
>> else to take care of it.
> 
> For an SPI, returning IRQ_NONE would (eventually) silence a screaming
> interrupt because the generic IRQ bits would disable it. I'm not sure if that
> applies to PPIs or not but if it does, I'd say that's a good reason to use it.
> 
>>
>>>> +       BUG_ON(timer->armed);
>>>> +
>>>> +       if (cval <= now) {
>>>> +               /*
>>>> +                * Timer has already expired while we were not
>>>> +                * looking. Inject the interrupt and carry on.
>>>> +                */
>>>> +               kvm_timer_inject_irq(vcpu);
>>>> +               return;
>>>> +       }
>>>
>>> Does this buy you much? You still have to cope with the timer expiring here
>>> anyway.
>>
>> It definitely does from a latency point of view. Programming a timer
>> that will expire right away, calling the interrupt handler, queuing the
>> work queue, waiting for the workqueue to be scheduled and finally
>> delivering the interrupt... If we can catch a few of these early (and we
>> do), it is worth it.
> 
> Ok, interesting. I wasn't sure how often that happened in practice.
> 
>>>> +int kvm_timer_init(struct kvm *kvm)
>>>> +{
>>>> +       if (timecounter && wqueue) {
>>>> +               kvm->arch.timer.cntvoff = kvm_phys_timer_read();
>>>
>>> Shouldn't this be initialised to 0 and then updated on world switch?
>>
>> No. You do not want your virtual offset to drift. Otherwise you'll
>> observe something like time dilatation, and your clocks will drift.
>> Plus, you really want all your vcpus to be synchronized. Allowing them
>> to drift apart could be an interesting experience... ;-)
> 
> In which case, why do we initialise it to the physical timer in the first
> place? Surely the value doesn't matter, as long as everybody agrees on what
> it is?

This ensures that the VM gets its virtual counter starting as closely as
possible to 0. As good a convention as any.

	M.
-- 
Jazz is not dead. It just smells funny...
