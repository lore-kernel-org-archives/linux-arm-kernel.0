From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 16:28:09 +0000
Subject: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
In-Reply-To: <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
 <1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20150309162809.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 04:49:15PM +0800, pi-cheng.chen wrote:
> +static int cpu_opp_table_get_freq_index(unsigned int freq)
> +{
> +	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
> +	int i;
> +
> +	for (i = 0; opp_tbl[i].freq != 0; i++) {
> +		if (opp_tbl[i].freq >= freq)
> +			return i;
> +	}
> +
> +	return -1;

My "return -1" detector fired on this...

> +static int cpu_opp_table_get_volt_index(unsigned int volt)
> +{
> +	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
> +	int i;
> +
> +	for (i = 0; opp_tbl[i].vproc != -1; i++)
> +		if (opp_tbl[i].vproc >= volt)
> +			return i;
> +
> +	return -1;

And this.

> +static int mtk_cpufreq_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data)
> +{
> +	struct cpufreq_freqs *freqs = data;
> +	struct cpu_opp_table *opp_tbl = dvfs_info->opp_tbl;
> +	int old_vproc, new_vproc, old_index, new_index;
> +
> +	if (!cpumask_test_cpu(freqs->cpu, &dvfs_info->cpus))
> +		return NOTIFY_DONE;
> +
> +	old_vproc = regulator_get_voltage(dvfs_info->proc_reg);
> +	old_index = cpu_opp_table_get_volt_index(old_vproc);
> +	new_index = cpu_opp_table_get_freq_index(freqs->new * 1000);
> +	new_vproc = opp_tbl[new_index].vproc;

Let's say that cpu_opp_table_get_freq_index() returns -1.  We then
do no error checking on this, and access the memory immediately
preceding opp_tbl[0].

Since we'll be loading garbage from opp_tbl[-1], this probably means
that mtk_cpufreq_voltage_trace() will go wrong.  Your method of using
the vproc values to work out which direction we should walk between
old_index...new_index means that we could end up walking through
almost the whole UINT_MAX range to wrap around to the new index.

Yet again, "return -1" proves to be a sure sign of a bug.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
