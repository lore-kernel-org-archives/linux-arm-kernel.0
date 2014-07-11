From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 11 Jul 2014 09:35:13 +0200
Subject: [PATCHv3] arm64: fpsimd: avoid restoring fpcr if the contents
 haven't changed
In-Reply-To: <1404992409-6968-1-git-send-email-will.deacon@arm.com>
References: <1404992409-6968-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu_zWB5ADag8w68--YnH6BNy3FVaHzz2zr+R5K6XcA9iYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 13:40, Will Deacon <will.deacon@arm.com> wrote:
> Writing to the FPCR is commonly implemented as a self-synchronising
> operation in the CPU, so avoid writing to the register when the saved
> value matches that in the hardware already.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/fpsimdmacros.h | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>

Hi Will,

This works fine as far as I can tell.
-- 
Ard.


> diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
> index 768414d55e64..007618b8188c 100644
> --- a/arch/arm64/include/asm/fpsimdmacros.h
> +++ b/arch/arm64/include/asm/fpsimdmacros.h
> @@ -40,6 +40,19 @@
>         str     w\tmpnr, [\state, #16 * 2 + 4]
>  .endm
>
> +.macro fpsimd_restore_fpcr state, tmp
> +       /*
> +        * Writes to fpcr may be self-synchronising, so avoid restoring
> +        * the register if it hasn't changed.
> +        */
> +       mrs     \tmp, fpcr
> +       cmp     \tmp, \state
> +       b.eq    9999f
> +       msr     fpcr, \state
> +9999:
> +.endm
> +
> +/* Clobbers \state */
>  .macro fpsimd_restore state, tmpnr
>         ldp     q0, q1, [\state, #16 * 0]
>         ldp     q2, q3, [\state, #16 * 2]
> @@ -60,7 +73,7 @@
>         ldr     w\tmpnr, [\state, #16 * 2]
>         msr     fpsr, x\tmpnr
>         ldr     w\tmpnr, [\state, #16 * 2 + 4]
> -       msr     fpcr, x\tmpnr
> +       fpsimd_restore_fpcr x\tmpnr, \state
>  .endm
>
>  .altmacro
> @@ -84,7 +97,7 @@
>  .macro fpsimd_restore_partial state, tmpnr1, tmpnr2
>         ldp     w\tmpnr1, w\tmpnr2, [\state]
>         msr     fpsr, x\tmpnr1
> -       msr     fpcr, x\tmpnr2
> +       fpsimd_restore_fpcr x\tmpnr2, x\tmpnr1
>         adr     x\tmpnr1, 0f
>         ldr     w\tmpnr2, [\state, #8]
>         add     \state, \state, x\tmpnr2, lsl #4
> --
> 2.0.0
>
