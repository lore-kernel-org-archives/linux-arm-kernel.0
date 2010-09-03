From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 3 Sep 2010 18:38:14 +0200
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every
	single	TC block
In-Reply-To: <4C80F2A7.9040007@atmel.com>
References: <1283517093-12628-1-git-send-email-fg@emlix.com>
	<4C80F2A7.9040007@atmel.com>
Message-ID: <20100903163814.GG17702@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:05 Fri 03 Sep     , Nicolas Ferre wrote:
> Le 03/09/2010 14:31, Fabian Godehardt :
> > Without this patch you will not be able to register the first block
> > because of the second association call on at91_add_device_tc().
> 
> Yes, I noticed that.
> 
> > Signed-off-by: Fabian Godehardt <fg@emlix.com>
> 
> Tell me if my little modification is ok for you. I will then sign it and
> send it to Russell patch tracking system: what do you think about it?
> 
> > ---
> >  arch/arm/mach-at91/at91sam9g45.c         |   12 +++++++++---
> >  arch/arm/mach-at91/at91sam9g45_devices.c |    4 ++--
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> > index 753c0d3..52ef2d6 100644
> > --- a/arch/arm/mach-at91/at91sam9g45.c
> > +++ b/arch/arm/mach-at91/at91sam9g45.c
> > @@ -121,8 +121,13 @@ static struct clk ssc1_clk = {
> >  	.pmc_mask	= 1 << AT91SAM9G45_ID_SSC1,
> >  	.type		= CLK_TYPE_PERIPHERAL,
> >  };
> > -static struct clk tcb_clk = {
> > -	.name		= "tcb_clk",
> > +static struct clk tcb0_clk = {
> > +	.name		= "tcb0_clk",
> > +	.pmc_mask	= 1 << AT91SAM9G45_ID_TCB,
> > +	.type		= CLK_TYPE_PERIPHERAL,
> > +};
> > +static struct clk tcb1_clk = {
> > +	.name		= "tcb1_clk",
> >  	.pmc_mask	= 1 << AT91SAM9G45_ID_TCB,
> >  	.type		= CLK_TYPE_PERIPHERAL,
> 
> I prefer to add a "fake" clock that depend on the first one instead of
> doubling the definition: like this:
> 
> /* One additional fake clock for second TC block */
> static struct clk tcb1_clk = {
>         .name           = "tcb1_clk",
>         .pmc_mask       = 0,
>         .type           = CLK_TYPE_PERIPHERAL,
>         .parent         = &tcb0_clk,
> };
> 
this modification will also work when we enable and disable the clock
the fact of duplicating the clock will result that if we disable the clock
we will disable it for both device

in the Nico implementation the cloc will be disable only when no-one use it

it's not the best solution but for now on it's before switching to the clkdev

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
