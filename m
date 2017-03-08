From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 8 Mar 2017 18:34:34 +0200
Subject: [PATCH] pinctrl: samsung: fix segfault when using external
 interrupts on s3c24xx
In-Reply-To: <20170306131516.GA6095@n1>
References: <1488489799-18136-1-git-send-email-sergio.prado@e-labworks.com>
 <20170304081504.unv6sihbmp76ynfy@kozik-lap>
 <20170306131516.GA6095@n1>
Message-ID: <20170308163434.obhtg6fwmjwqv7jm@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 09:15:16AM -0400, Sergio Prado wrote:
> Hi Krzysztof,
> 
> > > This is a regression from commit 8b1bd11c1f8f529057369c5b3702d13fd24e2765.
> > 
> > Checkpatch should complain here about commit format.
> > 
> > > 
> > > Tested on FriendlyARM mini2440.
> > > 
> > 
> > Please add:
> >   Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
> >   Cc: <stable@vger.kernel.org>
> > 
> 
> OK.
> 
> > > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > > ---
> > >  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > > index b82a003546ae..1b8d887796e8 100644
> > > --- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > > +++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > > @@ -356,8 +356,8 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
> > >  {
> > >  	struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
> > >  	struct irq_chip *chip = irq_desc_get_chip(desc);
> > > -	struct irq_data *irqd = irq_desc_get_irq_data(desc);
> > > -	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
> > > +	struct samsung_pinctrl_drv_data *d = data->drvdata;
> > > +	struct samsung_pin_bank *bank = d->pin_banks;
> > 
> > I think 'pin_banks' point to all banks of given controller not to the
> > currently accessed one.
> 
> Understood. I think it worked in my tests because on s3c2440 all banks
> have the same eint base address.
> 
> So what do you think is the best approach to solve this problem?

Maybe you can get to this through:
	s3c24xx_eint_domain_data = s3c24xx_eint_data->domains[virq].host_data;
	s3c24xx_eint_domain_data->bank

It is getting slightly more complicated...

Best regards,
Krzysztof
