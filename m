From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Aug 2016 11:38:01 +0530
Subject: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
In-Reply-To: <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <20160829060801.GB5094@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-08-16, 16:52, Finlye Xiao wrote:
> +static int rockchip_adjust_opp_table(struct device *cpu_dev,
> +				     struct cpufreq_frequency_table *table,
> +				     int volt)
> +{
> +	struct opp_table *opp_table;
> +	struct cpufreq_frequency_table *pos;
> +	struct dev_pm_opp *opp;
> +
> +	if (!volt)
> +		return 0;
> +
> +	rcu_read_lock();
> +
> +	opp_table = _find_opp_table(cpu_dev);
> +	if (IS_ERR(opp_table)) {
> +		rcu_read_unlock();
> +		return PTR_ERR(opp_table);
> +	}
> +
> +	cpufreq_for_each_valid_entry(pos, table) {
> +		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * 1000,
> +						 true);
> +		if (IS_ERR(opp))
> +			continue;
> +
> +		opp->u_volt += volt;
> +		opp->u_volt_min += volt;
> +		opp->u_volt_max += volt;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	return 0;
> +}

I wouldn't prefer altering the opp tables from individual drivers at all. At the
least, it should be done via some helpers exposed by the core.

But before that I would like to hear from Stephen a bit as I recall he was also
working on something similar.

-- 
viresh
