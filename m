From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Jul 2012 18:12:30 +0200
Subject: [PATCH 4/6] kirkwood: setup clock only in eth helpers.
In-Reply-To: <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
References: <1343661359-10150-1-git-send-email-ian.molton@codethink.co.uk>
 <1343661359-10150-5-git-send-email-ian.molton@codethink.co.uk>
Message-ID: <20120730161230.GM18016@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:15:57PM +0100, Ian Molton wrote:
> This patch modifies the ethernet setup helper functions so that they can be
> used /purely/ to set up the clocks.

Hi Ian

Set up is a bit ambiguous. I would actually say, start the clock
ticking, if it is not already.

I'm also not sure this is the best way to do it. I'd like to throw in
a counter proposal, and then we can discuss....

Problems start then the ethernet driver is a module, not built in. In
this situation, the clock gets turned off, in a lateinitcall, and then
later turned back on again when the module loads. Unfortunately, by
then its forgotten its own MAC address, as programmed by u-boot. So
this clk_prepare_enable() is here to ensure that the clock does not
get turned off, when we know the module is likely to be loaded
sometime later.

I've not looked at the clk DT bindings yet. Does it provide a
mechanism to prepare & enable a named clock? Maybe it does, but this
seems a bit of an edge case.

What i would instead do is add code to board-dt.c which looks into the
DT and see if it finds nodes egige0/egige1 and if so, calls
clk_prepare_enable(). We then don't need any per board code.

Andrew		      

> 
> This is part of ongoing work to enable device tree support in the mv643xx.c
> ethernet driver, where as yet the kirkwood platform does not have proper clk
> support.
> 
> This should allow a gradual migration to device tree and later to proper clk
> support, wherupon the helper functions can be removed entirely.
> 
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
>  arch/arm/mach-kirkwood/common.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index c4b64ad..c1776ea 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -299,7 +299,8 @@ void __init kirkwood_ehci_init(void)
>   ****************************************************************************/
>  void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>  {
> -	orion_ge00_init(eth_data,
> +	if (eth_data)
> +		orion_ge00_init(eth_data,
>  			GE00_PHYS_BASE, IRQ_KIRKWOOD_GE00_SUM,
>  			IRQ_KIRKWOOD_GE00_ERR);
>  	/* The interface forgets the MAC address assigned by u-boot if
> @@ -313,7 +314,8 @@ void __init kirkwood_ge00_init(struct mv643xx_eth_platform_data *eth_data)
>   ****************************************************************************/
>  void __init kirkwood_ge01_init(struct mv643xx_eth_platform_data *eth_data)
>  {
> -	orion_ge01_init(eth_data,
> +	if (eth_data)
> +		orion_ge01_init(eth_data,
>  			GE01_PHYS_BASE, IRQ_KIRKWOOD_GE01_SUM,
>  			IRQ_KIRKWOOD_GE01_ERR);
>  	clk_prepare_enable(ge1);
> -- 
> 1.7.9.5
> 
