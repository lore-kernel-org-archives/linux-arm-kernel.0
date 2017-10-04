From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 3 Oct 2017 19:10:59 -0700
Subject: [PATCH 5/7] gpio: brcmstb: enable masking of interrupts when
 changing type
In-Reply-To: <20170930034057.15166-6-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
 <20170930034057.15166-6-opendmb@gmail.com>
Message-ID: <CADtm3G5oWZTZ7OkAko9_5ge_eOG7FRaEd702rqh55hJnnFi5ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Fri, Sep 29, 2017 at 8:40 PM, Doug Berger <opendmb@gmail.com> wrote:
> Mask the GPIO interrupt while its type is being changed, just in case
> it can prevent a spurious interrupt.

"Just in case"?  I don't have access to hardware documentation for
this anymore, but I'd expect to some stronger claim that the hardware
actually requires masking before changing the trigger type.  If you
can quote documentation for this or explain an actual problem seen,
that would be good.

>
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> ---
>  drivers/gpio/gpio-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 0418cb266586..e2fff559c1ca 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -363,7 +363,9 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
>         bank->irq_chip.irq_set_type = brcmstb_gpio_irq_set_type;
>
>         /* Ensures that all non-wakeup IRQs are disabled at suspend */
> -       bank->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
> +       /* and that interrupts are masked when changing their type  */

This doesn't follow the kernel multi-line comment style, please adjust.

> +       bank->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
> +                              IRQCHIP_SET_TYPE_MASKED;
>
>         if (IS_ENABLED(CONFIG_PM_SLEEP) && !priv->parent_wake_irq &&
>                         of_property_read_bool(np, "wakeup-source")) {
> --
> 2.14.1
>

Thanks,
Gregory
