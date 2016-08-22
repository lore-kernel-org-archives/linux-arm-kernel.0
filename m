From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 22 Aug 2016 10:26:50 +0100
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160819173233.13260-6-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
Message-ID: <94227d94-1d60-fda7-731b-26656633d585@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/08/16 18:32, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Boot and Power Management Processor (BPMP) is a co-processor found
> on Tegra SoCs. It is designed to handle the early stages of the boot
> process and offload power management tasks (such as clocks, resets,
> powergates, ...) as well as system control services.
> 
> Compared to the ARM SCPI, the services provided by BPMP are message-
> based rather than method-based. The BPMP firmware driver provides the
> services to transmit data to and receive data from the BPMP. Users can
> also register an MRQ, for which a service routine will be run when a
> corresponding event is received from the firmware.

MRQ?

> A set of messages, called the BPMP ABI, are specified for a number of
> different services provided by the BPMP (such as clocks or resets).
> 
> Based on work by Sivaram Nair <sivaramn@nvidia.com> and Joseph Lo
> <josephl@nvidia.com>.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - use a message structure for transfers to avoid long function
>   prototypes
> - restructure driver for easier maintainability
> - rename bpmp_abi.h to bpmp-abi.h for consistency
> 
>  drivers/firmware/tegra/Kconfig  |   12 +
>  drivers/firmware/tegra/Makefile |    1 +
>  drivers/firmware/tegra/bpmp.c   |  880 +++++++++++++++++++++
>  include/soc/tegra/bpmp-abi.h    | 1601 +++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/bpmp.h        |  122 +++
>  5 files changed, 2616 insertions(+)
>  create mode 100644 drivers/firmware/tegra/bpmp.c
>  create mode 100644 include/soc/tegra/bpmp-abi.h
>  create mode 100644 include/soc/tegra/bpmp.h
> 
> diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
> index 1fa3e4e136a5..ff2730d5c468 100644
> --- a/drivers/firmware/tegra/Kconfig
> +++ b/drivers/firmware/tegra/Kconfig
> @@ -10,4 +10,16 @@ config TEGRA_IVC
>  	  keeps the content is synchronization between host CPU and remote
>  	  processors.
>  
> +config TEGRA_BPMP
> +	bool "Tegra BPMP driver"
> +	depends on ARCH_TEGRA && TEGRA_HSP_MBOX && TEGRA_IVC
> +	help
> +	  BPMP (Boot and Power Management Processor) is designed to off-loading
> +	  the PM functions which include clock/DVFS/thermal/power from the CPU.
> +	  It needs HSP as the HW synchronization and notification module and
> +	  IVC module as the message communication protocol.
> +
> +	  This driver manages the IPC interface between host CPU and the
> +	  firmware running on BPMP.
> +
>  endmenu
> diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
> index 92e2153e8173..e34a2f79e1ad 100644
> --- a/drivers/firmware/tegra/Makefile
> +++ b/drivers/firmware/tegra/Makefile
> @@ -1 +1,2 @@
> +obj-$(CONFIG_TEGRA_BPMP)	+= bpmp.o
>  obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> new file mode 100644
> index 000000000000..a09043b1be05
> --- /dev/null
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -0,0 +1,880 @@
> +/*
> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#define DEBUG

I don't think we want DEBUG by default, right?

> +#include <linux/clk/tegra.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/semaphore.h>

[snip]

> +static int tegra_bpmp_ping(struct tegra_bpmp *bpmp)
> +{
> +	struct mrq_ping_response response;
> +	struct mrq_ping_request request;
> +	struct tegra_bpmp_message msg;
> +	ktime_t start, delta;
> +	unsigned long flags;
> +	int err;
> +
> +	memset(&request, 0, sizeof(request));
> +	request.challenge = 1;
> +
> +	memset(&response, 0, sizeof(response));
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq = MRQ_PING;
> +	msg.tx.data = &request;
> +	msg.tx.size = sizeof(request);
> +	msg.rx.data = &response;
> +	msg.rx.size = sizeof(response);
> +
> +	start = ktime_get();
> +
> +	local_irq_save(flags);
> +	err = tegra_bpmp_transfer_atomic(bpmp, &msg);
> +	local_irq_restore(flags);
> +
> +	delta = ktime_sub(ktime_get(), start);
> +
> +	if (!err)
> +		dev_info(bpmp->dev,
> +			 "ping ok: challenge: %u, response: %u, time: %lld\n",
> +			 request.challenge, response.reply,
> +			 ktime_to_us(delta));

Should this be a dev_dbg? I guess this only happens on probe.

> +	return err;
> +}

[snip]

> +static int tegra_bpmp_probe(struct platform_device *pdev)
> +{
> +	struct tegra_bpmp_channel *channel;
> +	struct tegra_bpmp *bpmp;
> +	struct device_node *np;
> +	struct resource res;
> +	unsigned int i;
> +	char tag[32];
> +	size_t size;
> +	int err;
> +
> +	bpmp = devm_kzalloc(&pdev->dev, sizeof(*bpmp), GFP_KERNEL);
> +	if (!bpmp)
> +		return -ENOMEM;
> +
> +	bpmp->soc = of_device_get_match_data(&pdev->dev);
> +	bpmp->dev = &pdev->dev;
> +
> +	np = of_parse_phandle(pdev->dev.of_node, "shmem", 0);
> +	if (!np)
> +		return -ENOENT;
> +
> +	of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +
> +	bpmp->tx_base = devm_ioremap_resource(&pdev->dev, &res);
> +	if (IS_ERR(bpmp->tx_base))
> +		return PTR_ERR(bpmp->tx_base);
> +
> +	np = of_parse_phandle(pdev->dev.of_node, "shmem", 1);
> +	if (!np)
> +		return -ENOENT;
> +
> +	of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +
> +	bpmp->rx_base = devm_ioremap_resource(&pdev->dev, &res);
> +	if (IS_ERR(bpmp->rx_base))
> +		return PTR_ERR(bpmp->rx_base);
> +
> +	bpmp->num_channels = bpmp->soc->channels.cpu_tx.count +
> +			     bpmp->soc->channels.thread.count +
> +			     bpmp->soc->channels.cpu_rx.count;
> +
> +	bpmp->channels = devm_kcalloc(&pdev->dev, bpmp->num_channels,
> +				      sizeof(*channel), GFP_KERNEL);
> +	if (!bpmp->channels)
> +		return -ENOMEM;
> +
> +	/* mbox registration */
> +	bpmp->mbox.client.dev = &pdev->dev;
> +	bpmp->mbox.client.rx_callback = tegra_bpmp_handle_rx;
> +	bpmp->mbox.client.tx_block = false;
> +	bpmp->mbox.client.knows_txdone = false;
> +
> +	bpmp->mbox.channel = mbox_request_channel(&bpmp->mbox.client, 0);
> +	if (IS_ERR(bpmp->mbox.channel)) {
> +		err = PTR_ERR(bpmp->mbox.channel);
> +		dev_err(&pdev->dev, "failed to get HSP mailbox: %d\n", err);
> +		return err;
> +	}
> +
> +	/* message channel initialization */
> +	for (i = 0; i < bpmp->num_channels; i++) {
> +		struct tegra_bpmp_channel *channel = &bpmp->channels[i];
> +
> +		err = tegra_bpmp_channel_init(channel, bpmp, i);
> +		if (err)
> +			return err;
> +	}

We should make sure we free the mbox if we fail after requesting it.

Cheers
Jon

-- 
nvpublic
