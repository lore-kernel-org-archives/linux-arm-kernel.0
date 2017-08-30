From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Aug 2017 16:11:53 +0100
Subject: [PATCH v2 3/5] ARM: vmlinux.lds.S: replace open coded .data
 sections with generic macros
In-Reply-To: <20170830025547.30347-4-nicolas.pitre@linaro.org>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <20170830025547.30347-4-nicolas.pitre@linaro.org>
Message-ID: <CAKv+Gu8Jtr-kANe_GQAmENAFPA=Rnq5T9Amqw7fUhW3HQ4xsOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 August 2017 at 03:55, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Our .data section is missing PAGE_ALIGNED_DATA() which contains,
> amongst other things, the vdso page. This creates a System.map that
> looks like this:
>
> c15769a8 D _edata
> c1577000 d vdso_data_store
> c1578000 D __start___bug_table
> c1580544 D __stop___bug_table
> c1580544 B __bss_start
>
> By using RW_DATA_SECTION() we pick whatever generic sections might be
> added in the future and have page-aligned data next to other strongly
> aligned data. Furthermore we now include the entire thing, including the
> bug table, in the data accounting surrounded by _sdata/_edata.
>
> While at it let's also remplace the open coded .init.data by its
> equivalent INIT_DATA_SECTION().
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/kernel/vmlinux.lds.S | 38 ++++++--------------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 4f86b4b7bd..f73ba564b5 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -214,14 +214,9 @@ SECTIONS
>                 *(.pv_table)
>                 __pv_table_end = .;
>         }
> -       .init.data : {
> -               INIT_DATA
> -               INIT_SETUP(16)
> -               INIT_CALLS
> -               CON_INITCALL
> -               SECURITY_INITCALL
> -               INIT_RAM_FS
> -       }
> +
> +       INIT_DATA_SECTION(16)
> +
>         .exit.data : {
>                 ARM_EXIT_KEEP(EXIT_DATA)
>         }
> @@ -237,30 +232,9 @@ SECTIONS
>  #endif
>         __init_end = .;
>
> -       .data : {
> -               _data = .;              /* address in memory */
> -               _sdata = .;
> -
> -               /*
> -                * first, the init task union, aligned
> -                * to an 8192 byte boundary.
> -                */
> -               INIT_TASK_DATA(THREAD_SIZE)
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
> -       }
> -
> -       BUG_TABLE
> +       _sdata = .;
> +       RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +       _edata = .;
>
>  #ifdef CONFIG_HAVE_TCM
>          /*
> --
> 2.9.5
>
