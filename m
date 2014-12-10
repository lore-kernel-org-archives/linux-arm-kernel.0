From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 10 Dec 2014 10:13:39 +0100
Subject: [PATCH V2] arm: imx: correct the hardware clock gate setting for
 shared nodes
In-Reply-To: <1418201480-9935-1-git-send-email-b20788@freescale.com>
References: <1418201480-9935-1-git-send-email-b20788@freescale.com>
Message-ID: <20141210091339.GI13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 10, 2014 at 04:51:20PM +0800, Anson Huang wrote:
> For those clk gates which hold share count, since its is_enabled
> callback is only checking the share count rather than reading
> the hardware register setting, in the late phase of kernel bootup,
> the clk_disable_unused action will NOT handle the scenario of
> share_count is 0 but the hardware setting is enabled, actually,
> uboot normally enables all clk gates, then those shared clk gates
still s/uboot/U-Boot/

> will be always enabled until they are used by some modules.
> 
> So the problem would be: when kernel boot up, the usecount cat
> from clk tree is 0, but the clk gates actually is enabled in
> hardware register, it will confuse user and bring unnecessary power
> consumption.
> 
> This patch adds .disable_unused callback to handle such scenario in
> late phase of kernel boot up, then the hardware status will match the
> clk tree info.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
> changes from V1:
> 	handle such issue via clk-gate2 framework to fulfill all
> i.mx6 platforms, introduced .disable_unused callback.
>  arch/arm/mach-imx/clk-gate2.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
> index 5a75cdc..18204db 100644
> --- a/arch/arm/mach-imx/clk-gate2.c
> +++ b/arch/arm/mach-imx/clk-gate2.c
> @@ -96,15 +96,31 @@ static int clk_gate2_is_enabled(struct clk_hw *hw)
>  {
>  	struct clk_gate2 *gate = to_clk_gate2(hw);
>  
> -	if (gate->share_count)
> -		return !!__clk_get_enable_count(hw->clk);
> -	else
> -		return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
> +	return clk_gate2_reg_is_enabled(gate->reg, gate->bit_idx);
point out in the commit log that this is changed.

> +}
> +
> +static void clk_gate2_disable_unused(struct clk_hw *hw)
> +{
> +	struct clk_gate2 *gate = to_clk_gate2(hw);
> +	unsigned long flags = 0;
> +	u32 reg;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	if ((gate->share_count && *gate->share_count == 0) ||
> +		!gate->share_count) {
That's equivalent to the simpler expression
	if (!gate->share_count || *gate->share_count == 0)

Other than that it doesn't make the status quo worse, still I'd prefer
a nicer model for these shared clocks.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
