From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jan 2016 12:12:45 +0100
Subject: [PATCH 2/2] arm64: use memset to clear BSS
In-Reply-To: <1452078327-9635-2-git-send-email-mark.rutland@arm.com>
References: <1452078327-9635-1-git-send-email-mark.rutland@arm.com>
 <1452078327-9635-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu9xsLk2hDB_RxYn9kytgCOEk3WTYq0Vvegh4NsE7ERTtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2016 at 12:05, Mark Rutland <mark.rutland@arm.com> wrote:
> Currently we use an open-coded memzero to clear the BSS. As it is a
> trivial implementation, it is sub-optimal.
>
> Our optimised memset doesn't use the stack, is position-independent, and
> for the memzero case can use of DC ZVA to clear large blocks
> efficiently. In __mmap_switched the MMU is on and there are no live
> caller-saved registers, so we can safely call an uninstrumented memset.
>
> This patch changes __mmap_switched to use memset when clearing the BSS.
> We use the __pi_memset alias so as to avoid any instrumentation in all
> kernel configurations. As with the head symbols, we must get the linker
> to generate __bss_size, as there is no ELF relocation for the
> subtraction of two symbols.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/head.S  | 14 ++++++--------
>  arch/arm64/kernel/image.h |  2 ++
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 23cfc08..247a97b 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -415,14 +415,12 @@ ENDPROC(__create_page_tables)
>   */
>         .set    initial_sp, init_thread_union + THREAD_START_SP
>  __mmap_switched:
> -       adr_l   x6, __bss_start
> -       adr_l   x7, __bss_stop
> -
> -1:     cmp     x6, x7
> -       b.hs    2f
> -       str     xzr, [x6], #8                   // Clear BSS
> -       b       1b
> -2:
> +       // clear BSS
> +       adr_l   x0, __bss_start
> +       mov     x1, xzr
> +       mov_l   x2, __bss_size

Is it such a big deal to do

adr_l x2, __bss_stop
sub x2, x2, x0

instead?

Either way:
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> +       bl      __pi_memset
> +
>         adr_l   sp, initial_sp, x4
>         str_l   x21, __fdt_pointer, x5          // Save FDT pointer
>         str_l   x24, memstart_addr, x6          // Save PHYS_OFFSET
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index bc2abb8..5fd76b5 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -95,4 +95,6 @@ __efistub__edata              = _edata;
>
>  #endif
>
> +__bss_size                     = __bss_stop - __bss_start;
> +
>  #endif /* __ASM_IMAGE_H */
> --
> 1.9.1
>
