From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Sep 2015 11:28:23 +0530
Subject: [PATCH v3 2/3] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441303892-32004-3-git-send-email-b.zolnierkie@samsung.com>
References: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
 <1441303892-32004-3-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150907055823.GC26760@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-09-15, 20:11, Bartlomiej Zolnierkiewicz wrote:
> Add suspend frequency support and if needed set it to
> the frequency obtained from the suspend opp (can be defined
> using opp-v2 bindings and is optional).  Also implement
> custom suspend method (needed to not error out on platforms
> which don't require suspend frequency).
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> +#ifdef CONFIG_PM
> +static int cpufreq_dt_suspend(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +
> +	if (!policy->suspend_freq) {
> +		pr_debug("%s: suspend_freq not defined\n", __func__);
> +		return 0;
> +	}
> +
> +	pr_debug("%s: Setting suspend-freq: %u\n", __func__,
> +			policy->suspend_freq);
> +
> +	ret = __cpufreq_driver_target(policy, policy->suspend_freq,
> +			CPUFREQ_RELATION_H);
> +	if (ret)
> +		pr_err("%s: unable to set suspend-freq: %u. err: %d\n",
> +				__func__, policy->suspend_freq, ret);
> +
> +	return ret;
> +}
> +#else
> +#define cpufreq_dt_suspend NULL
> +#endif

No, there is no point replicating the exactly same routine again.
Rather modify cpufreq_generic_suspend() to not print error and instead
do pr_debug(), on !policy->suspend_freq.

-- 
viresh
