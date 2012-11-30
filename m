From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 18:11:16 -0500
Subject: [PATCH v4 3/5] ARM: KVM: arch_timers: Add guest timer core support
In-Reply-To: <50AFAE32.2040603@arm.com>
References: <20121110154554.3274.77777.stgit@chazy-air>
 <20121110154618.3274.53380.stgit@chazy-air>
 <20121123161759.GK32200@mudshark.cambridge.arm.com>
 <50AFA9BC.1010105@arm.com>
 <20121123170036.GN32200@mudshark.cambridge.arm.com>
 <50AFAE32.2040603@arm.com>
Message-ID: <CANM98qLqv0Q=FcPtRHUnye=XN7rvn6SEZ-jg=YP3RB88StO6RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 12:11 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/11/12 17:00, Will Deacon wrote:
>> On Fri, Nov 23, 2012 at 04:52:12PM +0000, Marc Zyngier wrote:
>>> On 23/11/12 16:17, Will Deacon wrote:
>>>>> diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
>>>>> index b80256b..7463f5b 100644
>>>>> --- a/arch/arm/kvm/reset.c
>>>>> +++ b/arch/arm/kvm/reset.c
>>>>> @@ -37,6 +37,12 @@ static struct kvm_regs a15_regs_reset = {
>>>>>         .usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
>>>>>  };
>>>>>
>>>>> +#ifdef CONFIG_KVM_ARM_TIMER
>>>>> +static const struct kvm_irq_level a15_virt_timer_ppi = {
>>>>> +       { .irq = 27 },  /* irq: A7/A15 specific */
>>>>
>>>> This should be parameterised by the vCPU type.
>>>
>>> This is already A15 specific, and assigned in an A15 specific code
>>> section below.
>>
>> Right, but we can take the interrupt number from the device-tree, like we do
>> for the host anyway.
>
> Certainly. I'll update this bit.
>
So we lock ourselves to always only support emulating the same CPU on
the guest as on the host?

(I know we assume this elsewhere and that even the A7 uses the same
IRQ number, but these doesn't necessarily have to be the same in the
future, and there's no need to make such a task more difficult, and we
are not really making things mode stable/simple by taking it from the
DT - are we?)

-Christoffer
