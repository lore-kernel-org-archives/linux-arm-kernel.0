From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Oct 2015 17:37:22 -0700
Subject: [PATCH v6] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <1444347736-23681-1-git-send-email-eric@anholt.net>
References: <1444347736-23681-1-git-send-email-eric@anholt.net>
Message-ID: <20151009003721.GM26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please drop the full-stop from your subject lines.

On 10/08, Eric Anholt wrote:
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
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Tested-by: Martin Sperl <kernel@martin.sperl.org>
> ---

There's a variable length array in here, causing sparse to
complain:

	drivers/clk/bcm/clk-bcm2835.c:1408:41:
	warning: Variable length array is used.

This one looks easy enough to fix with another allocation.

But then there's some weird casting warning coming from sparse
that I honestly don't understand:

drivers/clk/bcm/clk-bcm2835.c:370:36:
warning: cast truncates bits from constant value (3fffffffff8000
becomes ffff8000)
drivers/clk/bcm/clk-bcm2835.c:372:19:
warning: cast truncates bits from constant value (3ffffffff80
becomes ffffff80)
drivers/clk/bcm/clk-bcm2835.c:378:37:
warning: cast truncates bits from constant value (fffffffff80000
becomes fff80000)
drivers/clk/bcm/clk-bcm2835.c:380:42:
warning: cast truncates bits from constant value (1fffffffff
becomes ffffffff)

I guess I'll just ignore that for now. A couple nitpicks are
left, but nothing major.

> +static void bcm2835_pll_choose_ndiv_and_fdiv(unsigned long rate,
> +					     unsigned long parent_rate,
> +					     u32 *ndiv, u32 *fdiv)
> +{
> +	u64 div;
> +
> +	div = ((u64)rate << A2W_PLL_FRAC_BITS);

Drop the parenthesis here.

> +	/* Wait for the PLL to lock. */
> +	start = ktime_get();
> +	while (!(cprman_read(cprman, CM_LOCK) & data->lock_mask)) {
> +		ktime_t delta = ktime_sub(ktime_get(), start);
> +
> +		if (ktime_to_ms(delta) > LOCK_TIMEOUT_MS) {

Didn't notice this one before. Why not add the LOCK_TIMEOUT_MS to
start, and then call ktime_get() in the loop and use
ktime_after() to figure out if we're beyond the timeout?

> +			dev_err(cprman->dev, "%s: couldn't lock PLL\n",
> +				clk_hw_get_name(hw));
> +			return -ETIMEDOUT;
> +		}
> +
> +		cpu_relax();
> +	}
> +
> +	return 0;
> +}
[...]
> +
> +
> +	memset(&init, 0, sizeof(init));
> +	init.parent_names = &parent;
> +	init.num_parents = 1;
> +	init.name = data->name;
> +	init.flags = CLK_IGNORE_UNUSED;
> +
> +	if (data->is_vpu_clock) {
> +		init.ops = &bcm2835_vpu_clock_clk_ops;
> +	} else {
> +		init.ops = &bcm2835_clock_clk_ops;
> +		init.flags |= CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
> +	}
> +
> +	clock = devm_kzalloc(cprman->dev, sizeof(*clock), GFP_KERNEL);
> +	if (!clock)
> +		return NULL;
> +
> +	clock->cprman = cprman;
> +	clock->data = data;
> +	clock->hw.init = &init;
> +
> +	return clk_register(cprman->dev, &clock->hw);

devm_clk_register?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
