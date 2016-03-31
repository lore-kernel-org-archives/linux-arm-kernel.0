From: glider@google.com (Alexander Potapenko)
Date: Thu, 31 Mar 2016 18:43:18 +0200
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=Vgvuaoz_jUNcyxvFdu4LpyO55AWmTzGvCVhOYoaX9y7Q@mail.gmail.com>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
 <20160331142908.GG26532@leverpostej>
 <CAG_fn=V+e=+-svWOCUirOy4SvBNgJR5JWCFDU3uE3aKwz9ihvw@mail.gmail.com>
 <20160331160052.GA26393@leverpostej>
 <CAG_fn=Vgvuaoz_jUNcyxvFdu4LpyO55AWmTzGvCVhOYoaX9y7Q@mail.gmail.com>
Message-ID: <CAG_fn=WEWLodT+5yc4O12nLmaTjK5DJfXuaPX2tgXmuhrGOyCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 6:33 PM, Alexander Potapenko <glider@google.com> wrote:
> On Thu, Mar 31, 2016 at 6:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Mar 31, 2016 at 05:09:29PM +0200, Alexander Potapenko wrote:
>>> On Thu, Mar 31, 2016 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> > Hi,
>>> >
>>> > On Thu, Mar 31, 2016 at 03:54:45PM +0200, Alexander Potapenko wrote:
>>> >> Add ARCH_HAS_KCOV to ARM64 config. Disable instrumentation of
>>> >> arch/arm64/lib/delay.c
>>> >
>>> > Why do we disable instrumentation of delay.c?
>>> The main purpose of kcov is collecting coverage from syscalls. As far
>>> as I understand, coverage of functions from delay.c doesn't
>>> deterministically depend on the syscalls being called and their
>>> arguments.
>>> The initial kcov implementation
>>> (https://github.com/torvalds/linux/commit/5c9a8750a6409c63a0f01d51a9024861022f6593)
>>> disabled instrumentation of arch/x86/lib/delay.c, so I just copied
>>> that chunk.
>>>
>>> > What exactly does kcov instrumentation imply? Does it require certain
>>> > data to be mapped or certain functions to be callable while instrumented
>>> > functions are called?
>>> Yes, there is __sanitizer_cov_trace_pc() that must be callable.
>>
>> That will definitely be a problem for the KVM code which is run at a
>> different exception level with a different memory map. For GCOV, KASAN,
>> and UBSAN we simply disable instrumentation of that code [1].
>>
>> We should be able to do similarly for KCOV.
> Ok, I'll send out the updated patch.
>
>>> At boot time |current->kcov_mode| zero, so it virtually does nothing.
>>>
>>> Currently kcov instrumentation is disabled for the following files:
>>
>>> arch/x86/boot/*
>>> arch/x86/boot/compressed/*
>>> arch/x86/entry/vdso/*
>>> arch/x86/realmode/rm/*
>>
>> These are executed outside of the usual kernel context / address space,
>> so excluding these makes sense to me.
>>
>>> arch/x86/kernel/*
>>> arch/x86/kernel/apic/*
>>> arch/x86/kernel/cpu/common.c
>>> arch/x86/kernel/cpu/perf_event.c
>>> arch/x86/lib/delay.c
>>> arch/x86/mm/tlb.c
>>
>> For these, it's not immediately clear to me why instrumentation is
>> disabled, so I don't know whether or not we can instrument the analogous
>> arm64 code.
> According to the comments in
> https://github.com/torvalds/linux/commit/5c9a8750a6409c63a0f01d51a9024861022f6593,
> instrumentation of arch/x86/kernel/apic/* and arch/x86/lib/delay.c
> leads to non-deterministic coverage, instrumenting others prevent the
> kernel from booting.
>
>>> Only a handful of the above have corresponding files in arch/arm64:
>>> arch/arm64/boot/*
>>> arch/arm64/kernel/*
>>> arch/arm64/lib/delay.c
>>
>> We have arch/arm64/kernel/perf_event.c, and a couple of other files that
>> are directly analogous, even if the paths don't quite line up.
> Ok, it makes sense to also disable arch/arm64/kernel/perf_event.c then.
... and certainly turn off instrumentation for the "couple of other files".
By the way, I've just noticed that arch/x86/kernel/cpu/perf_event.c
has moved, so the Makefile isn't accurate anymore.

>>> My patch explicitly disables instrumentation for arch/arm64/lib/delay.c.
>>> I never had problems with arch/arm64/boot/* and arch/arm64/kernel/* in
>>> the 3.18 kernel, although instrumentation of the corresponding x86
>>> code is claimed to cause boot-time hangs.
>>> We can act conservatively and still disable instrumentation for these
>>> two dirs just to make sure nothing breaks in the future.
>>
>> I'd rather that we understood why instrumentation of the above is
>> disabled, such that we can make a sensible decision from the outset.
>>
>>> > We have some C code that is run outside of the normal kernel context
>>> > (e.g. EFI stub, KVM hyp code), and I suspect it may be necessary to
>>> > disable instrumentation for those also.
>>> EFI stub and a number of other files is already disabled by the
>>> initial kcov patch.
>>> I understand there might be some code specific to ARM64 that I may
>>> have overlooked, so I'd be grateful if someone could try the patch out
>>> with the upstream kernel.
>>
>> The only such code that I'm immediately aware of is the hyp-context KVM
>> code, as mentioned above.
>>
>> Thanks,
>> Mark.
>>
>> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/416790.html
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra?e, 33
> 80636 M?nchen
>
> Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
