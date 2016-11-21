From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Mon, 21 Nov 2016 15:45:55 +0000
Subject: [RFC PATCH v2 4/8] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <20161104200321.li3gzztg6p6xkwuh@localhost>
References: <20161027163058.12156-1-kevin.brodsky@arm.com>
 <20161027163058.12156-5-kevin.brodsky@arm.com>
 <20161028110926.0176e0ea@xhacker>
 <22ae46f6-f881-63ec-388d-8a7f6cf9934d@arm.com>
 <20161104200321.li3gzztg6p6xkwuh@localhost>
Message-ID: <f5ff1b88-aba3-2c3a-f65f-66a2e00f4764@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/16 20:03, Catalin Marinas wrote:
> On Fri, Oct 28, 2016 at 11:20:07AM +0100, Kevin Brodsky wrote:
>> On 28/10/16 04:09, Jisheng Zhang wrote:
>>> On Thu, 27 Oct 2016 17:30:54 +0100 Kevin Brodsky wrote:
>>>> Provide the files necessary for building a compat (AArch32) vDSO in
>>>> kernel/vdso32.
>>>>
>>>> This is mostly an adaptation of the arm vDSO. The most significant
>>>> change in vgettimeofday.c is the use of the arm64 vdso_data struct,
>>>> allowing the vDSO data page to be shared between the 32 and 64-bit
>>>> vDSOs.
>>>>
>>>> In addition to the time functions, sigreturn trampolines are also
>>>> provided, aiming at replacing those in the vector page. To improve
>>>> debugging, CFI and unwinding directives are used, based on glibc's
>>>> implementation. Symbol offsets are made available to the kernel using
>>>> the same method as the 64-bit vDSO.
>>>>
>>>> There is unfortunately an important caveat to all this: we cannot get
>>>> away with hand-coding 32-bit instructions like in kernel/kuser32.S,
>>>> this time we really need a 32-bit compiler. The compat vDSO Makefile
>>>> relies on CROSS_COMPILE_ARM32 to provide a 32-bit compiler,
>>>> appropriate logic will be added to the arm64 Makefile later on to
>>>> ensure that an attempt to build the compat vDSO is made only if this
>>>> variable has been set properly.
>>>>
>>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> ---
>>>>    arch/arm64/kernel/vdso32/Makefile        | 121 +++++++++++++
>>>>    arch/arm64/kernel/vdso32/sigreturn.S     |  86 +++++++++
>>>>    arch/arm64/kernel/vdso32/vdso.S          |  32 ++++
>>>>    arch/arm64/kernel/vdso32/vdso.lds.S      |  98 +++++++++++
>>>>    arch/arm64/kernel/vdso32/vgettimeofday.c | 294 +++++++++++++++++++++++++++++++
>>>>    5 files changed, 631 insertions(+)
>>>>    create mode 100644 arch/arm64/kernel/vdso32/Makefile
>>>>    create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
>>>>    create mode 100644 arch/arm64/kernel/vdso32/vdso.S
>>>>    create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
>>>>    create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c
>>>>
>>>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>>>> new file mode 100644
>>>> index 000000000000..38facc870f6e
>>>> --- /dev/null
>>>> +++ b/arch/arm64/kernel/vdso32/Makefile
>>>> @@ -0,0 +1,121 @@
>>>> +#
>>>> +# Building a vDSO image for AArch32.
>>>> +#
>>>> +# Author: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> +# A mix between the arm64 and arm vDSO Makefiles.
>>>> +
>>>> +CC_ARM32 := $(CROSS_COMPILE_ARM32)gcc
>>>> +
>>>> +# Same as cc-ldoption, but using CC_ARM32 instead of CC
>>>> +cc32-ldoption = $(call try-run,\
>>>> +        $(CC_ARM32) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>>>> +
>>>> +# Borrow vdsomunge.c from the arm vDSO
>>>> +munge := arch/arm/vdso/vdsomunge
>>>> +hostprogs-y := $(srctree)/$(munge)
>>>> +
>>>> +c-obj-vdso := vgettimeofday.o
>>>> +asm-obj-vdso := sigreturn.o
>>>> +
>>>> +# Build rules
>>>> +targets := $(c-obj-vdso) $(asm-obj-vdso) vdso.so vdso.so.dbg vdso.so.raw
>>>> +c-obj-vdso := $(addprefix $(obj)/, $(c-obj-vdso))
>>>> +asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
>>>> +obj-vdso := $(c-obj-vdso) $(asm-obj-vdso)
>>>> +
>>>> +ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
>>>> +ccflags-y += -DDISABLE_BRANCH_PROFILING
>>>> +
>>>> +# Force -O2 to avoid libgcc dependencies
>>>> +VDSO_CFLAGS := -march=armv8-a -O2
>>> For completeness, bringing 32bit compiler need to check whether the 32bit
>>> toolchain support some options. IIRC, armv8-a support isn't enabled until
>>> gcc 4.8, so old toolchains such gcc-4.7 will complain:
>>>    error: unrecognized argument in option ?-march=armv8-a?
>> That's a fair point. I guess -march=armv8-a is not strictly necessary and
>> the produced vDSO should be fine if arch/arm/vdso also compiles fine.
>> However we would still need to pass -march=armv7-a. I'm not sure what to do
>> between:
>> * Checking that the compiler supports -march=armv8-a when inspecting
>> CROSS_COMPILE_ARM32, and if it doesn't vdso32 will not be built.
>> * Checking whether -march=armv8-a is available here, and if it is not fall
>> back to -march=armv7-a.
> Does v8 vs v7 make any difference in the generated code? If not, we
> could just stick to armv7-a permanently.

I've just tried compiling with -march=armv7-a, and in fact it doesn't compile at all. 
It turns out vgettimeofday.c uses smp_rmb(), which expands to dmb ishld on arm64, and 
ishld doesn't exist in ARMv7. We could possibly work around that, but I think 
requiring GCC 4.8 is reasonable.

Thanks,
Kevin
