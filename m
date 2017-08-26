From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 26 Aug 2017 11:38:54 +0100
Subject: [PATCH 2/3] ARM: vmlinux*.lds.S: some decruftification
In-Reply-To: <20170825162600.15709-3-nicolas.pitre@linaro.org>
References: <20170825162600.15709-1-nicolas.pitre@linaro.org>
 <20170825162600.15709-3-nicolas.pitre@linaro.org>
Message-ID: <CAKv+Gu-oX4OYJu0HuroSyTE3TLD_Ez8EGttRrfuqNR6f5rR8zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 August 2017 at 17:25, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> Remove stuff from vmlinux.lds.S that is relevant only to the XIP build,
> and stuff from vmlinux-xip.lds.S related to self-modifying code that
> makes no sense in the XIP case.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Reviewed by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/kernel/vmlinux-xip.lds.S | 14 --------------
>  arch/arm/kernel/vmlinux.lds.S     |  4 +---
>  2 files changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 8265b11621..d6c08a4c30 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -77,9 +77,7 @@ SECTIONS
>                 *(.text.fixup)
>                 *(__ex_table)
>  #endif
> -#ifndef CONFIG_SMP_ON_UP
>                 *(.alt.smp.init)
> -#endif
>                 *(.discard)
>                 *(.discard.*)
>         }
> @@ -181,18 +179,6 @@ SECTIONS
>                 *(.taglist.init)
>                 __tagtable_end = .;
>         }
> -#ifdef CONFIG_SMP_ON_UP
> -       .init.smpalt : {
> -               __smpalt_begin = .;
> -               *(.alt.smp.init)
> -               __smpalt_end = .;
> -       }
> -#endif
> -       .init.pv_table : {
> -               __pv_table_begin = .;
> -               *(.pv_table)
> -               __pv_table_end = .;
> -       }
>         .init.data : {
>                 INIT_SETUP(16)
>                 INIT_CALLS
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index c83a7ba737..4f86b4b7bd 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -236,9 +236,8 @@ SECTIONS
>         . = ALIGN(THREAD_SIZE);
>  #endif
>         __init_end = .;
> -       __data_loc = .;
>
> -       .data : AT(__data_loc) {
> +       .data : {
>                 _data = .;              /* address in memory */
>                 _sdata = .;
>
> @@ -260,7 +259,6 @@ SECTIONS
>
>                 _edata = .;
>         }
> -       _edata_loc = __data_loc + SIZEOF(.data);
>
>         BUG_TABLE
>
> --
> 2.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
