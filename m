From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 8 Jul 2016 15:47:19 +0100
Subject: [PATCH v8 5/6] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1467911451-24731-6-git-send-email-sudeep.holla@arm.com>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-2-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-5-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160708144719.GI3784@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 06:10:50PM +0100, Sudeep Holla wrote:
> This patch adds appropriate callbacks to support ACPI Low Power Idle
> (LPI) on ARM64.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kernel/cpuidle.c |  18 +++++++
>  drivers/firmware/psci.c     | 122 ++++++++++++++++++++++++++++++++++++--------

I would split this patch in two (ARM64 cpuidle and PSCI) and for
the PSCI code (apologies, blame taken, it is entirely my fault) I
think that the code in v6 was better, I asked you to factor out
DT/ACPI idle states count and parameter retrieval but the end result
is much more complicated than what it was in v6, so for PSCI ACPI
idle states parsing I would revert to v6, apologies.

With changes above:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  2 files changed, 118 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> index 06786fdaadeb..7f16df7d7b23 100644
> --- a/arch/arm64/kernel/cpuidle.c
> +++ b/arch/arm64/kernel/cpuidle.c
> @@ -9,6 +9,9 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> @@ -39,3 +42,18 @@ int arm_cpuidle_suspend(int index)
>  
>  	return cpu_ops[cpu]->cpu_suspend(index);
>  }
> +
> +#ifdef CONFIG_ACPI
> +
> +#include <acpi/processor.h>
> +
> +int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> +{
> +	return arm_cpuidle_init(cpu);
> +}
> +
> +int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> +{
> +	return CPU_IDLE_ENTER_WRAPPED(arm_cpuidle_suspend, lpi->index);
> +}
> +#endif
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 03e04582791c..edd83c884a1d 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -13,6 +13,7 @@
>  
>  #define pr_fmt(fmt) "psci: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/cpuidle.h>
>  #include <linux/errno.h>
> @@ -250,12 +251,84 @@ static int __init psci_features(u32 psci_func_id)
>  #ifdef CONFIG_CPU_IDLE
>  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
>  
> -static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
> +static int psci_dt_get_state_count(struct device_node *cpu_dn)
>  {
> -	int i, ret, count = 0;
> -	u32 *psci_states;
> +	int count = 0;
>  	struct device_node *state_node;
>  
> +	/* Count idle states */
> +	while ((state_node = of_parse_phandle(cpu_dn, "cpu-idle-states",
> +					      count))) {
> +		count++;
> +		of_node_put(state_node);
> +	}
> +
> +	return count;
> +}
> +
> +static int psci_dt_get_idle_state(struct device_node *node, int idx, u32 *state)
> +{
> +	int ret;
> +	struct device_node *state_node;
> +
> +	state_node = of_parse_phandle(node, "cpu-idle-states", idx);
> +
> +	ret = of_property_read_u32(state_node, "arm,psci-suspend-param",
> +				   state);
> +	if (ret)
> +		pr_warn(" * %s missing arm,psci-suspend-param property\n",
> +			state_node->full_name);
> +
> +	of_node_put(state_node);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_ACPI
> +#include <acpi/processor.h>
> +
> +static int psci_acpi_get_state_count(unsigned int cpu)
> +{
> +	struct acpi_processor *pr = per_cpu(processors, cpu);
> +
> +	if (unlikely(!pr || !pr->flags.has_lpi))
> +		return -EINVAL;
> +
> +	return pr->power.count - 1;
> +}
> +
> +static int psci_acpi_get_idle_state(unsigned int cpu, int idx, u32 *state)
> +{
> +	struct acpi_processor *pr = per_cpu(processors, cpu);
> +	struct acpi_lpi_state *lpi = &pr->power.lpi_states[idx + 1];
> +
> +	if (!lpi)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only bits[31:0] represent a PSCI power_state while
> +	 * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification
> +	 */
> +	*state = lpi->address;
> +	return 0;
> +}
> +#else
> +static int psci_acpi_get_state_count(unsigned int cpu)
> +{
> +	return -EINVAL;
> +}
> +
> +static int psci_acpi_get_idle_state(unsigned int cpu, int idx, u32 *state)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
> +static int __psci_cpu_init_idle(struct device_node *cpu_dn, int cpu, bool acpi)
> +{
> +	int i, count, ret;
> +	u32 *psci_states;
> +
>  	/*
>  	 * If the PSCI cpu_suspend function hook has not been initialized
>  	 * idle states must not be enabled, so bail out
> @@ -263,14 +336,12 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  	if (!psci_ops.cpu_suspend)
>  		return -EOPNOTSUPP;
>  
> -	/* Count idle states */
> -	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> -					      count))) {
> -		count++;
> -		of_node_put(state_node);
> -	}
> +	if (acpi)
> +		count = psci_acpi_get_state_count(cpu);
> +	else
> +		count = psci_dt_get_state_count(cpu_dn);
>  
> -	if (!count)
> +	if (count <= 0)
>  		return -ENODEV;
>  
>  	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> @@ -278,21 +349,15 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < count; i++) {
> -		u32 state;
> -
> -		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> +		u32 state = 0;
>  
> -		ret = of_property_read_u32(state_node,
> -					   "arm,psci-suspend-param",
> -					   &state);
> -		if (ret) {
> -			pr_warn(" * %s missing arm,psci-suspend-param property\n",
> -				state_node->full_name);
> -			of_node_put(state_node);
> +		if (acpi)
> +			ret = psci_acpi_get_idle_state(cpu, i, &state);
> +		else
> +			ret = psci_dt_get_idle_state(cpu_dn, i, &state);
> +		if (ret)
>  			goto free_mem;
> -		}
>  
> -		of_node_put(state_node);
>  		pr_debug("psci-power-state %#x index %d\n", state, i);
>  		if (!psci_power_state_is_valid(state)) {
>  			pr_warn("Invalid PSCI power state %#x\n", state);
> @@ -310,11 +375,24 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
>  	return ret;
>  }
>  
> +static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
> +{
> +	return __psci_cpu_init_idle(cpu_node, cpu, false);
> +}
> +
> +static int psci_acpi_cpu_init_idle(unsigned int cpu)
> +{
> +	return __psci_cpu_init_idle(NULL, cpu, true);
> +}
> +
>  int psci_cpu_init_idle(unsigned int cpu)
>  {
>  	struct device_node *cpu_node;
>  	int ret;
>  
> +	if (!acpi_disabled)
> +		return psci_acpi_cpu_init_idle(cpu);
> +
>  	cpu_node = of_get_cpu_node(cpu, NULL);
>  	if (!cpu_node)
>  		return -ENODEV;
> -- 
> 2.7.4
> 
