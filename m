From: james.morse@arm.com (James Morse)
Date: Fri, 6 Jul 2018 09:56:16 +0100
Subject: [PATCH v3 1/5] arm64/mm: Introduce init_pg_dir
In-Reply-To: <20180702111659.25570-2-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-2-yaojun8558363@gmail.com>
Message-ID: <b0bffd8e-5aff-0410-4c97-b30ae79dab91@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Add init_pg_dir to vmlinux.lds.S and boiler-plate
> clearing/cleaning/invalidating it in head.S.

With just this patch I get a weird link error from ld[0]:
aarch64-linux-gnu-ld:./arch/arm64/kernel/vmlinux.lds:90 cannot move location
counter backwards (from ffff000008fa8000 to fffefffff8ead000)
make[2]: *** [/home/morse/linux/Makefile:1015: vmlinux] Error 1
make[1]: *** [Makefile:146: sub-make] Error 2
make: *** [Makefile:24: __sub-make] Error 2

Where line 90 is your INIT_DIR macro.

I'm going to guess that this is because SWAPPER_DIR_SIZE is defined in terms of
'_end', and that this can't be used inside '.init.data'.

Moving it outside the '.init.data' section fixes this [1]. We only need this to
be within the __init_begin/__init_end markers that free_initmem() uses, which it
still is after this change.
A side effect of this is we shouldn't label the C externs '__initdata' as they
are no longer in the '.init.data' section. (looks like I was wrong about sparse
being able to pick that up...)

(Could we make it clearer INIT_DIR is related to the page tables, e.g.
INIT_PG_TABLES? INIT_DIR makes me think of the rootfs for some reason)


Otherwise some boring nits:

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98dbba56..414fb167e3e7 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -456,6 +456,29 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>  	b.ne	9998b
>  	.endm
>  
> +/*
> + * clear_page - clear one page
> + */
> +	.macro clear_page, start:req
> +9996:	stp     xzr, xzr, [\start], #16
> +	stp     xzr, xzr, [\start], #16
> +	stp     xzr, xzr, [\start], #16
> +	stp     xzr, xzr, [\start], #16
> +	tst	\start, #(PAGE_SIZE - 1)

(This will match any page-aligned end address, so this macro only clears one
page if you give it a page aligned start address. Just something for us to
remember.)

> +	b.ne    9996b
> +	.endm

The rest of this file uses the white-space $instruction[tab]$arg, $arg, here you
mix and match.


> +/*
> + * clear_pages - clear contiguous pages
> + */
> +	.macro clear_pages, start:req, count:req
> +9997:	cbz	\count, 9998f
> +	clear_page \start
> +	sub	\count, \count, #1
> +	b	9997b
> +9998:
> +	.endm

Both callers of this have a start/end address, you may as well move the 'count'
calculation in here to save duplicating it.



With the link-error fixed:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..d4fc68286a49 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -68,6 +68,12 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define INIT_DIR					\
> +	. = ALIGN(PAGE_SIZE);                           \
> +	init_pg_dir = .;                                \
> +	. += SWAPPER_DIR_SIZE;                          \
> +	init_pg_end = .;
> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -168,6 +174,7 @@ SECTIONS
>  		CON_INITCALL
>  		SECURITY_INITCALL
>  		INIT_RAM_FS
> +		INIT_DIR
>  		*(.init.rodata.* .init.bss)	/* from the EFI stub */
>  	}
>  	.exit.data : {
> 

[0] aarch64-linux-gnu-ld --version
GNU ld (GNU Binutils for Debian) 2.30.90.20180627
Copyright (C) 2018 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later version.
This program has absolutely no warranty.


[1] Move INIT_DIR outside the .init.data section
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d4fc68286a49..169abc3d01c8 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -167,6 +167,8 @@ SECTIONS
        __inittext_end = .;
        __initdata_begin = .;

+       INIT_DIR
+
        .init.data : {
                INIT_DATA
                INIT_SETUP(16)
@@ -174,7 +176,6 @@ SECTIONS
                CON_INITCALL
                SECURITY_INITCALL
                INIT_RAM_FS
-               INIT_DIR
                *(.init.rodata.* .init.bss)     /* from the EFI stub */
        }
        .exit.data : {
