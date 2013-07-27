From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 27 Jul 2013 14:41:05 +0200
Subject: [PATCH v2 1/8] clk: mux: Add support for read-only muxes.
In-Reply-To: <1374536965-3545-2-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <1374536965-3545-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1460068.oJXN9T0Uhp@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tuesday 23 of July 2013 01:49:18 Tomasz Figa wrote:
> Some platforms have read-only clock muxes that are preconfigured at
> reset and cannot be changed at runtime. This patch extends mux clock
> driver to allow handling such read-only muxes by adding new
> CLK_MUX_READ_ONLY mux flag.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/clk/clk-mux.c        | 10 +++++++++-
>  include/linux/clk-provider.h |  2 ++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 614444c..92f1a1b 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -107,6 +107,11 @@ const struct clk_ops clk_mux_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_mux_ops);
> 
> +const struct clk_ops clk_mux_ro_ops = {
> +	.get_parent = clk_mux_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
> +
>  struct clk *clk_register_mux_table(struct device *dev, const char
> *name, const char **parent_names, u8 num_parents, unsigned long flags,
> void __iomem *reg, u8 shift, u32 mask,
> @@ -133,7 +138,10 @@ struct clk *clk_register_mux_table(struct device
> *dev, const char *name, }
> 
>  	init.name = name;
> -	init.ops = &clk_mux_ops;
> +	if (clk_mux_flags & CLK_MUX_READ_ONLY)
> +		init.ops = &clk_mux_ro_ops;
> +	else
> +		init.ops = &clk_mux_ops;
>  	init.flags = flags | CLK_IS_BASIC;
>  	init.parent_names = parent_names;
>  	init.num_parents = num_parents;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 1ec14a7..9487b96 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -327,8 +327,10 @@ struct clk_mux {
>  #define CLK_MUX_INDEX_ONE		BIT(0)
>  #define CLK_MUX_INDEX_BIT		BIT(1)
>  #define CLK_MUX_HIWORD_MASK		BIT(2)
> +#define CLK_MUX_READ_ONLY	BIT(3) /* mux setting cannot be changed */
> 
>  extern const struct clk_ops clk_mux_ops;
> +extern const struct clk_ops clk_mux_ro_ops;
> 
>  struct clk *clk_register_mux(struct device *dev, const char *name,
>  		const char **parent_names, u8 num_parents, unsigned long 
flags,

What do you think about this?

Best regards,
Tomasz
