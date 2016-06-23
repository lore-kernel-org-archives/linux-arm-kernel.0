From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Jun 2016 18:38:22 +0100
Subject: [PATCH 01/14] PM / Domains: Allow domain power states to be read
 from DT
In-Reply-To: <1466624209-27432-2-git-send-email-lina.iyer@linaro.org>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160623173822.GB22204@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 01:36:36PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
> 
> This patch allows domains to define idle states in the DT. SoC's can
> define domain idle states in DT using the "power-states" property of the
> domain provider. Calling of_pm_genpd_init() will  read the idle states
> and initialize the genpd for the domain.
> 
> In addition to the entry and exit latency for idle state, also add
> residency and state-param properties. A domain idling in a state is only
> power effecient if it stays idle for a certain period in that state. The
> residency provides this minimum time for the idle state to provide power
> benefits. The state-param is a state specific u32 value that the
> platform may use for that idle state.
> 
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple
> state support,changed to use pm_genpd_init()]
> ---
>  drivers/base/power/domain.c | 84 ++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pm_domain.h   |  3 ++
>  2 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a1f2aff..62ffabd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1253,6 +1253,82 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
>  
> +static int genpd_of_get_power_state(struct genpd_power_state *genpd_state,
> +				    struct device_node *state_node)
> +{
> +	int err = 0;
> +	u32 latency;
> +	u32 residency;
> +	u32 param;
> +	u32 entry_latency, exit_latency;
> +
> +	err = of_property_read_u32(state_node, "entry-latency-us",
> +				   &entry_latency);
> +	if (err) {
> +		pr_debug(" * %s missing entry-latency-us property\n",
> +			 state_node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	err = of_property_read_u32(state_node, "exit-latency-us",
> +				   &exit_latency);
> +	if (err) {
> +		pr_debug(" * %s missing exit-latency-us property\n",
> +			 state_node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	err = of_property_read_u32(state_node, "residency-us", &residency);
> +	if (!err)
> +		genpd_state->residency_ns = 1000 * residency;
> +
> +	err = of_property_read_u32(state_node, "state-param", &param);
> +	if (!err)
> +		genpd_state->param = param;
> +
> +	latency = entry_latency + exit_latency;
> +	genpd_state->power_on_latency_ns = 1000 * latency;
> +	genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +
> +	return 0;
> +}

As with the binding, I would very much prefer that this were unfiied
with the existing idle state parsing. I'm not keen on having two
arbitrarily different idle state binidngs and parsers.

Thanks,
Mark.
