From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Dec 2015 13:46:22 +0100
Subject: [PATCH] ARM64: Fix compiling with GCC 6 and Atomics enabled
In-Reply-To: <20151221123843.GM23092@arm.com>
References: <1450498655-3820-1-git-send-email-apinski@cavium.com>
 <20151221123843.GM23092@arm.com>
Message-ID: <CAKv+Gu_aUvckKpwWw+Xo5VkFEA8-uT9xU0-m5NgAzAc1d53uhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 December 2015 at 13:38, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Dec 18, 2015 at 08:17:35PM -0800, Andrew Pinski wrote:
>> The problem here is that GCC 6 and above emits .arch now
>> for each function so now the global .arch_extension has
>> no effect.  This fixes the problem by putting
>> .arch_extension inside ARM64_LSE_ATOMIC_INSN so
>> it is enabled for each place where LSE is used.
>
> Hmm, this is going to affect arch/arm/ much more heavily than arch/arm64.
> .arch_extension is used for virt, mp and sec over there, and it may be
> tricky to isolate the actual instruction usage (at least, virt looks
> lost in kvm/arm.c).
>
> Why can't gas have an option to accept all instruction encodings that it
> knows about, inspite of any .arch directives?
>

Modern GAS supports things like -march=armv7-a+mp+sec+virt, so it
probably makes sense to pass that on the command line when building
for v7 (or +sec only for v6) if the assembler is found to support it
at build time.


>> Signed-off-by: Andrew Pinski <apinski@cavium.com>
>> ---
>>  arch/arm64/include/asm/lse.h |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
>> index 3de42d6..625601f 100644
>> --- a/arch/arm64/include/asm/lse.h
>> +++ b/arch/arm64/include/asm/lse.h
>> @@ -17,8 +17,6 @@
>>
>>  #else        /* __ASSEMBLER__ */
>>
>> -__asm__(".arch_extension     lse");
>> -
>>  /* Move the ll/sc atomics out-of-line */
>>  #define __LL_SC_INLINE
>>  #define __LL_SC_PREFIX(x)    __ll_sc_##x
>> @@ -29,7 +27,7 @@ __asm__(".arch_extension    lse");
>>
>>  /* In-line patching at runtime */
>>  #define ARM64_LSE_ATOMIC_INSN(llsc, lse)                             \
>> -     ALTERNATIVE(llsc, lse, ARM64_HAS_LSE_ATOMICS)
>> +     ALTERNATIVE(".arch_extension        lse\n" llsc, lse, ARM64_HAS_LSE_ATOMICS)
>>
>>  #endif       /* __ASSEMBLER__ */
>>  #else        /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
>> --
>> 1.7.2.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
