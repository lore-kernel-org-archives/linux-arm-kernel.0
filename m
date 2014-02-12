From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Feb 2014 16:35:28 +0100
Subject: [PATCH] gpio: mvebu: use chained_irq_{enter,
 exit} for GIC compatibility
In-Reply-To: <1391772559-28357-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391772559-28357-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbAD-mdRJ0H6LVGkyf2novmMGvADY0bi=uxdTC9vF6w+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 12:29 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> On currently supported SoCs, the GPIO block used on Marvell EBU SoCs
> is always connected to the Marvell MPIC. However, we are going to
> introduce the support for newer Marvell EBU SoCs that use the
> Cortex-A9 core, and therefore use the GIC as their main interrupt
> controller, to which the GPIO block controlled by the gpio-mvebu
> driver is connected.
>
> The GIC interrupt controller driver uses the fasteoi flow handler. In
> order to ensure that the eoi hook of the GIC driver gets called, the
> GPIO driver should call chained_irq_enter() and chained_irq_exit() in
> its handler. Without this, the first GPIO interrupt locks up the
> system because it doesn't get acked at the GIC level.
>
> This change is similar to for example commit
> 0d978eb7349941139241a99acf05de6dd49b78d1 ("gpio: davinci: use
> chained_irq_enter/chained_irq_exit API").
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

That's right. Patch applied (w/Jason's ACK).

Now a bigger question: isn't this something that basically *all* GPIO
drivers supporting IRQs should be doing? I think they are basically
all cascaded.

When I grep drivers/gpio/* I see a lot of weird stuff. For example
drivers like gpio-ep93xx that uses irq_set_chained_handler()
but never calls chained_irq_[enter|exit]().

I sense a need of cleanup. Ultimately I want to move a
generic irq_chip into gpiolib, implement this with necessary callbacks
there and try to move drivers over to using that central irqchip
mechanism. But maybe I'm not seeing the irq subsystem in all
its complex glory so this may be a pipe dream.

I'm actually a bit uncertain about the semantics here so I'm
asking you for some advice ...

Ideas?

Yours,
Linus Walleij
