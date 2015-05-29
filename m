From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 May 2015 08:40:55 +0200
Subject: [PATCH 1/3] clk: mux: Add regmap support for simple mux
In-Reply-To: <1432838508-5184-2-git-send-email-matthias.bgg@gmail.com>
References: <1432838508-5184-1-git-send-email-matthias.bgg@gmail.com>
 <1432838508-5184-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <20150529064055.GA6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 08:41:46PM +0200, Matthias Brugger wrote:
> Some devices like SoCs from Mediatek need to use the clock muxes
> through a regmap interface.
> This patch adds regmap support for simple the simple multiplexer
> clock code.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/clk/clk-mux.c        | 103 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/clk-provider.h |  40 +++++++++++++++++
>  2 files changed, 132 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 1fa2a8d..c7c692a 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -29,6 +29,26 @@
>  
>  #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
>  
> +static void clk_mux_writel(struct clk_mux *mux, u32 val)
> +{
> +	if (mux->flags && CLK_MUX_USE_REGMAP)
> +		regmap_write(mux->regmap, mux->offset, val);
> +	else
> +		clk_writel(val, mux->reg);
> +}
> +
> +static u32 clk_mux_readl(struct clk_mux *mux)
> +{
> +	u32 val;
> +
> +	if (mux->flags && CLK_MUX_USE_REGMAP)
> +		regmap_read(mux->regmap, mux->offset, &val);
> +	else
> +		val = clk_readl(mux->reg);
> +
> +	return val;
> +}
> +
>  static u8 clk_mux_get_parent(struct clk_hw *hw)
>  {
>  	struct clk_mux *mux = to_clk_mux(hw);
> @@ -42,7 +62,10 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
>  	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
>  	 * val = 0x4 really means "bit 2, index starts at bit 0"
>  	 */
> -	val = clk_readl(mux->reg) >> mux->shift;
> +
> +	val = clk_mux_readl(mux);
> +
> +	val >>= mux->shift;
>  	val &= mux->mask;
>  
>  	if (mux->table) {
> @@ -89,11 +112,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
>  	if (mux->flags & CLK_MUX_HIWORD_MASK) {
>  		val = mux->mask << (mux->shift + 16);
>  	} else {
> -		val = clk_readl(mux->reg);
> +		val = clk_mux_readl(mux);
>  		val &= ~(mux->mask << mux->shift);
>  	}
>  	val |= index << mux->shift;
> -	clk_writel(val, mux->reg);
> +	clk_mux_writel(mux, val);

With regmap the register lock is inside the regmap, you must hold it
during read/modify/write operations which means you have to use
regmap_update_bits rather than regmap_read followed by regmap_write.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
