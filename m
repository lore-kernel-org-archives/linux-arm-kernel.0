From: keescook@chromium.org (Kees Cook)
Date: Mon, 15 Oct 2018 14:47:30 -0700
Subject: revisit arm64 per-task stack canaries
In-Reply-To: <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
 <20180213180436.GA21758@arm.com>
 <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
Message-ID: <CAGXu5j+t_f1wiHzUc0eX=mwPM6KPvHpTD6e9tDmMzMtb3Bwmyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 3:37 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> (+ Arnd)
>
> On 13 February 2018 at 19:04, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Ard,
>>
>> On Tue, Feb 13, 2018 at 01:56:49PM +0000, Ard Biesheuvel wrote:
>>> On 13 February 2018 at 12:52, Mark Rutland <mark.rutland@arm.com> wrote:
>>> > On Tue, Feb 13, 2018 at 12:36:02PM +0000, Ard Biesheuvel wrote:
>>> >> Instead, I have proposed a proof of concept [0] where the compiler
>>> >> emits an instruction sequence that loads the canary directly from the
>>> >> task struct, which is the per-thread data structure maintained by the
>>> >> kernel. Accessing that can be done safely without any of the
>>> >> limitations per-CPU variables have. The task struct pointer is kept in
>>> >> system register sp_el0 while running in the kernel.
>>> >
>>> > My major concern here is being tied to using sysregs in a particular
>>> > way. We might want to fiddle with that in future (e.g. using the
>>> > platform register as an optimization, or switching to a different sysreg
>>> > due to architectural extensions).
>>> >
>>>
>>> Yes. Also, there is a disparity between userland (using tpidr_el0) and
>>> kernel (using sp_el0), and perhaps it would make more sense to switch
>>> to tpidr_el0 in the kernel as well. But the general objection remains.
>>
>> Indeed, and I share Mark's view that we don't want to commit to a specific
>> sequence here. Ideally, we'd have a way to pass whatever thunk we need to
>> the compiler and have the freedom to implement it as we see fit (and to
>> change that implementation at a whim).
>>
>>> >> The purpose of this email to reach agreement between the various
>>> >> stakeholders (mainly the arm64 linux maintainers and the ARM GCC
>>> >> maintainers) on a way to proceed with implementing this in GCC.
>>> >
>>> > Would it be possible to have an always inline function to get the
>>> > canary, which GCC would implicitly fold into functions as necessary?
>>> >
>>> > ... then we could have something in a header, like:
>>> >
>>> > static __always_inline unsigned long get_task_canary(void)
>>> > {
>>> >         return current->canary;
>>> > }
>>> >
>>> > ... which we could change in future as needs change.
>>> >
>>>
>>> This is a question to the compiler folks, I suppose, but I'd venture a
>>> guess that this is rather hard. Perhaps a true function call would be
>>> better if it is done in a way that can be optimized by LTO (this is of
>>> course assuming that by GCC 9, this is something we are likely to use
>>> in the kernel)
>>>
>>> An alternative could be to decide to rely on a GCC plugin instead
>>> (although this would not be my preference). My poc implementation is a
>>> bit clunky, but I did not spend a lot of time on it. If we can refine
>>> it to replace the high/lo ref to __stack_chk_guard with something more
>>> robust, then we remain in control of which register and/or symbol ref
>>> we use and we don't paint ourselves into a corner.
>>
>> I'm wary of our ability to maintain a GCC plugin in the kernel source tree.
>> I would *much* prefer to have proper support in the compiler.
>>
>
> Hello all,
>
> Ramana, Arnd, Mark and I spoke about this again at Linaro Connect in
> Vancouver, and Ramana is still volunteering to work on the GCC side
> changes if we can agree on a way to parameterize this.
>
> To recap, my proof of concept was based on using the task struct
> pointer directly (which we keep in sp_el0 in the kernel). That way, we
> don't care about per-CPU vars and preemption etc, since the stack
> canary value is tied to the task anyway, regardless on which CPU it
> executes.
>
> So my suggestion was to turn this (the current sequence emitted by the compiler)
>
> adrp    x0, __stack__chk_guard
> ldr     x0, [x0, :lo12:__stack_chk_guard]
>
> into this
>
> mrs     x0, <sysreg>
> ldr     x0, [x0, :lo12:<offset>]
>
> where 'sysreg' and 'offset' are the names of 1) a system register and
> 2) an absolute ELF symbol, respectively.
>
> At Ramana's request (and with Arnd's help) I looked into whether we
> can provide offsetof(struct task_struct, stack_canary) as a bare
> number on the GCC command line instead, but this is turning out to be
> rather cumbersome, given that we need to run the compiler to find the
> offset in the first place. (The most promising approach would be to
> generate a file and include it with @filename so its contents are
> parsed as command line options but even that is rather fiddly to add
> into our build system)
>
> My approach of exposing the offset via the linker script works fine,
> and we wouldn't even need a separate GCC command line option in that
> case: we could just settle on __stack_chk_guard_sysreg_offset and
> stipulate that it is exposed as an absolute ELF symbol in the range
> [0..1023] when -mstack-protector-guard=<sysreg> is passed to GCC.
>
> Ramana, could you elaborate on your preference for a bare number on
> the command line? Do you see any alternatives?

I would continue to _love_ to have this all working. :) Getting a
per-thread canary would make me so happy! Please let me know if I can
help in some way.

-Kees

-- 
Kees Cook
Pixel Security
