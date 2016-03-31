From: glider@google.com (Alexander Potapenko)
Date: Thu, 31 Mar 2016 17:09:29 +0200
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160331142908.GG26532@leverpostej>
References: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
 <20160331142908.GG26532@leverpostej>
Message-ID: <CAG_fn=V+e=+-svWOCUirOy4SvBNgJR5JWCFDU3uE3aKwz9ihvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 4:29 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Thu, Mar 31, 2016 at 03:54:45PM +0200, Alexander Potapenko wrote:
>> Add ARCH_HAS_KCOV to ARM64 config. Disable instrumentation of
>> arch/arm64/lib/delay.c
>
> Why do we disable instrumentation of delay.c?
The main purpose of kcov is collecting coverage from syscalls. As far
as I understand, coverage of functions from delay.c doesn't
deterministically depend on the syscalls being called and their
arguments.
The initial kcov implementation
(https://github.com/torvalds/linux/commit/5c9a8750a6409c63a0f01d51a9024861022f6593)
disabled instrumentation of arch/x86/lib/delay.c, so I just copied
that chunk.

> What exactly does kcov instrumentation imply? Does it require certain
> data to be mapped or certain functions to be callable while instrumented
> functions are called?
Yes, there is __sanitizer_cov_trace_pc() that must be callable.
At boot time |current->kcov_mode| zero, so it virtually does nothing.

Currently kcov instrumentation is disabled for the following files:

arch/x86/boot/*
arch/x86/boot/compressed/*
arch/x86/entry/vdso/*
arch/x86/kernel/*
arch/x86/kernel/apic/*
arch/x86/kernel/cpu/common.c
arch/x86/kernel/cpu/perf_event.c
arch/x86/lib/delay.c
arch/x86/mm/tlb.c
arch/x86/realmode/rm/*

Only a handful of the above have corresponding files in arch/arm64:
arch/arm64/boot/*
arch/arm64/kernel/*
arch/arm64/lib/delay.c

My patch explicitly disables instrumentation for arch/arm64/lib/delay.c.
I never had problems with arch/arm64/boot/* and arch/arm64/kernel/* in
the 3.18 kernel, although instrumentation of the corresponding x86
code is claimed to cause boot-time hangs.
We can act conservatively and still disable instrumentation for these
two dirs just to make sure nothing breaks in the future.

> We have some C code that is run outside of the normal kernel context
> (e.g. EFI stub, KVM hyp code), and I suspect it may be necessary to
> disable instrumentation for those also.
EFI stub and a number of other files is already disabled by the
initial kcov patch.
I understand there might be some code specific to ARM64 that I may
have overlooked, so I'd be grateful if someone could try the patch out
with the upstream kernel.

WBR,
Alex

> Thanks,
> Mark.
>
>> Signed-off-by: Alexander Potapenko <glider@google.com>
>> ---
>>  arch/arm64/Kconfig      | 1 +
>>  arch/arm64/lib/Makefile | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 4f43622..c52aa61 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -7,6 +7,7 @@ config ARM64
>>       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>       select ARCH_HAS_ELF_RANDOMIZE
>>       select ARCH_HAS_GCOV_PROFILE_ALL
>> +     select ARCH_HAS_KCOV
>>       select ARCH_HAS_SG_CHAIN
>>       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>>       select ARCH_USE_CMPXCHG_LOCKREF
>> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
>> index c86b790..b407bc1 100644
>> --- a/arch/arm64/lib/Makefile
>> +++ b/arch/arm64/lib/Makefile
>> @@ -1,3 +1,6 @@
>> +# Produces uninteresting flaky coverage.
>> +KCOV_INSTRUMENT_delay.o      := n
>> +
>>  lib-y                := bitops.o clear_user.o delay.o copy_from_user.o       \
>>                  copy_to_user.o copy_in_user.o copy_page.o            \
>>                  clear_page.o memchr.o memcpy.o memmove.o memset.o    \
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra?e, 33
80636 M?nchen

Gesch?ftsf?hrer: Matthew Scott Sucherman, Paul Terence Manicle
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
