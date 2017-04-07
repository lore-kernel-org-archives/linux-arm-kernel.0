From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 7 Apr 2017 20:06:45 +0530
Subject: [PATCH v2] ARM: davinci: Add the clock for the CPPI 4.1 DMA engine
In-Reply-To: <20170405171750.16821-1-abailon@baylibre.com>
References: <20170405171750.16821-1-abailon@baylibre.com>
Message-ID: <e941f7f4-1904-a0c5-3ef0-973477087b2b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 April 2017 10:47 PM, Alexandre Bailon wrote:
> The CPPI 4.1 DMA is sharing its clock with the USB OTG,
> and most of the time, the clock will be enabled by USB.
> But during the init of the DMA, USB is not enabled (waiting for DMA),
> and then we must enable the clock before doing anything.
> Add the clock for the CPPI 4.1 DMA engine.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  arch/arm/mach-davinci/da830.c | 6 ++++++
>  arch/arm/mach-davinci/da850.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
> index 073c458..bd88470 100644
> --- a/arch/arm/mach-davinci/da830.c
> +++ b/arch/arm/mach-davinci/da830.c
> @@ -304,6 +304,11 @@ static struct clk usb20_clk = {
>  	.gpsc		= 1,
>  };
>  
> +static struct clk cppi41_clk = {
> +	.name		= "cppi41",
> +	.parent		= &usb20_clk,
> +};
> +
>  static struct clk aemif_clk = {
>  	.name		= "aemif",
>  	.parent		= &pll0_sysclk3,
> @@ -413,6 +418,7 @@ static struct clk_lookup da830_clks[] = {
>  	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
>  	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
>  	CLK("musb-da8xx",	"usb20",	&usb20_clk),
> +	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),

I dont see this device name being used in current linux-next. Is this
name accepted ?

The patch otherwise looks okay.

Thanks,
Sekhar
