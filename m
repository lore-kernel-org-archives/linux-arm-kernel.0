From: l.majewski@samsung.com (Lukasz Majewski)
Date: Fri, 10 Jan 2014 13:03:57 +0100
Subject: [PATCH 1/6] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <1389283165-17708-2-git-send-email-thomas.ab@samsung.com>
References: <1389283165-17708-1-git-send-email-thomas.ab@samsung.com>
 <1389283165-17708-2-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140110130357.0f3014f1@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

> On some platforms such as the Samsung Exynos, changing the frequency
> of the CPU clock requires changing the frequency of the PLL that is
> supplying the CPU clock. To change the frequency of the PLL, the CPU
> clock is temporarily reparented to another parent clock.

Please look into my comments about reparenting at PATCH 3/6.

> 
> The clock frequency of this temporary parent clock could be much
> higher than the clock frequency of the PLL at the time of
> reparenting. Due to the temporary increase in the CPU clock speed,
> the CPU (and any other components in the CPU clock domain such as
> dividers, mux, etc.) have to to be operated at a higher voltage
> level, called the safe voltage level. This patch adds optional
> support to temporarily switch to a safe voltage level during CPU
> frequency transitions.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    5 ++
>  drivers/cpufreq/cpufreq-cpu0.c                     |   49
> +++++++++++++++++++- 2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt index
> f055515..020d859 100644 ---
> a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt +++
> b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt @@ -19,6
> +19,10 @@ Optional properties:
>  - cooling-min-level:
>  - cooling-max-level:
>       Please refer to
> Documentation/devicetree/bindings/thermal/thermal.txt. +-
> safe-opp-index: Certain platforms require that during a opp
> transition,
> +  a system should not go below a particular opp level. For such
> systems,
> +  this property specifies the minimum opp to be maintained during the
> +  opp transitions.
>  
>  Examples:
>  
> @@ -36,6 +40,7 @@ cpus {
>  			396000  950000
>  			198000  850000
>  		>;
> +		safe-opp-index = <1>;
>  		clock-latency = <61036>; /* two CLK32 periods */
>  		#cooling-cells = <2>;
>  		cooling-min-level = <0>;
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c
> b/drivers/cpufreq/cpufreq-cpu0.c index 0c12ffc..dda4b7b 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -27,6 +27,8 @@
>  
>  static unsigned int transition_latency;
>  static unsigned int voltage_tolerance; /* in percentage */
> +static unsigned long safe_frequency;
> +static unsigned long safe_voltage;
>  
>  static struct device *cpu_dev;
>  static struct clk *cpu_clk;
> @@ -69,12 +71,26 @@ static int cpu0_set_target(struct cpufreq_policy
> *policy, unsigned int index) new_freq / 1000, volt ? volt / 1000 :
> -1); 
>  	/* scaling up?  scale voltage before frequency */
> -	if (!IS_ERR(cpu_reg) && new_freq > old_freq) {
> +	if (!IS_ERR(cpu_reg) && new_freq > old_freq &&
> +				new_freq >= safe_frequency) {
>  		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
>  		if (ret) {
>  			pr_err("failed to scale voltage up: %d\n",
> ret); return ret;
>  		}
> +	} else if (!IS_ERR(cpu_reg) && old_freq < safe_frequency) {
> +		/*
> +		 * the scaled up voltage level for the new_freq is
> lower
> +		 * than the safe voltage level. so set safe_voltage
> +		 * as the intermediate voltage level and revert it
> +		 * back after the frequency has been changed.
> +		 */
> +		ret = regulator_set_voltage(cpu_reg, safe_voltage,
> +						safe_voltage);
> +		if (ret) {
> +			pr_err("failed to set safe voltage: %d\n",
> ret);
> +			return ret;
> +		}
>  	}
>  
>  	ret = clk_set_rate(cpu_clk, freq_exact);
> @@ -94,6 +110,19 @@ static int cpu0_set_target(struct cpufreq_policy
> *policy, unsigned int index) }
>  	}
>  
> +	/*
> +	 * if safe voltage was applied during voltage scale up, then
> set
> +	 * the correct target voltage now.
> +	 */
> +	if (!IS_ERR(cpu_reg) && new_freq > old_freq &&
> +					new_freq < safe_frequency) {
> +		ret = regulator_set_voltage_tol(cpu_reg, volt, tol);
> +		if (ret) {
> +			pr_err("failed to scale voltage up: %d\n",
> ret);
> +			return ret;
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> @@ -116,7 +145,9 @@ static struct cpufreq_driver cpu0_cpufreq_driver
> = { 
>  static int cpu0_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct dev_pm_opp *opp;
>  	struct device_node *np;
> +	unsigned int safe_opp_index;
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(0);
> @@ -165,13 +196,27 @@ static int cpu0_cpufreq_probe(struct
> platform_device *pdev) goto out_put_node;
>  	}
>  
> +	if (!of_property_read_u32(np, "safe-opp-index",
> &safe_opp_index)) {
> +		rcu_read_lock();
> +		opp = dev_pm_opp_find_freq_exact(cpu_dev,
> +			freq_table[safe_opp_index].frequency * 1000,
> true);
> +		if (IS_ERR(opp)) {
> +			rcu_read_unlock();
> +			pr_err("safe opp index %d is invalid\n",
> +
> safe_opp_index);
> +			goto out_free_table;
> +		}
> +		safe_voltage = dev_pm_opp_get_voltage(opp);
> +		safe_frequency =
> freq_table[safe_opp_index].frequency;
> +		rcu_read_unlock();
> +	}
> +
>  	of_property_read_u32(np, "voltage-tolerance",
> &voltage_tolerance); 
>  	if (of_property_read_u32(np, "clock-latency",
> &transition_latency)) transition_latency = CPUFREQ_ETERNAL;
>  
>  	if (!IS_ERR(cpu_reg)) {
> -		struct dev_pm_opp *opp;
>  		unsigned long min_uV, max_uV;
>  		int i;
>  

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
