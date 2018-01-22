From: david@lechnology.com (David Lechner)
Date: Mon, 22 Jan 2018 11:15:51 -0600
Subject: [PATCH v6 20/41] ARM: da830: add new clock init using common
 clock framework
In-Reply-To: <1516468460-4908-21-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-21-git-send-email-david@lechnology.com>
Message-ID: <f0d15b56-d866-1f25-ce8f-f37d632d3366@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2018 11:13 AM, David Lechner wrote:
> This adds the new board-specific clock init in mach-davinci/da830.c
> using the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Also clean up the #includes since we are adding some here.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - add blank lines between function calls
> - include da8xx_register_cfgchip()
> 
>   arch/arm/mach-davinci/da830.c | 49 +++++++++++++++++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c

...

> +	clk = clk_register_fixed_factor(NULL, "i2c0", "pll0_aux_clk", 0, 1, 1);

Should be "pll0_auxclk" instead of "pll0_aux_clk" here and 2 more below.

> +	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
> +
> +	clk = clk_register_fixed_factor(NULL, "timer0", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, "timer0", NULL);
> +
> +	clk = clk_register_fixed_factor(NULL, "timer1", "pll0_aux_clk", 0, 1, 1);
> +	clk_register_clkdev(clk, NULL, "davinci-wdt");
> +
> +	clk = clk_register_fixed_factor(NULL, "rmii", "pll0_sysclk7", 0, 1, 1);
> +	clk_register_clkdev(clk, "rmii", NULL);
> +#else
>   	da8xx_register_cfgchip();
>   	davinci_clk_init(da830_clks);
> +#endif
>   	davinci_timer_init();
>   }
> 
