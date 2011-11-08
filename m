From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 16:41:16 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
Message-ID: <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> new file mode 100644
> index 0000000..e35479b
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -0,0 +1,442 @@
> +/*
> +
> +    i2c Support for Atmel's AT91 Two-Wire Interface (TWI)
> +
> +    Copyright (C) 2011 Nikolaus Voss <n.voss@weinmann.de>
> +
> +    Evolved from original work by:
> +    Copyright (C) 2004 Rick Bronson
> +    Converted to 2.6 by Andrew Victor <andrew@sanpeople.com>
> +
> +    Borrowed heavily from original work by:
> +    Copyright (C) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/at91_twi.h>
> +#include <mach/board.h>
> +#include <mach/cpu.h>

avoid including <mach/*> on drivers.

> +static void at91_set_twi_clock(struct at91_twi_dev *dev)
> +{
> +	unsigned long cdiv, ckdiv;
> +
> +	/* Calcuate clock dividers */
> +	cdiv = (clk_get_rate(dev->clk) / (2 * TWI_CLOCK)) - 3;
> +	cdiv = cdiv + 1;	/* round up */
> +	ckdiv = 0;
> +	while (cdiv > 255) {
> +		ckdiv++;
> +		cdiv = cdiv >> 1;
> +	}
> +
> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */

I don't think you should be using cpu_is_* on drivers.

> +static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
> +{
> +	struct at91_twi_dev *dev = dev_id;
> +	const unsigned status = at91_twi_read(dev, AT91_TWI_SR);
> +	const unsigned irqstatus = status & at91_twi_read(dev, AT91_TWI_IMR);
> +
> +	if (irqstatus & AT91_TWI_TXCOMP) {
> +		at91_disable_twi_interrupts(dev);
> +		dev->transfer_status = status;
> +		complete(&dev->cmd_complete);
> +	}
> +	else if (irqstatus & AT91_TWI_RXRDY) {
> +		at91_twi_read_next_byte(dev);
> +	}
> +	else if (irqstatus & AT91_TWI_TXRDY) {
> +		at91_twi_write_next_byte(dev);
> +	}
> +	else {
> +		return IRQ_NONE;

coding style is wrong. Also, are those IRQ events really mutually
exclusive ??

> +static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
> +{
> +	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
> +	int ret;
> +	unsigned int_addr_flag = 0;
> +	struct i2c_msg *m_start = msg;
> +
> +	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
> +
> +	/* the hardware can handle at most two messages concatenated by a
> +	 * repeated start via it's internal address feature.
> +	 */

wrong comment style.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/2bfcef61/attachment.sig>
