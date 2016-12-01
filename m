From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu, 1 Dec 2016 14:27:40 +0000
Subject: [RFC PATCH v2 4/8] arm64: compat: Add a 32-bit vDSO
In-Reply-To: <20161121184414.GC28723@e104818-lin.cambridge.arm.com>
References: <20161027163058.12156-1-kevin.brodsky@arm.com>
 <20161027163058.12156-5-kevin.brodsky@arm.com>
 <20161028110926.0176e0ea@xhacker>
 <22ae46f6-f881-63ec-388d-8a7f6cf9934d@arm.com>
 <20161104200321.li3gzztg6p6xkwuh@localhost>
 <f5ff1b88-aba3-2c3a-f65f-66a2e00f4764@arm.com>
 <20161121184414.GC28723@e104818-lin.cambridge.arm.com>
Message-ID: <70668250-d51b-a879-8ebf-66a07c178718@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/16 18:44, Catalin Marinas wrote:
> On Mon, Nov 21, 2016 at 03:45:55PM +0000, Kevin Brodsky wrote:
>> On 04/11/16 20:03, Catalin Marinas wrote:
>>> On Fri, Oct 28, 2016 at 11:20:07AM +0100, Kevin Brodsky wrote:
>>>> On 28/10/16 04:09, Jisheng Zhang wrote:
>>>>> On Thu, 27 Oct 2016 17:30:54 +0100 Kevin Brodsky wrote:
>>>>>> +# Force -O2 to avoid libgcc dependencies
>>>>>> +VDSO_CFLAGS := -march=armv8-a -O2
>>>>> For completeness, bringing 32bit compiler need to check whether the 32bit
>>>>> toolchain support some options. IIRC, armv8-a support isn't enabled until
>>>>> gcc 4.8, so old toolchains such gcc-4.7 will complain:
>>>>>    error: unrecognized argument in option ?-march=armv8-a?
>>>> That's a fair point. I guess -march=armv8-a is not strictly necessary and
>>>> the produced vDSO should be fine if arch/arm/vdso also compiles fine.
>>>> However we would still need to pass -march=armv7-a. I'm not sure what to do
>>>> between:
>>>> * Checking that the compiler supports -march=armv8-a when inspecting
>>>> CROSS_COMPILE_ARM32, and if it doesn't vdso32 will not be built.
>>>> * Checking whether -march=armv8-a is available here, and if it is not fall
>>>> back to -march=armv7-a.
>>> Does v8 vs v7 make any difference in the generated code? If not, we
>>> could just stick to armv7-a permanently.
>> I've just tried compiling with -march=armv7-a, and in fact it doesn't
>> compile at all. It turns out vgettimeofday.c uses smp_rmb(), which expands
>> to dmb ishld on arm64, and ishld doesn't exist in ARMv7. We could possibly
>> work around that, but I think requiring GCC 4.8 is reasonable.
> Since vgettimeofday.c is meant to be compiled for AArch32, it wouldn't
> look too bad to define its own barriers rather than relying on the
> AArch64 ones. So you could define v7_smp_rmb/v7_smp_wmb and use them in
> this file. Alternatively, replace smp_rmb() with smp_mb() in this file
> but with a big comment about ARMv7 compilation requirement and "ishld"
> not being available.

Fair enough. I'll add AArch32 barrier macros and compile with -march=armv7-a if the 
compiler doesn't support armv8-a. It's true that using arm64 barrier macros in 32-bit 
code is a bit dodgy anyway.

Cheers,
Kevin
