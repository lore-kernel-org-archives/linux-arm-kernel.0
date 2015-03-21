From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Mar 2015 11:53:09 +0100
Subject: [PATCH 4/6] clk: sunxi: Make divs clocks specify which output is
 the parent clock
In-Reply-To: <1426785548-5932-5-git-send-email-wens@csie.org>
References: <1426785548-5932-1-git-send-email-wens@csie.org>
 <1426785548-5932-5-git-send-email-wens@csie.org>
Message-ID: <20150321105309.GD2774@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 01:19:06AM +0800, Chen-Yu Tsai wrote:
> The current sunxi clock driver has the parent of divs clocks as the
> last clock output of the clock node. This makes it rather difficult
> to add new outputs, such as fixed dividers, which were previously
> unknown.
> 
> This patch makes the divs clocks data structure specify which output
> is the parent clock, and updates all current divs clocks accordingly.
> 
> We can then add new outputs after the parent clocks, at least not
> breaking backward compatibility with regards to the devicetree bindings.
> 
> Also replace kzalloc with kcalloc in sunxi_divs_clk_setup().
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index d92e30371d8a..d28acdde364e 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -1046,13 +1046,14 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>   * sunxi_divs_clk_setup() helper data
>   */
>  
> -#define SUNXI_DIVS_MAX_QTY	2
> +#define SUNXI_DIVS_MAX_QTY	4
>  #define SUNXI_DIVISOR_WIDTH	2
>  
>  struct divs_data {
>  	const struct factors_data *factors; /* data for the factor clock */
> -	int ndivs; /* number of children */
> +	int ndivs; /* number of outputs */
>  	struct {
> +		u8 parent; /* is it the parent? (only one please) */

I really don't get what this "parent" is about. Is it a clock passed
through to the users.

Do we have even have users for these?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/9cf76127/attachment.sig>
