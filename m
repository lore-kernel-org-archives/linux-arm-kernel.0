From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 11 Jan 2013 14:26:19 +0200
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <1357863807-380-7-git-send-email-rtivy@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
Message-ID: <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I'm happy to see this driver going upstream, thanks for pushing!

Please see below my few comments. PS - sorry for the belated review.

On Fri, Jan 11, 2013 at 2:23 AM, Robert Tivy <rtivy@ti.com> wrote:
> +config DAVINCI_REMOTEPROC
> +       tristate "DaVinci DA850/OMAPL138 remoteproc support (EXPERIMENTAL)"
> +       depends on ARCH_DAVINCI_DA850
> +       select REMOTEPROC
> +       select RPMSG
> +       select FW_LOADER

This one gets selected by CONFIG_REMOTEPROC, so you don't need to do so too.

> diff --git a/drivers/remoteproc/davinci_remoteproc.c b/drivers/remoteproc/davinci_remoteproc.c
> new file mode 100644
> index 0000000..fc6fd72
> --- /dev/null
> +++ b/drivers/remoteproc/davinci_remoteproc.c
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
> +
> +/**
> + * struct davinci_rproc - davinci remote processor state
> + * @rproc: rproc handle

Add @dsp_clk ?

> + */
> +struct davinci_rproc {
> +       struct rproc *rproc;
> +       struct clk *dsp_clk;
> +};
> +
> +static void __iomem *syscfg0_base;
> +static struct platform_device *remoteprocdev;
> +static struct irq_data *irq_data;
> +static void (*ack_fxn)(struct irq_data *data);
> +static int irq;

Is it safe to maintain these as globals (i.e. what if we have more
than a single pdev instance) ?

