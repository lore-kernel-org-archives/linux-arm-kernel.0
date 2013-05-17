From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 17 May 2013 22:34:21 +0200
Subject: [PATCH 6/6] pinctrl: exynos: Handle suspend/resume of GPIO EINT
 registers
In-Reply-To: <CAD=FV=WKCeW=3BFnmnyXB70VCjXHGrzarXbj8cBfq4-ENA-Y2w@mail.gmail.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
 <1368807872-2601-7-git-send-email-t.figa@samsung.com>
 <CAD=FV=WKCeW=3BFnmnyXB70VCjXHGrzarXbj8cBfq4-ENA-Y2w@mail.gmail.com>
Message-ID: <18754346.1REWN52J0K@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 of May 2013 12:25:02 Doug Anderson wrote:
> Tomasz,
> 
> On Fri, May 17, 2013 at 9:24 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > Some GPIO EINT control registers needs to be preserved across
> > suspend/resume cycle. This patch extends the driver to take care of
> > this.
> 
> I was confused why we didn't seem to need this on exynos5250-snow but
> figured it out.  We only use interrupts on GPX lines which don't need
> this code.  ...but on any exynos5250 boards that use one of the other
> banks for interrupts you'd need it.  I tested by setting one of the
> registers related to GPA0 and found that this code is indeed needed on
> exynos5250.  :)
> 
> Just nits / optional comments below, so on exynos5250-snow (pinmux
> backported to 3.8):
> 
> Tested-by: Doug Anderson <dianders@chromium.org>
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 
> > @@ -229,6 +235,11 @@ static int exynos_eint_gpio_init(struct
> > samsung_pinctrl_drv_data *d)> 
> >                         dev_err(dev, "gpio irq domain add failed\n");
> >                         return -ENXIO;
> >                 
> >                 }
> > 
> > +
> > +               bank->soc_priv = devm_kzalloc(d->dev,
> > +                       sizeof(struct exynos_eint_gpio_save),
> > GFP_KERNEL); +               if (!bank->soc_priv)
> > +                       return -ENOMEM;
> 
> Slight nit to add this before the call to irq_domain_add_linear().
> demv() will handle freeing your memory but nothing will handle undoing
> the irq_domain_add_linear() if you return an error.

I'm a bit sceptical when it is about error handling in such cases. 
Basically if interrupt initialization fails, something is seriously wrong, 
either with your kernel config or with some code.

Since such case has been already unhandled in the driver (with nr_banks > 
1 = always), so I didn't bother to add any undoing here.

> >         }
> >         
> >         return 0;
> > 
> > @@ -528,6 +539,58 @@ static int exynos_eint_wkup_init(struct
> > samsung_pinctrl_drv_data *d)> 
> >         return 0;
> >  
> >  }
> > 
> > +static void exynos_pinctrl_suspend_bank(
> > +                               struct samsung_pinctrl_drv_data
> > *drvdata, +                               struct samsung_pin_bank
> > *bank) +{
> > +       struct exynos_eint_gpio_save *save = bank->soc_priv;
> > +       void __iomem *regs = drvdata->virt_base;
> > +
> > +       save->eint_con = readl(regs + EXYNOS_GPIO_ECON_OFFSET
> > +                                               + bank->eint_offset);
> > +       save->eint_fltcon0 = readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET
> > +                                               + 2 *
> > bank->eint_offset); +       save->eint_fltcon1 = readl(regs +
> > EXYNOS_GPIO_EFLTCON_OFFSET +                                         
> >      + 2 * bank->eint_offset + 4);
> Optional: I wish there were debug statements to help debug, like:
> 
> pr_debug("%s: save     con %#010x\n", bank->name, save->eint_con);
> pr_debug("%s: save fltcon0 %#010x\n", bank->name, save->eint_fltcon0);
> pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
> 

Right, seems reasonable.

> > +}
> > +
> > +static void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data
> > *drvdata) +{
> > +       struct samsung_pin_ctrl *ctrl = drvdata->ctrl;
> > +       struct samsung_pin_bank *bank = ctrl->pin_banks;
> > +       int i;
> > +
> > +       for (i = 0; i < ctrl->nr_banks; ++i, ++bank)
> > +               if (bank->eint_type == EINT_TYPE_GPIO)
> > +                       exynos_pinctrl_suspend_bank(drvdata, bank);
> > +}
> > +
> > +static void exynos_pinctrl_resume_bank(
> > +                               struct samsung_pinctrl_drv_data
> > *drvdata, +                               struct samsung_pin_bank
> > *bank) +{
> > +       struct exynos_eint_gpio_save *save = bank->soc_priv;
> > +       void __iomem *regs = drvdata->virt_base;
> > +
> 
> Optional: debug statements:
> 
> pr_debug("%s:     con %#010x => %#010x\n", bank->name,
>   readl(regs + EXYNOS_GPIO_ECON_OFFSET + bank->eint_offset),
>   save->eint_con);
> pr_debug("%s: fltcon0 %#010x => %#010x\n", bank->name,
>   readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET + 2 * bank->eint_offset),
>   save->eint_fltcon0);
> pr_debug("%s: fltcon1 %#010x => %#010x\n", bank->name,
>   readl(regs + EXYNOS_GPIO_EFLTCON_OFFSET + 2 * bank->eint_offset + 4),
>   save->eint_fltcon1);

OK. I wonder if this could be added in a separate patch or I should rather 
send v2 on Monday?

Best regards,
Tomasz
