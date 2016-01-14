From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 14 Jan 2016 12:23:30 -0800
Subject: [PATCH V2 1/4] clk: bcm2835: avoid the use of BCM2835_CLOCK_COUNT
 in clk-bcm2835
In-Reply-To: <56979056.6010407@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
 <1452542157-2387-2-git-send-email-kernel@martin.sperl.org>
 <20160113200012.1168.74515@quark.deferred.io>
 <20160114001358.1168.5768@quark.deferred.io>
 <56979056.6010407@martin.sperl.org>
Message-ID: <20160114202330.1942.96295@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Martin Sperl (2016-01-14 04:11:02)
> 
> 
> On 14.01.2016 01:13, Michael Turquette wrote:
> > Quoting Michael Turquette (2016-01-13 12:00:12)
> >> Hi Martin,
> >>
> >> Quoting kernel at martin.sperl.org (2016-01-11 11:55:53)
> >>>   static int bcm2835_clk_probe(struct platform_device *pdev)
> >>>   {
> >>>          struct device *dev = &pdev->dev;
> >>>          struct clk **clks;
> >>> +       size_t clk_cnt;
> >>>          struct bcm2835_cprman *cprman;
> >>>          struct resource *res;
> >>> +       size_t i;
> >>> +
> >>> +       /* find the max clock index */
> >>> +       clk_cnt = BCM2835_CLOCK_PERI_IMAGE; /* see below */
> >>> +       for (i = 0; i < ARRAY_SIZE(bcm2835_register_clocks); i++)
> >>> +               clk_cnt = max(clk_cnt, bcm2835_register_clocks[i].index);
> >>> +       clk_cnt += 1;
> >>
> >> I'm not sure how this solution is better than using CLOCK_COUNT. Some
> >> other bindings use a max value, NR_CLKS or other sentinel.
> >>
> >> Why did you not choose to set clk_cnt equal to BCM2835_CLOCK_PWM? Why
> >> not initialize it to zero?
> >
> > OK, I just caught up on the asoc/bcm2835 thread.
> >
> > Really the best solution would be to have an array of all of the clks in
> > the driver and just use ARRAY_SIZE on it.
> >
> > For your driver, could you make an array of clk_hw pointers and call
> > devm_clk_register on all of them in a loop? This gets rid of the big
> > pile of explicit calls in bcm2835_clk_probe.
> >
> > You can also get rid of stuff like bcm2835_plla_core_data by just
> > stuffing that data into a single struct initialization. Here is a
> > snippet for how the qcom clk drivers do it:
> >
> > static struct clk_pll gpll0 = {
> >       .l_reg = 0x0004,
> >       .m_reg = 0x0008,
> >       .n_reg = 0x000c,
> >       .config_reg = 0x0014,
> >       .mode_reg = 0x0000,
> >       .status_reg = 0x001c,
> >       .status_bit = 17,
> >       .clkr.hw.init = &(struct clk_init_data){
> >               .name = "gpll0",
> >               .parent_names = (const char *[]){ "xo" },
> >               .num_parents = 1,
> >               .ops = &clk_pll_ops,
> >       },
> > };
> 
> I did not know you could do that - that could make life easier...
> 
> But a quick look shows that this approach probably would require a
> major rewrite of all the methods.
> 
> > static int bcm2835_clk_probe(struct platform_device *pdev)
> > {
> >       ...
> >       for (i = 0; i < num_clks; i++) {
> >               clk = devm_clk_register(dev, array_of_clks[i].hw)
> >       ...
> > }
> 
> I guess I can use a slightly different approach that does not
> require as many changes, that looks like this:
> 
> static const struct bcm2835_clk_desc clk_desc_array[] = {
>         /* register PLL */
>         [BCM2835_PLLA]          = REGISTER_PLL(&bcm2835_plla_data),
>         ...
> };
> ...
> static int bcm2835_clk_probe(struct platform_device *pdev)
> {
>         const size_t asize = ARRAY_SIZE(clk_desc_array);
>         ...
>         for (i = 0; i < asize; i++) {
>                 desc = &clk_desc_array[i];
>                 if (desc)
>                         clks[i] = desc->clk_register(cprman,
>                                                      desc->data);

Interesting. I have been playing with the idea of putting a .register()
callback into struct clk_init_data. Then it would be called by a new
clk_register_desc() top-level registration function.

You've done that here, but you've put the registration function in your
machine-specific struct. Nothing wrong with that.

Do you actually need a machine-specific registration function? Many clk
drivers only use their machine-specific registration functions to
allocate a stuct clk_hw and populate the contents of struct
clk_init_data, which can be done by the framework and reduce duplicate
code in drivers.

(they do this because the basic clk types like clk-divider, clk-gate,
etc do it, and everyone loves to copy/paste that code)

bcm2835 seems to register two clks in the PLL registration function (one
of which is a fixed factor divider), but you could just add those
post-PLL dividers to your array of clk data?

>         }
>         ...
> }
> 
> If we need to order the initialization then we can add some
> priority field to clk_desc_array and iterate over all the priority
> values.

I guess that you can order them in your array? Just start with the root
clocks at the beginning of the array (regardless of "clk type") and walk
through the array registering them.

Regards,
Mike
