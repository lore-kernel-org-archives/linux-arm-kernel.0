From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Nov 2013 16:07:47 +0800
Subject: [RFC PATCH 2/3] ARM: imx: cpuidle: Convert imx6q driver to
 platform_driver
In-Reply-To: <1382978973-4034-2-git-send-email-daniel.lezcano@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
 <1382978973-4034-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20131107080743.GB6500@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 09:49:32AM -0700, Daniel Lezcano wrote:
> +static struct platform_device imx6q_cpuidle_device = {
> +	.name = "cpuidle-imx6q",
> +	.dev = {
> +		.platform_data = imx6q_pm_idle,
> +	},
> +};
> +
>  void __init imx6q_pm_init(void)
>  {
> +	/*
> +	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
> +	 * to run cpuidle on them.
> +	 */
> +	if (imx6q_revision() > IMX_CHIP_REVISION_1_1) {
> +
> +		/* Need to enable SCU standby for entering WAIT modes */
> +		imx_scu_standby_enable();
> +
> +		/* Set chicken bit to get a reliable WAIT mode support */
> +		imx6q_set_chicken_bit();

So this is a behavior change.  Before the patch, these two functions
will not get called if CONFIG_CPU_IDLE is not enabled.  We only want to
call them when cpuidle driver is instantiated.

Shawn

> +
> +		platform_device_register(&imx6q_cpuidle_device);
> +	}
> +
>  	suspend_set_ops(&imx6q_pm_ops);
>  }
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
