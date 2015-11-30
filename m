From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 14:53:23 +0100
Subject: [PATCH v2 0/5] pinctrl: meson: enable support for external GPIO
 interrupts
In-Reply-To: <1448273816-11290-1-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdZqv62Vsb1Fs9fo27-K-T=O6wJLfzRB6ZCPehWOGrxUzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 11:16 AM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> In Meson SoCs we have 8 independent GPIO interrupts that can be programmed to
> use any of the GPIOs in the chip as interrupt source.
>
> These GPIOs are managed by GIC but they can be conditioned (and enabled) by
> some registers external to the GIC.
>
> GPIOs |--[mux1 or mux2]--[polarity]--[filter]--[edge_select]--> GIC
>
> For discussion see comment to the [PATCH 3/5].
>
> Changelog:
>
> * V2:
>     - Introduced .irq_request_resources() and .irq_release_resources()
>     - s/virq/irq/ and s/pin/hwirq/
>     - Moved to the new irq_fwspec

I'm waiting for the next version of this patch set.

However I am a bit concerned that we're starting to have a few
GPIO controllers now that are not really cascaded irqchips,
but instead just shunt the line through to some other interrupt
controller through a mux or latch.

We might need to add some handling to gpiolib core that
does this, like gpiochip_add_irq_mux() that sets up the
irqdomain we have for GPIOLIB_IRQCHIP to be used like
this and pull this code into gpiolib to avoid duplication of
code and bugs.

Yours,
Linus Walleij
