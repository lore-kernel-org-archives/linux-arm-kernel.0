From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 23:09:18 +0100
Subject: [PATCH v2] arm64: lse: deal with clobbered x16 register after
 branch via PLT
In-Reply-To: <1456429733-20825-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456429733-20825-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_e7+PUu8YwWvEMVuHqpEo8NMYoAmyuOT3eU3cXhNOJGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 at 20:48, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> The LSE atomics implementation uses runtime patching to patch in calls
> to out of line non-LSE atomics implementations on cores that lack hardware
> support for LSE. To avoid paying the overhead cost of a function call even
> if no call ends up being made, the bl instruction is kept invisible to the
> compiler, and the out of line implementations preserve all registers, not
> just the ones that they are required to preserve as per the AAPCS64.
>
> However, commit fd045f6cd98e ("arm64: add support for module PLTs") added
> support for routing branch instructions via veneers if the branch target
> offset exceeds the range of the ordinary relative branch instructions.
> Since this deals with jump and call instructions that are exposed to ELF
> relocations, the PLT code uses x16 to hold the address of the branch target
> when it performs an indirect branch-to-register, something which is
> explicitly allowed by the AAPCS64 (and ordinary compiler generated code
> does not expect register x16 or x17 to retain their values across a bl
> instruction).
>
> Since the lse runtime patched bl instructions don't adhere to the AAPCS64,
> they don't deal with this clobbering of registers x16 and x17. So add them
> to the clobber list of the asm() statements that perform the call
> instructions, and drop x16 and x17 from the list of registers that are
> caller saved in the out of line non-LSE implementations.
>
> In addition, since we have given these functions two scratch registers,
> they no longer need to stack/unstack temp registers, and the only remaining
> stack accesses are for the frame pointer. So pass -fomit-frame-pointer as
> well, this eliminates all stack accesses from these functions.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: added x17 and -fomit-frame-pointer
>

Actually, it appears the -fomit-frame-pointer is not even necessary:
the compiler will only generate the stack frame if it needs to stack
other registers as well, and with x16 and x17 available, it does not
need to preserve x30, resulting in the 'after' code below


