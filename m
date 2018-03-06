From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Mar 2018 19:14:08 +0000
Subject: [PATCH] KVM: arm: reserve bit in KVM_REG_ARM encoding for
 secure/nonsecure
In-Reply-To: <CAFEAcA_KtKd9cE2GwDe64CCCaGehMgN++3A=YgLEL+udQbxWVw@mail.gmail.com>
References: <20180306162646.7646-1-peter.maydell@linaro.org>
 <4dbad5e5-8e62-4729-16f3-59ce1cfdd550@arm.com>
 <CAFEAcA9KYxtUzH+DtUR-zVXeFYeVA1orh-Y7+FkufxNZ6o8ivw@mail.gmail.com>
 <90ed4785-bf17-02b6-7941-d9524c4642f6@arm.com>
 <CAFEAcA_KtKd9cE2GwDe64CCCaGehMgN++3A=YgLEL+udQbxWVw@mail.gmail.com>
Message-ID: <2b26805e-103d-d76d-e1f1-6ba7ca964ecf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 18:51, Peter Maydell wrote:
> On 6 March 2018 at 17:16, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 06/03/18 16:56, Peter Maydell wrote:
>>> On 6 March 2018 at 16:43, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> On 06/03/18 16:26, Peter Maydell wrote:
>>>>> +#define KVM_REG_ARM_SECURE_MASK      0x0000000010000000
>>>>> +#define KVM_REG_ARM_SECURE_SHIFT     28
>>>>>
>>>>>  #define ARM_CP15_REG_SHIFT_MASK(x,n) \
>>>>>       (((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
>>>>>
>>>>
>>>> Don't you also need to define it on the arm64 side?
>>>
>>> I don't think so, because AArch64 registers aren't security banked
>>> (except for some GICv3 ones, which aren't set via GET/SET_ONE_REG.)
>>> Or is there a case I'm missing?
>>
>> There is still the case of AArch32 guests on arm64, for which you'd need
>> to replicate the change to arch/arm64/include/uapi/asm/kvm.h. The two
>> architectures have different userspace APIs.
> 
> I thought that AArch32 guests on arm64 hosts still used the
> arm64 GET/SET_ONE_REG registers to set the guest's environment?
> The guest's r0-r7 are in what KVM considers X0..X7, etc, and
> cp15 registers are accessed by reading/writing their architecturally
> mapped AArch64 EL1 counterparts.

You're right, there is no banked state at all on arm64. Ignore me.

Can you please respin this patch with the updated comment? I'll queue it
for 4.17.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
