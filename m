From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 28 Nov 2009 00:46:18 +0100 (CET)
Subject: [PATCH] MXC: set GPIO IRQ handler
In-Reply-To: <20091126075724.GA12179@pengutronix.de>
References: <807htelb5d.fsf@merkur.tec.linutronix.de>
	<20091126075724.GA12179@pengutronix.de>
Message-ID: <alpine.LFD.2.00.0911280005010.24119@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Nov 2009, Uwe Kleine-K?nig wrote:
> On Wed, Nov 25, 2009 at 07:19:58PM +0100, John Ogness wrote:
> > The irq chip function gpio_set_irq_type() correctly sets the i.MX
> > registers but does not set the irq handler.
>
> I assume you see some breakage without your patch?  In mainline?

Is there some other sensible reason why someone would send such a
patch with a completely clear change log ?

> 
>                                             This means that all
> > gpio-based irq's are handled with handle_edge_irq().

> This is not true in mainline, ...

We probably look at a different mainline, right ?

int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
{
....
         set_irq_chip(j, &gpio_irq_chip);
         set_irq_handler(j, handle_edge_irq);

> .... until 060d20d (imx/gpio: Use
> handle_level_irq) (currently in imx/mxc-master) hits Linus' tree ...

The patch fixes an existing problem in mainline. It does not matter
whether there is a different fix pending in some git tree which is
supposed to hit mainline at some undefined point in the future.

> > This patch corrects this by also setting the appropriate handler.
> > 
> > This patch is against 2.6.32-rc8.
> ... so there is no hurry.

Interesting conclusion: every level triggered GPIO interrupt in
2.6.32-rc8 is affected by this problem. Definitely nothing to worry
about ....

> Can you please test with 060d20d if your breakage still occurs and
> if it is still valid report some details (for me and the commit log)?

Could you please provide useful details, i.e. a short explanation why
that commit is the superior fix, instead of forcing people to clone a
git tree to figure out what you are (not) talking about ?

That's the change log of 060d20d:

    imx/gpio: Use handle_level_irq
    
    According to Russell King handle_edge_irq is only useful for "edge-based
    inputs where the controller does not remember transitions with the input
    masked."
    
    So using handle_edge_irq unconditionally for both edge and level irqs is
    wrong.  Testing showed that the controller does remember transitions
    while the interrupt is masked.  So use handle_level_irq unconditionally.

And the changelog is utter crap.

Using handle_edge_irq for level triggered interrupts has nothing to do
with Russell's observation simply because using handle_edge_irq for
level triggered interrupts is patently wrong.

The fact that the irq controller of the imx happens to be designed by
people who seem to have understood the pitfalls of edge triggered irqs
allows to use handle_level_irq for both edge and level triggered. 

That does not make John's patch incorrect. Using handle_level_irq for
both is merily an optimization which would be even more understandable
if there would be an useful comment in the code.

Thanks,

	tglx
