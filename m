From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Mar 2017 12:27:04 +0000
Subject: [PATCH] arm64: mm: Add workaround for Qualcomm Technologies
 Falkor erratum E1029
In-Reply-To: <1488500355-7199-1-git-send-email-timur@codeaurora.org>
References: <1488500355-7199-1-git-send-email-timur@codeaurora.org>
Message-ID: <20170303122703.GA12945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 06:19:15PM -0600, Timur Tabi wrote:
> From: Neil Leeder <nleeder@codeaurora.org>
> 
> The Falkor core includes support for generating interrupt requests from
> CPU or L2 performance monitor events or cycle counter overflows,
> resulting in an IRQ or FIQ asynchronous interrupt request.  In cases
> where the CPU performance monitor interrupt request is generated in
> close proximity to the instruction stream executing a WFI or WFE
> instruction, the Falkor core may hang prior to entering the wait
> state.
> 
> The workaround for this condition is to add a config option and
> alternative_if processing in cpu_do_idle. For falkor v1 processor
> For processors other than Falkor v1, these instructions are
> replaced by nops.

The idle loop is not the only place where WFI can occur.

Notably, firmware is within its rights to use WFI, as is userspace given
that SCTLR_EL1.nTWI is set at boot time. So IIUC, userspace can deadlock
a core, which makes this sound very serious.

Can this *only* happen for the PMU interrupt?

I assume that as mentioned for other Falkor workarounds "the affected
chips are pre-production and are only available to select customers for
a limited time"?

Given that we're having to a fair amount of the arm64 core code, for
parts that QC don't even intend to support long term, it's increasingly
difficult to care about this upstream.

Are additional workarounds necessary for these parts?

[...]

>  ENTRY(cpu_do_idle)
> -	dsb	sy				// WFI may enter a low-power mode
> +#ifndef CONFIG_QCOM_FALKOR_ERRATUM_E1029
> +	dsb	sy			// WFI may enter a low-power mode
>  	wfi
>  	ret
> +#else
> +alternative_if_not ARM64_WORKAROUND_QCOM_FALKOR_E1029
> +	dsb	sy			// WFI may enter a low-power mode
> +	wfi
> +	ret
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +alternative_else
> +	mrs	x2, pmintenset_el1
> +	msr	pmintenclr_el1, x2
> +	isb
> +	dsb	sy			// WFI may enter a low-power mode
> +	wfi
> +	msr	pmintenset_el1, x2
> +	isb
> +	ret
> +alternative_endif
> +#endif
>  ENDPROC(cpu_do_idle)

NAK to poking the PMU registers here. This path shouldn't know anything
about the PMU.

Thanks,
Mark.
