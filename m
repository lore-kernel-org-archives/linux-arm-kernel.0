From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Mar 2016 07:55:38 +0100
Subject: [PATCH 1/2] ARM64:VDSO: Improve gettimeofday, don't use udiv
In-Reply-To: <1457898620-1867-2-git-send-email-apinski@cavium.com>
References: <1457898620-1867-1-git-send-email-apinski@cavium.com>
 <1457898620-1867-2-git-send-email-apinski@cavium.com>
Message-ID: <CAKv+Gu90LOYRKWR8svKhqn6T9qQ-A=VB7iP7wM6oz=MyCs7CJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2016 at 20:50, Andrew Pinski <apinski@cavium.com> wrote:
> On many cores, udiv with a large value is slow, expand instead
> the division out to be what GCC would have generated for the
> divide by 1000.
>
> On ThunderX, the speeds up gettimeofday by 5%.
>
> Signed-off-by: Andrew Pinski <apinski@cavium.com>
> ---
>  arch/arm64/kernel/vdso/gettimeofday.S |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> index efa79e8..e5caef9 100644
> --- a/arch/arm64/kernel/vdso/gettimeofday.S
> +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> @@ -64,10 +64,22 @@ ENTRY(__kernel_gettimeofday)
>         bl      __do_get_tspec
>         seqcnt_check w9, 1b
>
> -       /* Convert ns to us. */
> -       mov     x13, #1000
> -       lsl     x13, x13, x12
> -       udiv    x11, x11, x13
> +       /* Undo the shift. */
> +        lsr     x11, x11, x12
> +
> +       /* Convert ns to us (division by 1000 by using multiply high).
> +        * This is how GCC converts the division by 1000 into.
> +        * This is faster than divide on most cores.
> +        */
> +        mov     x13, 63439

Please don't mix hex and decimal constants

> +        movk    x13, 0xe353, lsl 16
> +        lsr     x11, x11, 3
> +        movk    x13, 0x9ba5, lsl 32
> +        movk    x13, 0x20c4, lsl 48
> +       /* x13 = 0x20c49ba5e353f7cf */

Could we clean this up a bit? Something along the lines of

.set m, 0x20c49ba5e353f7cf
movz x13,#:abs_g3:m
movk x13, #:abs:g2_nc:m
movk x13, #:abs_g1_nc:m
movk x13, #:abs_g0_nc:m

Actually, the movz/movk sequence should probably be implemented as a
macro in asm/assembler.h, with parameters for the register and the
symbol name. I think Mark proposed such a patch at some point

> +        umulh   x11, x11, x13
> +        lsr     x11, x11, 4
> +
>         stp     x10, x11, [x0, #TVAL_TV_SEC]
>  2:
>         /* If tz is NULL, return 0. */
> --
> 1.7.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
