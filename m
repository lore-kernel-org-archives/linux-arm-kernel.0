From: david@lechnology.com (David Lechner)
Date: Fri, 30 Dec 2016 18:52:44 -0600
Subject: [v2, 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <20160810110032.29295-2-kbeldan@baylibre.com>
References: <20160810110032.29295-2-kbeldan@baylibre.com>
Message-ID: <33cf2e96-6551-df6a-8a30-bf2c3aeabfee@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 06:00 AM, Karl Beldan wrote:
> Many davinci boards (da830 and da850 families) don't have their clocks
> in DT yet and won't be successful in getting an unnamed aemif clock
> without explicitly registering them via clk_lookups, failing the
> ti-aemif memory driver probe.
>
> The current aemif lookup entry resolving to the same clock:
>     'CLK(NULL,               "aemif",        &aemif_clk)'
> remains, as it is currently used (davinci_nand is getting a named clock
> "aemif").
>
> This change will allow to switch from the mach-davinci aemif code to
> the ti-aemif memory driver.
>
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> ---

FYI, I can't boot LEGO MINDSTORMS EV3 (AM1908) with a v4.9 mainline 
kernel. I did a git bisect and traced it down to this patch. I'm 
guessing that simply reverting it will break other things.

The problem is that &aemif_clk is a node in a linked list and points to 
itself, which creates an infinite loop when looking up the usb clocks 
that are later in the list.

I thought there was a patch to fix this properly from one of the Bay 
Libre guys to fix this already, but I can't seem to find it at the 
moment. When it is found, it would be good to have it applied to the 4.9 
stable and 4.10 mainline trees.


>  arch/arm/mach-davinci/da850.c    | 1 +
>  arch/arm/mach-davinci/da8xx-dt.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 2398862..3477d30 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -485,6 +485,7 @@ static struct clk_lookup da850_clks[] = {
>  	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
>  	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
>  	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
> +	CLK("ti-aemif",		NULL,		&aemif_clk),
>  	CLK(NULL,		"aemif",	&aemif_clk),
>  	CLK(NULL,		"usb11",	&usb11_clk),
>  	CLK(NULL,		"usb20",	&usb20_clk),
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index ca99711..c9f7e92 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -37,6 +37,7 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
>  		       NULL),
>  	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
> +	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", NULL),
>  	{}
>  };
>
>
