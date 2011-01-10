From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 10 Jan 2011 16:20:46 -0600
Subject: [PATCH 4/4] ARM: support for Thumb-2 instructions with
	CONFIG_ARM_PATCH_PHYS_VIRT
In-Reply-To: <1294129208-15201-5-git-send-email-nico@fluxnic.net>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-5-git-send-email-nico@fluxnic.net>
Message-ID: <AANLkTi=g+Wf7T60=nLeCpuPtYebZhE5URr4t2T6zzsCC@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 4, 2011 at 2:20 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/Kconfig              |    3 +--
>  arch/arm/include/asm/memory.h |    5 +++--
>  arch/arm/kernel/head.S        |   31 +++++++++++++++++++++++++++----
>  3 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 136ed9b..feb374a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -189,8 +189,7 @@ config VECTORS_BASE
>
>  config ARM_PATCH_PHYS_VIRT
>        bool
> -       depends on EXPERIMENTAL
> -       depends on !XIP && !THUMB2_KERNEL
> +       depends on !XIP && EXPERIMENTAL
>
>  source "init/Kconfig"
>
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index f83be97..80a939d 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -157,14 +157,15 @@
>  #error "this machine configuration uses complex __virt_to_phys/__phys_to_virt and cannot use CONFIG_ARM_PATCH_PHYS_VIRT"
>  #endif
>
> +/* the stub constant 0xff000000 is used to force the required insn encoding */
>  #define __pv_stub(from,to,instr)                       \
>        __asm__(                                        \
> -       "1:     " instr "\t%0, %1, %2\n"                \
> +       "1:     " instr "\t%0, %1, #0xff000000\n"       \
>        "       .pushsection .pv_table,\"a\"\n"         \
>        "       .long   1b\n"                           \
>        "       .popsection"                            \
>        : "=r" (to)                                     \
> -       : "r" (from), "I" (1))
> +       : "r" (from))
>
>  static inline unsigned long __virt_to_phys(unsigned long x)
>  {
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 621c792..397271d 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -447,11 +447,11 @@ __fixup_pv_table:
>        adr     r0, 1f
>        ldmia   r0, {r3-r5}
>        sub     r3, r0, r3      @ PHYS_OFFSET - PAGE_OFFSET
> +       movs    r6, r3, lsl #8  @ must be 16MiB aligned
> +       bne     __error
>        add     r4, r4, r3
>        add     r5, r5, r3
> -       mov     r6, r3, lsr #24 @ constant for add/sub instructions
> -       teq     r3, r6, lsl #24 @ must be 16MiB aligned
> -       bne     __error
> +       mov     r6, r3
>        b       __fixup_pv_table_loop
>  ENDPROC(__fixup_phys_virt)
>
> @@ -462,6 +462,8 @@ ENDPROC(__fixup_phys_virt)
>        .pushsection .text
>
>  ENTRY(__fixup_pv_table_loop)
> +#ifndef CONFIG_THUMB2_KERNEL
> +       mov     r6, r6, lsr #24 @ constant for add/sub instructions
>        orr     r6, r6, #0x400  @ mask in rotate right 8 bits
>  2:     cmp     r4, r5
>        ldrlo   r7, [r4], #4
> @@ -471,6 +473,27 @@ ENTRY(__fixup_pv_table_loop)
>        strlo   ip, [r7, r3]
>        blo     2b
>        mov     pc, lr
> +#else
> +       teq     r6, #0
> +       beq     2f
> +       clz     r7, r6
> +       lsr     r6, #24
> +       lsl     r6, r7
> +       bic     r6, r6, #0x3080

Should bits 12-13 of r6 ever be nonzero here? The code already throws
an error of the p2v offset is not a multiple of 16 MiB; i.e., (r6 &
~0xff000000) == 0, so r6 >> (24 - clz(r6)) must be in the range
0..0xff.

Of course, clearing the extra bits again doesn't matter...

> +       lsrs    r7, #1
> +       orrcs   r6, r6, #0x80
> +       orr     r6, r6, r7, lsl #12
> +       orr     r6, r6, #0x4000
> +2:     cmp     r4, r5
> +       bxhs    lr
> +       ldr     r7, [r4], #4
> +       add     r7, r3
> +       ldr     ip, [r7, #2]
> +       and     ip, ip, #0x0f00
> +       orr     ip, ip, r6
> +       str     ip, [r7, #2]
> +       b       2b
> +#endif
>  ENDPROC(__fixup_phys_virt_loop)
>
>  /*
> @@ -482,7 +505,7 @@ ENTRY(fixup_pv_table)
>        mov     r3, #0          @ offset (zero as we're in virtual space)
>        mov     r4, r0          @ loop start
>        mov     r5, r1          @ loop end
> -       mov     r6, r2, lsr #24 @ constant for add/sub instructions
> +       mov     r6, r2          @ PHYS_OFFSET - PAGE_OFFSET
>        bl      __fixup_pv_table_loop
>        ldmfd   sp!, {r4 - r7, pc}
>  ENDPROC(fixup_pv_table)

I've not been able to test this code yet, but it looks to me like it
should work for the Thumb-2 case.

Cheers
---Dave
