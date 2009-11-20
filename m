From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 14:10:35 +0000
Subject: RFC [PATCH 4/9] Added lpc32xx clock handler
In-Reply-To: <083DF309106F364B939360100EC290F804F54D560D@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F54D560D@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091120141035.GB16920@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 02:11:24AM +0100, Kevin Wells wrote:
> +static int local_onoff_set_rate(struct clk *clk, u32 rate)
> +{
> +       u32 tmp;
> +
> +       tmp = readl(clk->enable_reg);
> +
> +       if (rate == 0)
> +               tmp &= ~clk->enable_mask;
> +       else
> +               tmp |= clk->enable_mask;
> +
> +       writel(tmp, clk->enable_reg);
> +
> +       return 0;
> +}

Definitely need to get PNX well away from this invalid usage - the clock
enable state is not supposed to be controlled by setting the rate to
zero vs non-zero.  That's what clk_enable/clk_disable are supposed to
do.

Yes, PNX4008 is a right mess in this respect, but I now have a set of
patches which fixes some of that (at least the stuff which is exposed
to drivers.)

> +static int local_clk_enable(struct clk *clk)
> +{
> +       int ret = 0;
> +
> +       if (clk->parent != NULL)
> +               ret = local_clk_enable(clk->parent);
> +
> +       if (clk->usecount == 0)
> +               clk->enable(clk, 1);

This takes no account of what may happen if the parent clock returns
failure.

Also, with parented clocks, you really don't want to enable the parent
every time a child is enabled - it makes reparenting unnecessarily
difficult.  Just enable the parent if it's the first time the child is
being enabled.

> +/*
> + * clk_enable - inform the system when the clock source should be running.
> + */
> +int clk_enable(struct clk *clk)
> +{
> +       int ret;
> +
> +       if ((IS_ERR(clk)) || (clk == NULL))
> +               return -ENODEV;

These checks should not be necessary.

> +/*
> + * clk_disable - inform the system when the clock source is no longer required
> + */
> +void clk_disable(struct clk *clk)
> +{
> +       if ((IS_ERR(clk)) || (clk == NULL))
> +               return;

Ditto.

> +/*
> + * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
> + *               This is only valid once the clock source has been enabled
> + */
> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +       unsigned long rate = 0;
> +
> +       if (!IS_ERR(clk))

Ditto.

> +/*
> + * clk_round_rate - adjust a rate to the exact rate a clock can provide
> + */
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +       if (!IS_ERR(clk)) {

Ditto.

> +/*
> + * clk_set_rate - set the clock rate for a clock source
> + */
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +       int ret = -ENODEV;
> +
> +       if (!IS_ERR(clk)) {

Ditto.

> +/*
> + * clk_set_parent - set the parent clock source for this clock
> + */
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +       int ret = -ENODEV;
> +
> +       if (!IS_ERR(clk)) {

Ditto.

> +static void clk_inc_counts(struct clk *clk)
> +{
> +       clk->usecount++;
> +
> +       if (clk->parent != NULL)
> +               clk_inc_counts(clk->parent);
> +}
> +
> +int __init clk_init(void)
> +{
> +       u32 reg;
> +       int i;
> +
> +       /* Set initial rates for PLL397 and main oscillator */
> +       reg = readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
> +       if ((reg & CLKPWR_SYSCTRL_PLL397_DIS) != 0)
> +               osc_pll397.rate = 0;
> +       else {
> +               osc_pll397.rate = 397 * osc_32KHz.rate;
> +               clk_inc_counts(&osc_32KHz);

Is there a reason clk_enable() can't do this?

> +       }
> +       reg = readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
> +       if ((reg & CLKPWR_MOSC_DISABLE) != 0)
> +               osc_main.rate = 0;
> +       else
> +               osc_main.rate = MAIN_OSC_FREQ;
> +
> +       /* Update PLL397 or main osc use count and parent based on
> +          current SYSCLK selection */
> +       if (clk_is_sysclk_mainosc() != 0)
> +               clk_sys.parent = &osc_main;
> +       else
> +               clk_sys.parent = &osc_pll397;
> +       clk_sys.rate = clk_sys.parent->rate;
> +
> +       /* Compute the ARM PLL and USB PLL frequencies */
> +       local_update_armpll_rate();
> +       local_update_usbpll_rate();
> +       if (clk_usbpll.rate != 0)
> +               clk_inc_counts(&osc_main);
> +
> +       /* HCLK and PCLKs are always on and use the ARM PLL clock*/
> +       clk_inc_counts(clk_hclk.parent);
> +       clk_inc_counts(clk_pclk.parent);
> +
> +       /* Timer 0 is used for the system clock tick. It was pre-initialized
> +          prior to this elsewhere */
> +       clk_inc_counts(clk_timer0.parent);

Ditto for these.
