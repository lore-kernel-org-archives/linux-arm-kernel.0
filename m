From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 26 Apr 2018 15:47:49 +0200
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
Message-ID: <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 3:40 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Dmitry,
>
> On Thu, Apr 26, 2018 at 03:08:46PM +0200, Dmitry Vyukov wrote:
>> KCOV is code coverage collection facility used, in particular, by syzkaller
>> system call fuzzer. There is some interest in using syzkaller on arm devices.
>> So port KCOV to arm.
>>
>> On implementation level this merely declares that KCOV is supported and
>> disables instrumentation of 3 special cases. Reasons for disabling are
>> commented in code.
>>
>> Tested with qemu-system-arm/vexpress-a15.
>>
>> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Abbott Liu <liuwenliang@huawei.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Koguchi Takuo <takuo.koguchi.sw@hitachi.com>
>> Cc: Atul Prakash <atulp@google.com>
>> Cc: linux at armlinux.org.uk
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: syzkaller at googlegroups.com
>> ---
>>  arch/arm/Kconfig                  | 1 +
>>  arch/arm/boot/compressed/Makefile | 3 +++
>>  arch/arm/mm/Makefile              | 4 ++++
>>  arch/arm/vdso/Makefile            | 3 +++
>>  4 files changed, 11 insertions(+)
>
> The hyp code will also need to opt-out of KCOV instrumentation.
>
> i.e. arch/arm/kvm/hyp/Makefile will need:
>
> KCOV_INSTRUMENT := n
>
> ... and we should probably pick up the other bits from the arm64 hyp
> Makefile, i.e. all of:
>
> # KVM code is run at a different exception code with a different map, so
> # compiler instrumentation that inserts callbacks or checks into the code may
> # cause crashes. Just disable it.
> GCOV_PROFILE    := n
> KASAN_SANITIZE  := n
> UBSAN_SANITIZE  := n
> KCOV_INSTRUMENT := n

I can blindly add them if you wish, but I don't have a way to test it.
I also need an explanatory comment as to why we disable this.
Otherwise I have to say "Mark said so" :)

p.s. KASAN does not exist on arm (yet).

>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a7f8e7f4b88f..60558a6bb744 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -105,6 +105,7 @@ config ARM
>>       select REFCOUNT_FULL
>>       select RTC_LIB
>>       select SYS_SUPPORTS_APM_EMULATION
>> +     select ARCH_HAS_KCOV
>>       # Above selects are sorted alphabetically; please add new ones
>>       # according to that.  Thanks.
>>       help
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
>> index 45a6b9b7af2a..5219700e9161 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -25,6 +25,9 @@ endif
>>
>>  GCOV_PROFILE         := n
>>
>> +# Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>> +KCOV_INSTRUMENT              := n
>> +
>>  #
>>  # Architecture dependencies
>>  #
>> diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
>> index 9dbb84923e12..e8be5d904ac7 100644
>> --- a/arch/arm/mm/Makefile
>> +++ b/arch/arm/mm/Makefile
>> @@ -8,6 +8,10 @@ obj-y                                += dma-mapping$(MMUEXT).o
>>  obj-$(CONFIG_MMU)            += fault-armv.o flush.o idmap.o ioremap.o \
>>                                  mmap.o pgd.o mmu.o pageattr.o
>>
>> +# Instrumenting fault.c causes infinite recursion between:
>> +# __dabt_svc -> do_DataAbort -> __sanitizer_cov_trace_pc -> __dabt_svc
>> +KCOV_INSTRUMENT_fault.o := n
>
> Why does __sanitizer_cov_trace_pc() cause a data abort?
>
> We don't seem to have this issue on arm64, where our fault handling is
> instrumented, so this seems suspect.


I don't have an explanation. That's just what me and Takuo observed.
We've seen that it happens when __sanitizer_cov_trace_pc tries to
dereference current to check kcov mode.
