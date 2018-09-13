From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Sep 2018 10:45:28 +0200
Subject: unexpected side effect of "gpiolib: override irq_enable/disable"
In-Reply-To: <f64fcb6a-172f-45e8-af8f-f1e7bae3b4d8@xs4all.nl>
References: <20180912145829.hzklqndjasac2ap4@M43218.corp.atmel.com>
 <f64fcb6a-172f-45e8-af8f-f1e7bae3b4d8@xs4all.nl>
Message-ID: <CACRpkdZ2_Pn5rWuk514g2sK8yZpY=fJeW+YfV6_oYYR-b7BVmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 5:30 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:

> Can you try this patch first?
>
> Thanks!
>
>         Hans
>
> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index efce534a269b..e09e4e439928 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1859,6 +1859,8 @@ static void gpiochip_set_irq_hooks(struct gpio_chip *gpiochip)
>         }
>         if (WARN_ON(gpiochip->irq.irq_enable))
>                 return;
> +       if (irqchip->irq_enable == gpiochip_irq_enable)
> +               return;

This or somthing like it (like keeping some cookie around to see
if we use the same irqchip) makes sense to me.

drivers/pinctrl/nomadik/* also use the same irqchip twice, and
I bet some more.

Looking forward to proper patch.

Yours,
Linus Walleij
