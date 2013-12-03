From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Tue, 3 Dec 2013 16:46:23 +0000
Subject: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC
 related stuff to make it more arch-independent
In-Reply-To: <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203164623.GB13447@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 12:36:47AM +0800, Hanjun Guo wrote:

> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  	/* Enable coordination with firmware's _TSD info */
>  	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
> +	if (boot_option_idle_override == IDLE_NOMWAIT) {
> +		/*
> +		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
> +		 * mode will be disabled in the parameter of _PDC object.
> +		 * Of course C1_FFH access mode will also be disabled.
> +		 */
> +		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> +
> +	}
> +#endif

This is (fairly) arch-specific, so why not move it to 
arch_acpi_set_pdc_bits()?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
