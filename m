From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jun 2017 15:07:03 -0700
Subject: [RESEND PATCH v4] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <1496818794-14771-1-git-send-email-gabriel.fernandez@st.com>
References: <1496818794-14771-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20170621220703.GI4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch enables clocks for STM32H743 boards.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> for MFD changes:
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> for DT-Bindings
> Acked-by: Rob Herring <robh@kernel.org>
> v4:
>   - rename lock into stm32rcc_lock
>   - don't use clk_readl() 
>   - remove useless parentheses with GENMASK
>   - fix parents of timer_x clocks
>   - suppress pll configuration from DT
>   - fix kbuild warning
> 
> v3:
>   - fix compatible string "stm32h7-pll" into "st,stm32h7-pll"
>   - fix bad parent name for mco2 clock
>   - set CLK_SET_RATE_PARENT for ltdc clock
>   - set CLK_IGNORE_UNUSED for pll1
>   - disable power domain write protection on disable ops if needed
> 
> 
> v2:
>   - rename compatible string "stm32,pll" into "stm32h7-pll"
>   - suppress "st,pllrge" property
>   - suppress "st, frac-status" property
>   - change management of "st,frac"  property
> 	0 : enable 0 pll integer mode 
> 	other values : enable pll in fractional mode (value is
> 	the fractional factor)

Please drop the changelog from commit text.

> diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
> new file mode 100644
> index 0000000..2907c1f
> --- /dev/null
> +++ b/drivers/clk/clk-stm32h7.c
> @@ -0,0 +1,1532 @@
> +/* Power domain helper */
> +static inline void disable_power_domain_write_protection(void)
> +{
> +	if (pdrm)
> +		regmap_update_bits(pdrm, 0x00, (1 << 8), (1 << 8));
> +}
> +
> +static inline void enable_power_domain_write_protection(void)
> +{
> +	if (pdrm)
> +		regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
> +}
> +
> +static inline int is_enable_power_domain_write_protection(void)

Return bool, not int?

> +{
> +	if (pdrm) {
> +		u32 val;
> +
> +		regmap_read(pdrm, 0x00, &val);
> +
> +		return !(val & 0x100);
> +	}
> +	return -1;

Returning -1 looks odd.

> +}
> +
> +/* Gate clock with ready bit and backup domain management */
> +struct stm32_ready_gate {
> +	struct	clk_gate gate;
> +	u8	bit_rdy;
> +	u8	backup_domain;
> +};
> +
> +#define to_ready_gate_clk(_rgate) container_of(_rgate, struct stm32_ready_gate,\
> +		gate)
> +
> +#define RGATE_TIMEOUT 600000
> +
> +static int ready_gate_clk_is_enabled(struct clk_hw *hw)
> +{
> +	return clk_gate_ops.is_enabled(hw);
> +}

Perhaps we should expose clk_gate_ops::is_enabled as functions
that can be directly called and assigned in places like this so
we don't need wrapper functions that do nothing besides forward
the call.

> +
> +static int ready_gate_clk_enable(struct clk_hw *hw)
> +{
> +	struct clk_gate *gate = to_clk_gate(hw);
> +	struct stm32_ready_gate *rgate = to_ready_gate_clk(gate);
> +	int dbp_status;
> +	int bit_status;
> +	unsigned int timeout = RGATE_TIMEOUT;
> +
> +	if (clk_gate_ops.is_enabled(hw))
> +		return 0;
> +
> +	dbp_status = is_enable_power_domain_write_protection();
> +
> +	if (rgate->backup_domain && dbp_status)
> +		disable_power_domain_write_protection();
> +
> +	clk_gate_ops.enable(hw);
> +
> +	do {
> +		bit_status = !(readl(gate->reg) & BIT(rgate->bit_rdy));
> +
> +		if (bit_status)
> +			udelay(1000);
> +
> +	} while (bit_status && --timeout);

readl_poll_timeout?

> +
> +/* RTC clock */
> +static u8 rtc_mux_get_parent(struct clk_hw *hw)
> +{
> +	return clk_mux_ops.get_parent(hw);
> +}
> +
> +static int rtc_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	int dbp_status;
> +	int err;
> +
> +	dbp_status = is_enable_power_domain_write_protection();
> +
> +	if (dbp_status)
> +		disable_power_domain_write_protection();
> +
> +	err = clk_mux_ops.set_parent(hw, index);
> +
> +	if (dbp_status)
> +		enable_power_domain_write_protection();
> +
> +	return err;
> +}
> +
> +static int rtc_mux_determine_rate(struct clk_hw *hw,
> +		struct clk_rate_request *req)
> +{
> +	return clk_mux_ops.determine_rate(hw, req);
> +}

In this case we have that function exposed already so it could
be assigned.

> +
> +static const struct clk_ops rtc_mux_ops = {
> +	.get_parent	= rtc_mux_get_parent,
> +	.set_parent	= rtc_mux_set_parent,
> +	.determine_rate = rtc_mux_determine_rate,
> +};
> +
> +/* Clock gate with backup domain protection management */
> +static int bd_gate_is_enabled(struct clk_hw *hw)
> +{
> +	return clk_gate_ops.is_enabled(hw);
> +}
> +
> +static int bd_gate_enable(struct clk_hw *hw)
> +{
> +	int dbp_status;
> +	int err;
> +
> +	if (bd_gate_is_enabled(hw))
> +		return 0;
> +
[...]
> +
> +	return;
> +
> +err_free_clks:
> +	kfree(clk_data);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(stm32h7_rcc, "st,stm32h743-rcc", stm32h7_rcc_init);

Can you add a comment above this why we can't do a split design
with a platform driver and a CLK_OF_DECLARE_DRIVER() routine here
and also mention the other driver that's probing against the same
compatible?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
