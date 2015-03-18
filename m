From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 Mar 2015 11:07:17 +0100
Subject: [PATCH v2 3/8] ARM: add macro to perform far branches (b/bl)
In-Reply-To: <1426248452-4773-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1426248452-4773-1-git-send-email-ard.biesheuvel@linaro.org>
 <1426248452-4773-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu9cU_cgD4AgndKKiFsCjkUyB9MKyP3kieZAY7y4t9kofw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 13:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> These macros execute PC-relative branches, but with a larger
> reach than the 24 bits that are available in the b and bl opcodes.
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/assembler.h | 83 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index f67fd3afebdf..2e7f55194782 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -88,6 +88,17 @@
>  #endif
>
>  /*
> + * The program counter is always ahead of the address of the currently
> + * executing instruction by PC_BIAS bytes, whose value differs depending
> + * on the execution mode.
> + */
> +#ifdef CONFIG_THUMB2_KERNEL
> +#define PC_BIAS                4
> +#else
> +#define PC_BIAS                8
> +#endif
> +
> +/*
>   * Enable and disable interrupts
>   */
>  #if __LINUX_ARM_ARCH__ >= 6
> @@ -108,6 +119,78 @@
>         .endm
>  #endif
>
> +       /*
> +        * Macros to emit relative conditional branches that may exceed the
> +        * range of the 24-bit immediate of the ordinary b/bl instructions.
> +        * NOTE: this doesn't work with locally defined symbols, as they
> +        * lack the ARM/Thumb annotation (even if they are annotated as
> +        * functions)
> +        */
> +       .macro  b_far, target, tmpreg, c=
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> +       movt\c  \tmpreg, #:upper16:(\target - (8888f + PC_BIAS))
> +       movw\c  \tmpreg, #:lower16:(\target - (8888f + PC_BIAS))
> +8888:  add\c   pc, pc, \tmpreg
> +#else
> +       ldr\c   \tmpreg, 8889f
> +8888:  add\c   pc, pc, \tmpreg
> +       .ifnb   \c
> +       b       8890f
> +       .endif
> +8889:  .long   \target - (8888b + PC_BIAS)
> +8890:
> +#endif
> +       .endm

Actually, I have found something better:

add\c \tmpreg, pc, #:pc_g0_nc:\target - PC_BIAS
add\c \tmpreg, \tmpreg, #:pc_g1_nc:\target - PC_BIAS + 4
add\c pc, \tmpreg, #:pc_g2:\target - PC_BIAS + 8

This uses a PC-relative group relocation to split the offset into
12-bit chunks and poke them into the add instructions
This way, we don't need the literal at all.

Note that add with pc as destination is ARM-only, so we should
probably retain the v7 movw/movt regardless


> +
> +       .macro  bl_far, target, c=
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> +       movt\c  ip, #:upper16:(\target - (8887f + PC_BIAS))
> +       movw\c  ip, #:lower16:(\target - (8887f + PC_BIAS))
> +8887:  add\c   ip, ip, pc
> +       blx\c   ip
> +#else
> +       adr\c   lr, 8887f
> +       b_far   \target, ip, \c
> +8887:
> +#endif
> +       .endm
> +
> +       /*
> +        * Macros to emit absolute conditional branches: these are preferred
> +        * over the far variants above because they use fewer instructions
> +        * and/or use implicit literals that the assembler can group together
> +        * to optimize cache utilization. However, they can only be used to
> +        * call functions at their link time address, which rules out early boot
> +        * code that executes with the MMU off.
> +        * The v7 variant uses a movt/movw pair to prevent potential D-cache
> +        * stalls on the literal, so using these macros is preferred over using
> +        * 'ldr pc, =XXX' directly (unless no scratch register is available)
> +        * NOTE: this doesn't work with locally defined symbols, as they
> +        * lack the ARM/Thumb annotation (even if they are annotated as
> +        * functions)
> +        */
> +       .macro  b_abs, target, tmpreg, c=
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> +       movt\c  \tmpreg, #:upper16:\target
> +       movw\c  \tmpreg, #:lower16:\target
> +       bx\c    \tmpreg
> +#else
> +       ldr\c   pc, =\target
> +#endif
> +       .endm
> +
> +       .macro  bl_abs, target, c=
> +#if defined(CONFIG_CPU_32v7) || defined(CONFIG_CPU_32v7M)
> +       movt\c  lr, #:upper16:\target
> +       movw\c  lr, #:lower16:\target
> +       blx\c   lr
> +#else
> +       adr\c   lr, BSYM(8886f)
> +       ldr\c   pc, =\target
> +8886:
> +#endif
> +       .endm
> +
>         .macro asm_trace_hardirqs_off
>  #if defined(CONFIG_TRACE_IRQFLAGS)
>         stmdb   sp!, {r0-r3, ip, lr}
> --
> 1.8.3.2
>
