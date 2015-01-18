From: arend@broadcom.com (Arend van Spriel)
Date: Sun, 18 Jan 2015 10:14:04 +0100
Subject: [PATCH v5 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <1421451737-7107-3-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1421451737-7107-1-git-send-email-rjui@broadcom.com>
 <1421451737-7107-3-git-send-email-rjui@broadcom.com>
Message-ID: <54BB795C.6040402@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/15 00:42, Ray Jui wrote:

[...]

> +/*
> + * Can be expanded in the future if more interrupt status bits are utilized
> + */
> +#define ISR_MASK (1<<  IS_M_START_BUSY_SHIFT)
> +
> +static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
> +{
> +	struct bcm_iproc_i2c_dev *iproc_i2c = data;
> +	u32 status = readl(iproc_i2c->base + IS_OFFSET);
> +
> +	status&= ISR_MASK;
> +
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	writel(status, iproc_i2c->base + IS_OFFSET);
> +	complete_all(&iproc_i2c->done);

Looking over this code it seems to me there is always a single process 
waiting for iproc_i2c->done to complete. So using complete() here would 
suffice.

Regards,
Arend

> +
> +	return IRQ_HANDLED;
> +}
