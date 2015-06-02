From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 15:40:53 +0200
Subject: [PATCH v2 1/6] gpio: Add GPIO support for Broadcom STB SoCs
In-Reply-To: <1432865650-4062-2-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-2-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdaAcsB4CK9jfjTXUZDLkG3nt3ofTngmoiU92fhTowg6fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 4:14 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> This adds support for the GPIO IP "UPG GIO" used on Broadcom STB SoCs
> (BCM7XXX and some others).  Uses basic_mmio_gpio to instantiate a
> gpio_chip for each bank.  The driver assumes that it handles the base
> set of GPIOs on the system and that it can start its numbering sequence
> from 0, so any GPIO expanders used with it must dynamically assign GPIO
> numbers after this driver has finished registering its GPIOs.
>
> Does not implement the interrupt-controller portion yet, will be done in a
> future commit.
>
> List-usage-fixed-by: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
> ---
> v2:
> - change include to use <linux/gpio/driver.h> instead of <linux/gpio.h>
> - get rid of unnecessary imask member in struct bank
> - rename GPIO_PER_BANK -> MAX_GPIO_PER_BANK
> - always have 32 GPIOs per bank and add 'width' member in struct bank to hold
>   actual number of GPIOs in use
> - mark of_match table as const

This v2 version of 1/5 applied.

I recognize that you need one driver for all banks. I'm still hesitant
about the complexity it brings to e.g. the IRQ handling.

Another possibility would be to spawn one driver per bank anyways,
then have the IRQ requested as IRQF_SHARED so the IRQ
handler for the shared IRQ would walk all drivers IRQ handlers
and eventually figure out what GPIO fired it. But this
implementation is quicker I guess.

Yours,
Linus Walleij
