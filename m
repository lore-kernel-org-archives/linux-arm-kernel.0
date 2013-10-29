From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Oct 2013 13:43:53 -0400
Subject: [PATCHv2 2/7] ARM: imx: add clocking support code for the
 IMX50 SoC
In-Reply-To: <1383023757-30711-3-git-send-email-gerg@uclinux.org>
References: <1383023757-30711-1-git-send-email-gerg@uclinux.org>
 <1383023757-30711-3-git-send-email-gerg@uclinux.org>
Message-ID: <20131029174353.GD26784@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

I've applied these against v3.12-rc7 and found a few small things,
below.

On Tue, Oct 29, 2013 at 03:15:52PM +1000, gerg at uclinux.org wrote:
> From: Greg Ungerer <gerg@uclinux.org>
> 
> Add code to support the specific clock tree of the Freescale IMX50 SoC.
> It can use much of the common IMX51/IMX53 clocking code.
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 58 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index ce37af2..219c65e 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -365,6 +365,64 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_prepare_enable(clk[tmax3]); /* esdhc1, esdhc4 */
>  }
>  
> +static void __init mx50_clocks_init(struct device_node *np)
> +{
...
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx50-gpt");
> +	base = of_iomap(np, 0);

This requires linux/of_address.h

> +	WARN_ON(!base);
> +	irq = irq_of_parse_and_map(np, 0);

and this requires linux/of_irq.h

I would also add a comment somewhere it will be seen when moving this
code to drivers/clk that the file be renamed something like clk-imx5x.c.
No need to churn it now, though.

thx,

Jason.
