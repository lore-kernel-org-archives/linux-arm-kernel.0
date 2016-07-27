From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jul 2016 09:26:10 +0200
Subject: [PATCH 5/9] clk: sunxi-ng: mux: support fixed pre-dividers on
 multiple parents
In-Reply-To: <1469516671-19377-6-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-6-git-send-email-wens@csie.org>
Message-ID: <20160727072610.GE6560@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 26, 2016 at 03:04:27PM +0800, Chen-Yu Tsai wrote:
> Some clocks on the A31 have fixed pre-dividers on multiple parents.
> Add support for them.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c |  9 +++++----
>  drivers/clk/sunxi-ng/ccu_mux.c      |  6 ++++--
>  drivers/clk/sunxi-ng/ccu_mux.h      | 10 ++++++----
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> index 9af359544110..5f5c900c235b 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
> @@ -184,15 +184,16 @@ static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", apb2_parents, 0x058,
>  			     0);
>  
>  static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
> +static const struct ccu_mux_fixed_prediv ahb2_fixed_predivs[] = {
> +	{ .index = 1, .div = 2},
> +	{ },
> +};
>  static struct ccu_mux ahb2_clk = {
>  	.mux		= {
>  		.shift	= 0,
>  		.width	= 1,
>  
> -		.fixed_prediv	= {
> -			.index	= 1,
> -			.div	= 2,
> -		},
> +		.fixed_predivs	= ahb2_fixed_predivs,

I think I'd prefer to have the number of dividers too, instead of
iterating until we find a 0 one. It's easier to iterate over it, the
errors are easier to catch and it's consistent with the other arrays
we give, for example for the parents.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/ba14d2a0/attachment.sig>
