From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 18 Aug 2016 14:02:51 -0500
Subject: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
In-Reply-To: <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
 (Finlye Xiao's message of "Thu, 18 Aug 2016 16:52:21 +0800")
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <1471510341-63926-5-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <m260qxrjc4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finlye,

Finlye Xiao <finley.xiao@rock-chips.com> writes:

> From: Finley Xiao <finley.xiao@rock-chips.com>
>
> This patch supports adjusting opp's voltage according to leakage
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

[...]

> +static void rockchip_adjust_volt_by_leakage(struct device *cpu_dev,
> +					    struct cpufreq_policy *policy,
> +					    struct rockchip_cpu_avs *avs,
> +					    int id)
> +{
> +	struct cluster_info *cluster = &avs->cluster[id];
> +	int ret;
> +
> +	if (cluster->leakage)
> +		goto next;
>
> +	ret = rockchip_get_leakage(cpu_dev, &cluster->leakage);
> +	if (ret) {
> +		dev_err(avs->dev, "cpu%d leakage invalid\n", policy->cpu);
> +		return;
> +	}
> +
> +	ret = rockchip_get_offset_volt(cluster->leakage, cluster->table,
> +				       &cluster->adjust_volt);
> +	if (ret) {
> +		dev_err(avs->dev, "cpu%d leakage volt table err\n",
> +			policy->cpu);
> +		return;
> +	}

Rather than do this for each notifier, since the table is static, why
not fill out struct cluster_info during probe?

I see there is a check above to skip this if it's already filled out,
but since the data is static, why not fill it out once at probe.

> +next:
> +	ret = rockchip_adjust_opp_table(cpu_dev, policy->freq_table,
> +					cluster->adjust_volt);
> +	if (ret)
> +		dev_err(avs->dev, "cpu%d failed to adjust volt\n", policy->cpu);
> +
> +	dev_dbg(avs->dev, "cpu%d, leakage=%d, adjust_volt=%d\n", policy->cpu,
> +		cluster->leakage, cluster->adjust_volt);
> +}

[...]

> +static int rockchip_cpu_avs_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_cpu_avs *avs;
> +	char name[MAX_NAME_LEN];
> +	int i, ret, cpu, id;
> +	int last_id = -1;
> +	int cluster_num = 0;
> +
> +	for_each_online_cpu(cpu) {
> +		id = topology_physical_package_id(cpu);
> +		if (id < 0)
> +			return -EINVAL;
> +		if (id != last_id) {
> +			last_id = id;
> +			cluster_num++;
> +		}
> +	}

I don't think this counting is quite correct since physical and logial
CPU numbering is not guaranteed.

For example, I've seen big.LITTLE systems where the first little CPU is
the boot CPU, but the big CPUs are the next ones booted, you end up with
something like:

little cluster: CPU0,5-7
big cluster: CPU1-4

So your counting mechansim above would count 3 clusters in that case.

> +	avs = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_cpu_avs),
> +			   GFP_KERNEL);
> +	if (!avs)
> +		return -ENOMEM;
> +
> +	avs->dev = &pdev->dev;
> +	avs->cpufreq_notify.notifier_call = rockchip_cpu_avs_notifier;
> +	avs->cluster = devm_kzalloc(&pdev->dev,
> +		sizeof(struct cluster_info) * cluster_num, GFP_KERNEL);
> +	if (!avs->cluster)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cluster_num; i++) {
> +		snprintf(name, MAX_NAME_LEN, "leakage-volt-cluster%d", i);
> +		ret = rockchip_get_leakage_volt_table(&pdev->dev,
> +						      &avs->cluster[i].table,
> +						      name);
> +		if (ret)
> +			continue;
> +	}
> +
> +	return cpufreq_register_notifier(&avs->cpufreq_notify,
> +		CPUFREQ_POLICY_NOTIFIER);
> +}

Other than those minor comments, I think the driver looks good to me.

After those changes. We'll also need to see acks from the DT folks on
the DT changes and bindings before merging.

Kevin
