From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 24 Apr 2018 13:40:33 +0530
Subject: [RFC work-in-progress 5/7] !WIP ARM: davinci: convert da850 to
 using the davinci clocksource driver
In-Reply-To: <20180423183814.20615-6-brgl@bgdev.pl>
References: <20180423183814.20615-1-brgl@bgdev.pl>
 <20180423183814.20615-6-brgl@bgdev.pl>
Message-ID: <bed00d18-a4c1-5e8f-a15c-f2482e5ecb9a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 April 2018 12:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 3f27d46ca43f..712964383bc2 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -757,13 +757,28 @@ void __init da850_init(void)
>  	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
>  }
>  
> +static struct platform_device da850_timer_device = {
> +	.name			= "timer-davinci",
> +	.id			= -1,
> +};
> +
>  void __init da850_init_time(void)
>  {
>  	struct clk *clk;
> +	int ret;
>  
>  	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
>  
>  	davinci_timer_init(clk);
> +
> +	ret = clk_register_clkdev(clk, NULL, "timer-davinci");
> +	if (ret) {
> +		pr_err("%s: error registering ref_clk: %d", __func__, ret);
> +		return;
> +	}

This part had to be added because you don't have clocks converted to
early platform devices in your branch, right?

Thanks,
Sekhar
