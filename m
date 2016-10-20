From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 20 Oct 2016 09:47:04 +0200
Subject: [PATCH v2 1/6] clk: stm32f4: Add LSI & LSE clocks
In-Reply-To: <20161019202433.GA8871@codeaurora.org>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-2-git-send-email-gabriel.fernandez@st.com>
 <20161019202433.GA8871@codeaurora.org>
Message-ID: <e1a7dd16-089e-3a60-9e53-cdd57e42aeed@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen,
Many thanks for reviewing.

On 10/19/2016 10:24 PM, Stephen Boyd wrote:
> On 10/14, gabriel.fernandez at st.com wrote:
>> @@ -292,8 +298,110 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
>>   	return clks[i];
>>   }
>>   
>> +static struct regmap *pdrm;
> This can't be part of the stm32_rgate structure?
yes i can include it.

>
>> +
>> +static inline void disable_power_domain_write_protection(void)
>> +{
>> +	regmap_update_bits(pdrm, 0x00, (1 << 8), (1 << 8));
>> +}
>> +
>> +static inline void enable_power_domain_write_protection(void)
>> +{
>> +	regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
>> +}
>> +
>> +struct stm32_rgate {
>> +	struct	clk_hw hw;
>> +	struct	clk_gate gate;
> Why not use the clk_hw inside clk_gate?yes you right, if it's optional i won't have dependency with DT
ok
>
>> +	u8	bit_rdy_idx;
>> +};
>> +
>> +#define RTC_TIMEOUT 1000000
>> +
>> +#define to_rgclk(_hw) container_of(_hw, struct stm32_rgate, hw)
>> +
>> +static int rgclk_enable(struct clk_hw *hw)
>> +{
>> +	struct stm32_rgate *rgate = to_rgclk(hw);
>> +	struct clk_hw *gate_hw = &rgate->gate.hw;
>> +	struct clk_gate *gate = to_clk_gate(gate_hw);
>> +	u32 reg;
>> +	int ret;
>> +
>> +	__clk_hw_set_clk(gate_hw, hw);
> Then we don't need this part.
>
>> +
>> +	disable_power_domain_write_protection();
>> +
>> +	clk_gate_ops.enable(gate_hw);
>> +
>> +	ret = readl_relaxed_poll_timeout_atomic(gate->reg, reg,
>> +			reg & rgate->bit_rdy_idx, 1000, RTC_TIMEOUT);
>> +
>> +	enable_power_domain_write_protection();
>> +
>> +	return ret;
>> +}
>> +
>> +static void rgclk_disable(struct clk_hw *hw)
>> +{
>> +	clk_gate_ops.disable(hw);
>> +}
>> +
>> +static int rgclk_is_enabled(struct clk_hw *hw)
>> +{
>> +	return clk_gate_ops.is_enabled(hw);
>> +}
>> +
>> +
> Drop the double newline here please.
ok
>
>> +static const struct clk_ops rgclk_ops = {
>> +	.enable = rgclk_enable,
>> +	.disable = rgclk_disable,
>> +	.is_enabled = rgclk_is_enabled,
>> +};
>> +
>> +static struct clk_hw *clk_register_rgate(struct device *dev, const char *name,
>> +		const char *parent_name, unsigned long flags,
>> +		void __iomem *reg, u8 bit_idx, u8 bit_rdy_idx,
>> +		u8 clk_gate_flags, spinlock_t *lock)
>> +{
>> +	struct stm32_rgate *rgate;
>> +	struct clk_init_data init = { NULL };
>> +	struct clk_hw *hw;
>> +	int ret;
>> +
>> +	rgate = kzalloc(sizeof(*rgate), GFP_KERNEL);
>> +	if (!rgate)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	init.name = name;
>> +	init.ops = &rgclk_ops;
>> +	init.flags = flags | CLK_IS_BASIC;
> Please no CLK_IS_BASIC flags.
ok
>
>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>> +
>> +	rgate->hw.init = &init;
>> +	rgate->bit_rdy_idx = bit_rdy_idx;
>> +
>> +	rgate->gate.lock = lock;
>> +	rgate->gate.reg = reg;
>> +	rgate->gate.bit_idx = bit_idx;
>> +
>> +	hw = &rgate->hw;
>> +	ret = clk_hw_register(dev, hw);
>> +	if (ret) {
>> +		kfree(rgate);
>> +		hw = ERR_PTR(ret);
>> +	}
>> +
>> +	return hw;
>> +}
>> +
>>   static const char *sys_parents[] __initdata =   { "hsi", NULL, "pll" };
>>   
>> +const char *rtc_parents[4] = {
> static const char * const?
ok
>
>> +	"no-clock", "lse", "lsi", "hse-rtc"
>> +};
>> +
>>   static const struct clk_div_table ahb_div_table[] = {
>>   	{ 0x0,   1 }, { 0x1,   1 }, { 0x2,   1 }, { 0x3,   1 },
>>   	{ 0x4,   1 }, { 0x5,   1 }, { 0x6,   1 }, { 0x7,   1 },
>> @@ -319,6 +427,12 @@ static void __init stm32f4_rcc_init(struct device_node *np)
>>   		return;
>>   	}
>>   
>> +	pdrm = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
> Is there a dt binding update for this? It should probably be
> optional?
yes you right, if it's optional i don't need dependency with DT

>> +	if (IS_ERR(pdrm)) {
>> +		pr_err("%s: Unable to get syscfg\n", __func__);
>> +		goto fail;
>> +	}
>> +
>>   	hse_clk = of_clk_get_parent_name(np, 0);
>>   
