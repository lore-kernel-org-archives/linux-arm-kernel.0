From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 6 Oct 2015 23:19:05 +0200
Subject: [PATCH v4] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <1443815696-11528-1-git-send-email-eric@anholt.net>
References: <1443815696-11528-1-git-send-email-eric@anholt.net>
Message-ID: <56143AC9.60506@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am 02.10.2015 um 21:54 schrieb Eric Anholt:
> This adds support for enabling, disabling, and setting the rate of the
> audio domain clocks.  It will be necessary for setting the pixel clock
> for HDMI in the VC4 driver and let us write a cpufreq driver.  It will
> also improve compatibility with user changes to the firmware's
> config.txt, since our previous fixed clocks are unaware of it.
>
> The firmware also has support for configuring the clocks through the
> mailbox channel, but the pixel clock setup by the firmware doesn't
> work, and it's Raspberry Pi specific anyway.  The only conflicts we
> should have with the firmware would be if we made firmware calls that
> result in clock management (like opening firmware V3D or ISP access,
> which we don't support in upstream), or on hardware over-thermal or
> under-voltage (when the firmware would rewrite PLLB to take the ARM
> out of overclock).  If that happens, our cached .recalc_rate() results
> would be incorrect, but that's no worse than our current state where
> we used fixed clocks.
>
> The existing fixed clocks in the code are left in place to provide
> backwards compatibility with old device tree files.

only a few nits.

>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Tested-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>
> This is the remaining driver patch to go on the clock tree's
> clk-bcm2385 (oops, spelling :) ) tree for the bcm2835 driver.
>
> v2: Fix onecell->clks[] allocation size.
> v3: '/*' on otherwise-empty line for multiline comments, fix top
>      comment, use more named initializers, do fewer separate
>      allocations on probe, unwind allocations on failure in probe (from
>      review by Stephen Warren).  Use new clk_hw_get_name().  Switch
>      fb_prediv_bit to be fb_prediv_mask to avoid typing BIT() so many
>      times.
> v4: Incorporate feedback from Stephen Boyd, and use devm_kasprintf instead
>      of bare kasprintf in driver init.
>
>   drivers/clk/bcm/clk-bcm2835.c | 1509 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 1508 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index dd295e4..9498fd9 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> [...]
> +/*
> + * PLLA is the auxiliary PLL, used to drive the CCP2 (Compact Camera
> + * Port 2) transmitter clock.
> + *
> + * It is in the PX LDO power domain, which is on when the AUDIO domain
> + * is on.
> + */
> +static const struct bcm2835_pll_data bcm2835_plla_data = {
> +	.name = "plla",
> +	.cm_ctrl_reg = CM_PLLA,
> +	.a2w_ctrl_reg = A2W_PLLA_CTRL,
> +	.frac_reg = A2W_PLLA_FRAC,
> +	.ana_reg_base = A2W_PLLA_ANA0,
> +	.reference_enable_mask = A2W_XOSC_CTRL_PLLA_ENABLE,
> +	.lock_mask = CM_LOCK_FLOCKA,
> +
> +	.ana = &bcm2835_ana_default,
> +
> +	.min_rate = 600000000u,
> +	.max_rate = 2400000000u,
> +	.max_fb_rate = 1750000000u,

How about using a define for the max_fb_rate and use it for all PLLs?

> + [...]
> +static int bcm2835_pll_set_rate(struct clk_hw *hw,
> +				unsigned long rate, unsigned long parent_rate)
> +{
> +	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
> +	struct bcm2835_cprman *cprman = pll->cprman;
> +	const struct bcm2835_pll_data *data = pll->data;
> +	bool was_using_prediv, use_fb_prediv, do_ana_setup_first;
> +	u32 ndiv, fdiv, pdiv = 1, a2w_ctl;
> +	u32 ana[4];
> +	int i;
> +
> +	if (rate < data->min_rate || rate > data->max_rate) {
> +		dev_err(cprman->dev, "%s: rate out of spec: %ld vs (%ld, %ld)\n",

The format specifier looks wrong to me:

s/%ld/%lu

> +			clk_hw_get_name(hw), rate,
> +			data->min_rate, data->max_rate);
> +		return -EINVAL;
> +	}
> +
> +	if (rate > data->max_fb_rate) {
> +		use_fb_prediv = true;
> +		rate /= 2;
> +	} else {
> +		use_fb_prediv = false;
> +	}
> +
> +	bcm2835_pll_choose_ndiv_and_fdiv(rate, parent_rate, &ndiv, &fdiv);
> +
> +	for (i = 3; i >= 0; i--)
> +		ana[i] = cprman_read(cprman, data->ana_reg_base + i * 4);
> +
> +	was_using_prediv = ana[1] & data->ana->fb_prediv_mask;
> +
> +	ana[0] &= ~data->ana->mask0;
> +	ana[0] |= data->ana->set0;
> +	ana[1] &= ~data->ana->mask1;
> +	ana[1] |= data->ana->set1;
> +	ana[3] &= ~data->ana->mask3;
> +	ana[3] |= data->ana->set3;
> +
> +	if (was_using_prediv && !use_fb_prediv) {
> +		ana[1] &= ~data->ana->fb_prediv_mask;
> +		do_ana_setup_first = true;
> +	} else if (!was_using_prediv && use_fb_prediv) {
> +		ana[1] |= data->ana->fb_prediv_mask;
> +		do_ana_setup_first = false;
> +	} else {
> +		do_ana_setup_first = true;
> +	}
> +
> +	/* Unmask the reference clock from the oscillator. */
> +	cprman_write(cprman, A2W_XOSC_CTRL,
> +		     cprman_read(cprman, A2W_XOSC_CTRL) |
> +		     data->reference_enable_mask);
> +
> +	if (do_ana_setup_first)
> +		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
> +
> +	/* Set the PLL multiplier from the oscillator. */
> +	cprman_write(cprman, data->frac_reg, fdiv);
> +
> +	a2w_ctl = cprman_read(cprman, data->a2w_ctrl_reg);
> +	a2w_ctl &= ~A2W_PLL_CTRL_NDIV_MASK;
> +	a2w_ctl |= ndiv << A2W_PLL_CTRL_NDIV_SHIFT;
> +	a2w_ctl &= ~A2W_PLL_CTRL_PDIV_MASK;
> +	a2w_ctl |= pdiv << A2W_PLL_CTRL_PDIV_SHIFT;

Looks like pdiv is never changed and could be replaced by 1.

> +	cprman_write(cprman, data->a2w_ctrl_reg, a2w_ctl);
> +
> +	if (!do_ana_setup_first)
> +		bcm2835_pll_write_ana(cprman, data->ana_reg_base, ana);
> +
> +	bcm2835_pll_get_rate(&pll->hw, parent_rate);
> +
> +	return 0;
> +}
> +
> + [...]
> +static int bcm2835_pll_divider_set_rate(struct clk_hw *hw,
> +					unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct bcm2835_pll_divider *divider = bcm2835_pll_divider_from_hw(hw);
> +	struct bcm2835_cprman *cprman = divider->cprman;
> +	const struct bcm2835_pll_divider_data *data = divider->data;
> +	u32 cm;
> +
> +	clk_divider_ops.set_rate(hw, rate, parent_rate);

Is it safe to ignore the return value here?

> +
> +	cm = cprman_read(cprman, data->cm_reg);
> +	cprman_write(cprman, data->cm_reg, cm | data->load_mask);
> +	cprman_write(cprman, data->cm_reg, cm & ~data->load_mask);
> +
> +	return 0;
> +}
> +
> +  [...]
> +static struct platform_driver bcm2835_clk_driver = {
> +	.driver = {
> +		.name = "bcm2835-clk",
> +		.of_match_table = bcm2835_clk_of_match,
> +	},
> +	.probe          = bcm2835_clk_probe,
> +};

checkpatch.pl --strict suggests a blank line after the struct.

> +builtin_platform_driver(bcm2835_clk_driver);
> +
> +MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
> +MODULE_DESCRIPTION("BCM2835 clock driver");
> +MODULE_LICENSE("GPL v2");
>

Thanks

Stefan
