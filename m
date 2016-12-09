From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 9 Dec 2016 12:24:03 +0000
Subject: [PATCH v3] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <20161209122021.GA1574@e103592.cambridge.arm.com>
References: <1481215779-23432-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161209122021.GA1574@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu-P6ReNVVyyuwF8mE3S7U+X3uK6A=qKmmzU7vQy_SgXWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 December 2016 at 12:20, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Dec 08, 2016 at 04:49:39PM +0000, Ard Biesheuvel wrote:
>> Currently, we allow kernel mode NEON in softirq or hardirq context by
>> stacking and unstacking a slice of the NEON register file for each call
>> to kernel_neon_begin() and kernel_neon_end(), respectively.
>>
>> Given that
>> a) a CPU typically spends most of its time in userland, during which time
>>    no kernel mode NEON in process context is in progress,
>> b) a CPU spends most of its time in the kernel doing other things than
>>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
>>    in softirq context
>>
>> the stacking and subsequent unstacking is only necessary if we are
>> interrupting a thread while it is performing kernel mode NEON in process
>> context, which means that in all other cases, we can simply preserve the
>> userland FPSIMD state once, and only restore it upon return to userland,
>> even if we are being invoked from softirq or hardirq context.
>>
>> So instead of checking whether we are running in interrupt context, keep
>> track of the level of nested kernel mode NEON calls in progress, and only
>> perform the eager stack/unstack if the level exceeds 1.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> v3:
>> - avoid corruption by concurrent invocations of kernel_neon_begin()/_end()
>>
>> v2:
>> - BUG() on unexpected values of the nesting level
>> - relax the BUG() on num_regs>32 to a WARN, given that nothing actually
>>   breaks in that case
>>
>>  arch/arm64/kernel/fpsimd.c | 47 ++++++++++++++------
>>  1 file changed, 33 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 394c61db5566..536ddab9316d 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -220,20 +220,35 @@ void fpsimd_flush_task_state(struct task_struct *t)
>>
>>  #ifdef CONFIG_KERNEL_MODE_NEON
>>
>> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
>> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
>> +/*
>> + * Although unlikely, it is possible for three kernel mode NEON contexts to
>> + * be live at the same time: process context, softirq context and hardirq
>> + * context. So while the userland context is stashed in the thread's fpsimd
>> + * state structure, we need two additional levels of storage.
>> + */
>> +static DEFINE_PER_CPU(struct fpsimd_partial_state, nested_fpsimdstate[2]);
>> +static DEFINE_PER_CPU(atomic_t, kernel_neon_nesting_level);
>
> Come to think of it, should we use this_cpu_{read,add}() etc?
>

I wasn't aware those existed ...

> I'm not sure why we need the barrier semantics of atomic_t ops here.
>

I don't think we do. We only need the atomic increment/decrement, afaict
