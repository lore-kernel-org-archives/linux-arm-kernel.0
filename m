From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Jun 2014 17:09:11 +0100
Subject: [PATCH v5 4/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
In-Reply-To: <1403705421-17597-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1403705421-17597-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1403705421-17597-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140625160911.GG15240@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 03:10:17PM +0100, Lorenzo Pieralisi wrote:
> This patch implements the cpu_suspend cpu operations method through
> the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
> index passed by the cpu_suspend core call into a valid PSCI state according to
> the PSCI states initialized at boot by the PSCI suspend backend.
> 
> Entry point is set to cpu_resume physical address, that represents the
> default kernel execution address following a CPU reset.
> 
> Idle state indices missing a DT node description are initialized to power
> state standby WFI so that if called by the idle driver they provide the
> default behaviour.
> 
> Reviewed-by: Sebastian Capella <sebcape@gmail.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/psci.h |   4 ++
>  arch/arm64/kernel/psci.c      | 103 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

[...]

> +static void psci_power_state_unpack(u32 power_state,
> +				    struct psci_power_state *state)
> +{
> +	state->id = (power_state & PSCI_0_2_POWER_STATE_ID_MASK) >>
> +			PSCI_0_2_POWER_STATE_ID_SHIFT;
> +	state->type = (power_state & PSCI_0_2_POWER_STATE_TYPE_MASK) >>
> +			PSCI_0_2_POWER_STATE_TYPE_SHIFT;
> +	state->affinity_level =
> +			(power_state & PSCI_0_2_POWER_STATE_AFFL_MASK) >>
> +			PSCI_0_2_POWER_STATE_AFFL_SHIFT;
> +}

Is this valid for PSCI versions prior to 0.2?

>  /*
>   * The following two functions are invoked via the invoke_psci_fn pointer
>   * and will not be inlined, allowing us to piggyback on the AAPCS.
> @@ -199,6 +216,77 @@ static int psci_migrate_info_type(void)
>  	return err;
>  }
>  
> +int __init psci_dt_register_idle_states(struct cpuidle_driver *drv,
> +					struct device_node *state_nodes[])
> +{
> +	int cpu, i;

Perhaps unsigned int? You print i with %u below.

> +	for (i = 0; i < drv->state_count; i++) {
> +		u32 psci_power_state;
> +
> +		if (!state_nodes[i]) {
> +			/*
> +			 * An index with a missing node pointer falls back to
> +			 * simple STANDBYWFI
> +			 */
> +			psci_states[i].type = PSCI_POWER_STATE_TYPE_STANDBY;
> +			continue;
> +		}

Does this make sense? Are there any limitations on which state nodes
could be missing?

> +
> +		if (of_property_read_u32(state_nodes[i], "entry-method-param",
> +					 &psci_power_state)) {
> +			pr_warn(" * %s missing entry-method-param property\n",
> +				state_nodes[i]->full_name);
> +			/*
> +			 * If entry-method-param property is missing, fall
> +			 * back to STANDBYWFI state
> +			 */
> +			psci_states[i].type = PSCI_POWER_STATE_TYPE_STANDBY;
> +			continue;

Surely we want to throw away these states instead?

Otherwise we can get into a mess like:

psci_states[0] => low power state
psci_states[1] => lower power state
psci_states[2] => WFI / not low power
psci_states[3] => lowest power state

Where power usage and latency would jump around rather than follow
monotonic patterns.

Thanks,
Mark.
