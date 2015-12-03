From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 03 Dec 2015 14:22:14 +0000
Subject: [PATCH 11/12] cpufreq: arm-big-little: clarify frequency units
In-Reply-To: <1449091167-20758-12-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
 <1449091167-20758-12-git-send-email-ben@smart-cactus.org>
Message-ID: <1449152534.2817.26.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-02 at 22:19 +0100, Ben Gamari wrote:
> The frequency units are very confusing in this area as OPPs use Hz
> whereas cpufreq uses kHz. Be explicit about this in variable naming.
> 
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Ben Gamari <ben@smart-cactus.org>
> ---
>  drivers/cpufreq/arm_big_little.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 855599b..2d5761c 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -130,14 +130,14 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
>  }
>  
>  static int
> -bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
> +bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
>  {
>  	unsigned long volt = 0, volt_old = 0;
>  	long freq_Hz;
>  	u32 old_rate;

IMO variable renaming doesn't seem necessary, if cpufreq uses kHz then
in a cpufreq driver adding 'kHz' to variable seems redundant, especially
if Hz values like freq_Hz above are named especially to signal their
different units. However, if renaming is going to happen it should at
least be consistent within the same function i.e. also rename the old
old_rate variable above.

>  	int ret;
>  
> -	freq_Hz = new_rate * 1000;
> +	freq_Hz = new_rate_kHz * 1000;
>  	old_rate = clk_get_rate(clk[cluster]) / 1000;
>  
>  	if (!IS_ERR(reg[cluster])) {
> @@ -163,10 +163,10 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>  	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
>  		__func__, cpu, cluster,
>  		old_rate / 1000, (volt_old > 0) ? volt_old / 1000 : -1,
> -		new_rate / 1000, volt ? volt / 1000 : -1);
> +		new_rate_kHz / 1000, volt ? volt / 1000 : -1);
>  
>  	/* scaling up? scale voltage before frequency */
> -	if (!IS_ERR(reg[cluster]) && new_rate > old_rate) {
> +	if (!IS_ERR(reg[cluster]) && new_rate_kHz > old_rate) {
>  		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
>  		if (ret) {
>  			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage up: %d\n",
> @@ -175,7 +175,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>  		}
>  	}
>  
> -	ret = clk_set_rate(clk[cluster], new_rate * 1000);
> +	ret = clk_set_rate(clk[cluster], new_rate_kHz * 1000);
>  	if (WARN_ON(ret)) {
>  		pr_err("%s: clk_set_rate failed: %d, cluster: %d\n",
>  			__func__, cluster, ret);
> @@ -185,7 +185,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>  	}
>  
>  	/* scaling down? scale voltage after frequency */
> -	if (!IS_ERR(reg[cluster]) && new_rate < old_rate) {
> +	if (!IS_ERR(reg[cluster]) && new_rate_kHz < old_rate) {
>  		ret = regulator_set_voltage_tol(reg[cluster], volt, 0);
>  		if (ret) {
>  			pr_err("%s: cpu: %d, cluster: %d, failed to scale voltage down: %d\n",
> @@ -199,7 +199,7 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate)
>  }
>  
>  static unsigned int
> -bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
> +bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate_kHz)
>  {
>  	u32 new_rate, prev_rate;

Ditto. Rename these too to add '_kHz' ?

>  	int ret;
> @@ -209,13 +209,13 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>  
>  	if (bLs) {
>  		prev_rate = per_cpu(cpu_last_req_freq, cpu);
> -		per_cpu(cpu_last_req_freq, cpu) = rate;
> +		per_cpu(cpu_last_req_freq, cpu) = rate_kHz;
>  		per_cpu(physical_cluster, cpu) = new_cluster;
>  
>  		new_rate = find_cluster_maxfreq(new_cluster);
>  		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
>  	} else {
> -		new_rate = rate;
> +		new_rate = rate_kHz;
>  	}
>  
>  	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
> @@ -236,7 +236,7 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>  	} else if (ret && bLs) {
>  		per_cpu(cpu_last_req_freq, cpu) = prev_rate;
>  		per_cpu(physical_cluster, cpu) = old_cluster;
> -	} 
> +	}

There's a spurious whitespace change here. I know the space you deleted
shouldn't have been there, but doing tidyups like that generally isn't
done in patches that don't otherwise affect the code in question.

>  
>  	mutex_unlock(&cluster_lock[new_cluster]);
>  

-- 
Tixy
