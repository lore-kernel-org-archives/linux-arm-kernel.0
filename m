From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 28 Aug 2012 19:27:30 +0200
Subject: [PATCH 2/3] gpio: samsung: Add support for Exynos4x12 SoCs
In-Reply-To: <CAJuYYwR3tPhk=DHJVgk1E_MqWrwT+7_YdJOSjrYX=pF7_RFjpw@mail.gmail.com>
References: <4648723.rWnut7F0uJ@amdc1227> <2265472.2J2KAQrYg1@amdc1227>
 <CAJuYYwR3tPhk=DHJVgk1E_MqWrwT+7_YdJOSjrYX=pF7_RFjpw@mail.gmail.com>
Message-ID: <42072476.sfX69hco6r@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for reviewing the patch.

On Tuesday 28 of August 2012 20:25:34 Thomas Abraham wrote:
> > +       }, {
> > +               .config = &samsung_gpio_cfgs[9],
> > +               .irq_base = IRQ_EINT(24),
> > +               .chip   = {
> > +                       .base   = EXYNOS4_GPX3(0),
> > +                       .ngpio  = EXYNOS4_GPIO_X3_NR,
> > +                       .label  = "GPX3",
> > +                       .to_irq = samsung_gpiolib_to_irq,
> > +               },
> > +       },
> > +};
> 
> I see that GPX0, GPX1, GPX2 and GPX3 bank instances are already part
> of mainline kernel. How is that this is being added here.

It seems like somehow GPXx are added to exynos4210_gpios_2 again and the 
already present part is used for exynos4x12_gpios_2. I guess that it's 
because of adding ".base   = (void *)0xC00" to GPX0, which might be an 
accidental mistake. I will recheck that.

> > +       }, {
> > +               .base   = (void *)0xC00,
> > 
> >                 .config = &samsung_gpio_cfgs[9],
> >                 .irq_base = IRQ_EINT(0),
> >                 .chip   = {
> > 
> > @@ -2370,9 +2619,7 @@ static struct samsung_gpio_chip exynos4_gpios_2[]
> > = {> 
> >                 },
> >         
> >         },
> >  
> >  };
> 
> There are no GPX banks instantiated here for 4x12. What is the reason for
> that?

See previous point. GPXx which have been part of exynos4_gpios_2 become 
part of exynos4210_gpios_2.

> > -#endif
> > 
> > -#ifdef CONFIG_ARCH_EXYNOS4
> > 
> >  static struct samsung_gpio_chip exynos4_gpios_3[] = {
> >  
> >         {
> >         
> >                 .chip   = {
> > 
> > @@ -2727,12 +2974,15 @@ static __init void
> > exynos_gpiolib_attach_ofnode(struct samsung_gpio_chip *chip,
> What is the limitation in adding support for GPVx as well for 4x12 ?

I'm not sure, I might have simply overlooked GPVx. I will recheck that 
tomorrow.

Best regards,
--
Tomasz Figa
