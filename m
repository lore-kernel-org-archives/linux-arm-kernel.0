From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 21 Jan 2016 14:49:43 +0800
Subject: [PATCH v2] clk: rockchip: Add support for multiple clock providers
In-Reply-To: <3395528.oy9qVuyESf@phil>
References: <1453280809-3120-1-git-send-email-zhengxing@rock-chips.com>
 <3395528.oy9qVuyESf@phil>
Message-ID: <56A07F87.2060400@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko,
     Thank you for your reply.

On 2016?01?21? 07:38, Heiko Stuebner wrote:
> Hi,
>
> Am Mittwoch, 20. Januar 2016, 17:06:49 schrieb Xing Zheng:
>> There are need to support Multi-CRUs probability in future, but
>> it is not supported on the current Rockchip Clock Framework.
>>
>> Therefore, this patch add support a provider as the parameter
>> handler when we call the clock register functions for per CRU.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> overall this looks really nice. Thanks for following up on our talk so
> quickly :-) .
>
>> ---
>>
>> Changes in v2:
>> - Fix missed to call rockchip_clk_common_cru_init when SoCs clock init.
>>
>>   drivers/clk/rockchip/clk-rk3036.c |   15 +++--
>>   drivers/clk/rockchip/clk-rk3188.c |   40 ++++++++-----
>>   drivers/clk/rockchip/clk-rk3228.c |   15 +++--
>>   drivers/clk/rockchip/clk-rk3288.c |   17 ++++--
>>   drivers/clk/rockchip/clk-rk3368.c |   19 +++---
>>   drivers/clk/rockchip/clk.c        |  120
>> +++++++++++++++++++++++-------------- drivers/clk/rockchip/clk.h        |
>>    35 ++++++++---
>>   7 files changed, 170 insertions(+), 91 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3036.c
>> b/drivers/clk/rockchip/clk-rk3036.c index 483913b..050ad13 100644
>> --- a/drivers/clk/rockchip/clk-rk3036.c
>> +++ b/drivers/clk/rockchip/clk-rk3036.c
>> @@ -434,6 +434,7 @@ static const char *const rk3036_critical_clocks[]
>> __initconst = {
>>
>>   static void __init rk3036_clk_init(struct device_node *np)
>>   {
>> +	struct rockchip_clk_provider *ctx;
>>   	void __iomem *reg_base;
>>   	struct clk *clk;
>>
>> @@ -443,7 +444,9 @@ static void __init rk3036_clk_init(struct device_node
>> *np) return;
>>   	}
>>
>> -	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
>> +	ctx = rockchip_clk_init(reg_base, CLK_NR_CLKS);
>> +
>> +	rockchip_clk_common_cru_init(np);
>>
>>   	/* xin12m is created by an cru-internal divider */
>>   	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
>> @@ -473,15 +476,15 @@ static void __init rk3036_clk_init(struct
>> device_node *np) pr_warn("%s: could not register clock sclk_macref_out:
>> %ld\n", __func__, PTR_ERR(clk));
>>
>> -	rockchip_clk_register_plls(rk3036_pll_clks,
>> +	rockchip_clk_register_plls(ctx, rk3036_pll_clks,
>>   				   ARRAY_SIZE(rk3036_pll_clks),
>>   				   RK3036_GRF_SOC_STATUS0);
>> -	rockchip_clk_register_branches(rk3036_clk_branches,
>> +	rockchip_clk_register_branches(ctx, rk3036_clk_branches,
>>   				  ARRAY_SIZE(rk3036_clk_branches));
>>   	rockchip_clk_protect_critical(rk3036_critical_clocks,
>>   				      ARRAY_SIZE(rk3036_critical_clocks));
>>
>> -	rockchip_clk_register_armclk(ARMCLK, "armclk",
>> +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
>>   			mux_armclk_p, ARRAY_SIZE(mux_armclk_p),
>>   			&rk3036_cpuclk_data, rk3036_cpuclk_rates,
>>   			ARRAY_SIZE(rk3036_cpuclk_rates));
>> @@ -489,6 +492,8 @@ static void __init rk3036_clk_init(struct device_node
>> *np) rockchip_register_softrst(np, 9, reg_base + RK2928_SOFTRST_CON(0),
>> ROCKCHIP_SOFTRST_HIWORD_MASK);
>>
>> -	rockchip_register_restart_notifier(RK2928_GLB_SRST_FST, NULL);
>> +	rockchip_register_restart_notifier(ctx, RK2928_GLB_SRST_FST, NULL);
>> +
>> +	rockchip_clk_of_add_provider(np, ctx);
>>   }
>>   CLK_OF_DECLARE(rk3036_cru, "rockchip,rk3036-cru", rk3036_clk_init);
>> diff --git a/drivers/clk/rockchip/clk-rk3188.c
>> b/drivers/clk/rockchip/clk-rk3188.c index 7f7444c..338a22e 100644
>> --- a/drivers/clk/rockchip/clk-rk3188.c
>> +++ b/drivers/clk/rockchip/clk-rk3188.c
>> @@ -750,18 +750,19 @@ static const char *const rk3188_critical_clocks[]
>> __initconst = { "pclk_peri",
>>   };
>>
>> -static void __init rk3188_common_clk_init(struct device_node *np)
>> +static struct rockchip_clk_provider *__init rk3188_common_clk_init(struct
>> device_node *np) {
>> +	struct rockchip_clk_provider *ctx;
>>   	void __iomem *reg_base;
>>   	struct clk *clk;
>>
>>   	reg_base = of_iomap(np, 0);
>> -	if (!reg_base) {
>> -		pr_err("%s: could not map cru region\n", __func__);
>> -		return;
>> -	}
>> +	if (!reg_base)
>> +		panic("%s: could not map cru region\n", __func__);
> I don't believe in doing panics everywhere :-), please do
> 	return ERR_PTR(-ENOMEM);
> here and in similar locations and let the top-most caller handle errors.
Done.
>> @@ -260,27 +261,49 @@ static struct clk
>> *rockchip_clk_register_frac_branch(const char *name, return clk;
>>   }
>>
>> -static DEFINE_SPINLOCK(clk_lock);
>> -static struct clk **clk_table;
>> -static void __iomem *reg_base;
>> -static struct clk_onecell_data clk_data;
>>   static struct device_node *cru_node;
> please also include the devicetree node into the ctx struct. That way we can
> keep track of all of them (when there are multiple).
In my opinion, I am a bit worried about the function 
rockchip_clk_get_grf, it just refer to
common CRU node to acquire global GRF regmap. And the function is 
non-parameter,
so, I think I will add ctx as parameter in the clk-pll.c.

And, there are the same feature between PLL lock status in the 
GRF_SOC_STATUSx and the
the lock bit of CRU_xPLL_CONx. They are coexsit on some SoCs like 
RK3036/RK3228/RK3288/RK3368,
there is only GRF_SOC_STATUSx on some SoCs like RK3066/RK3188.
AFAIK,  there are not the bits of PLL lock status in the GRF_SOC_STATUSx 
any more in future, like RK3399.
Therefore, we should add some patches to keep the checking PLL lock 
status compatibility.

BTW, it looks that there are too many place call the 
rockchip_clk_get_grf, and they looks
like unused? Should we remove them?
>>   static struct regmap *grf;
>>
>> -void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
>> -			      unsigned long nr_clks)
>> +struct rockchip_clk_provider *__init rockchip_clk_init(
>> +			void __iomem *base, unsigned long nr_clks)
>>   {
>> -	reg_base = base;
>> -	cru_node = np;
>> -	grf = ERR_PTR(-EPROBE_DEFER);
>> +	struct rockchip_clk_provider *ctx;
>> +	struct clk **clk_table;
>> +	int i;
>> +
>> +	ctx = kzalloc(sizeof(struct rockchip_clk_provider), GFP_KERNEL);
>> +	if (!ctx)
>> +		panic("could not allocate clock provider context.\n");
> as I wrote above, please return a real error here. Especially when there are
> multiple clock controllers, it might actually get a bit farther in cases
> when only one of them fails, which might help in debugging underlying issues
> in such cases.
Done.
>>   	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
>>   	if (!clk_table)
>> -		pr_err("%s: could not allocate clock lookup table\n", __func__);
>> +		panic("could not allocate clock lookup table\n");
> same here (and kfree the ctx from above before returning)
Done.
>> +
>> +	for (i = 0; i < nr_clks; ++i)
>> +		clk_table[i] = ERR_PTR(-ENOENT);
>> +
>> +	ctx->reg_base = base;
>> +	ctx->clk_data.clks = clk_table;
>> +	ctx->clk_data.clk_num = nr_clks;
>> +	spin_lock_init(&ctx->lock);
>> +
>> +	return ctx;
>> +}
>>
>> -	clk_data.clks = clk_table;
>> -	clk_data.clk_num = nr_clks;
>> -	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>> +void __init rockchip_clk_common_cru_init(struct device_node *np)
>> +{
>> +	cru_node = np;
>> +	grf = ERR_PTR(-EPROBE_DEFER);
> I'm not sure why this is a separate function. Setting the node pointer (into
> the new struct as written above) can still happen in rockchip_clk_init, and
> initializing the global grf pointer as well.
Done.
>
> Heiko
Thanks.

- Xing Zheng
