From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Nov 2013 15:56:13 +0800
Subject: [RFC PATCH 1/3] ARM: imx: cpuidle: Convert imx5 driver to
 platform driver
In-Reply-To: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
References: <1382978973-4034-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20131107075607.GA6500@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 09:49:31AM -0700, Daniel Lezcano wrote:
> @@ -149,6 +149,13 @@ static void imx5_pm_idle(void)
>  	imx5_cpu_do_idle();
>  }
>  
> +static struct platform_device imx5_cpuidle_pdev = {
> +	.name = "cpuidle-imx5",
> +	.dev = {
> +		.platform_data = imx5_pm_idle,

This is a little bit hackish and less future proof.  We should probably
create a data structure with the function hook as a field in it.

Shawn

> +	},
> +};
> +
>  static int __init imx5_pm_common_init(void)
>  {
>  	int ret;
> @@ -166,7 +173,7 @@ static int __init imx5_pm_common_init(void)
>  	/* Set the registers to the default cpu idle state. */
>  	mx5_cpu_lp_set(IMX5_DEFAULT_CPU_IDLE_STATE);
>  
> -	return imx5_cpuidle_init();
> +	return platform_device_register(&imx5_cpuidle_pdev);
>  }
>  
>  void __init imx5_pm_init(void)
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
