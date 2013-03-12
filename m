From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 16:01:01 +0000
Subject: [PATCH] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1363103673-24720-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1363103673-24720-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130312160101.GW4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 04:54:33PM +0100, Uwe Kleine-K?nig wrote:
> +#include <asm/irq.h>
> +#include <asm/io.h>

linux/io.h

> +	unsigned int irqs, i, irq_base;
> +
> +	irq_base = irq_alloc_descs(-1, 16, irqs - 16, numa_node_id());
> +	if (IS_ERR_VALUE(irq_base)) {

Erm... irq_alloc_descs() returns a negative number on error.

	if ((int)irq_base < 0)

or make irq_base an int, and use:

	if (irq_base < 0)
