From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 8 Sep 2010 11:50:58 +0200
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every
	single TC block
In-Reply-To: <4C8750B8.6000107@atmel.com>
References: <201009060548.18521.fg@emlix.com>
	<1283772201-15453-1-git-send-email-nicolas.ferre@atmel.com>
	<AANLkTin+vCsG3FUvX6DTUfFe7ZJpbkYyqw_TLvH9ujrJ@mail.gmail.com>
	<4C8750B8.6000107@atmel.com>
Message-ID: <20100908095058.GA3939@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:00 Wed 08 Sep     , Nicolas Ferre wrote:
> Le 07/09/2010 21:42, avictor.za at gmail.com :
> > hi,
> > 
> >> +/* One additional fake clock for second TC block */
> >> +static struct clk tcb1_clk = {
> >> +       .name           = "tcb1_clk",
> >> +       .pmc_mask       = 0,
> >> +       .type           = CLK_TYPE_PERIPHERAL,
> >> +       .parent         = &tcb0_clk,
> >> +};
> >> +
> > 
> > Looking at this again...  since type is CLK_TYPE_PERIPHERAL, when you
> > call clk_register() the "parent" is changed to the master clock.
> > 
> > Which means, then later you call clk_enable() the "pmc_mask" is still
> > 0, so 0 gets written (in pmc_periph_mode) to AT91_PMC_PCER.  So the
> > TCB clock won't be enabled.
> > 
> > Or am I missing something?
> 
> You are absolutely right!
> 
> What do you think about this modification of clk_register() function?
> 
> --- a/arch/arm/mach-at91/clock.c
> +++ b/arch/arm/mach-at91/clock.c
> @@ -501,7 +501,8 @@ postcore_initcall(at91_clk_debugfs_init);
>  int __init clk_register(struct clk *clk)
>  {
>         if (clk_is_peripheral(clk)) {
> -               clk->parent = &mck;
> +               if (!clk->parent)
> +                       clk->parent = &mck;
>                 clk->mode = pmc_periph_mode;
>                 list_add_tail(&clk->node, &clocks);
>         }
> 
> It is a very little modification which implements what I had in mind
> while creating a kind of "child peripheral" clock.
so so

but until we switch to clkdev it will solve the issue

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
