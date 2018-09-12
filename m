From: james.morse@arm.com (James Morse)
Date: Wed, 12 Sep 2018 11:28:20 +0100
Subject: [PATCH v5 02/27] arm64: cpufeature: Use alternatives for VHE
 cpu_enable
In-Reply-To: <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-3-git-send-email-julien.thierry@arm.com>
Message-ID: <1d425320-aed3-b949-1ec5-f378248aac4d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> The cpu_enable callback for VHE feature requires all alternatives to have
> been applied. This prevents applying VHE alternative separately from the
> rest.
> 
> Use an alternative depending on VHE feature to know whether VHE
> alternatives have already been applied.

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1e433ac..3bc1c8b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1022,8 +1024,15 @@ static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
>  	 * that, freshly-onlined CPUs will set tpidr_el2, so we don't need to
>  	 * do anything here.
>  	 */
> -	if (!alternatives_applied)
> -		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
> +	asm volatile(ALTERNATIVE(
> +		"mrs	%0, tpidr_el1\n"
> +		"msr	tpidr_el2, %0",
> +		"nop\n"
> +		"nop",
> +		ARM64_HAS_VIRT_HOST_EXTN)
> +		: "+r" (tmp)
> +		:
> +		: "memory");
>  }
>  #endif

Catalin's preference was to keep this all in C:
https://patchwork.kernel.org/patch/10007977/
, for which we need to know if 'the' alternative has been applied.

I suspect there may be more registers in this list if we have to switch to
another EL2 register using alternatives. (but I don't have an example).

Could we make 'alternatives_applied' a macro that takes the cap as an argument?


Thanks,

James
