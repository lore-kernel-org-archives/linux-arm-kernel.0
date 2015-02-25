From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 11:22:21 +0100
Subject: [PATCH] drivers/tty: amba-pl011: defer driver probing if external
 dma is not ready.
In-Reply-To: <54ECF4E0.7010005@linaro.org>
References: <1424749613-24765-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <54ECD1E6.2070909@linaro.org> <54ECF4E0.7010005@linaro.org>
Message-ID: <7759418.HHcBTFejZY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 17:02:08 Jorge Ramirez-Ortiz wrote:
> On 02/24/2015 02:32 PM, Jorge Ramirez-Ortiz wrote:
> > On 02/24/2015 03:29 AM, Arnd Bergmann wrote:
> >> On Monday 23 February 2015 22:46:53 Jorge Ramirez-Ortiz wrote:
> >>> This patch addresses a race condition that happens when
> >>> device_initcall(pl011_dma_initicall) is executed before all the devices have been
> >>> probed - this issue was observed on an hisi_6220 SoC (HiKey board from Linaro).
> >> How do you want to handle the case where there is a DMA channel in DT, but
> >> no driver for it built into the kernel?
> >
> > In my view that should be fixed in the of-dma and the acpi-dma implementation
> > (just don't return EPROBE_DEFER a second time since the driver wasn't found
> > after the late_initcall associated to deferred probing). That would allow
> > drivers that use the defer probing mechanism to wait for optional controllers to
> > complete their probing sequence if those controllers don't become available.
> >
> > In any case, I can track the pending requests (up to twelve, one per UART) with
> > a list in the driver.
> > If a second request to probe fails with EPROBE_DEFER we can conclude that the
> > driver is not present.
> >
> > I have tested such an implementation and it works as expected.
> > would that be acceptable?
> 
> Something along these lines
> 
> +struct dma_deferred {
> +       struct list_head node;
> +       struct device *dev;
> +};
> +
> +static LIST_HEAD(dma_deferred_reqs);
> +
> +static int pl011_handle_dma_probe_defer(struct device *dev)
> +{
> +       struct list_head *node, *tmp;
> +       struct dma_deferred *entry;
> +
> +       list_for_each_safe(node, tmp, &dma_deferred_reqs) {
> +               entry = list_entry(node, struct dma_deferred, node);
> +               if (entry->dev == dev) {
> +                       dev_warn(dev, "DMA driver not present \n");
> +                       list_del(node);
> +                       kfree(entry);
> +                       return -ENODEV;
> +               }
> +       }

I don't see how this would help: Assume you probe the uart first, it defers
because of missing DMA, then you probe DMA, which defers because of some
other resource (clock, irq, ...), then probe the uart a second time and
it fails, then you probe the DMA driver which succeeds because the resources
are there. Another case would be the DMA driver being a loadable module
that only gets loaded after all deferred probes from built-in drivers
have completed.

I don't think we can make any reasonable assumption about the number of
times you need to defer the probing here.

Also, the UART is a rather central device, at least the one that is used
for the console, and we probably want to use it as early as possible even
if that means never attaching the dma engine.

A better solution might be to move the dma_request_slave_channel_reason()
call out of the probe() function entirely and into the open() function:
we use DMA if it is available by the time the device gets opened, otherwise
we don't.

	Arnd
