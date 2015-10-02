From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 17:07:41 -0700
Subject: [PATCH v3 3/4] clk: bcm2835: Add support for programming the
 audio domain clocks.
In-Reply-To: <1443475325-22270-3-git-send-email-eric@anholt.net>
References: <1443475325-22270-1-git-send-email-eric@anholt.net>
 <1443475325-22270-3-git-send-email-eric@anholt.net>
Message-ID: <20151002000741.GA1213@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28, Eric Anholt wrote:
> +
> +static const char *bcm2835_clock_per_parents[] = {
> +static const char *bcm2835_clock_vpu_parents[] = {
> +static const char *bcm2835_clock_osc_parents[] = {

Can these parent arrays be const char * const ?

> +	"gnd",
> +	"xosc",
> +	"testdebug0",
> +	"testdebug1"
> +};
> +
> +/*
> + * Used for a 1Mhz clock for the system clocksource, and also used by
> + * the watchdog timer and the camera pulse generator.
> + */
> +static struct bcm2835_clock_data bcm2835_clock_timer_data = {
> +static struct bcm2835_clock_data bcm2835_clock_otp_data = {
> +static struct bcm2835_clock_data bcm2835_clock_vpu_data = {
> +static struct bcm2835_clock_data bcm2835_clock_v3d_data = {
> +static struct bcm2835_clock_data bcm2835_clock_isp_data = {
> +static struct bcm2835_clock_data bcm2835_clock_h264_data = {
> +static struct bcm2835_clock_data bcm2835_clock_vec_data = {
> +static struct bcm2835_clock_data bcm2835_clock_uart_data = {
> +static struct bcm2835_clock_data bcm2835_clock_hsm_data = {
> +static struct bcm2835_clock_data bcm2835_clock_sdram_data = {
> +static struct bcm2835_clock_data bcm2835_clock_tsens_data = {
> +static struct bcm2835_clock_data bcm2835_clock_emmc_data = {

Can all these data structures be const?

> +static int bcm2835_pll_is_on(struct clk_hw *hw)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	const struct bcm2835_pll_data *data = pll->data;
> +
> +	return (cprman_read(cprman, data->a2w_ctrl_reg) &
> +		A2W_PLL_CTRL_PRST_DISABLE);

Useless parenthesis.

> +}
> +
> +static void bcm2835_pll_choose_ndiv_and_fdiv(unsigned long rate,
> +					     unsigned long parent_rate,
> +					     u32 *ndiv, u32 *fdiv)
> +{
> +	u64 div;
> +
> +	div = ((u64)rate << A2W_PLL_FRAC_BITS);
> +	do_div(div, parent_rate);
> +
> +	*ndiv = div >> A2W_PLL_FRAC_BITS;
> +	*fdiv = div & ((1 << A2W_PLL_FRAC_BITS) - 1);
> +}
[..]
> +static unsigned long bcm2835_pll_get_rate(struct clk_hw *hw,
> +					  unsigned long parent_rate)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	const struct bcm2835_pll_data *data = pll->data;
> +	u32 a2wctrl = cprman_read(cprman, data->a2w_ctrl_reg);
> +	u32 ndiv, pdiv, fdiv;
> +
> +	if (parent_rate == 0)
> +		return 0;
> +
> +	fdiv = cprman_read(cprman, data->frac_reg) & A2W_PLL_FRAC_MASK;
> +	ndiv = (a2wctrl & A2W_PLL_CTRL_NDIV_MASK) >> A2W_PLL_CTRL_NDIV_SHIFT;
> +	pdiv = (a2wctrl & A2W_PLL_CTRL_PDIV_MASK) >> A2W_PLL_CTRL_PDIV_SHIFT;
> +
> +	if (cprman_read(cprman, data->ana_reg_base + 4) &
> +	    data->ana->fb_prediv_mask) {
> +		ndiv *= 2;
> +	}

How about a local variable so that we can put the if on one line
and drop the braces?

> +
> +	return bcm2835_pll_rate_from_divisors(parent_rate, ndiv, fdiv, pdiv);
> +}
> +
[..]
> +static int bcm2835_pll_on(struct clk_hw *hw)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	const struct bcm2835_pll_data *data = pll->data;
> +
> +	/* Take the PLL out of reset. */
> +	cprman_write(cprman, data->cm_ctrl_reg,
> +		     cprman_read(cprman, data->cm_ctrl_reg) & ~CM_PLL_ANARST);
> +
> +	/* Wait for the PLL to lock. */
> +	while (!(cprman_read(cprman, CM_LOCK) & data->lock_mask))
> +		cpu_relax();

Is there any reasonable timeout that we can put here? Hopefully
this isn't an infinite loop.

> +
> +	return 0;
> +}
> +
> +static int bcm2835_pll_set_rate(struct clk_hw *hw,
> +				unsigned long rate, unsigned long parent_rate)
> +{
[..]
> +
> +	/* Unmask the reference clock from the oscillator. */
> +	cprman_write(cprman, A2W_XOSC_CTRL,
> +		     cprman_read(cprman, A2W_XOSC_CTRL) |
> +		     data->reference_enable_mask);
> +
> +	if (do_ana_setup_first) {
> +		cprman_write(cprman, data->ana_reg_base + 12, ana3);
> +		cprman_write(cprman, data->ana_reg_base + 8, ana2);

ana2 never changes, so why do we need to write it again?

> +		cprman_write(cprman, data->ana_reg_base + 4, ana1);
> +		cprman_write(cprman, data->ana_reg_base + 0, ana0);

Maybe this should be a function that takes a u32 array of size 4.

> +	}
> +
> +	/* Set the PLL multiplier from the oscillator. */
> +	cprman_write(cprman, data->frac_reg, fdiv);
> +	cprman_write(cprman, data->a2w_ctrl_reg,
> +		     (cprman_read(cprman, data->a2w_ctrl_reg) &
> +		      ~(A2W_PLL_CTRL_NDIV_MASK |
> +			A2W_PLL_CTRL_PDIV_MASK)) |
> +		     (ndiv << A2W_PLL_CTRL_NDIV_SHIFT) |
> +		     (pdiv << A2W_PLL_CTRL_PDIV_SHIFT));

This is a 6 line write. Can we get some local variables and do
the bit setting in different statements?

> +
> +	if (!do_ana_setup_first) {
> +		cprman_write(cprman, data->ana_reg_base + 12, ana3);
> +		cprman_write(cprman, data->ana_reg_base + 8, ana2);
> +		cprman_write(cprman, data->ana_reg_base + 4, ana1);
> +		cprman_write(cprman, data->ana_reg_base + 0, ana0);

Function would help because we do this twice.

> +	}
> +
> +	bcm2835_pll_get_rate(&pll->hw, parent_rate);
> +
> +	return 0;
> +}
> +
[...]
> +static unsigned long bcm2835_pll_divider_get_rate(struct clk_hw *hw,
> +						  unsigned long parent_rate)
> +{
> +	struct bcm2835_pll_divider *divider =
> +		container_of(hw, struct bcm2835_pll_divider, div.hw);
> +	struct bcm2835_cprman *cprman = divider->cprman;
> +	const struct bcm2835_pll_divider_data *data = divider->data;
> +	u32 div = cprman_read(cprman, data->a2w_reg);
> +
> +	div &= ((1 << A2W_PLL_DIV_BITS) - 1);

One too many parenthesis here.

> +	if (div == 0)
> +		div = 256;
> +
> +	return parent_rate / div;
> +}
> +
[..]
> +
> +static int bcm2835_clock_is_on(struct clk_hw *hw)
> +{
> +	struct bcm2835_clock *clock =
> +		container_of(hw, struct bcm2835_clock, hw);
> +	struct bcm2835_cprman *cprman = clock->cprman;
> +	const struct bcm2835_clock_data *data = clock->data;
> +
> +	/*
> +	 * The VPU clock is always on, regardless of what we might set
> +	 * the enable bit to.
> +	 */
> +	if (data->is_nonstop)

Maybe the variable should be called is_vpu_clock then? Or the
comment is going to go out of date soon.

> +		return true;
> +
> +	return (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) != 0;
> +}
> +
> +static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
> +				    unsigned long rate,
> +				    unsigned long parent_rate)
> +{
> +	struct bcm2835_clock *clock =
> +		container_of(hw, struct bcm2835_clock, hw);
> +	const struct bcm2835_clock_data *data = clock->data;
> +	u32 unused_frac_mask = (1 << (CM_DIV_FRAC_BITS - data->frac_bits)) - 1;

We have GENMASK for this sort of stuff.

> +	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
> +	u32 div;
> +
> +	do_div(temp, rate);
> +	div = temp;
> +
> +	/* Round and mask off the unused bits */
> +	if (unused_frac_mask != 0) {
> +		div += unused_frac_mask >> 1;
> +		div &= ~unused_frac_mask;
> +	}
> +
> +	/* Clamp to the limits. */
> +	div = max(div, unused_frac_mask + 1);
> +	div = min(div, (((1 << (data->int_bits + CM_DIV_FRAC_BITS)) - 1)) &
> +		  ~unused_frac_mask);
> +
> +	return div;
> +}
> +
> +static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
> +					    unsigned long parent_rate,
> +					    u32 div)
> +{
> +	const struct bcm2835_clock_data *data = clock->data;
> +	u64 temp;
> +
> +	/*
> +	 * The divisor is a 12.12 fixed point field, but only some of
> +	 * the bits are populated in any given clock.
> +	 */
> +	div >>= (CM_DIV_FRAC_BITS - data->frac_bits);

Useless parenthesis here.

> +	div &= (1 << (data->int_bits + data->frac_bits)) - 1;
> +
> +	if (div == 0)
> +		return 0;
> +
> +	temp = (u64)parent_rate << data->frac_bits;
> +
> +	do_div(temp, div);
> +
> +	return temp;
> +}
> +
> +static long bcm2835_clock_round_rate(struct clk_hw *hw,
> +				     unsigned long rate,
> +				     unsigned long *parent_rate)
> +{
> +	struct bcm2835_clock *clock =
> +		container_of(hw, struct bcm2835_clock, hw);

Would be nice to have a macro to get this onto one line

	struct bcm2835_clock *clock = to_bcm2385_clock(hw);

> +	u32 div = bcm2835_clock_choose_div(hw, rate, *parent_rate);
> +
> +	return bcm2835_clock_rate_from_divisor(clock, *parent_rate, div);
> +}
> +
> +static unsigned long bcm2835_clock_get_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct bcm2835_clock *clock =
> +		container_of(hw, struct bcm2835_clock, hw);
> +	struct bcm2835_cprman *cprman = clock->cprman;
> +	const struct bcm2835_clock_data *data = clock->data;
> +	u32 div = cprman_read(cprman, data->div_reg);
> +
> +	return bcm2835_clock_rate_from_divisor(clock, parent_rate, div);
> +}
> +
> +static void bcm2835_clock_wait_busy(struct bcm2835_clock *clock)
> +{
> +	struct bcm2835_cprman *cprman = clock->cprman;
> +	const struct bcm2835_clock_data *data = clock->data;
> +
> +	while (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
> +		cpu_relax();
> +}
> +
> +static void bcm2835_clock_off(struct clk_hw *hw)
> +{
> +	struct bcm2835_clock *clock =
> +		container_of(hw, struct bcm2835_clock, hw);
> +	struct bcm2835_cprman *cprman = clock->cprman;
> +	const struct bcm2835_clock_data *data = clock->data;
> +
> +	if (data->is_nonstop)

Or we should have different clk_ops for clocks that are "nonstop" so
that we don't do any sorts of checks here.

> +		return;
> +
> +	spin_lock(&cprman->regs_lock);
> +	cprman_write(cprman, data->ctl_reg,
> +		     cprman_read(cprman, data->ctl_reg) & ~CM_ENABLE);
> +	spin_unlock(&cprman->regs_lock);
> +
> +	/* BUSY will remain high until the divider completes its cycle. */
> +	bcm2835_clock_wait_busy(clock);
> +}
> +
[..]
> +static struct clk *
> +bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
> +			     const struct bcm2835_pll_divider_data *data)
> +{
[..]
> +	clk = clk_register(cprman->dev, &divider->div.hw);

What if clk_register() fails?

> +
> +	/*
> +	 * PLLH's channels have a fixed divide by 10 afterwards, which
> +	 * is what our consumers are actually using.
> +	 */
> +	if (data->fixed_divider != 1) {
> +		return clk_register_fixed_factor(cprman->dev, data->name,
> +						 divider_name,
> +						 CLK_SET_RATE_PARENT,
> +						 1,
> +						 data->fixed_divider);
> +	} else {
> +		return clk;
> +	}

Just return clk instead of the else return clk compound
statement.

> +}
> +
> +static struct clk *bcm2835_register_clock(struct bcm2835_cprman *cprman,
> +					  const struct bcm2835_clock_data *data)
> +{
> +	struct bcm2835_clock *clock;
> +	struct clk_init_data init;
> +	const char *parent;
> +
> +	/*
> +	 * Most of the clock generators have a mux field, so we
> +	 * instantiate a generic mux as our parent to handle it.
> +	 */
> +	if (data->num_mux_parents) {
> +		int i;
> +
> +		parent = kasprintf(GFP_KERNEL, "mux_%s", data->name);
> +		if (!parent)
> +			return NULL;
> +
> +		/*
> +		 * Replace our "xosc" references with the actual
> +		 * oscillator's name.
> +		 */
> +		for (i = 0; i < data->num_mux_parents; i++) {
> +			if (strcmp(data->parents[i], "xosc") == 0)
> +				data->parents[i] = cprman->osc_name;
> +		}

Braces aren't needed here.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
