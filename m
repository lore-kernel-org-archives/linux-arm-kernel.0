From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 3 Dec 2014 12:00:58 +0530
Subject: [PATCHv3 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
In-Reply-To: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
References: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
Message-ID: <CAKohpomv8fXqVEBWkmJTHKrkdVUbZCodV_D_pu3hjRqH0wUEeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2014 at 20:23, Eduardo Valentin <edubezval@gmail.com> wrote:
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1ab0018..88d2775 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -440,6 +440,9 @@ __cpufreq_cooling_register(struct device_node *np,
>         int ret = 0, i;
>         struct cpufreq_policy policy;
>
> +       if (!cpufreq_frequency_get_table(0))

Please add a pr_debug() here, that will be quite useful while debugging.

Also, you can't simply pass 0 to get_table() above. We might be
registering the cooling device for some other cluster as well..

This is what I have done in my patch earlier.

cpufreq_frequency_get_table(cpumask_first(clip_cpus));

And this will work for all cases.
