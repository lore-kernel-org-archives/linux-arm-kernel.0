From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Feb 2011 14:12:46 -0000
Subject: [PATCH 5/5] ARM: msm: update GPIO chained IRQ handler to use EOI
	in parent chip
In-Reply-To: <alpine.LFD.2.00.1102241338410.2701@localhost6.localdomain6>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-6-git-send-email-will.deacon@arm.com>
	<4D65A4BA.8030206@codeaurora.org>
	<alpine.LFD.2.00.1102241338410.2701@localhost6.localdomain6>
Message-ID: <000401cbd42c$e9a957b0$bcfc0710$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, 23 Feb 2011, Abhijeet Dharmapurikar wrote:
> 
> > Will Deacon wrote:
> > > The chained GPIO IRQ handler on MSM8x60 calls ->ack on the parent chip
> > > after handling the interrupt.
> > >
> > > This patch updates the code to use ->irq_eoi now that the GIC has moved
> > > to using the fasteoi flow model.
> > >
> > > Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  arch/arm/mach-msm/gpio-v2.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
> > > index 0de19ec..04fb411 100644
> > > --- a/arch/arm/mach-msm/gpio-v2.c
> > > +++ b/arch/arm/mach-msm/gpio-v2.c
> > > @@ -318,7 +318,7 @@ static void msm_summary_irq_handler(unsigned int irq,
> > > struct irq_desc *desc)
> > >  			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
> > >  							   i));
> > >  	}
> > > -	desc->chip->ack(irq);
> > > +	desc->chip->irq_eoi(irq);
> >
> > should be dec->chip->irq_eoi(&desc->irq_data);
> 
> Nope, it should do:
> 
>       struct irq_chip *chip = get_irq_desc_chip(desc);
> 
>       chip->irq_eoi();

Something like this?

diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
index 0de19ec..90a968f 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/arch/arm/mach-msm/gpio-v2.c
@@ -310,6 +310,7 @@ static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
 static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
        unsigned long i;
+       struct irq_chip *chip = get_irq_desc_chip(desc);
 
        for (i = find_first_bit(msm_gpio.enabled_irqs, NR_GPIO_IRQS);
             i < NR_GPIO_IRQS;
@@ -318,7 +319,7 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
                        generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
                                                           i));
        }
-       desc->chip->ack(irq);
+       chip->irq_eoi(&desc->irq_data);
 }

Will
