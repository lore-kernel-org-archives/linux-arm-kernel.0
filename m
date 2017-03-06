From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Mon, 6 Mar 2017 09:15:16 -0400
Subject: [PATCH] pinctrl: samsung: fix segfault when using external
 interrupts on s3c24xx
In-Reply-To: <20170304081504.unv6sihbmp76ynfy@kozik-lap>
References: <1488489799-18136-1-git-send-email-sergio.prado@e-labworks.com>
 <20170304081504.unv6sihbmp76ynfy@kozik-lap>
Message-ID: <20170306131516.GA6095@n1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

> > This is a regression from commit 8b1bd11c1f8f529057369c5b3702d13fd24e2765.
> 
> Checkpatch should complain here about commit format.
> 
> > 
> > Tested on FriendlyARM mini2440.
> > 
> 
> Please add:
>   Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple IORESOURCE_MEM for one pin-bank")
>   Cc: <stable@vger.kernel.org>
> 

OK.

> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > ---
> >  drivers/pinctrl/samsung/pinctrl-s3c24xx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > index b82a003546ae..1b8d887796e8 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
> > @@ -356,8 +356,8 @@ static inline void s3c24xx_demux_eint(struct irq_desc *desc,
> >  {
> >  	struct s3c24xx_eint_data *data = irq_desc_get_handler_data(desc);
> >  	struct irq_chip *chip = irq_desc_get_chip(desc);
> > -	struct irq_data *irqd = irq_desc_get_irq_data(desc);
> > -	struct samsung_pin_bank *bank = irq_data_get_irq_chip_data(irqd);
> > +	struct samsung_pinctrl_drv_data *d = data->drvdata;
> > +	struct samsung_pin_bank *bank = d->pin_banks;
> 
> I think 'pin_banks' point to all banks of given controller not to the
> currently accessed one.

Understood. I think it worked in my tests because on s3c2440 all banks
have the same eint base address.

So what do you think is the best approach to solve this problem?

> 
> 
> Best regards,
> Krzysztof
> 

-- 
Sergio Prado
Embedded Labworks
Office: +55 11 2628-3461
Mobile: +55 11 97123-3420
