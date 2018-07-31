From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 Jul 2018 12:29:31 +0100
Subject: [PATCH v5 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <a6a0ad8a-7962-9775-2924-a6f3b2724bcb@arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
 <1529403502-2843-2-git-send-email-vladimir.murzin@arm.com>
 <20180727113502.3qdbyffuvysva6bz@armageddon.cambridge.arm.com>
 <f3da236e-504d-66ab-19da-9f89eba253f1@arm.com>
 <20180730154209.2tawriqxgxub7paa@armageddon.cambridge.arm.com>
 <16344e26-6cd2-5e55-d34e-fd2a48bef733@arm.com>
 <20180730170337.rycf34urt7n2fptq@armageddon.cambridge.arm.com>
 <a6a0ad8a-7962-9775-2924-a6f3b2724bcb@arm.com>
Message-ID: <20180731112930.i7dxahzvw2p3rqph@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:17:30AM +0100, Vladimir Murzin wrote:
> Does it represent your idea correctly?
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index c506fb7..b6ba2f0 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -147,7 +147,8 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
>  	ttbr_replace_func *replace_phys;
>  
> -	phys_addr_t pgd_phys = virt_to_phys(pgdp);
> +	/* phys_to_ttbr() zeros lower 2 bits of ttbr with 52-bit PA */
> +	phys_addr_t ttbr1 = phys_to_ttbr(virt_to_phys(pgdp));
>  
>  	if (system_supports_cnp() && !WARN_ON(pgdp != lm_alias(swapper_pg_dir))) {
>  		/*
> @@ -158,13 +159,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  		 * Also we rely on the cpu_hwcap bit being set before
>  		 * calling the enable() function.
>  		 */
> -		pgd_phys |= TTBR_CNP_BIT;
> +		ttbr1 |= TTBR_CNP_BIT;
>  	}
>  
>  	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
>  
>  	cpu_install_idmap();
> -	replace_phys(pgd_phys);
> +	replace_phys(ttbr1);
>  	cpu_uninstall_idmap();
>  }
>  
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index bde3a3b..2c75b0b 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -190,7 +190,7 @@ ENDPROC(cpu_do_switch_mm)
>  .endm
>  
>  /*
> - * void idmap_cpu_replace_ttbr1(phys_addr_t new_pgd)
> + * void idmap_cpu_replace_ttbr1(phys_addr_t ttbr1)
>   *
>   * This is the low-level counterpart to cpu_replace_ttbr1, and should not be
>   * called by anything else. It can only be executed from a TTBR0 mapping.
> @@ -200,8 +200,7 @@ ENTRY(idmap_cpu_replace_ttbr1)
>  
>  	__idmap_cpu_set_reserved_ttbr1 x1, x3
>  
> -	phys_to_ttbr x3, x0
> -	msr	ttbr1_el1, x3
> +	msr	ttbr1_el1, x0
>  	isb
>  
>  	restore_daif x2

It looks fine. Thanks.

-- 
Catalin
