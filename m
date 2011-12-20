From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 14:59:04 +0000
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111220145904.GD29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 11:21:40AM +0800, Richard Zhao wrote:
> It support single core and multi-core ARM SoCs. But currently it assume
> all cores share the same frequency and voltage.

My comments on the previous version of the patch still apply:

 - The voltage ranges being set need to be specified as ranges.
 - Frequencies that can't be supported due to limitations of the
   available supplies shouldn't be exposed to users.
 - The driver needs to handle errors.

> +Required properties in /cpus/cpu at 0:
> +- compatible : "generic-cpufreq"
> +- cpu-freqs : cpu frequency points it support
> +- cpu-volts : cpu voltages required by the frequency point at the same index
> +- trans-latency :  transition_latency

You need to define units for all of these, and for the transition
latency you need to be clear about what's being measured (it looks like
the CPU time only, not any voltage ramping).

You also need to define how the core supplies get looked up.

> +	/* Manual states, that PLL stabilizes in two CLK32 periods */
> +	policy->cpuinfo.transition_latency = trans_latency;

I guess this comment is a cut'n'paste error.

> +
> +	ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +
> +	if (ret < 0) {
> +		pr_err("%s: invalid frequency table for cpu %d\n",
> +		       __func__, policy->cpu);

You should define pr_fmt to always include __func__ in the messages
rather than open coding - ensures consistency and is less noisy in the
code.

> +	pr_info("Generic CPU frequency driver\n");

This seems noisy...