> +
> +/**
> + * handle_event() - inbound virtqueue message workqueue function
> + *
> + * This funciton is registered as a kernel thread and is scheduled by the

typo

> + * kernel handler.
> + */
> +static irqreturn_t handle_event(int irq, void *p)
> +{
> +       struct rproc *rproc = platform_get_drvdata(remoteprocdev);

It's probably better to pass this as an irq cookie instead of relying
on global data

> +
> +       /* Process incoming buffers on our vring */
> +       while (IRQ_HANDLED == rproc_vq_interrupt(rproc, 0))
> +               ;

This is interesting. IIUC, you want a single irq event to trigger
processing of all the available messages. It makes sense, but I'm not
sure we need this to be platform-specific.

> +
> +       /* Must allow wakeup of potenitally blocking senders: */
> +       rproc_vq_interrupt(rproc, 1);

IIUC, you do this is because you have a single irq for all the vrings (PCMIIW).

We may want to add something in these lines to the generic remoteproc
framework, as additional platforms require it (e.g. keystone). I
remember a similar patch by Cyril was circulating internally but never
hit the mailing lists - you may want to take it even though it would
probably need to be refreshed.

> +static int davinci_rproc_start(struct rproc *rproc)
> +{
> +       struct platform_device *pdev = to_platform_device(rproc->dev.parent);
> +       struct device *dev = rproc->dev.parent;
> +       struct davinci_rproc *drproc = rproc->priv;
> +       struct clk *dsp_clk;
> +       struct resource *r;
> +       unsigned long host1cfg_physaddr;
> +       unsigned int host1cfg_offset;
> +       int ret;
> +
> +       remoteprocdev = pdev;
> +
> +       /* hw requires the start (boot) address be on 1KB boundary */
> +       if (rproc->bootaddr & 0x3ff) {
> +               dev_err(dev, "invalid boot address: must be aligned to 1KB\n");
> +
> +               return -EINVAL;
> +       }
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (IS_ERR_OR_NULL(r)) {
> +               dev_err(dev, "platform_get_resource() error: %ld\n",
> +                       PTR_ERR(r));
> +
> +               return PTR_ERR(r);
> +       }
> +       host1cfg_physaddr = (unsigned long)r->start;
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
> +
> +               return irq;
> +       }
> +
> +       irq_data = irq_get_irq_data(irq);
> +       if (IS_ERR_OR_NULL(irq_data)) {
> +               dev_err(dev, "irq_get_irq_data(%d) error: %ld\n",
> +                       irq, PTR_ERR(irq_data));
> +
> +               return PTR_ERR(irq_data);
> +       }
> +       ack_fxn = irq_data->chip->irq_ack;
> +
> +       ret = request_threaded_irq(irq, davinci_rproc_callback, handle_event,
> +               0, "davinci-remoteproc", drproc);
> +       if (ret) {
> +               dev_err(dev, "request_threaded_irq error: %d\n", ret);
> +
> +               return ret;
> +       }
> +
> +       syscfg0_base = ioremap(host1cfg_physaddr & PAGE_MASK, SZ_4K);
> +       host1cfg_offset = offset_in_page(host1cfg_physaddr);
> +       writel(rproc->bootaddr, syscfg0_base + host1cfg_offset);
> +
> +       dsp_clk = clk_get(dev, NULL);
> +       if (IS_ERR_OR_NULL(dsp_clk)) {
> +               dev_err(dev, "clk_get error: %ld\n", PTR_ERR(dsp_clk));
> +               ret = PTR_ERR(dsp_clk);
> +               goto fail;
> +       }

There's a lot in this ->start() method that better move to ->probe()
because it should be invoked only once throughout the life cycle of
this driver (probably most of the code above). Can you please take a
look?

> +/* kick a virtqueue */
> +static void davinci_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +       int timed_out;
> +       unsigned long timeout;
> +
> +       timed_out = 0;
> +       timeout = jiffies + HZ/100;
> +
> +       /* Poll for ack from other side first */
> +       while (readl(syscfg0_base + SYSCFG_CHIPSIG_OFFSET) &
> +               SYSCFG_CHIPINT2)
> +               if (time_after(jiffies, timeout)) {
> +                       dev_err(rproc->dev.parent, "failed to receive ack\n");
> +                       timed_out = 1;
> +
> +                       break;
> +               }

Can you please explain what this ack is a bit ? Just out of curiosity.

> +static int davinci_rproc_probe(struct platform_device *pdev)
> +{
> +       struct da8xx_rproc_pdata *pdata = pdev->dev.platform_data;
> +       struct davinci_rproc *drproc;
> +       struct rproc *rproc;
> +       struct clk *dsp_clk;
> +       int ret;
> +
> +       if (!fw_name) {
> +               dev_err(&pdev->dev, "No firmware file specified\n");
> +
> +               return -EINVAL;
> +       }

There are a few issues with this fw_name module param:

1. Usually we don't rely on users providing the firmware file name for
drivers to work. Drivers should know the name beforehand, and if there
may be several different instances of firmwares (for different cores
you may have), then it's just better to get it from the platform data.

2. You may still want to have such a module param in order to be able
to override the default firmware name (for debugging purposes?), but
I'm not sure it should be davinci-specific. if we do want it to be
then please prefix the name with 'davinci'.

> +       ret = rproc_add(rproc);
> +       if (ret)
> +               goto free_rproc;
> +
> +       /*
> +        * rproc_add() can end up enabling the DSP's clk with the DSP
> +        * *not* in reset, but davinci_rproc_start() needs the DSP to be
> +        * held in reset at the time it is called.
> +        */
> +       dsp_clk = clk_get(rproc->dev.parent, NULL);
> +       davinci_clk_reset_assert(dsp_clk);
> +       clk_put(dsp_clk);

This looks racy. Don't you prefer to assert the reset line before you
call rproc_add ?

> +static int __devexit davinci_rproc_remove(struct platform_device *pdev)
> +{
> +       struct rproc *rproc = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       ret = rproc_del(rproc);
> +       if (ret)
> +               return ret;

Personally I'd not test ret here.

I know there's a nice check for !rproc inside rproc_del, but frankly
I'd prefer the system to crash if the developer blew up so badly. It's
nothing I'd want to be silently buried.

> diff --git a/include/linux/platform_data/da8xx-remoteproc.h b/include/linux/platform_data/da8xx-remoteproc.h
> new file mode 100644
> index 0000000..50e8c55
> --- /dev/null
> +++ b/include/linux/platform_data/da8xx-remoteproc.h
> @@ -0,0 +1,33 @@
> +/*
> + * Remote Processor
> + *
> + * Copyright (C) 2011-2012 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __DA8XX_REMOTEPROC_H__
> +#define __DA8XX_REMOTEPROC_H__
> +
> +#include <linux/remoteproc.h>

You should be able to avoid including this header by forward declaring
struct rproc_ops.

Thanks,
Ohad.
