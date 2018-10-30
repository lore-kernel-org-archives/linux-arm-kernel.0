From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 Oct 2018 09:45:49 -0300
Subject: revisit arm64 per-task stack canaries
In-Reply-To: <20181030103502.GD19955@arm.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
 <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
 <CAKv+Gu-WVMnk2AhB9ziupL-TQoR8gZ121mkQAV9mvbgjirhbmg@mail.gmail.com>
 <20180213180436.GA21758@arm.com>
 <CAKv+Gu_q9mbjHhuU8g_nM6vBS_F3ypAvnuKLAg-Oaf+2wf2ePw@mail.gmail.com>
 <20181030103502.GD19955@arm.com>
Message-ID: <CAKv+Gu96pRfneQ-SLL3a9d-uLAqOPvkLcB25Md=f+z9f5Yg+fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 October 2018 at 07:35, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Oct 12, 2018 at 12:37:46PM +0200, Ard Biesheuvel wrote:
>> To recap, my proof of concept was based on using the task struct
>> pointer directly (which we keep in sp_el0 in the kernel). That way, we
>> don't care about per-CPU vars and preemption etc, since the stack
>> canary value is tied to the task anyway, regardless on which CPU it
>> executes.
>>
>> So my suggestion was to turn this (the current sequence emitted by the compiler)
>>
>> adrp    x0, __stack__chk_guard
>> ldr     x0, [x0, :lo12:__stack_chk_guard]
>>
>> into this
>>
>> mrs     x0, <sysreg>
>> ldr     x0, [x0, :lo12:<offset>]
>>
>> where 'sysreg' and 'offset' are the names of 1) a system register and
>> 2) an absolute ELF symbol, respectively.
>>
>> At Ramana's request (and with Arnd's help) I looked into whether we
>> can provide offsetof(struct task_struct, stack_canary) as a bare
>> number on the GCC command line instead, but this is turning out to be
>> rather cumbersome, given that we need to run the compiler to find the
>> offset in the first place. (The most promising approach would be to
>> generate a file and include it with @filename so its contents are
>> parsed as command line options but even that is rather fiddly to add
>> into our build system)
>>
>> My approach of exposing the offset via the linker script works fine,
>> and we wouldn't even need a separate GCC command line option in that
>> case: we could just settle on __stack_chk_guard_sysreg_offset and
>> stipulate that it is exposed as an absolute ELF symbol in the range
>> [0..1023] when -mstack-protector-guard=<sysreg> is passed to GCC.
>
> That sounds like a sensible proposal to me. I'm assuming that the sysreg
> is specified on the compiler command line as well?
>

Yes, hence the -mstack-protector-guard=<sysreg>  :-)

>> Ramana, could you elaborate on your preference for a bare number on
>> the command line? Do you see any alternatives?
>
> With CONFIG_THREAD_INFO_IN_TASK I suppose we could bodge things so that
> this constant is also zero, but it seems to me that all we gain is
> fragility when compared to exposing a named symbol.
>

Yeah, I looked into that as well: we could copy the stack_canary
member into our thread_info struct, but it is indeed a bodge.

> Ramana -- was this just a cosmetic preference, or are there good technical
> reasons to avoid the new symbol (which isn't an awful lot different to what
> we currently use).
>

I suppose absolute ELF symbols are somewhat unusual, but they are
clearly defined by the ELF spec and we already use them in other
places as well.
