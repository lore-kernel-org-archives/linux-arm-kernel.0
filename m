From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 13 Oct 2017 16:31:48 +0100
Subject: [PATCH v3 04/13] arm64: alternatives: use tpidr_el2 on VHE hosts
In-Reply-To: <20170922182614.27885-5-james.morse@arm.com>
References: <20170922182614.27885-1-james.morse@arm.com>
 <20170922182614.27885-5-james.morse@arm.com>
Message-ID: <20171013153148.dnejsvhxeui6opfw@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 07:26:05PM +0100, James Morse wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index cd52d365d1f0..8e4c7da2b126 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -865,6 +865,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.capability = ARM64_HAS_VIRT_HOST_EXTN,
>  		.def_scope = SCOPE_SYSTEM,
>  		.matches = runs_at_el2,
> +		.enable = cpu_copy_el2regs,
>  	},
>  	{
>  		.desc = "32-bit EL0 Support",
> @@ -1308,3 +1309,25 @@ static int __init enable_mrs_emulation(void)
>  }
>  
>  late_initcall(enable_mrs_emulation);
> +
> +int cpu_copy_el2regs(void *__unused)
> +{
> +	int do_copyregs = 0;
> +
> +	/*
> +	 * Copy register values that aren't redirected by hardware.
> +	 *
> +	 * Before code patching, we only set tpidr_el1, all CPUs need to copy
> +	 * this value to tpidr_el2 before we patch the code. Once we've done
> +	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
> +	 * do anything here.
> +	 */
> +	asm volatile(ALTERNATIVE("mov %0, #1", "mov %0, #0",
> +				 ARM64_HAS_VIRT_HOST_EXTN)
> +		    : "=r" (do_copyregs) : : );

Can you just do:

	if (cpu_have_const_cap(ARM64_HAS_VIRT_HOST_EXTN))
		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);

At this point the capability bits should be set and the jump labels
enabled.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
