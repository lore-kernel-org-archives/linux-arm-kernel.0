From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Jan 2013 11:08:43 +0530
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <1357863807-380-7-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
Message-ID: <50FCD463.5000006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/11/2013 5:53 AM, Robert Tivy wrote:
> Adding a remoteproc driver implementation for OMAP-L138 DSP
> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>  drivers/remoteproc/Kconfig                     |   23 ++
>  drivers/remoteproc/Makefile                    |    1 +
>  drivers/remoteproc/davinci_remoteproc.c        |  307 ++++++++++++++++++++++++
>  include/linux/platform_data/da8xx-remoteproc.h |   33 +++

naming the driver davinci_remoteproc.c and platform data as
da8xx-remoteproc.h is odd. The driver looks really specific to omap-l138
so may be call the driver da8xx-remoteproc.c?

> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 96ce101..7d3a5e0 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -41,4 +41,27 @@ config STE_MODEM_RPROC
>  	  This can be either built-in or a loadable module.
>  	  If unsure say N.
>  
> +config DAVINCI_REMOTEPROC
> +	tristate "DaVinci DA850/OMAPL138 remoteproc support (EXPERIMENTAL)"
> +	depends on ARCH_DAVINCI_DA850
> +	select REMOTEPROC
> +	select RPMSG
> +	select FW_LOADER
> +	select CMA
> +	default n
> +	help
> +	  Say y here to support DaVinci DA850/OMAPL138 remote processors
> +	  via the remote processor framework.
> +
> +	  You want to say y here in order to enable AMP
> +	  use-cases to run on your platform (multimedia codecs are
> +	  offloaded to remote DSP processors using this framework).
> +
> +	  It's safe to say n here if you're not interested in multimedia
> +	  offloading or just want a bare minimum kernel.

> +	  This feature is considered EXPERIMENTAL, due to it not having
> +	  any previous exposure to the general public and therefore
> +	  limited developer-based testing.

This is probably true in general for remoteproc (I am being warned a lot
by the framework when using it) so may be you can drop this specific
reference.

> diff --git a/drivers/remoteproc/davinci_remoteproc.c b/drivers/remoteproc/davinci_remoteproc.c
> new file mode 100644
> index 0000000..fc6fd72
> --- /dev/null
> +++ b/drivers/remoteproc/davinci_remoteproc.c
> @@ -0,0 +1,307 @@
> +/*
> + * Remote processor machine-specific module for Davinci
> + *
> + * Copyright (C) 2011-2012 Texas Instruments, Inc.

2013?

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#define pr_fmt(fmt)    "%s: " fmt, __func__

You dont seem to be using this anywhere.

> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/printk.h>
> +#include <linux/bitops.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/platform_data/da8xx-remoteproc.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>

It will be nice to keep this sorted. It avoids duplicate includes later.

> +static char *fw_name;
> +module_param(fw_name, charp, S_IRUGO);
> +MODULE_PARM_DESC(fw_name, "\n\t\tName of DSP firmware file in /lib/firmware");
> +
> +/*
> + * OMAP-L138 Technical References:
> + * http://www.ti.com/product/omap-l138
> + */
> +#define SYSCFG_CHIPSIG_OFFSET 0x174
> +#define SYSCFG_CHIPSIG_CLR_OFFSET 0x178
> +#define SYSCFG_CHIPINT0 (1 << 0)
> +#define SYSCFG_CHIPINT1 (1 << 1)
> +#define SYSCFG_CHIPINT2 (1 << 2)
> +#define SYSCFG_CHIPINT3 (1 << 3)

You can use BIT(x) here.

