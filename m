From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Aug 2017 16:12:45 +0100
Subject: [PATCH v2 4/5] ARM: vmlinux-xip.lds.S: fix multiple issues
In-Reply-To: <20170830025547.30347-5-nicolas.pitre@linaro.org>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <20170830025547.30347-5-nicolas.pitre@linaro.org>
Message-ID: <CAKv+Gu_vKD-Exnt3L9+FRgq9nueFAUWoggwUpJbpCS=bMd_JfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2017 at 03:55, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The XIP linker script has several problems:
>
> - PAGE_ALIGNED_DATA is missing and is likely to end up somewhere with
>   the wrong LMA.
>
> - BUG_TABLE definitely has the wrong LMA, it is not copied to RAM, and
>   its VMA is unaccounted for and likely to clash with dynamic memory
>   usage.
>
> - TCM usage is similarly broken.
>
> - PERCPU_SECTION is left in ROM despite being written to.
>
> Let's use generic macros for those things and locate them appropriately.
> Incidentally, those macros are usable with a LMA != VMA already by
> properly defining LOAD_OFFSET.
>
> TCM is not fixed here. It never worked in a XIP configuration anyway, so
> that can wait until another round of cleanups.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/kernel/vmlinux-xip.lds.S | 70 +++++++++++++++++++--------------------
>  1 file changed, 34 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 88e8db3979..39b1fb470a 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -179,7 +179,7 @@ SECTIONS
>                 *(.taglist.init)
>                 __tagtable_end = .;
>         }
> -       .init.data : {
> +       .init.rodata : {
>                 INIT_SETUP(16)
>                 INIT_CALLS
>                 CON_INITCALL
> @@ -187,48 +187,46 @@ SECTIONS
>                 INIT_RAM_FS
>         }
>
> -#ifdef CONFIG_SMP
> -       PERCPU_SECTION(L1_CACHE_BYTES)
> -#endif
> -
>         _exiprom = .;                   /* End of XIP ROM area */
> -       __data_loc = ALIGN(4);          /* location in binary */
> -       . = PAGE_OFFSET + TEXT_OFFSET;
> -
> -       .data : AT(__data_loc) {
> -               _data = .;              /* address in memory */
> -               _sdata = .;
>
> -               /*
> -                * first, the init task union, aligned
> -                * to an 8192 byte boundary.
> -                */
> -               INIT_TASK_DATA(THREAD_SIZE)
> +/*
> + * From this point, stuff is considered writable and will be copied to RAM
> + */
> +       __data_loc = ALIGN(4);          /* location in file */
> +       . = PAGE_OFFSET + TEXT_OFFSET;  /* location in memory */
> +#undef LOAD_OFFSET
> +#define LOAD_OFFSET (PAGE_OFFSET + TEXT_OFFSET - __data_loc)
> +
> +       . = ALIGN(THREAD_SIZE);
> +       _sdata = .;
> +       RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +       .data.ro_after_init : AT(ADDR(.data.ro_after_init) - LOAD_OFFSET) {
> +               *(.data..ro_after_init)
> +       }
> +       _edata = .;
>
> -               . = ALIGN(PAGE_SIZE);
> -               __init_begin = .;
> +       . = ALIGN(PAGE_SIZE);
> +       __init_begin = .;
> +       .init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
>                 INIT_DATA
> +       }
> +       .exit.data : AT(ADDR(.exit.data) - LOAD_OFFSET) {
>                 ARM_EXIT_KEEP(EXIT_DATA)
> -               . = ALIGN(PAGE_SIZE);
> -               __init_end = .;
> -
> -               *(.data..ro_after_init)
> -
> -               NOSAVE_DATA
> -               CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
> -               READ_MOSTLY_DATA(L1_CACHE_BYTES)
> -
> -               /*
> -                * and the usual data section
> -                */
> -               DATA_DATA
> -               CONSTRUCTORS
> -
> -               _edata = .;
>         }
> -       _edata_loc = __data_loc + SIZEOF(.data);
> +#ifdef CONFIG_SMP
> +       PERCPU_SECTION(L1_CACHE_BYTES)
> +#endif
> +
> +       /*
> +        * End of copied data. We need a dummy section to get its LMA.
> +        * Also located before final ALIGN() as trailing padding is not stored
> +        * in the resulting binary file and useless to copy.
> +        */
> +       .data.endmark : AT(ADDR(.data.endmark) - LOAD_OFFSET) { }
> +       _edata_loc = LOADADDR(.data.endmark);
>
> -       BUG_TABLE
> +       . = ALIGN(PAGE_SIZE);
> +       __init_end = .;
>
>  #ifdef CONFIG_HAVE_TCM
>          /*
> --
> 2.9.5
>
