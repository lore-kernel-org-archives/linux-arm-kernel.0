From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Sep 2018 14:30:41 +0100
Subject: [PATCH RESEND 4/6] arm64: add sysfs vulnerability show for
 spectre v2
In-Reply-To: <20180827143310.641-5-ykaukab@suse.de>
References: <20180827143310.641-1-ykaukab@suse.de>
 <20180827143310.641-5-ykaukab@suse.de>
Message-ID: <20180917133041.GC23040@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 04:33:08PM +0200, Mian Yousaf Kaukab wrote:
> Only report mitigation present if hardening callback has been
> successfully installed.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> ---
>  arch/arm64/kernel/cpu_errata.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 92616431ae4e..8469d3be7b15 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -481,7 +481,8 @@ multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
>  			caps->cpu_enable(caps);
>  }
>  
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +#if defined(CONFIG_HARDEN_BRANCH_PREDICTOR) || \
> +	defined(CONFIG_GENERIC_CPU_VULNERABILITIES)
>  
>  /*
>   * List of CPUs where we need to issue a psci call to
> @@ -712,4 +713,35 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  }
>  
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	u64 pfr0;
> +	struct bp_hardening_data *data;
> +
> +	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
> +	if (cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_CSV2_SHIFT))
> +		return sprintf(buf, "Not affected\n");

This strikes me as a pretty terrible interface, as it means that the file
can return different contents depending on which CPU it was read from on a
big/little machine. I think we need to either expose this per-cpu, or expose
the value of the system (e.g. if one CPU is vulnerable, we always say
vulnerable).

> +
> +	if (cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR)) {
> +		/*
> +		 * Hardware is vulnerable. Lets check if bp hardening callback
> +		 * has been successfully installed
> +		 */
> +		data = arm64_get_bp_hardening_data();

Related to the above, but this is accessing per-cpu stuff.

Will
