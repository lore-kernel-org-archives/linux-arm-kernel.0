From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 May 2018 08:47:42 -0700
Subject: [PATCH v3 08/15] ARM: spectre-v2: harden user aborts in kernel
 space
In-Reply-To: <E1fMDHD-00073Q-Ob@rmk-PC.armlinux.org.uk>
References: <20180525135938.GE17671@n2100.armlinux.org.uk>
 <E1fMDHD-00073Q-Ob@rmk-PC.armlinux.org.uk>
Message-ID: <20180525154742.GA77025@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@armlinux.org.uk> [180525 15:10]:
> +static void cpu_v7_spectre_init(void)
> +{
> +	const char *spectre_v2_method = NULL;
> +	int cpu = smp_processor_id();
> +
> +	if (per_cpu(harden_branch_predictor_fn, cpu))
> +		return;
> +
> +	switch (read_cpuid_part()) {
> +	case ARM_CPU_PART_CORTEX_A8:
> +	case ARM_CPU_PART_CORTEX_A9:
> +	case ARM_CPU_PART_CORTEX_A12:
> +	case ARM_CPU_PART_CORTEX_A17:
> +	case ARM_CPU_PART_CORTEX_A73:
> +	case ARM_CPU_PART_CORTEX_A75:
> +		per_cpu(harden_branch_predictor_fn, cpu) =
> +			harden_branch_predictor_bpiall;
> +		spectre_v2_method = "BPIALL";
> +		break;
> +
> +	case ARM_CPU_PART_CORTEX_A15:
> +	case ARM_CPU_PART_BRAHMA_B15:
> +		per_cpu(harden_branch_predictor_fn, cpu) =
> +			harden_branch_predictor_iciallu;
> +		spectre_v2_method = "ICIALLU";
> +		break;
> +	}
> +	if (spectre_v2_method)
> +		pr_info("CPU%u: Spectre v2: using %s workaround\n",
> +			smp_processor_id(), spectre_v2_method);
> +}

We can now get this with the whole series applied:

CPU0: Spectre v2: firmware did not set auxiliary control register
IBE bit, system vulnerable
CPU: Spectre v2: using ICIALLU workaround

So maybe change the wording from "using %s workaround" to
"chosen workaround %s"?

Or I guess disabling the pr_info when not functional can
be done in the later patches based on some variable set
by check_spectre_auxcr() would be doable too.

Regards,

Tony
