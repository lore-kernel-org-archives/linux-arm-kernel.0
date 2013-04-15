From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 10:53:10 -0600
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
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
Message-ID: <516C3076.3000107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2013 07:35 PM, Javier Martinez Canillas wrote:
...
> Is the following inlined patch [1] what you were thinking that would
> be the right approach?
...
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
...
> +static int omap_gpio_irq_request(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +
> +	return omap_gpio_request(&bank->chip, d->hwirq);

If you want the GPIO usage to be known to the GPIO subsystem, then
wouldn't you call gpio_request() here rather than omap_gpio_request()?
The above code will certainly do enough so that the OMAP GPIO HW is
fully enabled as you need, but I thought the idea was to also prevent
some other code successfully running gpio_request() on that same GPIO?
