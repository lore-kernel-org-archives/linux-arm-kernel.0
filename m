From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Feb 2018 17:23:58 +0000
Subject: [RFC PATCH v3 3/3] arm64/kernel: enable A53 erratum #8434319
 handling at runtime
In-Reply-To: <20180214113645.16793-4-ard.biesheuvel@linaro.org>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-4-ard.biesheuvel@linaro.org>
Message-ID: <20180223172358.kxo2aaamybz5674g@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 11:36:45AM +0000, Ard Biesheuvel wrote:
> Omit patching of ADRP instruction at module load time if the current
> CPUs are not susceptible to the erratum.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Open question: how should we handle big.LITTLE configurations where affected
> Cortex-A53s may appear late.

I think verify_local_cpu_errata_workarounds() will handle that for us,
aborting the late onlining of a CPU with an erratum a boot CPU didn't
have.

[...]

> +static bool __maybe_unused
> +needs_erratum_843419_workaround(const struct arm64_cpu_capabilities *entry,
> +				int scope)
> +{
> +	u32 cpuid = read_cpuid_id();
> +
> +	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> +
> +	if ((cpuid & MIDR_CPU_MODEL_MASK) != MIDR_CORTEX_A53)
> +		return false;
> +	else if ((cpuid & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)) == 0x4)
> +		/* erratum was fixed in some versions of r0p4 */
> +		return !(read_cpuid(REVIDR_EL1) & BIT(8));
> +	else
> +		return true;
> +}

This would be easier to read as:

	if ((cpuid & MIDR_CPU_MODEL_MASK) != MIDR_CORTEX_A53)
		return false;

	/* erratum was fixed in some versions of r0p4 */
	if ((cpuid & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)) == 0x4)
		return !(read_cpuid(REVIDR_EL1) & BIT(8));
	
	return true;

Thanks,
Mark.
