From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Oct 2015 19:03:15 +0530
Subject: [PATCH 3/4] cpufreq: imx6q: Fix regulator/clock error handling
In-Reply-To: <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20151022133315.GE3897@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-10-15, 10:47, Sascha Hauer wrote:
> +	arm_reg = regulator_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_reg))
> +		return PTR_ERR(arm_reg);
> +
> +	pu_reg = regulator_get_optional(cpu_dev, "pu");

Yes, current code doesn't care about if this failed, but if that's the
intention please add a comment for it now.

> +	soc_reg = regulator_get(cpu_dev, "soc");
> +	if (IS_ERR(soc_reg))
> +		return PTR_ERR(soc_reg);
> +
> +	return 0;
> +}
> +
> +
> +static void imx6q_cpufreq_put_resources(void)
> +{
> +	if (!IS_ERR_OR_NULL(arm_reg))
> +		regulator_put(arm_reg);
> +	arm_reg = NULL;

Can you please clarify (maybe again) why this is required to be set to
NULL again?

-- 
viresh
