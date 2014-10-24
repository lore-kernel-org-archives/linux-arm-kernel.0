From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 24 Oct 2014 16:19:47 +0200
Subject: [PATCH] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
References: <1414156789-30188-1-git-send-email-lkundrak@v3.sk>
Message-ID: <544A6003.8000708@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lubomir,

Am 24.10.2014 um 15:19 schrieb Lubomir Rintel:
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
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  .../bindings/mailbox/brcm,bcm2835-mbox.txt         |  18 ++
>  drivers/mailbox/Kconfig                            |   9 +
>  drivers/mailbox/Makefile                           |   1 +
>  drivers/mailbox/bcm2835-mailbox.c                  | 291 +++++++++++++++++++++
>  4 files changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
>  create mode 100644 drivers/mailbox/bcm2835-mailbox.c
>
> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> new file mode 100644
> index 0000000..68d761a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/brcm,bcm2835-mbox.txt
> @@ -0,0 +1,18 @@
> +Broadcom BCM2835 VideoCore mailbox IPC
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm2835-mbox"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : the interrupt number. Must be <0 1>, the mailbox interrupt.
> +- #mbox-cells : Specifies the number of cells needed to encode a
> +  mailbox channel. The value shall be 1.
> +
> +Example:
> +
> +mailbox: mailbox at 0x7e00b800 {
> +	compatible = "brcm,bcm2835-mbox";
> +	reg = <0x7e00b880 0x40>;
> +	interrupts = <0 1>;
> +	#mbox-cells = <1>;
> +};

i think you should add the devicetree maintainers to CC and the
Documentation is a extra patch.

> [...]
>
> diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
> new file mode 100644
> index 0000000..5a37ac2
> --- /dev/null
> +++ b/drivers/mailbox/bcm2835-mailbox.c
> @@ -0,0 +1,291 @@
> +/*
> + *  Copyright (C) 2010 Broadcom
> + *  Copyright (C) 2013-2014 Lubomir Rintel
> + *  Copyright (C) 2013 Craig McGeachie
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This device provides a mechanism for writing to the mailboxes,
> + * that are shared between the ARM and the VideoCore processor
> + *
> + * Parts of the driver are based on:
> + *  - arch/arm/mach-bcm2708/vcio.c file written by Gray Girling that was
> + *    obtained from branch "rpi-3.6.y" of git://github.com/raspberrypi/
> + *    linux.git
> + *  - drivers/mailbox/bcm2835-ipc.c by Lubomir Rintel at
> + *    https://github.com/hackerspace/rpi-linux/blob/lr-raspberry-pi/drivers/
> + *    mailbox/bcm2835-ipc.c
> + *  - documentation available on the following web site:
> + *    https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/err.h>
> +#include <linux/spinlock.h>

Please reorder the includes alphabetical.

> [...]
>
> +
> +static irqreturn_t bcm2835_mbox_irq(int irq, void *dev_id)
> +{
> +	struct bcm2835_mbox *mbox = (struct bcm2835_mbox *) dev_id;
> +	struct device *dev = mbox->dev;
> +
> +	while (!(readl(mbox->regs + MAIL0_STA) & ARM_MS_EMPTY)) {

I think it would be good to have a timeout condition here.

In general i believe not all debug messages are necessary anymore.

Thanks

Stefan
