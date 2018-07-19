From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Jul 2018 17:51:50 +0100
Subject: [PATCH 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
 <1531983117-9443-3-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20180719165150.GI27938@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 03:51:57PM +0900, Keiji Hayashibara wrote:

This all looks good, just a small number of fairly minor things - mostly
style points.

> @@ -0,0 +1,532 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * spi-uniphier.c - Socionext UniPhier SPI controller driver
> + *
> + * Copyright 2012      Panasonic Corporation
> + * Copyright 2016-2018 Socionext Inc.
> + */

Please make the entire comment a C++ one, it makes things look a bit
more joined up/intentional.

> +#define BYTES_PER_WORD(x)			\
> +({						\
> +	int __x;				\
> +	__x = (x <= 8)  ? 1 :			\
> +	      (x <= 16) ? 2 : 4;		\
> +	__x;					\
> +})

Could this be replaced with an inline function?  The usage seems fine
but it's a bit big for a macro.  The end result should be similar.

> +static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
> +{
> +	struct uniphier_spi_priv *priv = dev_id;
> +	u32 val, stat;
> +
> +	stat = readl(priv->base + SSI_IS);
> +	val = SSI_IC_TCIC | SSI_IC_RCIC | SSI_IC_RORIC;
> +	writel(val, priv->base + SSI_IC);
> +
> +	/* rx fifo overrun */
> +	if (stat & SSI_IS_RORID) {
> +		priv->error = -EIO;
> +		goto done;
> +	}
> +
> +	/* rx complete */
> +	if ((stat & SSI_IS_RCID) && (stat & SSI_IS_RXRS)) {

> +	}
> +
> +	return IRQ_HANDLED;
> +
> +done:
> +	complete(&priv->xfer_done);
> +	return IRQ_HANDLED;

This will unconditionally report IRQ_HANDLED even if none of the flags
were set by the hardware which will cause problems if something goes
wrong - the interrupt will continually be serviced and the interrupt
framework won't be able to mitigate or provide diagnostics.  It's better
to return IRQ_NONE if nothing is detected from the hardware.

> +static const struct of_device_id uniphier_spi_match[] = {
> +	{ .compatible = "socionext,uniphier-scssi", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);

The binding document also listed socionext,uniphier-mcssi as a
compatible but this driver doesn't match that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180719/6db264ca/attachment.sig>
