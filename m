From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 24 Feb 2011 13:40:18 +0100 (CET)
Subject: [PATCH 5/5] ARM: msm: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <4D65A4BA.8030206@codeaurora.org>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-6-git-send-email-will.deacon@arm.com>
	<4D65A4BA.8030206@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1102241338410.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Feb 2011, Abhijeet Dharmapurikar wrote:

> Will Deacon wrote:
> > The chained GPIO IRQ handler on MSM8x60 calls ->ack on the parent chip
> > after handling the interrupt.
> > 
> > This patch updates the code to use ->irq_eoi now that the GIC has moved
> > to using the fasteoi flow model.
> > 
> > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mach-msm/gpio-v2.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
> > index 0de19ec..04fb411 100644
> > --- a/arch/arm/mach-msm/gpio-v2.c
> > +++ b/arch/arm/mach-msm/gpio-v2.c
> > @@ -318,7 +318,7 @@ static void msm_summary_irq_handler(unsigned int irq,
> > struct irq_desc *desc)
> >  			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
> >  							   i));
> >  	}
> > -	desc->chip->ack(irq);
> > +	desc->chip->irq_eoi(irq);
> 
> should be dec->chip->irq_eoi(&desc->irq_data);

Nope, it should do:

      struct irq_chip *chip = get_irq_desc_chip(desc);

      chip->irq_eoi();

Thanks,

	tglx
