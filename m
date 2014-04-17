From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Apr 2014 13:01:19 +0800
Subject: [PATCH] ARM: imx6: clk: i.MX6 DualLite/Solo i2c4 clock
In-Reply-To: <534ECCF4.9040108@gmail.com>
References: <534ECCF4.9040108@gmail.com>
Message-ID: <20140417050118.GS2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 07:33:24PM +0100, Iain Paton wrote:
> Compared to i.MX6 Quad/Dual the CCM_CCGR1 register in the i.MX6 Solo/DualLite
> replaces the ecspi5 clock with the i2c4 clock.
> 
> Handle this difference using cpu_is_imx6dl().
> 
> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index b0e7f9d..2961b16 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -352,7 +352,13 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
>  	clk[ecspi2]       = imx_clk_gate2("ecspi2",        "ecspi_root",        base + 0x6c, 2);
>  	clk[ecspi3]       = imx_clk_gate2("ecspi3",        "ecspi_root",        base + 0x6c, 4);
>  	clk[ecspi4]       = imx_clk_gate2("ecspi4",        "ecspi_root",        base + 0x6c, 6);
> -	clk[ecspi5]       = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
> +	if (cpu_is_imx6dl())
> +		/*
> +		 * ecspi5 is replaced with i2c4 on imx6dl & imx6s
> +		 */

Single line comment should be like /* bla ... */.

I fixed it up and applied the patch.  Thanks.

Shawn

> +		clk[ecspi5] = imx_clk_gate2("i2c4",        "ipg_per",           base + 0x6c, 8);
> +	else
> +		clk[ecspi5] = imx_clk_gate2("ecspi5",      "ecspi_root",        base + 0x6c, 8);
>  	clk[enet]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
>  	clk[esai]         = imx_clk_gate2("esai",          "esai_podf",         base + 0x6c, 16);
>  	clk[gpt_ipg]      = imx_clk_gate2("gpt_ipg",       "ipg",               base + 0x6c, 20);
> -- 
> 1.8.5.1
> 
> 
> 
