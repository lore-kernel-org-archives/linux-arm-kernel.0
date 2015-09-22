From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Sep 2015 19:01:07 -0700
Subject: [PATCH v2 3/4] clk: bcm2835: Add support for programming the
 audio domain clocks.
In-Reply-To: <1441922305-2298-3-git-send-email-eric@anholt.net>
References: <1441922305-2298-1-git-send-email-eric@anholt.net>
 <1441922305-2298-3-git-send-email-eric@anholt.net>
Message-ID: <5600B663.8000501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 02:58 PM, Eric Anholt wrote:
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

> +/**
> + * DOC: BCM2835 CPRMAN (clock manager for the "audio" domain)
> + *
> + * The clock tree on the 2835 has several levels.  There's a root
> + * oscillator running at 19.2Mhz.  After the oscillator there are 4

Nit: s/4/5.

> +struct bcm2835_pll_data {
...
> +	/* Highest rate for the VCO before we have to use the
> +	 * pre-divide-by-2.
> +	 */

Nit: /* should be on a line on its own I think. Similar elsewhere.

> +static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
> +	0,
> +	0,
> +	~((7 << 19) | (15 << 15)),
> +	(2 << 19) | (8 << 15),
> +	~(7 << 7),
> +	(6 << 1),
> +
> +	14

Nit: Elide the blank line? In some other structs too.

Are there #defines or names you can use for those initializers?

> +static int bcm2835_clk_probe(struct platform_device *pdev)

> +	cprman = kzalloc(sizeof(*cprman), GFP_KERNEL);
> +	if (!cprman)
> +		return -ENOMEM;

This function allocates/initializes a lot of resources without using
devm_ versions of APIs.
> +
> +	spin_lock_init(&cprman->regs_lock);
> +	cprman->dev = &pdev->dev;
> +	cprman->regs = of_iomap(dev->of_node, 0);
> +	if (!cprman->regs)
> +		return -ENODEV;

.. consequently if probe() fails later on (such as here) then resources
allocated earlier are not released. probe() should either switch to APIs
such as devm_kzalloc() or add some cleanup handling.

> +	cprman->osc_name = of_clk_get_parent_name(dev->of_node, 0);
> +	if (!cprman->osc_name)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, cprman);

I'd expect that to happen right after allocating cprman, since it feels
related to having allocated the cprman object.

> +	onecell = kmalloc(sizeof(*onecell), GFP_KERNEL);
> +	if (!onecell)
> +		return -ENOMEM;
> +	onecell->clk_num = BCM2835_CLOCK_COUNT;
> +	onecell->clks = kzalloc(sizeof(*onecell->clks) *
> +				BCM2835_CLOCK_COUNT, GFP_KERNEL);

Does this need to be dynamically allocated? I think you can just make
these fields in struct bcm2835_cprman; even the array of clks could be:

struct clks clks[BCM2835_CLOCK_COUNT];

> +	clks[BCM2835_PLLA] = bcm2835_register_pll(cprman, &bcm2835_plla_data);
> +	clks[BCM2835_PLLB] = bcm2835_register_pll(cprman, &bcm2835_pllb_data);

These can fail; shouldn't there be error-checking? Or, does
of_clk_add_provider() check for this?
