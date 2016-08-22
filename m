From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 14:54:58 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <94227d94-1d60-fda7-731b-26656633d585@nvidia.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
 <94227d94-1d60-fda7-731b-26656633d585@nvidia.com>
Message-ID: <20160822125458.GC17367@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 10:26:50AM +0100, Jon Hunter wrote:
> 
> On 19/08/16 18:32, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The Boot and Power Management Processor (BPMP) is a co-processor found
> > on Tegra SoCs. It is designed to handle the early stages of the boot
> > process and offload power management tasks (such as clocks, resets,
> > powergates, ...) as well as system control services.
> > 
> > Compared to the ARM SCPI, the services provided by BPMP are message-
> > based rather than method-based. The BPMP firmware driver provides the
> > services to transmit data to and receive data from the BPMP. Users can
> > also register an MRQ, for which a service routine will be run when a
> > corresponding event is received from the firmware.
> 
> MRQ?

I think that means "Message ReQuest", which is sort of like an IRQ but
the user will receive a message (with potentially payload) instead. Do
you want me to spell that out in the commit message, or what would you
suggest?

> > diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
> > index 92e2153e8173..e34a2f79e1ad 100644
> > --- a/drivers/firmware/tegra/Makefile
> > +++ b/drivers/firmware/tegra/Makefile
> > @@ -1 +1,2 @@
> > +obj-$(CONFIG_TEGRA_BPMP)	+= bpmp.o
> >  obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
> > diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> > new file mode 100644
> > index 000000000000..a09043b1be05
> > --- /dev/null
> > +++ b/drivers/firmware/tegra/bpmp.c
> > @@ -0,0 +1,880 @@
> > +/*
> > + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> > + * more details.
> > + */
> > +
> > +#define DEBUG
> 
> I don't think we want DEBUG by default, right?

Yes, that's left-over from debugging.

> > +static int tegra_bpmp_ping(struct tegra_bpmp *bpmp)
> > +{
> > +	struct mrq_ping_response response;
> > +	struct mrq_ping_request request;
> > +	struct tegra_bpmp_message msg;
> > +	ktime_t start, delta;
> > +	unsigned long flags;
> > +	int err;
> > +
> > +	memset(&request, 0, sizeof(request));
> > +	request.challenge = 1;
> > +
> > +	memset(&response, 0, sizeof(response));
> > +
> > +	memset(&msg, 0, sizeof(msg));
> > +	msg.mrq = MRQ_PING;
> > +	msg.tx.data = &request;
> > +	msg.tx.size = sizeof(request);
> > +	msg.rx.data = &response;
> > +	msg.rx.size = sizeof(response);
> > +
> > +	start = ktime_get();
> > +
> > +	local_irq_save(flags);
> > +	err = tegra_bpmp_transfer_atomic(bpmp, &msg);
> > +	local_irq_restore(flags);
> > +
> > +	delta = ktime_sub(ktime_get(), start);
> > +
> > +	if (!err)
> > +		dev_info(bpmp->dev,
> > +			 "ping ok: challenge: %u, response: %u, time: %lld\n",
> > +			 request.challenge, response.reply,
> > +			 ktime_to_us(delta));
> 
> Should this be a dev_dbg? I guess this only happens on probe.

I suppose you could use this anywhere else, too, just to check that the
BPMP is still responding. But yes, I think making this DEBUG level will
be enough.

> 
> > +	return err;
> > +}
> 
> [snip]
> 
> > +static int tegra_bpmp_probe(struct platform_device *pdev)
> > +{
> > +	struct tegra_bpmp_channel *channel;
> > +	struct tegra_bpmp *bpmp;
> > +	struct device_node *np;
> > +	struct resource res;
> > +	unsigned int i;
> > +	char tag[32];
> > +	size_t size;
> > +	int err;
> > +
> > +	bpmp = devm_kzalloc(&pdev->dev, sizeof(*bpmp), GFP_KERNEL);
> > +	if (!bpmp)
> > +		return -ENOMEM;
> > +
> > +	bpmp->soc = of_device_get_match_data(&pdev->dev);
> > +	bpmp->dev = &pdev->dev;
> > +
> > +	np = of_parse_phandle(pdev->dev.of_node, "shmem", 0);
> > +	if (!np)
> > +		return -ENOENT;
> > +
> > +	of_address_to_resource(np, 0, &res);
> > +	of_node_put(np);
> > +
> > +	bpmp->tx_base = devm_ioremap_resource(&pdev->dev, &res);
> > +	if (IS_ERR(bpmp->tx_base))
> > +		return PTR_ERR(bpmp->tx_base);
> > +
> > +	np = of_parse_phandle(pdev->dev.of_node, "shmem", 1);
> > +	if (!np)
> > +		return -ENOENT;
> > +
> > +	of_address_to_resource(np, 0, &res);
> > +	of_node_put(np);
> > +
> > +	bpmp->rx_base = devm_ioremap_resource(&pdev->dev, &res);
> > +	if (IS_ERR(bpmp->rx_base))
> > +		return PTR_ERR(bpmp->rx_base);
> > +
> > +	bpmp->num_channels = bpmp->soc->channels.cpu_tx.count +
> > +			     bpmp->soc->channels.thread.count +
> > +			     bpmp->soc->channels.cpu_rx.count;
> > +
> > +	bpmp->channels = devm_kcalloc(&pdev->dev, bpmp->num_channels,
> > +				      sizeof(*channel), GFP_KERNEL);
> > +	if (!bpmp->channels)
> > +		return -ENOMEM;
> > +
> > +	/* mbox registration */
> > +	bpmp->mbox.client.dev = &pdev->dev;
> > +	bpmp->mbox.client.rx_callback = tegra_bpmp_handle_rx;
> > +	bpmp->mbox.client.tx_block = false;
> > +	bpmp->mbox.client.knows_txdone = false;
> > +
> > +	bpmp->mbox.channel = mbox_request_channel(&bpmp->mbox.client, 0);
> > +	if (IS_ERR(bpmp->mbox.channel)) {
> > +		err = PTR_ERR(bpmp->mbox.channel);
> > +		dev_err(&pdev->dev, "failed to get HSP mailbox: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	/* message channel initialization */
> > +	for (i = 0; i < bpmp->num_channels; i++) {
> > +		struct tegra_bpmp_channel *channel = &bpmp->channels[i];
> > +
> > +		err = tegra_bpmp_channel_init(channel, bpmp, i);
> > +		if (err)
> > +			return err;
> > +	}
> 
> We should make sure we free the mbox if we fail after requesting it.

Yes, will do.

Thanks,
Thierry

> 
> Cheers
> Jon
> 
> -- 
> nvpublic
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/d8c5926a/attachment.sig>
