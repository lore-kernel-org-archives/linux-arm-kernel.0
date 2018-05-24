From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 24 May 2018 12:27:11 +0100
Subject: [PATCH 04/14] arm64: Add ARCH_WORKAROUND_2 probing
In-Reply-To: <20180522150648.28297-5-marc.zyngier@arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-5-marc.zyngier@arm.com>
Message-ID: <20180524112711.rmjoyifcwbu3xsqz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 04:06:38PM +0100, Marc Zyngier wrote:
> As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
> discovery mechanism for detecting the SSBD mitigation.
> 
> A new capability is also allocated for that purpose, and a
> config option.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

[...]

> +static void do_ssbd(bool state)
> +{
> +	switch (psci_ops.conduit) {
> +	case PSCI_CONDUIT_HVC:
> +		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
> +		break;
> +
> +	case PSCI_CONDUIT_SMC:
> +		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
> +		break;
> +
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +}
> +
> +static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> +				    int scope)
> +{
> +	struct arm_smccc_res res;
> +	bool supported = true;
> +
> +	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> +
> +	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
> +		return false;
> +
> +	/*
> +	 * The probe function return value is either negative
> +	 * (unsupported or mitigated), positive (unaffected), or zero
> +	 * (requires mitigation). We only need to do anything in the
> +	 * last case.
> +	 */
> +	switch (psci_ops.conduit) {
> +	case PSCI_CONDUIT_HVC:
> +		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
> +		if ((int)res.a0 != 0)
> +			supported = false;
> +		break;
> +
> +	case PSCI_CONDUIT_SMC:
> +		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
> +		if ((int)res.a0 != 0)
> +			supported = false;
> +		break;

Once this is merged, I'll rebase my SMCCCC conduit cleanup atop.

Mark.
