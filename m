From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Nov 2010 07:22:04 +0100
Subject: [PATCHv4 3/3] ARM: imx: Get the silicon version from the IIM
	module
In-Reply-To: <1289518217-26716-3-git-send-email-Dinh.Nguyen@freescale.com>
References: <1289518217-26716-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1289518217-26716-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1289518217-26716-3-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20101112062204.GE18358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 05:30:17PM -0600, Dinh.Nguyen at freescale.com wrote:
> From: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> 
> Instead of reading the silicon version from ROM, we should
> read the SREV register from the IIM.
> 
> Freescale has dropped all support for MX51 REV1.0, only MX51
> REV 2.0 and 3.0 are valid.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/mach-mx5/clock-mx5x.c |   16 ++++++++++++++++
>  arch/arm/mach-mx5/cpu.c        |   34 ++++++++++++++++------------------
>  2 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/clock-mx5x.c b/arch/arm/mach-mx5/clock-mx5x.c
> index 9216ac1..82779fb 100644
> --- a/arch/arm/mach-mx5/clock-mx5x.c
> +++ b/arch/arm/mach-mx5/clock-mx5x.c
> @@ -780,6 +780,12 @@ static struct clk ahb_clk = {
>  	.round_rate = _clk_ahb_round_rate,
>  };
>  
> +static struct clk iim_clk = {
> +	.parent = &ipg_clk,
> +	.enable_reg = MXC_CCM_CCGR0,
> +	.enable_shift = MXC_CCM_CCGRx_CG15_OFFSET,
> +};
> +
>  /* Main IP interface clock for access to registers */
>  static struct clk ipg_clk = {
>  	.parent = &ahb_clk,
> @@ -1099,6 +1105,7 @@ static struct clk_lookup mx51_lookups[] = {
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
>  	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
>  	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
> +	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
>  };
>  
>  static struct clk_lookup mx53_lookups[] = {
> @@ -1107,6 +1114,7 @@ static struct clk_lookup mx53_lookups[] = {
>  	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
>  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
>  	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
> +	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
>  };
>  
>  static void clk_tree_init(void)
> @@ -1147,6 +1155,10 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_enable(&cpu_clk);
>  	clk_enable(&main_bus_clk);
>  
> +	clk_enable(&iim_clk);
> +	mx51_revision();
> +	clk_disable(&iim_clk);
> +
>  	/* set the usboh3_clk parent to pll2_sw_clk */
>  	clk_set_parent(&usboh3_clk, &pll2_sw_clk);
>  
> @@ -1182,6 +1194,10 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
>  	clk_enable(&cpu_clk);
>  	clk_enable(&main_bus_clk);
>  
> +	clk_enable(&iim_clk);
> +	mx53_revision();
> +	clk_disable(&iim_clk);
> +
>  	/* System timer */
>  	mxc_timer_init(&gpt_clk, MX53_IO_ADDRESS(MX53_GPT1_BASE_ADDR),
>  		MX53_MXC_INT_GPT);
> diff --git a/arch/arm/mach-mx5/cpu.c b/arch/arm/mach-mx5/cpu.c
> index a00d2bc..92cc832 100644
> --- a/arch/arm/mach-mx5/cpu.c
> +++ b/arch/arm/mach-mx5/cpu.c
> @@ -20,37 +20,35 @@
>  
>  static int cpu_silicon_rev = -1;
>  
> -#define SI_REV 0x48
> +#define SREV 0x24
>  
>  static void query_silicon_parameter(void)
>  {
> -	void __iomem *rom = ioremap(MX51_IROM_BASE_ADDR, MX51_IROM_SIZE);
> +	void __iomem *iim_base;
>  	u32 rev;
>  
> -	if (!rom) {
> -		cpu_silicon_rev = -EINVAL;
> -		return;
> -	}
> +	if (cpu_is_mx51())
> +		iim_base = MX51_IO_ADDRESS(MX51_IIM_BASE_ADDR);
> +	else if (cpu_is_mx53())
> +		iim_base = MX53_IO_ADDRESS(MX53_IIM_BASE_ADDR);
>  
> -	rev = readl(rom + SI_REV);
> +	rev = readl(iim_base + SREV) & 0xff;
>  	switch (rev) {
> -	case 0x1:
> -		cpu_silicon_rev = MX51_CHIP_REV_1_0;
> -		break;
> -	case 0x2:
> -		cpu_silicon_rev = MX51_CHIP_REV_1_1;
> +	case 0x0:
> +		if (cpu_is_mx51())
> +			cpu_silicon_rev = MX51_CHIP_REV_2_0;
> +		else if (cpu_is_mx53())
> +			cpu_silicon_rev = MX53_CHIP_REV_1_0;
>  		break;
>  	case 0x10:
> -		cpu_silicon_rev = MX51_CHIP_REV_2_0;
> -		break;
> -	case 0x20:
> -		cpu_silicon_rev = MX51_CHIP_REV_3_0;
> +		if (cpu_is_mx51())
> +			cpu_silicon_rev = MX51_CHIP_REV_3_0;
> +		else if (cpu_is_mx53())
> +			cpu_silicon_rev = MX53_CHIP_REV_2_0;
>  		break;
>  	default:
>  		cpu_silicon_rev = 0;
>  	}
I'd prefer something like this instead of the switch above:

	if (cpu_is_mx51())
		cpu_silicon_rev = mx51_something_sensibe(rev);
	else if (cpu_is_mx53())
		cpu_silicon_rev = mx53_something_sensibe(rev);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
