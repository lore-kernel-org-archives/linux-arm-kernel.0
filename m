From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 May 2015 07:47:30 +0530
Subject: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
In-Reply-To: <1432232981-3917-1-git-send-email-shailendra.capricorn@gmail.com>
References: <1432232981-3917-1-git-send-email-shailendra.capricorn@gmail.com>
Message-ID: <20150522021730.GA7730@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 23:59, Shailendra Verma wrote:
> During probe free the memory allocated to "exynos_info" in case of unknown
> SOC type.
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 82d2fbb..b77923a 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -182,6 +182,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>  		ret = exynos5250_cpufreq_init(exynos_info);
>  	} else {
>  		pr_err("%s: Unknown SoC type\n", __func__);
> +		kfree(exynos_info);
>  		return -ENODEV;
>  	}

There is no point replicating this stuff. Use labels like: err_vdd_arm
to get this done. But you also need to make sure the right error gets
propagated.

-- 
viresh