> +
> +/**
> + * struct davinci_rproc - davinci remote processor state
> + * @rproc: rproc handle
> + */
> +struct davinci_rproc {
> +	struct rproc *rproc;
> +	struct clk *dsp_clk;
> +};
> +
> +static void __iomem *syscfg0_base;
> +static struct platform_device *remoteprocdev;
> +static struct irq_data *irq_data;
> +static void (*ack_fxn)(struct irq_data *data);
> +static int irq;
> +
> +/**
> + * handle_event() - inbound virtqueue message workqueue function
> + *
> + * This funciton is registered as a kernel thread and is scheduled by the
> + * kernel handler.
> + */
> +static irqreturn_t handle_event(int irq, void *p)
> +{
> +	struct rproc *rproc = platform_get_drvdata(remoteprocdev);
> +
> +	/* Process incoming buffers on our vring */
> +	while (IRQ_HANDLED == rproc_vq_interrupt(rproc, 0))
> +		;
> +
> +	/* Must allow wakeup of potenitally blocking senders: */
> +	rproc_vq_interrupt(rproc, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * davinci_rproc_callback() - inbound virtqueue message handler
> + *
> + * This handler is invoked directly by the kernel whenever the remote
> + * core (DSP) has modified the state of a virtqueue.  There is no
> + * "payload" message indicating the virtqueue index as is the case with
> + * mailbox-based implementations on OMAP4.  As such, this handler "polls"
> + * each known virtqueue index for every invocation.
> + */
> +static irqreturn_t davinci_rproc_callback(int irq, void *p)
> +{
> +	if (readl(syscfg0_base + SYSCFG_CHIPSIG_OFFSET) & SYSCFG_CHIPINT0) {

personally I think using a variable to read the register and then
testing its value inside if() is more readable.

> +		/* Clear interrupt level source */
> +		writel(SYSCFG_CHIPINT0,
> +			syscfg0_base + SYSCFG_CHIPSIG_CLR_OFFSET);
> +
> +		/*
> +		 * ACK intr to AINTC.
> +		 *
> +		 * It has already been ack'ed by the kernel before calling
> +		 * this function, but since the ARM<->DSP interrupts in the
> +		 * CHIPSIG register are "level" instead of "pulse" variety,
> +		 * we need to ack it after taking down the level else we'll
> +		 * be called again immediately after returning.
> +		 */
> +		ack_fxn(irq_data);

Don't really like interrupt controller functions being invoked like this
but I don't understand the underlying issue well enough to suggest an
alternate.

> +
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int davinci_rproc_start(struct rproc *rproc)
> +{
> +	struct platform_device *pdev = to_platform_device(rproc->dev.parent);
> +	struct device *dev = rproc->dev.parent;
> +	struct davinci_rproc *drproc = rproc->priv;
> +	struct clk *dsp_clk;
> +	struct resource *r;
> +	unsigned long host1cfg_physaddr;
> +	unsigned int host1cfg_offset;
> +	int ret;
> +
> +	remoteprocdev = pdev;
> +
> +	/* hw requires the start (boot) address be on 1KB boundary */
> +	if (rproc->bootaddr & 0x3ff) {
> +		dev_err(dev, "invalid boot address: must be aligned to 1KB\n");
> +
> +		return -EINVAL;
> +	}
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Along with moving this to probe as Ohad requested, you can use
devm_request_and_ioremap() to simplify the error paths here. Have a look
at: Documentation/driver-model/devres.txt

> +	if (IS_ERR_OR_NULL(r)) {
> +		dev_err(dev, "platform_get_resource() error: %ld\n",
> +			PTR_ERR(r));
> +
> +		return PTR_ERR(r);
> +	}
> +	host1cfg_physaddr = (unsigned long)r->start;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
> +
> +		return irq;
> +	}
> +
> +	irq_data = irq_get_irq_data(irq);
> +	if (IS_ERR_OR_NULL(irq_data)) {
> +		dev_err(dev, "irq_get_irq_data(%d) error: %ld\n",
> +			irq, PTR_ERR(irq_data));
> +
> +		return PTR_ERR(irq_data);
> +	}
> +	ack_fxn = irq_data->chip->irq_ack;
> +
> +	ret = request_threaded_irq(irq, davinci_rproc_callback, handle_event,
> +		0, "davinci-remoteproc", drproc);
> +	if (ret) {
> +		dev_err(dev, "request_threaded_irq error: %d\n", ret);
> +
> +		return ret;
> +	}
> +
> +	syscfg0_base = ioremap(host1cfg_physaddr & PAGE_MASK, SZ_4K);
> +	host1cfg_offset = offset_in_page(host1cfg_physaddr);
> +	writel(rproc->bootaddr, syscfg0_base + host1cfg_offset);
> +
> +	dsp_clk = clk_get(dev, NULL);

devm_clk_get() here.

> +	if (IS_ERR_OR_NULL(dsp_clk)) {
> +		dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
> +		ret = PTR_ERR(dsp_clk);
> +		goto fail;
> +	}
> +	clk_enable(dsp_clk);
> +	davinci_clk_reset_deassert(dsp_clk);
> +
> +	drproc->dsp_clk = dsp_clk;
> +
> +	return 0;
> +fail:
> +	free_irq(irq, drproc);
> +	iounmap(syscfg0_base);
> +
> +	return ret;
> +}
> +
> +static int davinci_rproc_stop(struct rproc *rproc)
> +{
> +	struct davinci_rproc *drproc = rproc->priv;
> +	struct clk *dsp_clk = drproc->dsp_clk;
> +
> +	clk_disable(dsp_clk);
> +	clk_put(dsp_clk);
> +	iounmap(syscfg0_base);
> +	free_irq(irq, drproc);
> +
> +	return 0;
> +}
> +
> +/* kick a virtqueue */
> +static void davinci_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	int timed_out;
> +	unsigned long timeout;
> +
> +	timed_out = 0;
> +	timeout = jiffies + HZ/100;
> +
> +	/* Poll for ack from other side first */
> +	while (readl(syscfg0_base + SYSCFG_CHIPSIG_OFFSET) &
> +		SYSCFG_CHIPINT2)

If there is a context switch here long enough ..

> +		if (time_after(jiffies, timeout)) {


.. then time_after() might return true and you will erroneously report a
timeout even though hardware is working perfectly fine.

Thanks,
Sekhar
