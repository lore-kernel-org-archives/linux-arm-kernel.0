From: david-b@pacbell.net (David Brownell)
Date: Mon, 6 Sep 2010 18:51:55 -0700 (PDT)
Subject: [PATCH v2] AT91: pio: add gpio_is_valid() function
In-Reply-To: <1283782864-10567-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <51719.68478.qm@web180304.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


--- On Mon, 9/6/10, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Subject: [PATCH v2] AT91: pio: add gpio_is_valid() function


Of course there already *IS* a gpio_is_valid(),
with arch/platform hooks


> --- a/arch/arm/mach-at91/include/mach/gpio.h
> +++ b/arch/arm/mach-at91/include/mach/gpio.h

>  
> +/* keep room for a couple of GPIO expanders */
> +#define NR_EXTRA_GPIO??? ???64
> +#define ARCH_NR_GPIOS??? ???
> (NR_BUILTIN_GPIO + NR_EXTRA_GPIO)

ISTR contemplating something like NR_EXTRA_GPIO
once too, but deciding against it.  Doing it this
way (per-platform) seems OK.  ISTR, matches OMAP;
might be worth generalizing...)


>  #ifndef __ASSEMBLY__
> +static inline int gpio_is_valid(int number)
> +{
> +??? if (number >= PIN_BASE &&

I suppose that clause is the entire reason to
not like the standard gpio_is_valid() ??  Since
on AT91 the IRQ and GPIO numbers share the same
space, but 0..(PIN_BASE-1) are IRQs not GPIOs.
  Yes?

Worth re-thinking your approach to handling that.
Most of the numbers in that range are valid GPIO
numbers -- on non-AT91 platforms.  Maybe AT91
scould grow to_gpio(N) and to_irq(N) macros.  It
was handy sharing the spaces when implementing
GPIO IRQ support, but in retrospect maybe that was
not the best idea.


> +??? ? ? number <=
> ARCH_NR_GPIOS)


More conventional, FWIW -- just return the
boolean xpression's value ...
> +??? ??? return 1;
> +??? return 0;
