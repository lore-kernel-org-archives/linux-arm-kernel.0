From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Jan 2018 10:59:36 +0000
Subject: per-task stack canaries for arm64
In-Reply-To: <CAKv+Gu-TtJ7Pxa7+qOX7MiQwPFwsNOup2Q=0TvjCO4xHxf3QQA@mail.gmail.com>
References: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
 <CAGXu5j+cJoc6o8d-hmLFj08r18GhEbKhVNA94LDKM5yqo9CbSQ@mail.gmail.com>
 <CAKv+Gu9vViZUBYJWnGdnewL9h-ahP0Hs8gU+3_QH76ROdQh1yQ@mail.gmail.com>
 <CAGXu5j+PO=Ben0J-xnOztrAdsku2SUKFiz6w7cqTEfHTveFFSg@mail.gmail.com>
 <f80404f3-985f-9e3b-2ad3-f2b0fc2a8b28@arm.com>
 <CAKv+Gu-TtJ7Pxa7+qOX7MiQwPFwsNOup2Q=0TvjCO4xHxf3QQA@mail.gmail.com>
Message-ID: <CAKv+Gu8P6OZDSMw7oA+5_RgGLkeOwoaEPb_5c510uoBAJY7MeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 January 2018 at 13:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 18 January 2018 at 10:26, Ramana Radhakrishnan
> <ramana.radhakrishnan@arm.com> wrote:
>> On 1/17/18 8:45 PM, Kees Cook wrote:
>>> On Wed, Jan 17, 2018 at 12:32 PM, Ard Biesheuvel
>>> <ard.biesheuvel@linaro.org> wrote:
>>>> On 17 January 2018 at 19:10, Kees Cook <keescook@chromium.org> wrote:
>>>>> On Wed, Jan 17, 2018 at 10:24 AM, Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>> [...]
>>>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
>>>>> which was done for x86 only, and provides both:
>>>>>   -mstack-protector-guard-symbol=...
>>>>>   -mstack-protector-guard-reg=...
>>>>>
>>>>> If this could be extended to arm64, I think we'd be in good shape (and
>>>>> it could be trivially detected at build time).
>>>>>
>>>>
>>>> I'm not entirely sure what the point is of specifying the name of the
>>>> symbol on the command line. It is ultimately up to the GCC developers
>>>> to decide how much point there is to maintaining parity with x86 here.
>>>>
>>>> [...]
>>>>>> Ramana indicated at the time that he would be up for adding, e.g.,
>>>>>> -fstack-protector-linux-kernel as a command line option, and add the
>>>>>> contents of tpidr_el1 to every reference of __stack_chk_guard when
>>>>>> set.
>>
>> Wow, that was a hall-way conversation eons ago. It took me a while to
>> page that in.
>>
>>
>>>>>
>>>>> I think we want to reuse the command-line names from the x86 options
>>>>> above, unless there's a good reason not to?
>>>>
>>>> I'm perfectly happy to settle for whatever the GCC developers manage
>>>> to agree on, as long as it gives us the ability to use tpidr_el1 as
>>>> the offset.
>>>
>>> Ramana, Uro?, what's the best next step? Should we open a GCC bug
>>> specifically for arm64 here?
>>
>> The next best step is someone opening a GCC feature request with some
>> more details - CC'ing me on ramana at gcc.gnu.org should work. What I would
>> like to see is a feature request on GCC bugzilla along with some
>> comments / buyin from the AArch64 kernel maintainers whether they would
>> like to see such a feature and what the behaviour should be and get some
>> feedback from the AArch64 GCC maintainers upstream before starting the
>> work.
>>
>> I think the following (unoptimized) or some derivative of this should work.
>>
>>         adrp    x19, __stack_chk_guard
>>         add     x19, x19, :lo12:__stack_chk_guard
>>         mrs     x2, tpidr_el1
>>         add     x2, x2, x19
>>         ldr     x2, [x2]
>>
>>
>> It's also not likely that this will be done in time for GCC 8 as we are
>> now in stage 4 and we're probably looking at GCC 9 for this assuming
>> this goes ahead.
>>
>> Hope this helps.
>>
>
> Thanks Ramana.
>
> I guess there is one snag here: if we get scheduled to another CPU
> between the mrs and the ldr, we will load the wrong value. I guess
> this is what Mark alluded to in his reference to atomics in the quoted
> email thread.
>
> Also, we select between tpidr_el2 and tpidr_el1 at runtime depending
> on whether VHE is available.
>
> So I guess it isn't as simple as I thought, unfortunately ...

OK, so I have done a bit of homework, and I think this shouldn't be
too difficult after all.

I realized that we don't really need per-CPU references to
__stack_chk_guard, given that we already keep the task struct pointer
in sp_el0. This means we should be able to do

mrs   x0, sp_el0
movz  x1, :abs_g0:__stack_chk_guard_tsk_offset
add   x0, x0, x1
ldr   x2, [x0]

where __stack_chk_guard_tsk_offset is exposed via an ELF symbol.
(Analogous to x86, this could be implemented at the GCC level using
arbitrary sysreg and symbol names to remain flexible)

So my next question (mainly to Ramana): would it be possible to emit
the mrs/movz/add sequence above from targetm.stack_protect_guard() in
a way that will allow expand_normal() to expand it in a useful manner
(e.g., as an INDIRECT_REF that can be matched by the memory_operand in
Aarch64's stack_protect_set)? If that is the case, we could implement
this in a GCC plugin in the kernel rather than relying on upstream GCC
changes (and having to commit to this ABI long term)
