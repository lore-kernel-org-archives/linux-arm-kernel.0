From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 11:49:51 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211403130.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
Message-ID: <20110429104951.GG5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 02:20:22PM +0200, Thomas Gleixner wrote:
> Care to look over the various implementations and find out that a lot
> of them look like:
> 
> static int _clk_enable(struct clk *clk)
> {
>         unsigned int reg;
> 
>         reg = __raw_readl(clk->enable_reg);
>         reg |= 1 << clk->enable_shift;
>         __raw_writel(reg, clk->enable_reg);
> 
>         return 0;
> }
> 
> Just in about 100 variations of the theme. Which is basically the same
> as we have in irq chip implementations. And I showed how much of these
> things can be factored out when done right. And even if a particular
> clock does not implement enable/disable calls, then having
> regs.enable_reg around is not a problem.

And you haven't noticed that with how things stand with what Jeremy's
proposed, we _can_ abstract this kind of stuff.

Having read a number of your messages, I think you don't like it because
you haven't been involved in creating it - I don't think there's anything
much more specific than that to your protestations about it.

We _can_ (and I hope we do) factor out the 100 "clock gate" implementations
into one instance - and I believe we can do that with Jeremy's proposal.

For those clocks which have an clock gate and a clock mux, we can create
two clk structures, one being the clock gate container and one being the
clock mux container, even if they're accessing the same register.

Shoving the enable crap into the core framework enforces that every clock
has an gate attached to it, which is soo far departed from reality I've
got to ask what universe you're living in.

Finally, go look at the OMAP clock structure where they stuff everything
into one struct clk:

struct clk {
        struct list_head        node;
        const struct clkops     *ops;
        const char              *name;
        struct clk              *parent;
        struct list_head        children;
        struct list_head        sibling;        /* node for children */
        unsigned long           rate;
        void __iomem            *enable_reg;
        unsigned long           (*recalc)(struct clk *);
        int                     (*set_rate)(struct clk *, unsigned long);
        long                    (*round_rate)(struct clk *, unsigned long);
        void                    (*init)(struct clk *);
        u8                      enable_bit;
        s8                      usecount;
        u8                      fixed_div;
        u8                      flags;
#ifdef CONFIG_ARCH_OMAP2PLUS
        void __iomem            *clksel_reg;
        u32                     clksel_mask;
        const struct clksel     *clksel;
        struct dpll_data        *dpll_data;
        const char              *clkdm_name;
        struct clockdomain      *clkdm;
#else
        u8                      rate_offset;
        u8                      src_offset;
#endif
#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
        struct dentry           *dent;  /* For visible tree hierarchy */
#endif
};

If you start saying "a clock struct should contain enable bit, register
address" then you're well on the path to creating a horrid mess like the
above.  And this is something we _must_ avoid.

So, Jeremy's done the right thing and created a base struct clk which
is very much like a kobject, along with a set of methods to operate on
it.  Around that can be built things like fixed rate clocks, MUXes,
gates, PLLs, and everything else which is required with minimal expense
- and all provided by core clk code.  And we avoid crappy bloated
structures like the thing above.
