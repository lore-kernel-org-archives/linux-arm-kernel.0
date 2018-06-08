From: james.morse@arm.com (James Morse)
Date: Fri, 8 Jun 2018 18:44:01 +0100
Subject: [PATCH v4 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <1526638022-4137-2-git-send-email-vladimir.murzin@arm.com>
References: <1526638022-4137-1-git-send-email-vladimir.murzin@arm.com>
 <1526638022-4137-2-git-send-email-vladimir.murzin@arm.com>
Message-ID: <0fe34377-4277-0de6-2cc7-ebb6c0aaf889@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 18/05/18 11:07, Vladimir Murzin wrote:
> Common Not Private (CNP) is a feature of ARMv8.2 extension which
> allows translation table entries to be shared between different PEs in
> the same inner shareable domain, so the hardware can use this fact to
> optimise the caching of such entries in the TLB.
> 
> CNP occupies one bit in TTBRx_ELy and VTTBR_EL2, which advertises to
> the hardware that the translation table entries pointed to by this
> TTBR are the same as every PE in the same inner shareable domain for
> which the equivalent TTBR also has CNP bit set. In case CNP bit is set
> but TTBR does not point at the same translation table entries for a
> given ASID and VMID, then the system is mis-configured, so the results
> of translations are UNPREDICTABLE.
> 
> For EL1 we postpone setting CNP till all cpus are up and rely on
> cpufeature framework to 1) patch the code which is sensitive to CNP
> and 2) update TTBR1_EL1 with CNP bit set. TTBR1_EL1 can be
> reprogrammed as result of hibernation or cpuidle (via __enable_mmu).
> cpuidle's path has been changed to restore CnP and for hibernation the
> code has been changed to save raw TTBR1_EL1 and blindly restore it on
> resume.
> 
> For EL0 there are a few cases we need to care of changes in
> TTBR0_EL1:
>   - a switch to idmap
>   - software emulated PAN

(Nit: I don't think this has anything to do with EL0, its just the low half of
the VA space in TTBR0...)

> we rule out latter via Kconfig options and for the former we make
> sure that CNP is set for non-zero ASIDs only.

Reviewed-by: James Morse <james.morse@arm.com>


> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 39ec0b8..4f9e3ea 100644
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
> +                 * Also we rely on the cpu_hwcap bit being set before

(Nit: stray whitespace)


> +		 * calling the enable() function.
> +		 */
> +		pgd_phys |= TTBR_CNP_BIT;
> +	}
> +
>  	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
>  
>  	cpu_install_idmap();


> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9d1b06d..199e9dd 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -858,6 +860,16 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
>  	return read_sanitised_ftr_reg(SYS_CTR_EL0) & BIT(CTR_DIC_SHIFT);
>  }
>  
> +static bool __maybe_unused
> +has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
> +{
> +#ifdef CONFIG_CRASH_DUMP
> +	if (elfcorehdr_size)
> +		return false;
> +#endif

It might be worth a comment why kdump is relevant, (here or in the commit
message). Kdump isn't guaranteed to power-off all secondary CPUs, CNP may share
TLB entries with a CPU stuck in the crashed kernel.

I don't think we can't trust it even if we bring all CPUs into the new kernel as
the DT may not reflect all the CPUs the crashed-kernel had. (kexec doesn't have
this problem as it always powers-off secondaries before kexec-ing)


> +	return has_cpuid_feature(entry, scope);
> +}
> +
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>  
> @@ -1642,6 +1667,11 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
>  	return (cpus_have_const_cap(ARM64_HAS_PAN) && !cpus_have_const_cap(ARM64_HAS_UAO));
>  }
>  
> +static void __maybe_unused cpu_enable_cnp (struct arm64_cpu_capabilities const *cap)

Nit: stray space between cpu_enable_cnp and the parameters.


> +{
> +	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> +}
> +
>  /*
>   * We emulate only the following system register space.
>   * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 1ec5f28..ea27121 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -125,7 +125,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  		return -EOVERFLOW;
>  
>  	arch_hdr_invariants(&hdr->invariants);
> -	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
> +	hdr->ttbr1_el1		= read_sysreg(ttbr1_el1);
>  	hdr->reenter_kernel	= _cpu_resume;
>  
>  	/* We can't use __hyp_get_vectors() because kvm may still be loaded */

We also run__cpu_suspend_exit() from hibernate's restore, which will restore CNP
so this isn't strictly necessary.

There is some future-cleanup we can do here, if hibernate set the idmap when
calling __cpu_suspend_exit(), that function could do the replace_ttbr1() without
an extra install/uninstall of the idmap.



Thanks,

James
