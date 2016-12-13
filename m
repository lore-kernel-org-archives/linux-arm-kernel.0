From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Dec 2016 19:19:32 +0000
Subject: [PATCH v6] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <CAKv+Gu9+Rcuc3Ubbom_NrYW5sR5B9teSfhM1+zi2JKhj4GUXWQ@mail.gmail.com>
References: <1481632529-24218-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161213173457.GF23377@e104818-lin.cambridge.arm.com>
 <CAKv+Gu9+Rcuc3Ubbom_NrYW5sR5B9teSfhM1+zi2JKhj4GUXWQ@mail.gmail.com>
Message-ID: <CAKv+Gu8SSXqVnvEz6yA9r5VxGicqxqmXDnDh9S1teZ4y5CZOxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2016 at 19:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 13 December 2016 at 17:34, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Tue, Dec 13, 2016 at 12:35:29PM +0000, Ard Biesheuvel wrote:
>>> Currently, we allow kernel mode NEON in softirq or hardirq context by
>>> stacking and unstacking a slice of the NEON register file for each call
>>> to kernel_neon_begin() and kernel_neon_end(), respectively.
>>>
>>> Given that
>>> a) a CPU typically spends most of its time in userland, during which time
>>>    no kernel mode NEON in process context is in progress,
>>> b) a CPU spends most of its time in the kernel doing other things than
>>>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
>>>    in softirq context
>>>
>>> the stacking and subsequent unstacking is only necessary if we are
>>> interrupting a thread while it is performing kernel mode NEON in process
>>> context, which means that in all other cases, we can simply preserve the
>>> userland FPSIMD state once, and only restore it upon return to userland,
>>> even if we are being invoked from softirq or hardirq context.
>>>
>>> So instead of checking whether we are running in interrupt context, keep
>>> track of the level of nested kernel mode NEON calls in progress, and only
>>> perform the eager stack/unstack if the level exceeds 1.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>> v6:
>>> - use a spinlock instead of disabling interrupts
>>
>> My concern with the spinlock or disabling interrupts is the latency if
>> we ever get some insanely long SVE vectors.
>>
>
> Thinking about this a bit more, and trying a couple of things in code,
> I think this looks like it could be a nasty problem.
>
> The primary issue is that *any* code that handles the FP/SIMD state,
> i.e., preserve it, restore it, etc, could be interrupted, and if
> kernel_neon_begin()/_end() was used during that time, the top SVE end
> of the registers is just blown away if we don't make the nested
> save/restore SVE aware.
>
> For instance, looking at
>
> void fpsimd_restore_current_state(void)
> {
>   preempt_disable();
>   if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>     struct fpsimd_state *st = &current->thread.fpsimd_state;
>
>     fpsimd_load_state(st);
>     this_cpu_write(fpsimd_last_state, st);
>     st->cpu = smp_processor_id();
>   }
>   preempt_enable();
> }
>
> if fpsimd_load_state() is interrupted and the NEON is used, the
> registers that were restored before the interruption will have
> incorrect values if SVE is being used by userland.
>
> On the preserve side, we can deal with this by preserving into a temp
> buffer, and only store the value that was recorded when the flag was
> set, i.e.,
>
> static void safe_preserve_fpsimd_state(void)
> {
>   union __fpsimd_percpu_state *s = this_cpu_ptr(nested_fpsimdstate);
>
>   if (in_irq()) {
>   /* No interruptions possible, so just proceed */
>     if (!test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>       fpsimd_save_state(&current->thread.fpsimd_state);

The indentation is slightly off here: the 'else' treats the !in_irq() case

>     } else {
>       struct fpsimd_state *fp;
>
>       fp = in_interrupt() ? &s[0].full : &s[1].full;
>
>       fpsimd_save_state(fp);
>       if (!test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>         current->thread.fpsimd_state = *fp;
>   }
> }
>
> which is already cumbersome if the full FP/SIMD state grows to 64 KB
>
> However, on the restore side, I fail to see how we can tolerate
> interruptions in a similar way.
>
> --
> Ard.
