From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 07 Jan 2014 17:56:45 +0100
Subject: [PATCH v3 01/13] clk: sunxi: register factors clocks behind
 composite
In-Reply-To: <1387769564-12894-2-git-send-email-emilio@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
 <1387769564-12894-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <52CC31CD.2060005@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Emilio, Mike,

On 23/12/2013 04:32, Emilio L?pez wrote:
> This commit reworks factors clock registration to be done behind a
> composite clock. This allows us to additionally add a gate, mux or
> divisors, as it will be needed by some future PLLs.
>


> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   drivers/clk/sunxi/clk-factors.c | 63 +------------------------------------
>   drivers/clk/sunxi/clk-factors.h | 16 +++++-----
>   drivers/clk/sunxi/clk-sunxi.c   | 70 ++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 76 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index f05207a..9e23264 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -30,14 +30,6 @@
>    * parent - fixed parent.  No clk_set_parent support
>    */
>
> -struct clk_factors {
> -	struct clk_hw hw;
> -	void __iomem *reg;
> -	struct clk_factors_config *config;
> -	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
> -	spinlock_t *lock;
> -};
> -
>   #define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
>
>   #define SETMASK(len, pos)		(((1U << (len)) - 1) << (pos))
> @@ -120,61 +112,8 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
>   	return 0;
>   }
>
> -static const struct clk_ops clk_factors_ops = {
> +const struct clk_ops clk_factors_ops = {
>   	.recalc_rate = clk_factors_recalc_rate,
>   	.round_rate = clk_factors_round_rate,
>   	.set_rate = clk_factors_set_rate,
>   };
> -
> -/**
> - * clk_register_factors - register a factors clock with
> - * the clock framework
> - * @dev: device registering this clock
> - * @name: name of this clock
> - * @parent_name: name of clock's parent
> - * @flags: framework-specific flags
> - * @reg: register address to adjust factors
> - * @config: shift and width of factors n, k, m and p
> - * @get_factors: function to calculate the factors for a given frequency
> - * @lock: shared register lock for this clock
> - */
> -struct clk *clk_register_factors(struct device *dev, const char *name,
> -				 const char *parent_name,
> -				 unsigned long flags, void __iomem *reg,
> -				 struct clk_factors_config *config,
> -				 void (*get_factors)(u32 *rate, u32 parent,
> -						     u8 *n, u8 *k, u8 *m, u8 *p),
> -				 spinlock_t *lock)
> -{
> -	struct clk_factors *factors;
> -	struct clk *clk;
> -	struct clk_init_data init;
> -
> -	/* allocate the factors */
> -	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
> -	if (!factors) {
> -		pr_err("%s: could not allocate factors clk\n", __func__);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	init.name = name;
> -	init.ops = &clk_factors_ops;
> -	init.flags = flags;
> -	init.parent_names = (parent_name ? &parent_name : NULL);
> -	init.num_parents = (parent_name ? 1 : 0);
> -
> -	/* struct clk_factors assignments */
> -	factors->reg = reg;
> -	factors->config = config;
> -	factors->lock = lock;
> -	factors->hw.init = &init;
> -	factors->get_factors = get_factors;
> -
> -	/* register the clock */
> -	clk = clk_register(dev, &factors->hw);
> -
> -	if (IS_ERR(clk))
> -		kfree(factors);
> -
> -	return clk;
> -}
> diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
> index f49851c..02e1a43 100644
> --- a/drivers/clk/sunxi/clk-factors.h
> +++ b/drivers/clk/sunxi/clk-factors.h
> @@ -17,11 +17,13 @@ struct clk_factors_config {
>   	u8 pwidth;
>   };
>
> -struct clk *clk_register_factors(struct device *dev, const char *name,
> -				 const char *parent_name,
> -				 unsigned long flags, void __iomem *reg,
> -				 struct clk_factors_config *config,
> -				 void (*get_factors) (u32 *rate, u32 parent_rate,
> -						      u8 *n, u8 *k, u8 *m, u8 *p),
> -				 spinlock_t *lock);
> +struct clk_factors {
> +	struct clk_hw hw;
> +	void __iomem *reg;
> +	struct clk_factors_config *config;
> +	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
> +	spinlock_t *lock;
> +};
> +
> +extern const struct clk_ops clk_factors_ops;
>   #endif
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 8fc1375..b823613 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -23,6 +23,9 @@
>
>   static DEFINE_SPINLOCK(clk_lock);
>
> +/* Maximum number of parents our clocks have */
> +#define SUNXI_MAX_PARENTS	5
> +
>   /**
>    * sun4i_osc_clk_setup() - Setup function for gatable oscillator
>    */
> @@ -255,7 +258,11 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
>    * sunxi_factors_clk_setup() - Setup function for factor clocks
>    */
>
> +#define SUNXI_FACTORS_MUX_MASK 0x3
> +
>   struct factors_data {
> +	int enable;
> +	int mux;
>   	struct clk_factors_config *table;
>   	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
>   };
> @@ -306,16 +313,71 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>   					   struct factors_data *data)
>   {
>   	struct clk *clk;
> +	struct clk_factors *factors;
> +	struct clk_gate *gate = NULL;
> +	struct clk_mux *mux = NULL;
> +	struct clk_hw *gate_hw = NULL;
> +	struct clk_hw *mux_hw = NULL;
>   	const char *clk_name = node->name;
> -	const char *parent;
> +	const char *parents[SUNXI_MAX_PARENTS];
>   	void *reg;
> +	int i = 0;
>
>   	reg = of_iomap(node, 0);
>
> -	parent = of_clk_get_parent_name(node, 0);
> +	/* if we have a mux, we will have >1 parents */
> +	while (i < SUNXI_MAX_PARENTS &&
> +	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
> +		i++;
> +
> +	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
> +	if (!factors)
> +		return;
> +
> +	/* Add a gate if this factor clock can be gated */
> +	if (data->enable) {
> +		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> +		if (!gate) {
> +			kfree(factors);
> +			return;
> +		}
> +
> +		/* set up gate properties */
> +		gate->reg = reg;
> +		gate->bit_idx = data->enable;
> +		gate->lock = &clk_lock;
> +		gate_hw = &gate->hw;
> +	}
> +
> +	/* Add a mux if this factor clock can be muxed */
> +	if (data->mux) {
> +		mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
> +		if (!mux) {
> +			kfree(factors);
> +			kfree(gate);
> +			return;
> +		}
> +
> +		/* set up gate properties */
> +		mux->reg = reg;
> +		mux->shift = data->mux;
> +		mux->mask = SUNXI_FACTORS_MUX_MASK;
> +		mux->lock = &clk_lock;
> +		mux_hw = &mux->hw;
> +	}
> +
> +	/* set up factors properties */
> +	factors->reg = reg;
> +	factors->config = data->table;
> +	factors->get_factors = data->getter;
> +	factors->lock = &clk_lock;
>
> -	clk = clk_register_factors(NULL, clk_name, parent, 0, reg,
> -				   data->table, data->getter, &clk_lock);
> +	clk = clk_register_composite(NULL, clk_name,
> +			parents, i,
> +			mux_hw, &clk_mux_ops,
> +			&factors->hw, &clk_factors_ops,
> +			gate_hw, &clk_gate_ops,
> +			i ? 0 : CLK_IS_ROOT);
>

I'm currently working on the sunxi NFC (Nand Flash Controller) driver
and I need to set the NAND clk (which is a mod0 clk type) rate.

It seems that the composite clk fallbacks to the mux_hw's determine_rate
instead of calling the rate_hw's (or factors hw) round_rate, if rate_hw
does not implement determine_rate.

In the sunxi specific case, this leads to a DIV by 0 error when later
calling set_rate on this composite clk, because the requested freq is
set to 0 (result from mux_hw determine_rate):


[    0.632125] Division by zero in kernel.
[    0.635970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
3.13.0-rc1-00005-ge2b2be1-dirty #203
[    0.644230] [<c00139bc>] (unwind_backtrace+0x0/0xf8) from 
[<c0010fb8>] (show_stack+0x10/0x14)
[    0.652765] [<c0010fb8>] (show_stack+0x10/0x14) from [<c029276c>] 
(dump_stack+0x68/0x84)
[    0.660861] [<c029276c>] (dump_stack+0x68/0x84) from [<c015e8b0>] 
(Ldiv0+0x8/0x10)
[    0.668438] [<c015e8b0>] (Ldiv0+0x8/0x10) from [<c020d63c>] 
(sun4i_get_mod0_factors+0x6c/0xa8)
[    0.677057] [<c020d63c>] (sun4i_get_mod0_factors+0x6c/0xa8) from 
[<c020d87c>] (clk_factors_set_rate+0x50/0x138)
[    0.687149] [<c020d87c>] (clk_factors_set_rate+0x50/0x138) from 
[<c020cf18>] (clk_composite_set_rate+0x20/0x24)
[    0.697241] [<c020cf18>] (clk_composite_set_rate+0x20/0x24) from 
[<c020b538>] (clk_change_rate+0x5c/0xf8)
[    0.706812] [<c020b538>] (clk_change_rate+0x5c/0xf8) from 
[<c020b64c>] (clk_set_rate+0x78/0xb0)
[    0.715518] [<c020b64c>] (clk_set_rate+0x78/0xb0) from [<c01cc370>] 
(sunxi_nfc_probe+0x1ec/0x5e0)
[    0.724383] [<c01cc370>] (sunxi_nfc_probe+0x1ec/0x5e0) from 
[<c01b50d4>] (platform_drv_probe+0x18/0x48)
[    0.733779] [<c01b50d4>] (platform_drv_probe+0x18/0x48) from 
[<c01b37f0>] (driver_probe_device+0x100/0x210)
[    0.743521] [<c01b37f0>] (driver_probe_device+0x100/0x210) from 
[<c01b398c>] (__driver_attach+0x8c/0x90)
[    0.753005] [<c01b398c>] (__driver_attach+0x8c/0x90) from 
[<c01b2178>] (bus_for_each_dev+0x54/0x88)
[    0.762058] [<c01b2178>] (bus_for_each_dev+0x54/0x88) from 
[<c01b2fd4>] (bus_add_driver+0xd8/0x1cc)
[    0.771108] [<c01b2fd4>] (bus_add_driver+0xd8/0x1cc) from 
[<c01b3fc8>] (driver_register+0x78/0xf4)
[    0.780069] [<c01b3fc8>] (driver_register+0x78/0xf4) from 
[<c00087c8>] (do_one_initcall+0x38/0x160)
[    0.789118] [<c00087c8>] (do_one_initcall+0x38/0x160) from 
[<c0372bc0>] (kernel_init_freeable+0xfc/0x1c8)
[    0.798688] [<c0372bc0>] (kernel_init_freeable+0xfc/0x1c8) from 
[<c028fd00>] (kernel_init+0x8/0x110)
[    0.807825] [<c028fd00>] (kernel_init+0x8/0x110) from [<c000e2b8>] 
(ret_from_fork+0x14/0x3c)


We should definitely check the requested freq and gracefully handle the
0 case.

But anyway, I think there is a drawback in the way composite clk
implement the determine_rate handler.
Mike, shouldn't we choose the best parent (using mux) fullfilling the
rate_hw needs ?


I'll post a proposal...


Best Regards,

Boris

>   	if (!IS_ERR(clk)) {
>   		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>
