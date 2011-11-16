From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Nov 2011 17:44:19 +0000
Subject: [PATCH 1/3] drivers: base: add support for stmp-style devices
In-Reply-To: <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
References: <1321440459-4527-1-git-send-email-w.sang@pengutronix.de>
 <1321440459-4527-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <201111161744.19733.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 November 2011, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Introducing new core code definitely requires a long patch description.
How about copying the description from the introductory mail here?

>  drivers/base/Kconfig        |    3 ++
>  drivers/base/Makefile       |    1 +
>  drivers/base/stmp_device.c  |   80 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/stmp_device.h |   19 ++++++++++
>  4 files changed, 103 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/base/stmp_device.c
>  create mode 100644 include/linux/stmp_device.h

I'm not convinced that drivers/base is the right place, but I also can't
think of anything better right now.

> diff --git a/drivers/base/stmp_device.c b/drivers/base/stmp_device.c

> +/*
> + * Clear the bit and poll it cleared.  This is usually called with
> + * a reset address and mask being either SFTRST(bit 31) or CLKGATE
> + * (bit 30).
> + */
> +static int stmp_clear_poll_bit(void __iomem *addr, u32 mask)
> +{
> +	int timeout = 0x400;
> +
> +	writel(mask, addr + STMP_CLR_ADDR);
> +	udelay(1);
> +	while ((readl(addr) & mask) && --timeout)
> +		/* nothing */;
> +
> +	return !timeout;
> +}

For portable code, you should use cpu_relax() inside of the loop.

Is the udelay() actually necessary here?

> +int stmp_reset_block(void __iomem *reset_addr)
> +{
> +	int ret;
> +	int timeout = 0x400;
> +
> +	/* clear and poll SFTRST */
> +	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_SFTRST);
> +	if (unlikely(ret))
> +		goto error;

Please don't use likely()/unlikely() in code that is not very
performance sensitive. It will usually just increase the code size
but not actually have a measurable benefit.

> +	/* clear CLKGATE */
> +	writel(STMP_MODULE_CLKGATE, reset_addr + STMP_CLR_ADDR);
> +
> +	/* set SFTRST to reset the block */
> +	writel(STMP_MODULE_SFTRST, reset_addr + STMP_SET_ADDR);
> +	udelay(1);
> +
> +	/* poll CLKGATE becoming set */
> +	while ((!(readl(reset_addr) & STMP_MODULE_CLKGATE)) && --timeout)
> +		/* nothing */;
> +	if (unlikely(!timeout))
> +		goto error;

Since the run-time of a readl() may vary greatly, counting to 400
for a timeout seems completely arbitrary and unhelpful.

A better construct is 

	long timeout = jiffies + HZ / 10; /* wait for at most 100ms */

	do {
		...
	} while (time_before(jiffies, timeout));

or the ktime equivalent of that if you are waiting for very short times.

> +	/* clear and poll SFTRST */
> +	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_SFTRST);
> +	if (unlikely(ret))
> +		goto error;
> +
> +	/* clear and poll CLKGATE */
> +	ret = stmp_clear_poll_bit(reset_addr, STMP_MODULE_CLKGATE);
> +	if (unlikely(ret))
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	pr_err("%s(%p): module reset timeout\n", __func__, reset_addr);
> +	return -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL(stmp_reset_block);

EXPORT_SYMBOL_GPL?

> diff --git a/include/linux/stmp_device.h b/include/linux/stmp_device.h
> new file mode 100644
> index 0000000..330f8d8
> --- /dev/null
> +++ b/include/linux/stmp_device.h
> @@ -0,0 +1,19 @@
> +#ifndef __STMP_DEVICE_H__
> +#define __STMP_DEVICE_H__
> +
> +#define STMP_SET_ADDR		0x4
> +#define STMP_CLR_ADDR		0x8
> +#define STMP_TOG_ADDR		0xc

The register numbers should probably go into the implementation file,
they are not an interface.

> +extern int stmp_reset_block(void __iomem *);
> +#endif /* __STMP_DEVICE_H__ */


	Arnd
