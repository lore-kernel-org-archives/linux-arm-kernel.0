From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 May 2015 12:59:35 +0200
Subject: [PATCH 0/3] GPIO support for BRCMSTB
In-Reply-To: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkda3EDa7YdzeT6FQ=cQw1RrDath7pQsCos-JeB2y4r18gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 10:37 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> There is only one IRQ for each GIO IP block (i.e. several register banks share
> an IRQ).  After briefly looking into the generic IRQ chip implementation, it
> seemed like in this case that using it would result in the driver being more
> complex than necessary because AFAICT it expects a 1:1 mapping of
> irq_chip_generic to gpio_chip.  It seemed like less of a pain to have a single
> irq_chip since we have a single IRQ for all register banks (multiple
> gpio_chips).  I might be missing something, maybe using a shared IRQ across
> multiple irq_chips is easier than I think?  Suggestions welcome.

What is needed is a 1:1 mapping between GPIO offsets and IRQ
offsets.

If you just number your GPIOs 0...n and your IRQs 0...n
it should work just fine with one irqchip for all banks.

What screws things up is likely that the hardware supports
32 lines per bank and not all are used.

I suggest you enable 32 line and 32 IRQs per bank,
so that hwirq maps nicely 1:1 on the GPIO offsets,
then just use the width thing to NACK operations on
GPIO lines you are not using. This way you can also
decode and warn on spurious IRQs on the unused lines.

Yours,
Linus Walleij
