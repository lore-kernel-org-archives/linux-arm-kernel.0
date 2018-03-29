From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Mar 2018 10:02:18 +0100
Subject: [PATCH resend 2/2] arm64: assembler: add macros to conditionally
 yield the NEON under PREEMPT
In-Reply-To: <20180328171812.GN16308@e103592.cambridge.arm.com>
References: <20180328124129.6459-1-ard.biesheuvel@linaro.org>
 <20180328124129.6459-3-ard.biesheuvel@linaro.org>
 <20180328171812.GN16308@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu-FdndoFON3tJi0WP=+HsBtaoLY-uf6=0bd3e6jr1h-DQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2018 at 18:18, Dave Martin <Dave.Martin@arm.com> wrote:
> On Wed, Mar 28, 2018 at 02:41:29PM +0200, Ard Biesheuvel wrote:
>> Add support macros to conditionally yield the NEON (and thus the CPU)
>> that may be called from the assembler code.
>>
>> In some cases, yielding the NEON involves saving and restoring a non
>> trivial amount of context (especially in the CRC folding algorithms),
>> and so the macro is split into three, and the code in between is only
>> executed when the yield path is taken, allowing the context to be preserved.
>> The third macro takes an optional label argument that marks the resume
>> path after a yield has been performed.
>
> Minor comments below, mostly just suggestions/observations.
>
> With the missing #include in asm-offsets.c fixed (if you think it's
> appropriate):
>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>

Thanks Dave

Replies below

>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/assembler.h | 64 ++++++++++++++++++++
>>  arch/arm64/kernel/asm-offsets.c    |  2 +
>>  2 files changed, 66 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index d354eb7f2f0c..fb11514273d9 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -623,4 +623,68 @@ USER(\label, ic  ivau, \tmp2)                    // invalidate I line PoU
>>       .endif
>>       .endm
>>
>> +/*
>> + * Check whether to yield to another runnable task from kernel mode NEON code
>> + * (which runs with preemption disabled).
>> + *
>> + * if_will_cond_yield_neon
>> + *        // pre-yield patchup code
>> + * do_cond_yield_neon
>> + *        // post-yield patchup code
>> + * endif_yield_neon    <label>
>> + *
>> + * where <label> is optional, and marks the point where execution will resume
>> + * after a yield has been performed. If omitted, execution resumes right after
>> + * the endif_yield_neon invocation.
>
> Maybe add a comment describing cond_yield_neon, e.g.:
>
>  *
>  * As a convenience, in the case where no patchup code is required
>  * the above sequence may be abbreviated to:
>  *
>  * cond_yield_neon <label>
>

Makes sense. I will add that.

>> + *
>> + * Note that the patchup code does not support assembler directives that change
>> + * the output section, any use of such directives is undefined.
>> + *
>> + * The yield itself consists of the following:
>> + * - Check whether the preempt count is exactly 1, in which case disabling
>> + *   preemption once will make the task preemptible. If this is not the case,
>> + *   yielding is pointless.
>> + * - Check whether TIF_NEED_RESCHED is set, and if so, disable and re-enable
>> + *   kernel mode NEON (which will trigger a reschedule), and branch to the
>> + *   yield fixup code.
>> + *
>> + * This macro sequence clobbers x0, x1 and the flags register unconditionally,
>> + * and may clobber x2 .. x18 if the yield path is taken.
>> + */
>
> Does this mean that the pre-yield patchup code can safely refer to
> x2..x18, but the post-yield patchup code and the code at <label> (or
> otherwise immediately following endif_yield_neon) can't?
>

In theory, yes, but it doesn't really matter in practice. If you go
down the yield path, you will always run the pre and post sequences,
and the main code will need to keep state in x19 and up anyway if it
wants it to be preserved.

I should probably rephrase this to say that x0 .. x18 may be clobbered.

