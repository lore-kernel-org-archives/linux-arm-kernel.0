From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 22 Jan 2013 17:33:58 +0530
Subject: [PATCH v5 9/9] ARM: davinci: da850: Added dsp clock definition
In-Reply-To: <1357863807-380-10-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-10-git-send-email-rtivy@ti.com>
Message-ID: <50FE802E.2020306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On 1/11/2013 5:53 AM, Robert Tivy wrote:
> Added dsp clock definition, keyed to "davinci-rproc.0".
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>  arch/arm/mach-davinci/da850.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 097fcb2..50107c5 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -375,6 +375,14 @@ static struct clk sata_clk = {
>  	.flags		= PSC_FORCE,
>  };
>  
> +static struct clk dsp_clk = {
> +	.name		= "dsp",
> +	.parent		= &pll0_sysclk1,
> +	.domain		= DAVINCI_GPSC_DSPDOMAIN,
> +	.lpsc		= DA8XX_LPSC0_GEM,
> +	.flags		= PSC_LRST,
> +};
> +
>  static struct clk_lookup da850_clks[] = {
>  	CLK(NULL,		"ref",		&ref_clk),
>  	CLK(NULL,		"pll0",		&pll0_clk),
> @@ -421,6 +429,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK("spi_davinci.1",	NULL,		&spi1_clk),
>  	CLK("vpif",		NULL,		&vpif_clk),
>  	CLK("ahci",		NULL,		&sata_clk),
> +	CLK("davinci-rproc.0",	NULL,		&dsp_clk),

Adding this clock node without the having the driver probed leads to
kernel hang while booting. With CONFIG_DAVINCI_RESET_CLOCKS=n, the
kernel boot fine. It looks like there is some trouble disabling the
clock if it is not used. Can you please check this issue?

Thanks,
Sekhar
