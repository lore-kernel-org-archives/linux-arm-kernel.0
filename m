From: james.morse@arm.com (James Morse)
Date: Fri, 6 Jul 2018 09:58:40 +0100
Subject: [PATCH v3 4/5] arm64/mm: Make swapper_pg_dir smaller
In-Reply-To: <20180702111659.25570-5-yaojun8558363@gmail.com>
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-5-yaojun8558363@gmail.com>
Message-ID: <00553a1b-f354-ea74-c0c2-e68f9c6a16a5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Make swapper_pg_dir smaller so we don't need to memblock_free() it.

Patch looks good, but could the commit message explain why its now safe to do this?

Thanks,

James


> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index d4fc68286a49..d69e11ad92e3 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -236,7 +236,7 @@ SECTIONS
>  	. += RESERVED_TTBR0_SIZE;
>  #endif
>  	swapper_pg_dir = .;
> -	. += SWAPPER_DIR_SIZE;
> +	. += PAGE_SIZE;
>  	swapper_pg_end = .;
>  
>  	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a7ab0010ff80..a1e8fc624324 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -632,14 +632,6 @@ void __init paging_init(void)
>  	map_mem(swapper_pg_dir);
>  	cpu_replace_ttbr1(swapper_pg_dir);
>  	init_mm.pgd = swapper_pg_dir;
> -
> -	/*
> -	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
> -	 * allocated with it.
> -	 */
> -	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
> -		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
> -		      - PAGE_SIZE);
>  }
>  
>  /*
> 
