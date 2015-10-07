From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 6 Oct 2015 20:30:43 -0600
Subject: [PATCH v5] clk: bcm2835: Add support for programming the audio
 domain clocks.
In-Reply-To: <1444181140-3570-1-git-send-email-eric@anholt.net>
References: <1444181140-3570-1-git-send-email-eric@anholt.net>
Message-ID: <561483D3.70000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2015 07:25 PM, Eric Anholt wrote:
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

> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c

> +static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
> +	.mask0 = 0,
> +	.set0 = 0,
> +	.mask1 = ~((7 << 19) | (15 << 15)),
> +	.set1 = (2 << 19) | (8 << 15),
> +	.mask3 = ~(7 << 7),
> +	.set3 = (6 << 1),
> +	.fb_prediv_mask = BIT(14),
> +};

Sorry for the slow response, but my previous comment on that block of
code was regarding the values not matching the values to the fields in
the struct. For example, in "7 << 19", what do 7 and 19 represent? That
could be documented by e.g.:

#define FOO_MASK 7
#define FOO_SHIFT 19

where FOO is the name of the field, and would tie the values into the
documentation (assuming there is some)

Of course@this stage it's fine to change this later.
