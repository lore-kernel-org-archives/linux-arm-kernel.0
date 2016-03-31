From: glider@google.com (Alexander Potapenko)
Date: Thu, 31 Mar 2016 19:18:45 +0200
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160331171434.GC26393@leverpostej>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
 <20160331142908.GG26532@leverpostej>
 <CAG_fn=V+e=+-svWOCUirOy4SvBNgJR5JWCFDU3uE3aKwz9ihvw@mail.gmail.com>
 <20160331160052.GA26393@leverpostej>
 <CAG_fn=Vgvuaoz_jUNcyxvFdu4LpyO55AWmTzGvCVhOYoaX9y7Q@mail.gmail.com>
 <20160331171434.GC26393@leverpostej>
Message-ID: <CAG_fn=UGRMM-dJYNO3RF5zcC5p=x-+5yvk+KqU5aRbAH9p+pHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 7:14 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 31, 2016 at 06:33:24PM +0200, Alexander Potapenko wrote:
>> On Thu, Mar 31, 2016 at 6:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Thu, Mar 31, 2016 at 05:09:29PM +0200, Alexander Potapenko wrote:
>> >> Currently kcov instrumentation is disabled for the following files:
>> >
>> >> arch/x86/boot/*
>> >> arch/x86/boot/compressed/*
>> >> arch/x86/entry/vdso/*
>> >> arch/x86/realmode/rm/*
>> >
>> > These are executed outside of the usual kernel context / address space,
>> > so excluding these makes sense to me.
>> >
>> >> arch/x86/kernel/*
>> >> arch/x86/kernel/apic/*
>> >> arch/x86/kernel/cpu/common.c
>> >> arch/x86/kernel/cpu/perf_event.c
>> >> arch/x86/lib/delay.c
>> >> arch/x86/mm/tlb.c
>> >
>> > For these, it's not immediately clear to me why instrumentation is
>> > disabled, so I don't know whether or not we can instrument the analogous
>> > arm64 code.
>> According to the comments in
>> https://github.com/torvalds/linux/commit/5c9a8750a6409c63a0f01d51a9024861022f6593,
>> instrumentation of arch/x86/kernel/apic/* and arch/x86/lib/delay.c
>> leads to non-deterministic coverage,
>
> To what extent does determinism matter? Are we just ruling out the worst
> cases, or is this likely to turn into a whack-a-mole game?
I guess we'd better ask Dmitry who excluded these files on x86 and
experimented with coverage a lot.
Dmitry, can you clarify this, please?
> Do we exclude clocksources and other driver code?
>
> Looking at the arm64 delay timer code, it looks like everything will be
> inlined (and therefore coverage should be deterministic so long as the
> delay functions are called deterministically). That said, the same looks
> basically true of the x86 code, so I guess I've misunderstood.
>
>> instrumenting others prevent the kernel from booting.
>
> I haven't been able to come up with a scenario whereby kcov would be
> fatal for the above, so it's difficult to say if we have equivalent
> problems.
>
> For reference, do we have any examples as to why any of these prevent
> booting?
Not sure there's any documentation so far except for the comments in
the original kcov patch.

>> >> Only a handful of the above have corresponding files in arch/arm64:
>> >> arch/arm64/boot/*
>> >> arch/arm64/kernel/*
>> >> arch/arm64/lib/delay.c
>> >
>> > We have arch/arm64/kernel/perf_event.c, and a couple of other files that
>> > are directly analogous, even if the paths don't quite line up.
>> Ok, it makes sense to also disable arch/arm64/kernel/perf_event.c then.
>
> Potentially, though it really depends on why it was excluded on x86.
>
> Some of the arm64 perf code lives in drivers/perf/arm_pmu.c, also.
>
> Thanks,
> Mark.



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
