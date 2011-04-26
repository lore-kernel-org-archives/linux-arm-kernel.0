From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 19:29:12 +0200
Subject: [PATCH 03/14] at91: factorize at91 interrupts init to soc
In-Reply-To: <0D753D10438DA54287A00B027084269764D256A077@AUSP01VMBX24.collaborationhost.net>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-3-git-send-email-plagnioj@jcrosoft.com>
	<0D753D10438DA54287A00B027084269764D256A077@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110426172912.GA29103@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:11 Mon 25 Apr     , H Hartley Sweeten wrote:
> On Monday, April 25, 2011 11:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >
> > they are the same except the default priority
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> 
> [snip]
> 
> > diff --git a/arch/arm/mach-at91/board-1arm.c b/arch/arm/mach-at91/board-1arm.c
> > index b0d235e..ba08329 100644
> > --- a/arch/arm/mach-at91/board-1arm.c
> > +++ b/arch/arm/mach-at91/board-1arm.c
> > @@ -65,7 +65,7 @@ static void __init onearm_map_io(void)
> >  
> >  static void __init onearm_init_irq(void)
> >  {
> > -	at91rm9200_init_interrupts(NULL);
> > +	at91_init_interrupts(NULL);
> >  }
> 
> [snip]
>  
> > diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
> > index 81f5815..f0a1661 100644
> > --- a/arch/arm/mach-at91/soc.c
> > +++ b/arch/arm/mach-at91/soc.c
> > @@ -20,6 +20,18 @@
> >  
> >  static struct at91_soc __initdata current_soc;
> >  
> > +void __init at91_init_interrupts(unsigned int *priority)
> > +{
> > +	if (!priority)
> > +		priority = current_soc.default_irq_priority;
> > +
> > +	/* Initialize the AIC interrupt controller */
> > +	at91_aic_init(priority);
> > +
> > +	/* Enable GPIO interrupts */
> > +	at91_gpio_irq_setup();
> > +}
> > +
> 
> All the board files call at91_init_interrupts with a NULL priority.  Why not just
> remove the parameter entirely, make MACHINE_START.init_irq = at91_init_interrupts,
> and then remove all the {board}_init_irq functions.
keep it is important as the irq priority can be board specific as we have
nearly no fifo on at91
agreed to too have a a generic function

Best Regards,
J.
