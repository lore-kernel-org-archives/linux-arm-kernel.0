From: glider@google.com (Alexander Potapenko)
Date: Tue, 14 Jun 2016 20:16:08 +0200
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <20160614175543.GA2468@leverpostej>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
Message-ID: <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 7:55 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jun 14, 2016 at 06:57:21PM +0200, Alexander Potapenko wrote:
>> Add ARCH_HAS_KCOV to ARM64 config. To avoid crashes, disable
>> instrumentation of the following files:
>>
>> arch/arm64/boot/*
>> arch/arm64/kvm/hyp/*
>>
>> Signed-off-by: Alexander Potapenko <glider@google.com>
>> ---
>> v2: - disable instrumentation of arch/arm64/{boot,kvm/hyp}
>>     - enable instrumentation of arch/arm64/lib/delay.c
>> ---
>>  arch/arm64/Kconfig          | 1 +
>>  arch/arm64/boot/Makefile    | 4 ++++
>>  arch/arm64/kvm/hyp/Makefile | 4 ++++
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 5a0a691..eb0b0a0 100644
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
>> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
>> index 305c552..74cec89 100644
>> --- a/arch/arm64/boot/Makefile
>> +++ b/arch/arm64/boot/Makefile
>> @@ -14,6 +14,10 @@
>>  # Based on the ia64 boot/Makefile.
>>  #
>>
>> +# Avoid potential boot-time problems with kcov instrumentation. We are mostly
>> +# interested in syscall coverage, so boot code is not interesting anyway.
>> +KCOV_INSTRUMENT              := n
>
> We have no code under our boot directory, so I don't think the changes
> to arch/arm64/boot are necessary.
Indeed we don't! Removed that.
>> +
>>  targets := Image Image.gz
>>
>>  $(obj)/Image: vmlinux FORCE
>> diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
>> index 778d0ef..0c85feb 100644
>> --- a/arch/arm64/kvm/hyp/Makefile
>> +++ b/arch/arm64/kvm/hyp/Makefile
>> @@ -17,6 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
>>  obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
>>  obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
>>
>> +# KVM code is run at a different exception code with a different map, so
>> +# compiler instrumentation that inserts callbacks or checks into the code may
>> +# cause crashes. Just disable it.
>>  GCOV_PROFILE := n
>>  KASAN_SANITIZE       := n
>>  UBSAN_SANITIZE       := n
>> +KCOV_INSTRUMENT      := n
>
> This looks sane to me.
>
> With VHE this code _may_ run in the same memory map as the kernel, but
> it's not something we can determine at compile time.
>
> Otherwise, I believe that the rest of the C code under arch/arm64 runs
> in the usual kernel memory map (including the special case of kaslr.c),
> and the EFI stub code has already been covered, so I'm not immediately
> aware of anything else that needs to be special-cased.
>
> I built and booted (via EFI) a kernel with this feature enabled (also
> with the boot/Makefile change removed). I haven't tested the feature
> itself as such, as I'm not sure how to do that.
You can test it by running the test program from Documentation/kcov.txt.

> FWIW, with the boot/Makefile change removed, feel free to add:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
Thank you!
I'll wait till tomorrow for others to comment, and then will send the
updated version.
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
