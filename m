From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Oct 2017 14:41:29 +0200
Subject: [PATCH v2 1/5] ARM: head-common.S: speed up startup code
In-Reply-To: <20170830025547.30347-2-nicolas.pitre@linaro.org>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <20170830025547.30347-2-nicolas.pitre@linaro.org>
Message-ID: <CAMuHMdXnYysiDURyztXv3bhBMyk0o1EN=JzwqwvUifzw5fFYAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Aug 30, 2017 at 4:55 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Let's use optimized routines such as memcpy to copy .data and memzero
> to clear .bss in the startup code instead of doing it one word at a
> time. Those routines don't use any global data so they're safe to use
> even if .data and .bss segments are not initialized.
>
> In the .data copy case a temporary stack is installed in the .bss area
> as the actual kernel stack is located within the copied data area. The
> XIP kernel linker script ensures a 8 byte alignment for that purpose.
>
> Finally, make the .data copy and related pointers surrounded by
> CONFIG_XIP_KERNEL to make it obvious what it is all about. This will
> allow for further cleanups in the non-XIP linker script.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This is now commit 9520b1a1b5f7a348 ("ARM: head-common.S: speed up startup
code") in arm/for-next.

If CONFIG_DEBUG_LOCK_ALLOC=y, the kernel log is spammed with a few hundred
identical messages on various Renesas systems:

    unwind: Unknown symbol address c0800300
    unwind: Index not found c0800300

I've bisected this to the aforementioned commit.

c0800300 points to the instruction just after the __memzero call, cfr. below.

Do you have a clue? Thanks!

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

c0800300 is the address of the next instruction:

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
> +       .long   __bss_stop                      @ sp (temporary stack in .bss)
> +#endif
> +
> +       .long   __bss_start                     @ r0
> +       .long   __bss_stop                      @ r1
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

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
