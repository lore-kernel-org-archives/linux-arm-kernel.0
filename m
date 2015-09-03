From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 3 Sep 2015 08:20:19 +0530
Subject: [PATCH] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441212121-21021-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441212121-21021-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20150903025019.GA13140@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-09-15, 18:42, Bartlomiej Zolnierkiewicz wrote:
> Add suspend frequency support and set it to the boot frequency,
> this matches what the old exynos-cpufreq driver has been doing.
> 
> This patch fixes suspend/resume support on Exynos4412 based
> Trats2 board and reboot hang on Exynos4412 based Odroid U3
> board.
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This patch supersedes "[PATCH] ARM: dts: exynos4412-odroid-*: add
> workaround for CPUfreq/reboot issue" one from yesterday.
> 
>  drivers/cpufreq/cpufreq-dt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index c3583cd..c9138c7 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -329,6 +329,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->driver_data = priv;
>  
>  	policy->clk = cpu_clk;
> +
> +	/* capture boot frequency */
> +	policy->suspend_freq = clk_get_rate(cpu_clk) / 1000;;

We should be using opp-v2's suspend-opp thing for this now..

-- 
viresh
