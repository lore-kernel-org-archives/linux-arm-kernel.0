From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 10 Mar 2016 10:29:50 +0800
Subject: [PATCH v3 4/7] clk: rockchip: Add support for multiple clock
 providers
In-Reply-To: <1978482.7WNnERYOPX@diego>
References: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
 <1457491027-30936-5-git-send-email-zhengxing@rock-chips.com>
 <1978482.7WNnERYOPX@diego>
Message-ID: <56E0DC1E.9090004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,
     Thank you for helping me to optimize these details. :-)

On 2016?03?10? 06:25, Heiko St?bner wrote:
> Hi Xing,
>
> Am Mittwoch, 9. M?rz 2016, 10:37:04 schrieb Xing Zheng:
>> There are need to support Multi-CRUs probability in future, but
>> it is not supported on the current Rockchip Clock Framework.
>>
>> Therefore, this patch add support a provider as the parameter
>> handler when we call the clock register functions for per CRU.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> I've applied that in a clk branch for 4.7 [0] with some changes detailed
> below. If you can, please check that I didn't mess anything up :-)
>
> I've sucessfully booted that on both a rk3036 and rk3288 as well.
>
>
> Heiko
>
> [0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.7-clk/next&id=d509ddf2e57c99ae760d1a289b85f1e0d729f864
>
>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/clk/rockchip/clk-pll.c    |   30 ++++----
>>   drivers/clk/rockchip/clk-rk3036.c |   17 +++--
>>   drivers/clk/rockchip/clk-rk3188.c |   48 ++++++++----
>>   drivers/clk/rockchip/clk-rk3228.c |   17 +++--
>>   drivers/clk/rockchip/clk-rk3288.c |   19 +++--
>>   drivers/clk/rockchip/clk-rk3368.c |   21 ++++--
>>   drivers/clk/rockchip/clk.c        |  148
>> +++++++++++++++++++++++-------------- drivers/clk/rockchip/clk.h        |
>> 49 ++++++++----
>>   8 files changed, 231 insertions(+), 118 deletions(-)
> [...]
>
>> diff --git a/drivers/clk/rockchip/clk-rk3188.c
>> b/drivers/clk/rockchip/clk-rk3188.c index e832403..7c73c51 100644
>> --- a/drivers/clk/rockchip/clk-rk3188.c
>> @@ -759,57 +759,78 @@ static const char *const rk3188_critical_clocks[]
>> __initconst = { "hclk_cpubus"
>>   };
>>
>> -static void __init rk3188_common_clk_init(struct device_node *np)
>> +static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct
>> device_node *np) {
>> +	struct rockchip_clk_provider *ctx;
>>   	void __iomem *reg_base;
>>
>>   	reg_base = of_iomap(np, 0);
>>   	if (!reg_base) {
>>   		pr_err("%s: could not map cru region\n", __func__);
>> -		return;
>> +		return ERR_PTR(-ENOMEM);
>>   	}
>>
>> -	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
>> +	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
>> +	if (IS_ERR(ctx)) {
>> +		pr_err("%s: rockchip clk init failed\n", __func__);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>>
>> -	rockchip_clk_register_branches(common_clk_branches,
>> +	rockchip_clk_register_branches(ctx, common_clk_branches,
>>   				  ARRAY_SIZE(common_clk_branches));
>>
>>   	rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
>>   				  ROCKCHIP_SOFTRST_HIWORD_MASK);
>>
>> -	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST, NULL);
>> +	rockchip_register_restart_notifier(ctx, RK2928_GLB_SRST_FST, NULL);
>> +
>> +	return ctx;
>>   }
>>
>>   static void __init rk3066a_clk_init(struct device_node *np)
>>   {
>> -	rk3188_common_clk_init(np);
>> -	rockchip_clk_register_plls(rk3066_pll_clks,
>> +	struct rockchip_clk_provider *ctx;
>> +
>> +	ctx = rk3188_common_clk_init(np);
>> +	if (IS_ERR(ctx)) {
>> +		pr_err("%s: common clk init failed\n", __func__);
>> +		return;
>> +	}
> I've dropped the pr_err + parentheses, as rk3188_common_clk_init
> will already output a suitable error.
>
>
>> +
>> +	rockchip_clk_register_plls(ctx, rk3066_pll_clks,
>>   				   ARRAY_SIZE(rk3066_pll_clks),
>>   				   RK3066_GRF_SOC_STATUS);
>> -	rockchip_clk_register_branches(rk3066a_clk_branches,
>> +	rockchip_clk_register_branches(ctx, rk3066a_clk_branches,
>>   				  ARRAY_SIZE(rk3066a_clk_branches));
>> -	rockchip_clk_register_armclk(ARMCLK, "armclk",
>> +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
>>   			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
>>   			&rk3066_cpuclk_data, rk3066_cpuclk_rates,
>>   			ARRAY_SIZE(rk3066_cpuclk_rates));
>>   	rockchip_clk_protect_critical(rk3188_critical_clocks,
>>   				      ARRAY_SIZE(rk3188_critical_clocks));
>> +	rockchip_clk_of_add_provider(np, ctx);
>>   }
>>   CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
>>
>>   static void __init rk3188a_clk_init(struct device_node *np)
>>   {
>> +	struct rockchip_clk_provider *ctx;
>>   	struct clk *clk1, *clk2;
>>   	unsigned long rate;
>>   	int ret;
>>
>> -	rk3188_common_clk_init(np);
>> -	rockchip_clk_register_plls(rk3188_pll_clks,
>> +	ctx = rk3188_common_clk_init(np);
>> +	if (IS_ERR(ctx)) {
>> +		pr_err("%s: common clk init failed\n", __func__);
>> +		return;
>> +	}
> same as above
>
>
>> +
>> +	rockchip_clk_register_plls(ctx, rk3188_pll_clks,
>>   				   ARRAY_SIZE(rk3188_pll_clks),
>>   				   RK3188_GRF_SOC_STATUS);
>> -	rockchip_clk_register_branches(rk3188_clk_branches,
>> +	rockchip_clk_register_branches(ctx, rk3188_clk_branches,
>>   				  ARRAY_SIZE(rk3188_clk_branches));
>> -	rockchip_clk_register_armclk(ARMCLK, "armclk",
>> +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
>>   				  mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
>>   				  &rk3188_cpuclk_data, rk3188_cpuclk_rates,
>>   				  ARRAY_SIZE(rk3188_cpuclk_rates));
>> @@ -833,6 +854,7 @@ static void __init rk3188a_clk_init(struct device_node
>> *np)
>>
>>   	rockchip_clk_protect_critical(rk3188_critical_clocks,
>>   				      ARRAY_SIZE(rk3188_critical_clocks));
>> +	rockchip_clk_of_add_provider(np, ctx);
>>   }
>>   CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
> [...]
>
>> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
>> index ab50524..54e6b74 100644
>> --- a/drivers/clk/rockchip/clk.c
>> +++ b/drivers/clk/rockchip/clk.c
>> @@ -312,66 +316,94 @@ static struct clk
>> *rockchip_clk_register_factor_branch(const char *name, return clk;
>>   }
>>
>> -static DEFINE_SPINLOCK(clk_lock);
>> -static struct clk **clk_table;
>> -static void __iomem *reg_base;
>> -static struct clk_onecell_data clk_data;
>> -static struct device_node *cru_node;
>> -static struct regmap *grf;
>> -
>> -void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
>> -			      unsigned long nr_clks)
>> +struct rockchip_clk_provider *__init rockchip_clk_init(struct device_node
> I've added a space between the asterisk and __init flag
>
>
>> *np, +			void __iomem *base, unsigned long nr_clks)
>>   {
>> -	reg_base = base;
>> -	cru_node = np;
>> -	grf = ERR_PTR(-EPROBE_DEFER);
>> +	struct rockchip_clk_provider *ctx;
>> +	struct clk **clk_table;
>> +	int i;
>> +
>> +	ctx = kzalloc(sizeof(struct rockchip_clk_provider), GFP_KERNEL);
>> +	if (!ctx) {
>> +		pr_err("%s: Could not allocate clock provider context\n",
>> +			__func__);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>>
>>   	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
>> -	if (!clk_table)
>> -		pr_err("%s: could not allocate clock lookup table\n", __func__);
>> +	if (!clk_table) {
>> +		pr_err("%s: Could not allocate clock lookup table\n",
>> +			__func__);
>> +		goto err_free;
>> +	}
>> +
>> +	for (i = 0; i < nr_clks; ++i)
>> +		clk_table[i] = ERR_PTR(-ENOENT);
>>
>> -	clk_data.clks = clk_table;
>> -	clk_data.clk_num = nr_clks;
>> -	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>> +	ctx->reg_base = base;
>> +	ctx->clk_data.clks = clk_table;
>> +	ctx->clk_data.clk_num = nr_clks;
>> +	ctx->cru_node = np;
>> +	ctx->grf = ERR_PTR(-EPROBE_DEFER);
>> +	spin_lock_init(&ctx->lock);
>> +
>> +	return ctx;
>> +
>> +err_free:
>> +	kfree(ctx);
>> +	return ERR_PTR(-ENOMEM);
>> +}
>> +
>> +void __init rockchip_clk_of_add_provider(struct device_node *np,
>> +				struct rockchip_clk_provider *ctx)
>> +{
>> +	if (np) {
>> +		if (of_clk_add_provider(np, of_clk_src_onecell_get,
>> +					&ctx->clk_data))
>> +			panic("could not register clk provider\n");
> I've changed that to a pr_err, again no need to panic on this, as letting
> the kernel run may give the affected developer more hints what may be wrong.
>
>
>> +	}
>>   }
>>
>> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
>> index 7aafe18..b7affb6 100644
>> --- a/drivers/clk/rockchip/clk.h
>> +++ b/drivers/clk/rockchip/clk.h
>> @@ -127,6 +128,20 @@ enum rockchip_pll_type {
>>   	.nb = _nb,						\
>>   }
>>
>> +/**
>> + * struct rockchip_clk_provider: information about clock provider
>> + * @reg_base: virtual address for the register base.
>> + * @clk_data: holds clock related data like clk* and number of clocks.
>> + * @lock: maintains exclusion between callbacks for a given clock-provider.
> I've added the missing kerneldoc entries here
>
>
>> + */
>> +struct rockchip_clk_provider {
>> +	void __iomem *reg_base;
>> +	struct clk_onecell_data clk_data;
>> +	struct device_node *cru_node;
>> +	struct regmap *grf;
>> +	spinlock_t lock;
>> +};
>> +
>>   struct rockchip_pll_rate_table {
>>   	unsigned long rate;
>>   	unsigned int nr;
>
>
>

-- 
- Xing Zheng
