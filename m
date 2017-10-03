From: jintack@cs.columbia.edu (Jintack Lim)
Date: Tue, 3 Oct 2017 17:11:34 -0400
Subject: [RFC PATCH v2 19/31] KVM: arm64: Describe AT instruction
 emulation design
In-Reply-To: <59D3CAF2.2030704@arm.com>
References: <1507000273-3735-1-git-send-email-jintack.lim@linaro.org>
 <1507000273-3735-17-git-send-email-jintack.lim@linaro.org>
 <59D3CAF2.2030704@arm.com>
Message-ID: <CAHyh4xgWaPTYn5C-KZKp-wmkCpZ5A--2iemVV5rfG1Opjk1yJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Tue, Oct 3, 2017 at 1:37 PM, James Morse <james.morse@arm.com> wrote:
> Hi Jintack,
>
> On 03/10/17 04:11, Jintack Lim wrote:
>> This design overview will help to digest the subsequent patches that
>> implement AT instruction emulation.
>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 8d04926..d8728cc 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1621,6 +1621,72 @@ static bool access_id_aa64mmfr0_el1(struct kvm_vcpu *v,
>>       { SYS_DESC(SYS_SP_EL2), NULL, reset_special, SP_EL2, 0},
>>  };
>>
>> +/*
>> + * AT instruction emulation
>> + *
>> + * We emulate AT instructions executed in the virtual EL2.
>
>> + * Basic strategy for the stage-1 translation emulation is to load proper
>> + * context, which depends on the trapped instruction and the virtual HCR_EL2,
>> + * to the EL1 virtual memory control registers and execute S1E[01] instructions
>> + * in EL2. See below for more detail.
>
> What happens if the guest memory containing some stage1-page-table has been
> unmapped from stage2? (e.g. its swapped to disk).
>
> (there is some background to this: I tried to implement the kvm_translate
> ioctl() using this approach, running 'at s1e1*' from EL2. I ran into problems
> when parts of the guest's stage1 page tables had been unmapped from stage2.)
>
> From memory, I found that the AT instructions would fault-in those pages when
> run from EL1, but when executing the same instruction at EL2 they just failed
> without any hint of which IPA needed mapping in.

I think I haven't encountered this case yet, probably because I
usually don't set a swap partition.

In fact, I couldn't find pseudocode for AT instructions. If you
happened to have one, is that behavior you observed described in ARM
ARM?

Thanks,
Jintack

>
> I can try digging for any left over code if we want to setup a test case for this...
>
>
> Thanks,
>
> James
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>
