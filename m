From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 09:31:46 +0200
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
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
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com>
 <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
Message-ID: <CACRpkdaA_7Feuui-S65m--2FfvpoUkfn6b9SoWavAstZUS23ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 2:41 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:

So:

> +static int omap_gpio_irq_domain_xlate(struct irq_domain *d,
> +                                     struct device_node *ctrlr,
> +                                     const u32 *intspec, unsigned int intsize,
> +                                     irq_hw_number_t *out_hwirq,
> +                                     unsigned int *out_type)
> +{
> +       int ret;
> +       struct gpio_bank *bank = d->host_data;
> +       int gpio = bank->chip.base + intspec[0];
> +
> +       if (WARN_ON(intsize < 2))
> +               return -EINVAL;
> +
> +       ret = gpio_request_one(gpio, GPIOF_IN, ctrlr->full_name);
> +       if (ret)
> +               return ret;

So how to figure out if a device is already requesting this GPIO
on some orthogonal axis?

if (this_gpio_was_hogged_as_input_in_gpiolib) {
   ret = gpio_request_on()...
}

Is my suggestion, then you can explicitly mark which GPIOs
shall have their IRQs implicitly translated to GPIOs and
requested.

Alas, this requires the DTS:es to have this hogging added, but
it is fully backwards-compatible.

Then the applicabl OMAP drivers (like MMC) can be fixed to
do gpio_to_irq() on  their pins instead of using the IRQ
directly.

Yours,
Linus Walleij
