From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Mon, 15 Apr 2013 13:25:38 +0200
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost>
 <51391F41.5000303@ti.com>
 <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
 <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
 <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com>
 <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
 <515319D5.20105@wwwdotorg.org>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
 <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org>
 <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org>
 <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
Message-ID: <CAAwP0s2tdDGXsWm0b5rHsxcv_qjMSOqE8g_mmyNW3oeXW=VpYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 10:53 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sun, Apr 14, 2013 at 3:35 AM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:
>
>> Is the following inlined patch [1] what you were thinking that would
>> be the right approach?

Hi Linus, thanks a lot for your feedback.

>
> This looks sort of OK, but I'm still struggling with the question of
> what we could do to help other implementations facing the same issue.
>

Yes, I don't know how we can make it easier to other implementations
(besides adding the irq_request hook to irq_chip) since the logic is
GPIO controller specific.

For example I took a look to drivers/gpio/gpio-tegra.c and if I
understood correctly, the implementation for this driver should be
something like this:

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 414ad91..a2d5c3d 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -346,6 +346,11 @@ static int tegra_gpio_wake_enable(struct irq_data
*d, unsigned int enable)
 }
 #endif

+static int tegra_gpio_irq_request(struct irq_data *d)
+{
+	tegra_gpio_request(NULL, d->hwirq);
+}
+
 static struct irq_chip tegra_gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_ack	= tegra_gpio_irq_ack,
@@ -355,6 +360,7 @@ static struct irq_chip tegra_gpio_irq_chip = {
 #ifdef CONFIG_PM_SLEEP
 	.irq_set_wake	= tegra_gpio_wake_enable,
 #endif
+	.irq_request    = tegra_gpio_irq_request,
 };

 static const struct dev_pm_ops tegra_gpio_pm_ops = {

This is definitely quite similar to the omap-gpio.c change but not the same.

> This is a pretty hard design pattern to properly replicate in every such
> driver is it not?
>
> Hmmmm
>

Is indeed a hard design pattern but I couldn't figure out a more
generic way to handle this.

Maybe we could use [1] for now to solve the issue that we have with
OMAP GPIO and later when the same issue is found on other GPIO
controllers and a similar change is made on these drivers we will see
some form of pattern that emerge allowing us to make a later refactor
to reduce the code duplication.

Or do you have a better idea on how to solve this?

> Yours,
> Linus Walleij

Best regards,
Javier