> Before:
> 0000000000000000 <__ll_sc_atomic_add>:
>    0:   a9be7bfd        stp     x29, x30, [sp,#-32]!
>    4:   910003fd        mov     x29, sp
>    8:   f9000be8        str     x8, [sp,#16]
>    c:   f9800031        prfm    pstl1strm, [x1]
>   10:   885f7c28        ldxr    w8, [x1]
>   14:   0b000108        add     w8, w8, w0
>   18:   881e7c28        stxr    w30, w8, [x1]
>   1c:   35ffffbe        cbnz    w30, 10 <__ll_sc_atomic_add+0x10>
>   20:   f9400be8        ldr     x8, [sp,#16]
>   24:   a8c27bfd        ldp     x29, x30, [sp],#32
>   28:   d65f03c0        ret
>   2c:   d503201f        nop
>
> After:
> 0000000000000000 <__ll_sc_atomic_add>:
>    0:   f9800031        prfm    pstl1strm, [x1]
>    4:   885f7c31        ldxr    w17, [x1]
>    8:   0b000231        add     w17, w17, w0
>    c:   88107c31        stxr    w16, w17, [x1]
>   10:   35ffffb0        cbnz    w16, 4 <__ll_sc_atomic_add+0x4>
>   14:   d65f03c0        ret
>
>  arch/arm64/include/asm/atomic_lse.h | 38 ++++++++++----------
>  arch/arm64/lib/Makefile             |  2 +-
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 197e06afbf71..7af60139f718 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -36,7 +36,7 @@ static inline void atomic_andnot(int i, atomic_t *v)
>         "       stclr   %w[i], %[v]\n")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic_or(int i, atomic_t *v)
> @@ -48,7 +48,7 @@ static inline void atomic_or(int i, atomic_t *v)
>         "       stset   %w[i], %[v]\n")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic_xor(int i, atomic_t *v)
> @@ -60,7 +60,7 @@ static inline void atomic_xor(int i, atomic_t *v)
>         "       steor   %w[i], %[v]\n")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic_add(int i, atomic_t *v)
> @@ -72,7 +72,7 @@ static inline void atomic_add(int i, atomic_t *v)
>         "       stadd   %w[i], %[v]\n")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  #define ATOMIC_OP_ADD_RETURN(name, mb, cl...)                          \
> @@ -90,7 +90,7 @@ static inline int atomic_add_return##name(int i, atomic_t *v)         \
>         "       add     %w[i], %w[i], w30")                             \
>         : [i] "+r" (w0), [v] "+Q" (v->counter)                          \
>         : "r" (x1)                                                      \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30", ##cl);                                   \
>                                                                         \
>         return w0;                                                      \
>  }
> @@ -116,7 +116,7 @@ static inline void atomic_and(int i, atomic_t *v)
>         "       stclr   %w[i], %[v]")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic_sub(int i, atomic_t *v)
> @@ -133,7 +133,7 @@ static inline void atomic_sub(int i, atomic_t *v)
>         "       stadd   %w[i], %[v]")
>         : [i] "+r" (w0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  #define ATOMIC_OP_SUB_RETURN(name, mb, cl...)                          \
> @@ -153,7 +153,7 @@ static inline int atomic_sub_return##name(int i, atomic_t *v)               \
>         "       add     %w[i], %w[i], w30")                             \
>         : [i] "+r" (w0), [v] "+Q" (v->counter)                          \
>         : "r" (x1)                                                      \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30" , ##cl);                                  \
>                                                                         \
>         return w0;                                                      \
>  }
> @@ -177,7 +177,7 @@ static inline void atomic64_andnot(long i, atomic64_t *v)
>         "       stclr   %[i], %[v]\n")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic64_or(long i, atomic64_t *v)
> @@ -189,7 +189,7 @@ static inline void atomic64_or(long i, atomic64_t *v)
>         "       stset   %[i], %[v]\n")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic64_xor(long i, atomic64_t *v)
> @@ -201,7 +201,7 @@ static inline void atomic64_xor(long i, atomic64_t *v)
>         "       steor   %[i], %[v]\n")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic64_add(long i, atomic64_t *v)
> @@ -213,7 +213,7 @@ static inline void atomic64_add(long i, atomic64_t *v)
>         "       stadd   %[i], %[v]\n")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  #define ATOMIC64_OP_ADD_RETURN(name, mb, cl...)                                \
> @@ -231,7 +231,7 @@ static inline long atomic64_add_return##name(long i, atomic64_t *v) \
>         "       add     %[i], %[i], x30")                               \
>         : [i] "+r" (x0), [v] "+Q" (v->counter)                          \
>         : "r" (x1)                                                      \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30", ##cl);                                   \
>                                                                         \
>         return x0;                                                      \
>  }
> @@ -257,7 +257,7 @@ static inline void atomic64_and(long i, atomic64_t *v)
>         "       stclr   %[i], %[v]")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  static inline void atomic64_sub(long i, atomic64_t *v)
> @@ -274,7 +274,7 @@ static inline void atomic64_sub(long i, atomic64_t *v)
>         "       stadd   %[i], %[v]")
>         : [i] "+r" (x0), [v] "+Q" (v->counter)
>         : "r" (x1)
> -       : "x30");
> +       : "x16", "x17", "x30");
>  }
>
>  #define ATOMIC64_OP_SUB_RETURN(name, mb, cl...)                                \
> @@ -294,7 +294,7 @@ static inline long atomic64_sub_return##name(long i, atomic64_t *v) \
>         "       add     %[i], %[i], x30")                               \
>         : [i] "+r" (x0), [v] "+Q" (v->counter)                          \
>         : "r" (x1)                                                      \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30", ##cl);                                   \
>                                                                         \
>         return x0;                                                      \
>  }
> @@ -330,7 +330,7 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
>         "2:")
>         : [ret] "+&r" (x0), [v] "+Q" (v->counter)
>         :
> -       : "x30", "cc", "memory");
> +       : "x16", "x17", "x30", "cc", "memory");
>
>         return x0;
>  }
> @@ -359,7 +359,7 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,       \
>         "       mov     %" #w "[ret], " #w "30")                        \
>         : [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr)             \
>         : [old] "r" (x1), [new] "r" (x2)                                \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30", ##cl);                                   \
>                                                                         \
>         return x0;                                                      \
>  }
> @@ -416,7 +416,7 @@ static inline long __cmpxchg_double##name(unsigned long old1,               \
>           [v] "+Q" (*(unsigned long *)ptr)                              \
>         : [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),             \
>           [oldval1] "r" (oldval1), [oldval2] "r" (oldval2)              \
> -       : "x30" , ##cl);                                                \
> +       : "x16", "x17", "x30", ##cl);                                   \
>                                                                         \
>         return x0;                                                      \
>  }
> diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> index 1a811ecf71da..d323a82c4ac3 100644
> --- a/arch/arm64/lib/Makefile
> +++ b/arch/arm64/lib/Makefile
> @@ -15,4 +15,4 @@ CFLAGS_atomic_ll_sc.o := -fcall-used-x0 -ffixed-x1 -ffixed-x2         \
>                    -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9           \
>                    -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12   \
>                    -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15   \
> -                  -fcall-saved-x16 -fcall-saved-x17 -fcall-saved-x18
> +                  -fcall-saved-x18 -fomit-frame-pointer
> --
> 2.5.0
>
