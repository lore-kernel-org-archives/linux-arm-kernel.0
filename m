From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Jan 2016 23:28:45 +0100
Subject: [PATCH v3 04/13] clk: at91: make IRQ optional and register them
 later
In-Reply-To: <20160122154034.GA20020@breakpoint.cc>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1449248628-3486-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20160122154034.GA20020@breakpoint.cc>
Message-ID: <20160125222845.GC11740@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22/01/2016 at 16:40:35 +0100, Sebastian Andrzej Siewior wrote :
> On 2015-12-04 18:03:39 [+0100], Alexandre Belloni wrote:
> > diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> > index 295b17b9c689..296d20a29c6c 100644
> > --- a/drivers/clk/at91/pmc.c
> > +++ b/drivers/clk/at91/pmc.c
> > @@ -20,6 +20,9 @@
> ?
> > +	pmc->irqdomain = irq_domain_add_linear(pdev->dev.of_node, 32,
> > +					       &pmc_irq_ops, pmc);
> > +	if (!pmc->irqdomain)
> > +		return 0;
> >  
> > -static void __init of_at91sam9n12_pmc_setup(struct device_node *np)
> > -{
> > -	of_at91_pmc_setup(np, &at91sam9n12_caps);
> > -}
> > -CLK_OF_DECLARE(at91sam9n12_clk_pmc, "atmel,at91sam9n12-pmc",
> > -	       of_at91sam9n12_pmc_setup);
> > +	regmap_write(pmc->regmap, AT91_PMC_IDR, 0xffffffff);
> > +	ret = request_irq(pmc->virq, pmc_irq_handler,
> > +			  IRQF_SHARED | IRQF_COND_SUSPEND, "pmc", pmc);
> 
> You need IRQF_NOTHREAD here becuase pmc_irq_handler() is demuxing
> interrupts / invoking generic_handle_irq().
> However regmap_read() inside pmc_irq_handler() is taking a sleeping lock
> on -RT so this is not going to fly. So either get rid regmap_read() in
> the handler or use handle_nested_irq() instead.
> 

So, using handle_nested_irq() is actually quite impractical because it
has to be called from a threaded irq handler. So we either need to use
IRQF_ONESHOT which is not possible because the IRQ is shared
with the PIT (unless we take Thomas' IRQF_COND_ONESHOT patch).

I think we may as well stay simple and remove the whole irq handling and
only do polling on the status register. As the series is done right now,
this only has an impact during the clocks prepare(). As in that case it
would not be sleeping anymore, we can also transform those prepare() in
enable().


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
