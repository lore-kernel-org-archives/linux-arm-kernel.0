From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 26 Nov 2014 11:04:09 +0100
Subject: [PATCH v10 07/10] qcom: cpuidle: Add cpuidle driver for QCOM cpus
In-Reply-To: <1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
Message-ID: <5475A599.1010601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 07:03 PM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into C-States. Use the
> cpuidle DT interface, common across ARM architectures, to provide the
> idle state information to the cpuidle framework.
>
> Supported modes at this time are Standby and Standalone Power Collapse.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

One nit and one comment below. Other than that:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

> +static int qcom_cpu_stby(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->standby(NULL);

In my last comment I was referring about a check for entering 
successfully the idle state:

	if (lpm_ops->standby(NULL))
		return -1;

> +	return index;
> +}
> +
> +static int qcom_cpu_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->spc(NULL);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver qcom_cpuidle_driver = {
> +	.name	= "qcom_cpuidle",
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] = {
> +	{ .compatible = "qcom,idle-state-stby", .data = qcom_cpu_stby},

                                                                    ^^^^
		a missing space right before the closing bracket.

> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
> +	{ },
> +};
> +

Thanks!

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
