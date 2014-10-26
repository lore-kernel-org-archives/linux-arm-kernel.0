From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 25 Oct 2014 21:07:41 -0600
Subject: [PATCH] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
References: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
Message-ID: <544C657D.9070803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2014 07:19 AM, Lubomir Rintel wrote:
> Implement BCM2835 mailbox support as a device registered with the
> general purpose mailbox framework. Implementation based on commits by
> Lubomir Rintel [1], Suman Anna and Jassi Brar [2] on which to base the
> implementation.
> 
> [1] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-April/000528.html
> [2] http://lists.infradead.org/pipermail/linux-rpi-kernel/2013-May/000546.html
> 
> [lkundrak at v3.sk: Tidied up Squashed Craig's work for review, carried over
> to new version of Mailbox framework]
> 
> Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

It's a bit odd that the patch author is you if all those other people
signed off the patch before you. Given that list of S-o-b, I'd have
expected to see the following at the start of the email:

From: Craig McGeachie <slapdau@yahoo.com.au>

... either that, or say "based on work by ..." rather than s-o-b all
those other people?

> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt

> +Required properties:
> +
> +- compatible : should be "brcm,bcm2835-mbox"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.

The DT binding should only specify exact values for properties that this
HW module owns. The value of interrupts is owned by the IRQ controller
that this module's IRQ output is sent to. This binding should say simple
like:

- interrupts : The module's interrupt output.
  See ../interrupt-controller/interrupts for details of the format.

Can you please make sure there aren't any other interrupts, clocks,
resets, or other resources that should be listed here. DT works better
if you list all the resources from the start, even if the current Linux
driver doesn't make use of some of them yet.


> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig

> +config BCM2835_MBOX
> +	tristate "BCM2835 Mailbox"
> +	depends on ARCH_BCM2835
> +	help
> +	  An implementation of the BCM2385 Mailbox.  It is used to invoke
> +	  the services of the Videocore. Say Y here if you want to use the

"Y or M" since this is tristate?

> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile

>  obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
> +obj-$(CONFIG_BCM2835_MBOX)	+= bcm2835-mailbox.o

Alphabetical order?

> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c

> +/* Mailbox registers. We basically only support mailbox 0 & 1. We deliver to
> + * the VC in mailbox 1, it delivers to us in mailbox 0. See BCM2835 ARM
> + * Peripherals section 1.3 for an explanation about the placement of memory

Rather than "BCM2835 ARM Peripherals", perhaps use the exact filename so
it's obvious what the name refers to.

> +static int request_mailbox_irq(struct bcm2835_mbox *mbox)
...
> +	ret = devm_request_irq(dev, irq, bcm2835_mbox_irq, 0, dev_name(dev),
> +		mbox);

Are you absolutely sure that using devm_request_irq() is safe? It's only
safe if you can absolutely guarantee that the IRQ won't fire after
remove() (or rather, whenever the resources required for the IRQ handler
to run without crashing/failing) and before the devm core actually
unregisters the IRQ handler. If this can't be guaranteed, explicit
management of the IRQ is required.

> +MODULE_AUTHOR("Craig McGeachie");
> +MODULE_AUTHOR("Lubomir Rintel <lkundrak@v3.sk>");

I have no idea if multiple MODULE_AUTHOR()s work. Can you make sure they do.

This driver doesn't seem to handle the property mailbox channel, which
would involve additional handling of the memory buffers used to transfer
the associated messages. Perhaps you're expecting some higher-level
driver to sit on top of this driver for that purpose?

Having a separate device/driver might be problematic, since there's only
the single mailbox HW module in the chip, and DT should mostly only
nodes for actual physical HW modules. Perhaps we could make this driver
register the device object for any separate driver though. Even then,
you'd have to make sure that the #mbox-cells value was enough to refer
to the property channel in the future.

Some functionality is only available through the property mailbox
protocol, rather than the separate dedicated channels, so it's important
to allow for that functionality.
