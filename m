From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Dec 2017 10:25:35 +0000
Subject: [PATCH v2 10/18] arm64: entry: Add exception trampoline page for
 exceptions from EL0
In-Reply-To: <1512059986-21325-11-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-11-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu-pC=3FjtrUvb_X0J0Lc6L3PMTMH1t+eDcQNG8eVeShaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2017 at 16:39, Will Deacon <will.deacon@arm.com> wrote:
> To allow unmapping of the kernel whilst running at EL0, we need to
> point the exception vectors at an entry trampoline that can map/unmap
> the kernel on entry/exit respectively.
>
> This patch adds the trampoline page, although it is not yet plugged
> into the vector table and is therefore unused.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S       | 86 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S | 17 ++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index d454d8ed45e4..dea196f287a0 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -28,6 +28,8 @@
>  #include <asm/errno.h>
>  #include <asm/esr.h>
>  #include <asm/irq.h>
> +#include <asm/memory.h>
> +#include <asm/mmu.h>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
>  #include <asm/thread_info.h>
> @@ -943,6 +945,90 @@ __ni_sys_trace:
>
>         .popsection                             // .entry.text
>
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +/*
> + * Exception vectors trampoline.
> + */
> +       .pushsection ".entry.tramp.text", "ax"
> +
> +       .macro tramp_map_kernel, tmp
> +       mrs     \tmp, ttbr1_el1
> +       sub     \tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
> +       bic     \tmp, \tmp, #USER_ASID_FLAG
> +       msr     ttbr1_el1, \tmp
> +       .endm
> +
> +       .macro tramp_unmap_kernel, tmp
> +       mrs     \tmp, ttbr1_el1
> +       add     \tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
> +       orr     \tmp, \tmp, #USER_ASID_FLAG
> +       msr     ttbr1_el1, \tmp
> +       /*
> +        * We avoid running the post_ttbr_update_workaround here because the
> +        * user and kernel ASIDs don't have conflicting mappings, so any
> +        * "blessing" as described in:
> +        *
> +        *   http://lkml.kernel.org/r/56BB848A.6060603 at caviumnetworks.com
> +        *
> +        * will not hurt correctness. Whilst this may partially defeat the
> +        * point of using split ASIDs in the first place, it avoids
> +        * the hit of invalidating the entire I-cache on every return to
> +        * userspace.
> +        */
> +       .endm
> +
> +       .macro tramp_ventry, regsize = 64
> +       .align  7
> +1:
> +       .if     \regsize == 64
> +       msr     tpidrro_el0, x30
> +       .endif
> +       tramp_map_kernel        x30
> +       ldr     x30, =vectors

Could we move this literal into the next page, and only map that in
the kernel page tables? It's the only piece of information in the
trampoline page that can reveal the true location of the kernel, and
moving it out is trivial to implement on top of the changes you are
already making to harden KASLR.

> +       prfm    plil1strm, [x30, #(1b - tramp_vectors)]
> +       msr     vbar_el1, x30
> +       add     x30, x30, #(1b - tramp_vectors)
> +       isb
> +       br      x30
> +       .endm
> +
> +       .macro tramp_exit, regsize = 64
> +       adr     x30, tramp_vectors
> +       msr     vbar_el1, x30
> +       tramp_unmap_kernel      x30
> +       .if     \regsize == 64
> +       mrs     x30, far_el1
> +       .endif
> +       eret
> +       .endm
> +
> +       .align  11
> +ENTRY(tramp_vectors)
> +       .space  0x400
> +
> +       tramp_ventry
> +       tramp_ventry
> +       tramp_ventry
> +       tramp_ventry
> +
> +       tramp_ventry    32
> +       tramp_ventry    32
> +       tramp_ventry    32
> +       tramp_ventry    32
> +END(tramp_vectors)
> +
> +ENTRY(tramp_exit_native)
> +       tramp_exit
> +END(tramp_exit_native)
> +
> +ENTRY(tramp_exit_compat)
> +       tramp_exit      32
> +END(tramp_exit_compat)
> +
> +       .ltorg
> +       .popsection                             // .entry.tramp.text
> +#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
> +
>  /*
>   * Special system call wrappers.
>   */
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 7da3e5c366a0..6b4260f22aab 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -57,6 +57,17 @@ jiffies = jiffies_64;
>  #define HIBERNATE_TEXT
>  #endif
>
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +#define TRAMP_TEXT                                     \
> +       . = ALIGN(PAGE_SIZE);                           \
> +       VMLINUX_SYMBOL(__entry_tramp_text_start) = .;   \
> +       *(.entry.tramp.text)                            \
> +       . = ALIGN(PAGE_SIZE);                           \
> +       VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
> +#else
> +#define TRAMP_TEXT
> +#endif
> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -113,6 +124,7 @@ SECTIONS
>                         HYPERVISOR_TEXT
>                         IDMAP_TEXT
>                         HIBERNATE_TEXT
> +                       TRAMP_TEXT
>                         *(.fixup)
>                         *(.gnu.warning)
>                 . = ALIGN(16);
> @@ -214,6 +226,11 @@ SECTIONS
>         . += RESERVED_TTBR0_SIZE;
>  #endif
>
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +       tramp_pg_dir = .;
> +       . += PAGE_SIZE;
> +#endif
> +
>         __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
>         _end = .;
>
> --
> 2.1.4
>
