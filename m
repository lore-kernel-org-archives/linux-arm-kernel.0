From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 4 Jan 2018 17:14:07 +0000
Subject: [PATCH 11/11] arm64: Implement branch predictor hardening for
 affected Cortex-A CPUs
In-Reply-To: <CAKv+Gu8E=yWRE9PThFeG3efuT5JLbAK+RpmhTvuEeXwk-iuN9g@mail.gmail.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-12-git-send-email-will.deacon@arm.com>
 <CAKv+Gu8E=yWRE9PThFeG3efuT5JLbAK+RpmhTvuEeXwk-iuN9g@mail.gmail.com>
Message-ID: <b4a2d82d-9c4c-6bed-fe25-9b69fdc41215@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/18 16:31, Ard Biesheuvel wrote:
> On 4 January 2018 at 15:08, Will Deacon <will.deacon@arm.com> wrote:
>> Cortex-A57, A72, A73 and A75 are susceptible to branch predictor aliasing
>> and can theoretically be attacked by malicious code.
>>
>> This patch implements a PSCI-based mitigation for these CPUs when available.
>> The call into firmware will invalidate the branch predictor state, preventing
>> any malicious entries from affecting other victim contexts.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> ---
>>  arch/arm64/kernel/bpi.S        | 24 ++++++++++++++++++++++++
>>  arch/arm64/kernel/cpu_errata.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
>> index 06a931eb2673..2b10d52a0321 100644
>> --- a/arch/arm64/kernel/bpi.S
>> +++ b/arch/arm64/kernel/bpi.S
>> @@ -53,3 +53,27 @@ ENTRY(__bp_harden_hyp_vecs_start)
>>         vectors __kvm_hyp_vector
>>         .endr
>>  ENTRY(__bp_harden_hyp_vecs_end)
>> +ENTRY(__psci_hyp_bp_inval_start)
>> +       stp     x0, x1, [sp, #-16]!
>> +       stp     x2, x3, [sp, #-16]!
>> +       stp     x4, x5, [sp, #-16]!
>> +       stp     x6, x7, [sp, #-16]!
>> +       stp     x8, x9, [sp, #-16]!
>> +       stp     x10, x11, [sp, #-16]!
>> +       stp     x12, x13, [sp, #-16]!
>> +       stp     x14, x15, [sp, #-16]!
>> +       stp     x16, x17, [sp, #-16]!
>> +       stp     x18, x19, [sp, #-16]!
> 
> Would it be better to update sp only once here?

Maybe. I suppose that's quite uarch dependent, but worth trying.

> Also, do x18 and x19 need to be preserved/restored here?

My bad. I misread the SMCCC and though I needed to save it too. For the
reference, the text says:

"Registers  X18-X30 and stack pointers SP_EL0 and SP_ELx are saved by
the function that is called, and must be preserved over the SMC or HVC
call."

I'll amend the patch.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
