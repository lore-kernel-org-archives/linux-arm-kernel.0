From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue, 03 Apr 2012 10:02:51 -0400
Subject: [PATCH] arm: da850: change ASYNC/PLL0_SYSCLK3 clock rate with DVFS
In-Reply-To: <1333458083-29753-1-git-send-email-prakash.pm@ti.com>
References: <1333458083-29753-1-git-send-email-prakash.pm@ti.com>
Message-ID: <4F7B030B.4080900@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2012 9:01 AM, Manjunathappa, Prakash wrote:

> Clock for EMIF is derived from ASYNC clock domain(PLL0_SYSCLK3) and was
> configured with fixed divider as there was no significant performance
> degradation with existing NAND/NOR EMIF devices if it is not
> reconfigured accordingly at different OPPs.
>
> On systems where devices other than NAND/NOR are interfaced through
> EMIF, such performance degradation may not be desirable. So change the
> PLL0_SYSCLK3 output frequency for different OPPs by re-configuring
> the divider value.
>
> Configured values are as per rates specified in OMAP-L138 Data sheet
> (http://www.ti.com/lit/ds/symlink/omap-l138.pdf, Table 5-5).
>
> Patch addresses concerns raised in below thread of Linux-DaVinci-community:
> http://www.mail-archive.com/davinci-linux-open-source at linux.davincidsp.com/msg22535.html
>
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  arch/arm/mach-davinci/da850.c |   37 +++++++++++++++++++++++++++++++++++--
>  1 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index b44dc84..7e98ed7 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -49,6 +49,7 @@
>  static int da850_set_armrate(struct clk *clk, unsigned long rate);
>  static int da850_round_armrate(struct clk *clk, unsigned long rate);
>  static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
> +static int da850_set_sysclk3_rate(struct clk *clk, unsigned long rate);
>  
>  static struct pll_data pll0_data = {
>  	.num		= 1,
> @@ -88,8 +89,8 @@ static struct clk pll0_sysclk3 = {
>  	.parent		= &pll0_clk,
>  	.flags		= CLK_PLL,
>  	.div_reg	= PLLDIV3,
> -	.set_rate	= davinci_set_sysclk_rate,
> -	.maxrate	= 100000000,
> +	.set_rate	= da850_set_sysclk3_rate,



da850_set_pll0_sysclk3_rate ?
(there is a pll1_sysclk3 as well)

> +	.maxrate	= 148000000,
>  };
>  
>  static struct clk pll0_sysclk4 = {
> @@ -1004,6 +1005,33 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long index)
>  
>  	return 0;
>  }
> +
> +static int da850_set_sysclk3_rate(struct clk *clk, unsigned long rate)
> +{
> +	struct clk *arm_clk;
> +	unsigned long sys_clk3_rate = 148000000;



why not sys_clk3_rate = rate? or just use rate?

> +	int ret;
> +
> +	arm_clk = clk_get(NULL, "arm");
> +	if (WARN(IS_ERR(arm_clk), "Unable to get ARM clock\n"))
> +		return PTR_ERR(arm_clk);
> +
> +	/* Set EMIF clock based on OPPs */
> +	switch (clk_get_rate(arm_clk)) {
> +	case 200000000:
> +		sys_clk3_rate = 75000000;


what if the requested rate is lower than 75 MHz?

> +		break;
> +	case 96000000:
> +		sys_clk3_rate = 50000000;
> +		break;
> +	}
> +
> +	ret = davinci_set_sysclk_rate(clk, sys_clk3_rate);
> +	if (WARN_ON(ret))
> +		return ret;
> +
> +	return 0;
> +}



This routine is ignoring the requested rate passed in.  At 300 MHz OPP,
you are going to configure it for 148 MHz instead of 100 MHz (the
current implementation).  I would think that this rate should
be controllable by platform initialization code unless it needs limiting
based on specification.  What if someone wants to run the EMIFA
slower than 148 MHz?

There are platforms that would like to keep the EMIFA rate at a relatively
fixed / stable value of, e.g., 100 MHz or as close to that value as possible
at any OPP above 300 MHz.  This patch does not appear support that.

>  #else
>  int __init da850_register_cpufreq(char *async_clk)
>  {
> @@ -1024,6 +1052,11 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
>  {
>  	return clk->rate;
>  }
> +
> +static int da850_set_sysclk3_rate(struct clk *clk, unsigned long rate)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  int __init da850_register_pm(struct platform_device *pdev)
