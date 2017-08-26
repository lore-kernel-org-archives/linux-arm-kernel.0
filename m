From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 26 Aug 2017 11:49:35 +0100
Subject: [PATCH 1/3] ARM: head-common.S: speed up startup code
In-Reply-To: <20170825162600.15709-2-nicolas.pitre@linaro.org>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <20170825162600.15709-2-nicolas.pitre@linaro.org>
Message-ID: <CAKv+Gu9Wtq9-0vK3JCUy0FZYhoexPLWxMr5fhWxrGhiA2tS6Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 August 2017 at 17:25, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Let's use optimized routines such as memcpy to copy .data and memzero
> to clear .bss in the startup code instead of doing it one word at a
> time. Those routines don't use any global data so they're safe to use
> even if .data and .bss segments are not initialized.
>
> In the .data copy case a temporary stack is installed in the .bss area
> as the actual kernel stack is located within the copied data area.
>
> Finally, make the .data copy and related pointers surrounded by
> CONFIG_XIP_KERNEL to make it obvious what it is all about. This will
> allow for some cleanup in the non-XIP linker script as well.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/kernel/head-common.S | 76 +++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 8733012d23..63a21fe03f 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -79,47 +79,59 @@ ENDPROC(__vet_atags)
>   */
>         __INIT
>  __mmap_switched:
> -       adr     r3, __mmap_switched_data
> -
> -       ldmia   r3!, {r4, r5, r6, r7}
> -       cmp     r4, r5                          @ Copy data segment if needed
> -1:     cmpne   r5, r6
> -       ldrne   fp, [r4], #4
> -       strne   fp, [r5], #4
> -       bne     1b
> -
> -       mov     fp, #0                          @ Clear BSS (and zero fp)
> -1:     cmp     r6, r7
> -       strcc   fp, [r6],#4
> -       bcc     1b
> -
> - ARM(  ldmia   r3, {r4, r5, r6, r7, sp})
> - THUMB(        ldmia   r3, {r4, r5, r6, r7}    )
> - THUMB(        ldr     sp, [r3, #16]           )
> -       str     r9, [r4]                        @ Save processor ID
> -       str     r1, [r5]                        @ Save machine type
> -       str     r2, [r6]                        @ Save atags pointer
> -       cmp     r7, #0
> -       strne   r0, [r7]                        @ Save control register values
> +
> +       mov     r7, r1
> +       mov     r8, r2
> +       mov     r10, r0
> +
> +       adr     r4, __mmap_switched_data
> +       mov     fp, #0
> +
> +#ifdef CONFIG_XIP_KERNEL
> +   ARM(        ldmia   r4!, {r0, r1, r2, sp} )
> + THUMB(        ldmia   r4!, {r0, r1, r2, r3} )
> + THUMB(        mov     sp, r3 )
> +       sub     r2, r2, r1
> +       bl      memcpy                          @ copy .data to RAM
> +#endif
> +
> +   ARM(        ldmia   r4!, {r0, r1, sp} )
> + THUMB(        ldmia   r4!, {r0, r1, r3} )
> + THUMB(        mov     sp, r3 )
> +       sub     r1, r1, r0
> +       bl      __memzero                       @ clear .bss
> +
> +       ldmia   r4, {r0, r1, r2, r3}
> +       str     r9, [r0]                        @ Save processor ID
> +       str     r7, [r1]                        @ Save machine type
> +       str     r8, [r2]                        @ Save atags pointer
> +       cmp     r3, #0
> +       strne   r10, [r3]                       @ Save control register values
>         b       start_kernel
>  ENDPROC(__mmap_switched)
>
>         .align  2
>         .type   __mmap_switched_data, %object
>  __mmap_switched_data:
> -       .long   __data_loc                      @ r4
> -       .long   _sdata                          @ r5
> -       .long   __bss_start                     @ r6
> -       .long   _end                            @ r7
> -       .long   processor_id                    @ r4
> -       .long   __machine_arch_type             @ r5
> -       .long   __atags_pointer                 @ r6
> +#ifdef CONFIG_XIP_KERNEL
> +       .long   _sdata                          @ r0
> +       .long   __data_loc                      @ r1
> +       .long   _edata_loc                      @ r2
> +       .long   _end                            @ sp (temporary stack in .bss)
> +#endif
> +
> +       .long   __bss_start                     @ r0
> +       .long   _end                            @ r1
> +       .long   init_thread_union + THREAD_START_SP @ sp
> +
> +       .long   processor_id                    @ r0
> +       .long   __machine_arch_type             @ r1
> +       .long   __atags_pointer                 @ r2
>  #ifdef CONFIG_CPU_CP15
> -       .long   cr_alignment                    @ r7
> +       .long   cr_alignment                    @ r3
>  #else
> -       .long   0                               @ r7
> +       .long   0                               @ r3
>  #endif
> -       .long   init_thread_union + THREAD_START_SP @ sp
>         .size   __mmap_switched_data, . - __mmap_switched_data
>
>  /*
> --
> 2.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
