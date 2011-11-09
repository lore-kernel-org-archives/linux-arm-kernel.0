From: balbi@ti.com (Felipe Balbi)
Date: Wed, 9 Nov 2011 21:59:26 +0200
Subject: [PATCH v4 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <fc7ccca66f0ffea1aa9c0409162b4a66974c46b3.1320853921.git.n.voss@weinmann.de>
References: <cover.1320853921.git.n.voss@weinmann.de>
 <fc7ccca66f0ffea1aa9c0409162b4a66974c46b3.1320853921.git.n.voss@weinmann.de>
Message-ID: <20111109195925.GB17406@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 08, 2011 at 11:49:46AM +0100, Nikolaus Voss wrote:
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index e8a1852..fba6da6 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
>  obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  
>  # Embedded system I2C/SMBus host controller drivers
> +obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
>  obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
>  obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> new file mode 100644
> index 0000000..5f4be34
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -0,0 +1,417 @@
> +/*
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

wrong multi-line comment style.

> +static void at91_set_twi_clock(struct at91_twi_dev *dev)

this should be __devinit as it's only used by at91_twi_hwinit()

> +{
> +	unsigned long cdiv, ckdiv;
> +
> +	/* Calcuate clock dividers and round up */

typo: calculate.

> +	cdiv = (clk_get_rate(dev->clk) / (2 * TWI_CLOCK_HZ)) - 3 + 1;

DIV_ROUND_UP() ??

> +	ckdiv = 0;
> +	while (cdiv > 255) {
> +		ckdiv++;
> +		cdiv = cdiv >> 1;
> +	}
> +
> +	if (cpu_is_at91rm9200() && (ckdiv > 5)) {
> +		dev_err(dev->dev, "AT91RM9200 Erratum #22: using ckdiv = 5.\n");

is it really an error ? Or would it be enough as dev_dbg() ?

> +static int at91_do_twi_transfer(struct at91_twi_dev *dev, bool is_read)
> +{
> +	int ret;
> +
> +	INIT_COMPLETION(dev->cmd_complete);
> +	if (is_read) {
> +		if (!dev->buf_len)
> +			at91_twi_write(dev, AT91_TWI_CR,
> +				       AT91_TWI_START | AT91_TWI_STOP);
> +		else
> +			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_START);
> +		at91_twi_write(dev, AT91_TWI_IER,
> +			       AT91_TWI_TXCOMP | AT91_TWI_RXRDY);
> +	} else {
> +		at91_twi_write_next_byte(dev);
> +		at91_twi_write(dev, AT91_TWI_IER,
> +			       AT91_TWI_TXCOMP | AT91_TWI_TXRDY);
> +	}
> +
> +	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> +							dev->adapter.timeout);
> +	if (ret == 0) {
> +		dev_err(dev->dev, "controller timed out\n");
> +		at91_init_twi_bus(dev);
> +		return -ETIMEDOUT;
> +	}
> +	if (dev->transfer_status & AT91_TWI_NACK) {
> +		dev_dbg(dev->dev, "received nack\n");
> +		return -ENODEV;

not sure error code matches here. If the HW replies with NACK you tell
your users there's no I2C adapter ? Sounds a bit weird to me...

> +static int __devinit at91_twi_probe(struct platform_device *pdev)
> +{
> +	struct at91_twi_dev *dev;
> +	struct resource *mem, *irq, *ioarea;
> +	int rc;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem)
> +		return -ENODEV;
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

int irq = platform_get_irq(pdev, 0), would work better for you. In case
of error it will return -ENXIO

> +	if (!irq)
> +		return -ENODEV;
> +
> +	ioarea = request_mem_region(mem->start, resource_size(mem), pdev->name);
> +	if (!ioarea)
> +		return -EBUSY;
> +
> +	dev = kzalloc(sizeof(struct at91_twi_dev), GFP_KERNEL);

sizeof(*dev) would allow you to change the type of dev without having to
patch this line. Quite unlikely, I know, but still...

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111109/89190d73/attachment-0001.sig>
