From: james.morse@arm.com (James Morse)
Date: Fri, 7 Sep 2018 10:57:11 +0100
Subject: [RESEND PATCH v4 1/6] arm64/mm: Introduce the init_pg_dir.
In-Reply-To: <20180822095432.12125-2-yaojun8558363@gmail.com>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-2-yaojun8558363@gmail.com>
Message-ID: <6e614449-5574-98f6-cc39-f6fbddea48d8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> To make the swapper_pg_dir read only, we will move it to the rodata
> section. And force the kernel to set up the initial page table in
> the init_pg_dir. After generating all levels page table, we copy
> only the top level into the swapper_pg_dir during paging_init().

Could you add v3's
| Add init_pg_dir to vmlinux.lds.S and boiler-plate
| clearing/cleaning/invalidating it in head.S.

too. This makes it obvious that 'init_pg_dir isn't used yet' is deliberate.

Reviewed-by: James Morse <james.morse@arm.com>


Some boring nits:

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98dbba56..eb363a915c0e 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU

> +/*
> + * clear_pages - clear contiguous pages
> + *
> + *	start, end: page aligend virtual addresses

(Nit: aligned)


> + */
> +	.macro clear_pages, start:req, end:req

> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..61d7cee3eaa6 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -68,6 +68,12 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define INIT_PG_TABLES					\

                               ^ These are tabs ...

> +	. = ALIGN(PAGE_SIZE);                           \

                               ^ ... but these are spaces.

> +	init_pg_dir = .;                                \
> +	. += SWAPPER_DIR_SIZE;                          \
> +	init_pg_end = .;

Please pick one and stick with it. The macro above,
CONFIG_UNMAP_KERNEL_AT_EL0, uses tabs, please do the same.



Thanks,

James
