From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Thu, 20 Oct 2016 09:50:34 +0200
Subject: [PATCH v2 4/6] clk: stm32f4: Add RTC clock
In-Reply-To: <20161019204537.GD8871@codeaurora.org>
References: <1476436699-21879-1-git-send-email-gabriel.fernandez@st.com>
 <1476436699-21879-5-git-send-email-gabriel.fernandez@st.com>
 <20161019204537.GD8871@codeaurora.org>
Message-ID: <d805fde7-c8a8-15e0-b13d-b54b5c7cca6a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for reviewing.

Ok for all yours remarks


On 10/19/2016 10:45 PM, Stephen Boyd wrote:
> On 10/14, gabriel.fernandez at st.com wrote:
>> @@ -310,6 +310,15 @@ static inline void enable_power_domain_write_protection(void)
>>   	regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
>>   }
>>   
>> +static inline void sofware_reset_backup_domain(void)
>> +{
>> +	unsigned long val;
>> +
>> +	val = readl(base + STM32F4_RCC_BDCR);
>> +	writel(val |= (1 << 16), base + STM32F4_RCC_BDCR);
> Interesting C style here! Why set the bit in val that will then
> be cleared in the next function call? Please just don't do it. It
> would be better to do writel(val | BIT(16), ...)
>
>> +	writel(val & ~(1 << 16), base + STM32F4_RCC_BDCR);
>> +}
>> +
>>   struct stm32_rgate {
>>   	struct	clk_hw hw;
>>   	struct	clk_gate gate;
>> @@ -396,6 +405,113 @@ static struct clk_hw *clk_register_rgate(struct device *dev, const char *name,
>>   	return hw;
>>   }
>>   
>> +static int cclk_gate_enable(struct clk_hw *hw)
>> +{
>> +	int ret;
>> +
>> +	disable_power_domain_write_protection();
>> +
>> +	ret = clk_gate_ops.enable(hw);
>> +
>> +	enable_power_domain_write_protection();
>> +
>> +	return ret;
>> +}
>> +
>> +static void cclk_gate_disable(struct clk_hw *hw)
>> +{
>> +	disable_power_domain_write_protection();
>> +
>> +	clk_gate_ops.disable(hw);
>> +
>> +	enable_power_domain_write_protection();
>> +}
>> +
>> +static int cclk_gate_is_enabled(struct clk_hw *hw)
>> +{
>> +	return clk_gate_ops.is_enabled(hw);
>> +}
>> +
>> +static const struct clk_ops cclk_gate_ops = {
>> +	.enable		= cclk_gate_enable,
>> +	.disable	= cclk_gate_disable,
>> +	.is_enabled	= cclk_gate_is_enabled,
>> +};
>> +
>> +static u8 cclk_mux_get_parent(struct clk_hw *hw)
>> +{
>> +	return clk_mux_ops.get_parent(hw);
>> +}
>> +
>> +
> Weird double newline here. Please remove one.
>
>> +static int cclk_mux_set_parent(struct clk_hw *hw, u8 index)
>> +{
>> +	int ret;
>> +
>> +	disable_power_domain_write_protection();
>> +
>> +	sofware_reset_backup_domain();
>> +
>> +	ret = clk_mux_ops.set_parent(hw, index);
>> +
>> +	enable_power_domain_write_protection();
>> +
>> +	return ret;
>> +}
>> +
>> +
> Same.
>
>> +static const struct clk_ops cclk_mux_ops = {
>> +	.get_parent = cclk_mux_get_parent,
>> +	.set_parent = cclk_mux_set_parent,
>> +};
>> +
>> +static struct clk_hw *stm32_register_cclk(struct device *dev, const char *name,
>> +		const char * const *parent_names, int num_parents,
>> +		void __iomem *reg, u8 bit_idx, u8 shift, unsigned long flags,
>> +		spinlock_t *lock)
>> +{
>> +	struct clk_hw *hw;
>> +	struct clk_gate *gate;
>> +	struct clk_mux *mux;
>> +
>> +	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> sizeof(*gate) please.
>
>> +	if (!gate) {
>> +		hw = ERR_PTR(-EINVAL);
>> +		goto fail;
>> +	}
>> +
>> +	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
> sizeof(*mux) please.
>
>> +	if (!mux) {
>> +		kfree(gate);
>> +		hw = ERR_PTR(-EINVAL);
>> +		goto fail;
>> +	}
>> +
