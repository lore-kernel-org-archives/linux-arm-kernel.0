From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 9 Aug 2014 21:33:17 +0800
Subject: [PATCH V3 2/3] ARM: clk-gate2: Add API imx_clk_gate2_exclusive
 for clk_gate2
In-Reply-To: <e1a314548b2e00fccccb4ece8200da97cf89c6bb.1407481023.git.shengjiu.wang@freescale.com>
References: <cover.1407481023.git.shengjiu.wang@freescale.com>
 <e1a314548b2e00fccccb4ece8200da97cf89c6bb.1407481023.git.shengjiu.wang@freescale.com>
Message-ID: <20140809133314.GA8849@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 08, 2014 at 03:02:48PM +0800, Shengjiu Wang wrote:
> As some clocks are mutually exlcusive, they can't be enabled simultaneously,
> So add this new API for registering exclusive clock, the enable function will
> check if there is exclusive clock and it is not enabled, then this clock can
> be enabled, otherwise, it will return error.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  arch/arm/mach-imx/clk-gate2.c |   18 +++++++++++++++++-
>  arch/arm/mach-imx/clk.h       |    2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/clk-gate2.c b/arch/arm/mach-imx/clk-gate2.c
> index 84acdfd..df64c4d 100644
> --- a/arch/arm/mach-imx/clk-gate2.c
> +++ b/arch/arm/mach-imx/clk-gate2.c
> @@ -8,7 +8,7 @@
>   *
>   * Gated clock implementation
>   */
> -
> +#include <linux/clk-private.h>

I do not see why this header is needed.

Shawn

>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> @@ -34,6 +34,7 @@ struct clk_gate2 {
>  	u8		flags;
>  	spinlock_t	*lock;
>  	unsigned int	*share_count;
> +	struct clk	*clk_exclusive;
>  };
>  
>  #define to_clk_gate2(_hw) container_of(_hw, struct clk_gate2, hw)
> @@ -46,6 +47,11 @@ static int clk_gate2_enable(struct clk_hw *hw)
>  
>  	spin_lock_irqsave(gate->lock, flags);
>  
> +	if (gate->clk_exclusive && __clk_is_enabled(gate->clk_exclusive)) {
> +		spin_unlock_irqrestore(gate->lock, flags);
> +		return -EBUSY;
> +	}
> +
>  	if (gate->share_count && (*gate->share_count)++ > 0)
>  		goto out;
>  
> @@ -147,3 +153,13 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
>  
>  	return clk;
>  }
> +
> +int imx_clk_gate2_exclusive(struct clk *clk1, struct clk *clk2)
> +{
> +	struct clk_gate2 *gate1 = to_clk_gate2(clk1->hw);
> +	struct clk_gate2 *gate2 = to_clk_gate2(clk2->hw);
> +
> +	gate1->clk_exclusive = clk2;
> +	gate2->clk_exclusive = clk1;
> +	return 0;
> +}
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index d5ba76f..2b07376 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -36,6 +36,8 @@ struct clk *clk_register_gate2(struct device *dev, const char *name,
>  struct clk * imx_obtain_fixed_clock(
>  			const char *name, unsigned long rate);
>  
> +int imx_clk_gate2_exclusive(struct clk *clk1, struct clk *clk2);
> +
>  static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
>  		void __iomem *reg, u8 shift)
>  {
> -- 
> 1.7.9.5
> 
