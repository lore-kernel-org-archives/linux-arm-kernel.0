From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Nov 2018 10:16:12 +0100
Subject: [PATCH 0/3] arm64: use subsections instead of function calls for
 LL/SC fallbacks
In-Reply-To: <20181127193054.GF5641@arm.com>
References: <20181113233923.20098-1-ard.biesheuvel@linaro.org>
 <20181127193054.GF5641@arm.com>
Message-ID: <CAKv+Gu89wROHY2NXO-raB3zwMqdc9soExGCnj8GyZd4stm3zrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2018 at 20:30, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> On Tue, Nov 13, 2018 at 03:39:20PM -0800, Ard Biesheuvel wrote:
> > Refactor the LL/SC atomics code so we can emit the LL/SC fallbacks for the
> > LSE atomics as subsections that get instantiated at each call site rather
> > than as out of line functions that get called from inline asm (without the
> > awareness of the compiler)
> >
> > This should allow slightly better LSE code, and removes stack spilling and
> > potential PLT indirection for the LL/SC fallbacks.
>
> Thanks, I much prefer using subsections to the current approach. However,
> a downside of your patches is that the some of the asm operands passed
> to the LSE implementation are redundant, for example, in the fetch-ops:
>
> "       " #lse_op #ac #rl " %w[i], %w[res], %[v]")                      \
>         : [res]"=&r" (result), [val]"=&r" (val), [tmp]"=&r" (tmp),      \
>           [v]"+Q" (v->counter)                                          \
>

That applies to most of the ops, but note that
- compared to the current situation, where x16, x17 and x30 are always
considered clobbered, the situation actually improves in some cases,
and doesn't get worse in any of them
- i tweaked the patterns a bit so that, for instance in the example
you quote, [i] is now only an input register, which may permit the
compiler to reuse a live register holding the value of i

> I'd have thought we could avoid this by splitting up the asms and using
> a static key to dispatch them. For example, the really crude hacking
> below resulted in reasonable code generation:
>
> 000000000000040 <will_atomic_add>:
>   40:   14000004        b       50 <will_atomic_add+0x10>       // Patched with NOP once features are determined
>   44:   14000007        b       60 <will_atomic_add+0x20>       // Patched with NOP if LSE
>   48:   b820003f        stadd   w0, [x1]
>   4c:   d65f03c0        ret
>   50:   90000002        adrp    x2, 0 <cpu_hwcaps>
>   54:   f9400042        ldr     x2, [x2]
>   58:   721b005f        tst     w2, #0x20
>   5c:   54ffff61        b.ne    48 <will_atomic_add+0x8>  // b.any
>   60:   14000002        b       68 <will_atomic_add+0x28>
>   64:   d65f03c0        ret
>   68:   f9800031        prfm    pstl1strm, [x1]
>   6c:   885f7c22        ldxr    w2, [x1]
>   70:   0b000042        add     w2, w2, w0
>   74:   88037c22        stxr    w3, w2, [x1]
>   78:   35ffffa3        cbnz    w3, 6c <will_atomic_add+0x2c>
>   7c:   17fffffa        b       64 <will_atomic_add+0x24>
>
> So if we tweaked the existing code so that we can generate the LL/SC
> versions either in a subsection or not depending on LSE, then we could
> probably play this sort of trick using a static key.
>
> What do you think?
>

If you inline that function, the register allocation will be exactly
the same, no? The compiler will still need to spill whatever is in the
registers that the LL/SC code may use if executed. Or will it only do
so when taking that path?

Also, AIUI, the point was to optimize for LSE, and fall back to LL/SC
(potentially taking a slight performance hit in doing so). Does the
compiler actually move the unlikely path out of line? I can't tell
from just this function, but if it doesn't, the ret at 0x4c will
become another branch in reality, branching over the LL/SC code

So it really depends on how well the compiler behaves when emitting
these inline. Does it really help that much to use fewer registers?
Enough to justify adding unconditional branches, and potentially lower
I-cache utilization?

> --->8
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 7e2ec64aa414..ec7bfa40ee85 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -369,7 +369,7 @@ static inline bool __cpus_have_const_cap(int num)
>  {
>         if (num >= ARM64_NCAPS)
>                 return false;
> -       return static_branch_unlikely(&cpu_hwcap_keys[num]);
> +       return static_branch_likely(&cpu_hwcap_keys[num]);
>  }
>
>  static inline bool cpus_have_cap(unsigned int num)
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f4fc1e0544b7..f44080ef7188 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -405,3 +405,36 @@ static int __init register_kernel_offset_dumper(void)
>         return 0;
>  }
>  __initcall(register_kernel_offset_dumper);
> +
> +static inline void ll_sc_atomic_add(int i, atomic_t *v)
> +{
> +       unsigned long tmp;
> +       int result;
> +
> +       asm volatile(
> +"      b       3f\n"
> +"      .subsection 1\n"
> +"3:    prfm    pstl1strm, %2\n"
> +"1:    ldxr    %w0, %2\n"
> +"      add     %w0, %w0, %w3\n"
> +"      stxr    %w1, %w0, %2\n"
> +"      cbnz    %w1, 1b\n"
> +"      b       4f\n"
> +"      .previous\n"
> +"4:"
> +       : "=&r" (result), "=&r" (tmp), "+Q" (v->counter)
> +       : "Ir" (i));
> +}
> +
> +void will_atomic_add(int i, atomic_t *v)
> +{
> +       if (!cpus_have_const_cap(ARM64_HAS_LSE_ATOMICS)) {
> +               ll_sc_atomic_add(i, v);
> +       } else {
> +               asm volatile("stadd     %w[i], %[v]"
> +               : [v] "+Q" (v->counter)
> +               : [i] "r" (i));
> +       }
> +
> +       return;
> +}
