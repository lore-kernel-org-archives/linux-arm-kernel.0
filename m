From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Dec 2016 14:17:14 +0000
Subject: [PATCH v6] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <20161213134908.GG1574@e103592.cambridge.arm.com>
References: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161213134908.GG1574@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_9QSkoxYb8=ECn4ar4LXpojtuNgpoLe+0-hA4n-8PhNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2016 at 13:49, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Dec 13, 2016 at 12:35:29PM +0000, Ard Biesheuvel wrote:
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
>
> Hang on ... we could be in the middle of fpsimd_save_state() for other
> reasons, say on the context switch path.  Wouldn't we need to take the
> lock for those too?
>

Yes. Saving the state should never be interrupted, and now that I
think of it, this is an issue for your original patch as well: even if
you always preserve the state first in kernel_neon_begin(), any
occurrence of fpsimd_save_state() could be interrupted by a
kernel_neon_begin()/_end() pair, after which the SVE state is nuked
anyway (regardless of whether a patch like this one is applied) So I
think we do need the lock in all cases where the FP/SIMD is copied to
memory and the flag set.

> Also, a spinlock can't protect a critical section from code running on
> the same CPU... wouldn't it just deadlock in that case?
>

That is why I use spin_trylock(). But I realise now that the patch is
incorrect: the nesting level needs to be incremented first, or the
interrupter will still clobber the context while it is being
preserved.

> I still tend to prefer v4 -- there we do a redundant double-save only if
> one kernel_neon_begin() interrupts the actual task context save.
>

I think we're not at the bottom of this rabbit hole yet:-)
