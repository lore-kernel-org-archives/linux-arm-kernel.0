From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Mar 2013 10:52:51 +0000
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
Message-ID: <20130305105251.GL17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
> +static void put_cluster_clk_and_freq_table(u32 cluster)
> +{
> +	if (!atomic_dec_return(&cluster_usage[cluster])) {
> +		clk_put(clk[cluster]);
> +		clk[cluster] = NULL;

What's the point in setting the clk to NULL?

> +static int get_cluster_clk_and_freq_table(u32 cluster)
> +{
> +	char name[9] = "cluster";
> +	int count;
> +
> +	if (atomic_inc_return(&cluster_usage[cluster]) != 1)
> +		return 0;
> +
> +	freq_table[cluster] = arm_bL_ops->get_freq_tbl(cluster, &count);
> +	if (!freq_table[cluster])
> +		goto atomic_dec;
> +
> +	name[7] = cluster + '0';
> +	clk[cluster] = clk_get(NULL, name);
> +	if (!IS_ERR_OR_NULL(clk[cluster])) {

NAK.  Two reasons.

1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
   times.

2. Maybe clk_get_sys() rather than clk_get() and use a sensible device
   name ("cpu-cluster.%u" maybe) rather than a connection name with a
   NULL device?
