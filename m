From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Sep 2018 14:01:37 +0100
Subject: [PATCH v5 1/6] arm64/mm: Introduce the init_pg_dir.
In-Reply-To: <20180917044333.30051-2-yaojun8558363@gmail.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-2-yaojun8558363@gmail.com>
Message-ID: <20180924130137.re3nftpsi2dx2da2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 12:43:28PM +0800, Jun Yao wrote:
> To make the swapper_pg_dir read only, we will move it to the rodata
> section. And force the kernel to set up the initial page table in
> the init_pg_dir. After generating all levels page table, we copy
> only the top level into the swapper_pg_dir during paging_init().
> 
> In this patch, just add the init_pg_dir to vmlinux.lds.S and
> boiler-plate clearing/cleaning/invalidating it in head.S.

I don't believe it is necessary to explicitly zero init_pg_dir.

We have to clear swapper_pg_dir and idmap_pg_dir since they're after
_edata, and the bootloader won't have zeroed the relevant memory (nor
will it have cleaned that memory to the PoC).

However, anything in .init must have been loaded and cleaned to the PoC
by the bootloader per the arm64 Linux boot protocol. So as long as
that's zero in the kernel Image, that must be zero in memory (and any
caches).

> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
>  arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
>  3 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98dbba56..e7bdc324d538 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
>  	b.ne	9998b
>  	.endm
>  
> +/*
> + * clear_page - clear one page
> + *
> + *	start:	page aligned virtual address
> + */
> +	.macro clear_page, start:req
> +9996:	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	stp	xzr, xzr, [\start], #16
> +	tst	\start, #(PAGE_SIZE - 1)
> +	b.ne	9996b
> +	.endm
> +
> +/*
> + * clear_pages - clear contiguous pages
> + *
> + *	start, end:	page aligned virtual addresses
> + */
> +	.macro clear_pages, start:req, end:req
> +	sub	\end, \end, \start
> +	lsr	\end, \end, #(PAGE_SHIFT)
> +9997:	cbz	\end, 9998f
> +	clear_page \start
> +	sub	\end, \end, #1
> +	b	9997b
> +9998:
> +	.endm

Given the above, I don't think that we need these macros. In a
subsequent patch, we can just limit the range of pages that we zero.

> +
>  /*
>   * Annotate a function as position independent, i.e., safe to be called before
>   * the kernel virtual mapping is activated.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..2c83a8c47e3f 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -295,18 +295,21 @@ __create_page_tables:
>  	sub	x1, x1, x0
>  	bl	__inval_dcache_area
>  
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	sub	x1, x1, x0
> +	bl	__inval_dcache_area
> +
>  	/*
>  	 * Clear the idmap and swapper page tables.
>  	 */
>  	adrp	x0, idmap_pg_dir
>  	adrp	x1, swapper_pg_end
> -	sub	x1, x1, x0
> -1:	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	stp	xzr, xzr, [x0], #16
> -	subs	x1, x1, #64
> -	b.ne	1b
> +	clear_pages x0, x1
> +
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	clear_pages x0, x1
>  
>  	mov	x7, SWAPPER_MM_MMUFLAGS
>  
> @@ -395,6 +398,11 @@ __create_page_tables:
>  	dmb	sy
>  	bl	__inval_dcache_area
>  
> +	adrp	x0, init_pg_dir
> +	adrp	x1, init_pg_end
> +	sub	x1, x1, x0
> +	bl	__inval_dcache_area
> +
>  	ret	x28
>  ENDPROC(__create_page_tables)
>  	.ltorg
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..612ffc0bbe11 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -68,6 +68,12 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define INIT_PG_TABLES					\
> +	. = ALIGN(PAGE_SIZE);				\
> +	init_pg_dir = .;				\
> +	. += SWAPPER_DIR_SIZE;				\
> +	init_pg_end = .;

This will allocate a full set of PGD + PUD + PMD (+ PTE) levels, but the
commit message says we only copy the top level table.

The memory for otjher levels of table can be re-allocated once the
kernel init phase is over, so that seems a bit worrying.

Do we switch over to new copies of those levels, or do we continue using
the entries from INIT_PG_TABLES?

Thanks,
Mark.

> +
>  /*
>   * The size of the PE/COFF section that covers the kernel image, which
>   * runs from stext to _edata, must be a round multiple of the PE/COFF
> @@ -161,6 +167,8 @@ SECTIONS
>  	__inittext_end = .;
>  	__initdata_begin = .;
>  
> +	INIT_PG_TABLES
> +
>  	.init.data : {
>  		INIT_DATA
>  		INIT_SETUP(16)
> -- 
> 2.17.1
> 
