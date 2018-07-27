From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jul 2018 12:35:02 +0100
Subject: [PATCH v5 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1529403502-2843-2-git-send-email-vladimir.murzin@arm.com>
References: <1529403502-2843-1-git-send-email-vladimir.murzin@arm.com>
 <1529403502-2843-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20180727113502.3qdbyffuvysva6bz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, Jun 19, 2018 at 11:18:20AM +0100, Vladimir Murzin wrote:
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 39ec0b8..c506fb7 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -149,6 +149,18 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  
>  	phys_addr_t pgd_phys = virt_to_phys(pgdp);
>  
> +	if (system_supports_cnp() && !WARN_ON(pgdp != lm_alias(swapper_pg_dir))) {
> +		/*
> +		 * cpu_replace_ttbr1() is used when there's a boot CPU
> +		 * up (i.e. cpufeature framework is not up yet) and
> +		 * latter only when we enable CNP via cpufeature's
> +		 * enable() callback.
> +		 * Also we rely on the cpu_hwcap bit being set before
> +		 * calling the enable() function.
> +		 */
> +		pgd_phys |= TTBR_CNP_BIT;
> +	}
> +
>  	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);

So the above code sets the TTBR_CNP_BIT (bit 0) in pgd_phys and calls
the idmap_cpu_replace_ttbr1() with this value. Looking at the latter, it
performs a phys_to_ttbr transformation of pgd_phys which masks out the
bottom 2 bits when CONFIG_ARM64_PA_BITS_52 is enabled. I think we need
to tweak TTBR_BADDR_MASK_52 to start from bit 0.

(cc'ing Kristina as she added this code, in case there is any issue with
extending the mask)

-- 
Catalin