>> +
>> +     .macro          cond_yield_neon, lbl
>> +     if_will_cond_yield_neon
>> +     do_cond_yield_neon
>> +     endif_yield_neon        \lbl
>> +     .endm
>> +
>> +     .macro          if_will_cond_yield_neon
>> +#ifdef CONFIG_PREEMPT
>> +     get_thread_info x0
>> +     ldr             w1, [x0, #TSK_TI_PREEMPT]
>> +     ldr             x0, [x0, #TSK_TI_FLAGS]
>> +     cmp             w1, #PREEMPT_DISABLE_OFFSET
>> +     csel            x0, x0, xzr, eq
>> +     tbnz            x0, #TIF_NEED_RESCHED, .Lyield_\@       // needs rescheduling?
>> +#endif
>> +     /* fall through to endif_yield_neon */
>> +     .subsection     1
>
> Can we junk the code in this case rather than including it in the
> kernel, like
>
>         .section .discard.cond_yield_neon
>
> (this seems to conform to some notion of a standard discarded section
> name, see <asm-generic/vmlinux.lds.h>).  This additionally discards
> the do_cond_yield_neon invocation (which I guess is what we'd expect
> for a non-preemptible kernel?)
>
> If doing that discard, a note could be added in the comment block
> to warn people not to assume that the patchup code and any labels
> defined in it will definitely end up in the kernel image.
>
> Since the patchup sequences aren't likely to be many or large, it's
> not the end of the world if we don't do this discarding though.
>

I chose not to bother. These are handcrafted assembly files that are
usually kept in modules, which means the .text footprint is a 4k
multiple anyway, and the code is complex enough as it is, so
discarding ~10 instructions that have been moved out of the hot path
already doesn't seem that useful to me.

>> +.Lyield_\@ :
>> +     .endm
>> +
>> +     .macro          do_cond_yield_neon
>> +     bl              kernel_neon_end
>> +     bl              kernel_neon_begin
>> +     .endm
>> +
>> +     .macro          endif_yield_neon, lbl
>> +     .ifnb           \lbl
>> +     b               \lbl
>> +     .else
>> +     b               .Lyield_out_\@
>> +     .endif
>
> Should you include
>
>         .purgem do_cond_yield_neon
>         .purgem endif_yield_neon
>
> here?
>
> Otherwise, I think you would get macro redefinition errors if
> if_will_cond_yield_neon is used more than once in a given file.
>

if_will_cond_yield_neon does not define any macros itself, so this
shouldn't be a problem.

> You could maybe protect against nested and misordered macro uses by the
> following, though it feels a bit like overkill.  Alternatively you
> could use a magic symbol to record the current state, similarly to
> frame_{push,pop}.
>
>         .macro __if_will_cond_yield_neon
>         .purgem if_will_cond_yield_neon
>         //...
>
>         .macro do_cond_yield_neon
>         .purgem do_cond_yield_neon
>         //...
>
>         .macro endif_yield_neon
>         .purgem endif_yield_neon
>         //...
>
>         .macro if_will_cond_yield_neon
>         __if_will_cond_yield_neon
>         .endm // if_will_cond_yield_neon
>         .endm // endif_yield_neon
>         .endm // do_cond_yield_neon
>         .endm // __if_will_cond_yield_neon
>
>         .macro if_will_cond_yield_neon
>         __if_will_cond_yield_neon
>         .endm
>
>> +     .previous
>> +.Lyield_out_\@ :
>> +     .endm
>> +
>>  #endif       /* __ASM_ASSEMBLER_H */
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 1303e04110cd..1e2ea2e51acb 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -93,6 +93,8 @@ int main(void)
>>    DEFINE(DMA_TO_DEVICE,              DMA_TO_DEVICE);
>>    DEFINE(DMA_FROM_DEVICE,    DMA_FROM_DEVICE);
>>    BLANK();
>
> #include <linux/preempt.h> ?
>

Good point, will add.

>> +  DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
>> +  BLANK();
>
> [...]
>
> Cheers
> ---Dave
