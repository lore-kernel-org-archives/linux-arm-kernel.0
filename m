From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 22 Aug 2016 11:46:49 +0100
Subject: [PATCH v3 04/12] firmware: tegra: Add IVC library
In-Reply-To: <20160819173233.13260-5-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-5-thierry.reding@gmail.com>
Message-ID: <90222c3a-7c69-6fa3-d161-4ed0c5759f34@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/08/16 18:32, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Inter-VM communication (IVC) is a communication protocol which is
> designed for interprocessor communication (IPC) or the communication
> between the hypervisor and the virtual machine with a guest OS.
> 
> Message channels are used to communicate between processors. They are
> backed by DRAM or SRAM, so care must be taken to maintain coherence of
> data.
> 
> The IVC library maintains memory-based descriptors for the transmission
> and reception channels as well as the data coherence of the counter and
> payload. Clients, such as the driver for the BPMP firmware, can use the
> library to exchange messages with remote processors.
> 
> Based on work by Peter Newman <pnewman@nvidia.com> and Joseph Lo
> <josephl@nvidia.com>.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - use a more object oriented design
> 
>  drivers/firmware/Kconfig        |   1 +
>  drivers/firmware/Makefile       |   1 +
>  drivers/firmware/tegra/Kconfig  |  13 +
>  drivers/firmware/tegra/Makefile |   1 +
>  drivers/firmware/tegra/ivc.c    | 683 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/ivc.h         | 109 +++++++
>  6 files changed, 808 insertions(+)
>  create mode 100644 drivers/firmware/tegra/Kconfig
>  create mode 100644 drivers/firmware/tegra/Makefile
>  create mode 100644 drivers/firmware/tegra/ivc.c
>  create mode 100644 include/soc/tegra/ivc.h

[snip]

> +static void *tegra_ivc_frame_virt(struct tegra_ivc *ivc,
> +				  struct tegra_ivc_header *header,
> +				  unsigned int frame)
> +{
> +	BUG_ON(frame >= ivc->num_frames);

WARN_ON and return an error pointer?

> +
> +	return (void *)(header + 1) + ivc->frame_size * frame;
> +}
> +
> +static inline dma_addr_t tegra_ivc_frame_phys(struct tegra_ivc *ivc,
> +					      dma_addr_t phys,
> +					      unsigned int frame)
> +{
> +	unsigned long offset;
> +
> +	BUG_ON(!ivc->peer);
> +	BUG_ON(frame >= ivc->num_frames);

WARN_ON?

> +
> +	offset = sizeof(struct tegra_ivc_header) + ivc->frame_size * frame;
> +
> +	return phys + offset;
> +}

[snip]

> +static int check_ivc_params(unsigned long base1, unsigned long base2,
> +			    unsigned int num_frames, size_t frame_size)
> +{
> +	BUG_ON(offsetof(struct tegra_ivc_header, tx.count) & (TEGRA_IVC_ALIGN - 1));
> +	BUG_ON(offsetof(struct tegra_ivc_header, rx.count) & (TEGRA_IVC_ALIGN - 1));
> +	BUG_ON(sizeof(struct tegra_ivc_header) & (TEGRA_IVC_ALIGN - 1));

WARN_ON?

> +	if ((uint64_t)num_frames * (uint64_t)frame_size >= 0x100000000) {
> +		pr_err("num_frames * frame_size overflows\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The headers must at least be aligned enough for counters
> +	 * to be accessed atomically.
> +	 */
> +	if (base1 & (TEGRA_IVC_ALIGN - 1)) {
> +		pr_err("IVC channel start not aligned: %lx\n", base1);
> +		return -EINVAL;
> +	}
> +
> +	if (base2 & (TEGRA_IVC_ALIGN - 1)) {
> +		pr_err("IVC channel start not aligned: %lx\n", base2);
> +		return -EINVAL;
> +	}
> +
> +	if (frame_size & (TEGRA_IVC_ALIGN - 1)) {
> +		pr_err("frame size not adequately aligned: %zu\n", frame_size);
> +		return -EINVAL;
> +	}
> +
> +	if (base1 < base2) {
> +		if (base1 + frame_size * num_frames > base2) {
> +			pr_err("queue regions overlap: %lx + %zx, %zx\n",
> +			       base1, frame_size, frame_size * num_frames);
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (base2 + frame_size * num_frames > base1) {
> +			pr_err("queue regions overlap: %lx + %zx, %zx\n",
> +			       base2, frame_size, frame_size * num_frames);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int tegra_ivc_init(struct tegra_ivc *ivc, struct device *peer,
> +		   void __iomem *rx_virt, dma_addr_t rx_phys,
> +		   void __iomem *tx_virt, dma_addr_t tx_phys,
> +		   unsigned int num_frames, size_t frame_size,
> +		   void (*notify)(struct tegra_ivc *ivc, void *data),
> +		   void *data)
> +{
> +	size_t queue_size;
> +	int err;
> +
> +	err = check_ivc_params((unsigned long)rx_virt, (unsigned long)tx_virt,
> +			       num_frames, frame_size);
> +	if (err < 0)
> +		return err;
> +
> +	BUG_ON(!ivc);
> +	BUG_ON(!notify);

We should check this first and just return -EINVAL.

> +	queue_size = tegra_ivc_total_queue_size(num_frames * frame_size);
> +
> +	/*
> +	 * All sizes that can be returned by communication functions should
> +	 * fit in an int.
> +	 */
> +	if (frame_size > INT_MAX)
> +		return -E2BIG;
> +
> +	ivc->rx.channel = (struct tegra_ivc_header *)rx_virt;
> +	ivc->tx.channel = (struct tegra_ivc_header *)tx_virt;
> +
> +	if (peer) {
> +		if (rx_phys != DMA_ERROR_CODE) {
> +			ivc->rx.phys = rx_phys;
> +			ivc->tx.phys = tx_phys;
> +		} else {
> +			ivc->rx.phys = dma_map_single(peer, ivc->rx.channel,
> +						      queue_size,
> +						      DMA_BIDIRECTIONAL);
> +			if (ivc->rx.phys == DMA_ERROR_CODE)
> +				return -ENOMEM;
> +
> +			ivc->tx.phys = dma_map_single(peer, ivc->tx.channel,
> +						      queue_size,
> +						      DMA_BIDIRECTIONAL);
> +			if (ivc->tx.phys == DMA_ERROR_CODE) {
> +				dma_unmap_single(peer, ivc->rx.phys,
> +						 queue_size,
> +						 DMA_BIDIRECTIONAL);
> +				return -ENOMEM;
> +			}
> +		}
> +	}
> +
> +	ivc->peer = peer;
> +	ivc->notify = notify;
> +	ivc->notify_data = data;
> +	ivc->frame_size = frame_size;
> +	ivc->num_frames = num_frames;
> +
> +	/*
> +	 * These values aren't necessarily correct until the channel has been
> +	 * reset.
> +	 */
> +	ivc->tx.position = 0;
> +	ivc->rx.position = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tegra_ivc_init);
> diff --git a/include/soc/tegra/ivc.h b/include/soc/tegra/ivc.h
> new file mode 100644
> index 000000000000..af9a54a54e45
> --- /dev/null
> +++ b/include/soc/tegra/ivc.h
> @@ -0,0 +1,109 @@
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
> +#ifndef __TEGRA_IVC_H
> +
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/types.h>
> +
> +struct tegra_ivc_header;
> +
> +struct tegra_ivc {
> +	struct device *peer;
> +
> +	struct {
> +		struct tegra_ivc_header *channel;
> +		dma_addr_t phys;
> +		u32 position;
> +	} rx, tx;
> +
> +	void (*notify)(struct tegra_ivc *ivc, void *data);
> +	void *notify_data;
> +
> +	unsigned int num_frames;
> +	size_t frame_size;
> +};
> +
> +/**
> + * tegra_ivc_read_get_next_frame - Peek at the next frame to receive
> + * @ivc		pointer of the IVC channel
> + *
> + * Peek at the next frame to be received, without removing it from
> + * the queue.
> + *
> + * Returns a pointer to the frame, or an error encoded pointer.
> + */
> +void *tegra_ivc_read_get_next_frame(struct tegra_ivc *ivc);

Is it odd to return a void * pointer here and not a pointer to a
specific structure type?

> +/**
> + * tegra_ivc_read_advance - Advance the read queue
> + * @ivc		pointer of the IVC channel
> + *
> + * Advance the read queue
> + *
> + * Returns 0, or a negative error value if failed.
> + */
> +int tegra_ivc_read_advance(struct tegra_ivc *ivc);
> +
> +/**
> + * tegra_ivc_write_get_next_frame - Poke at the next frame to transmit
> + * @ivc		pointer of the IVC channel
> + *
> + * Get access to the next frame.
> + *
> + * Returns a pointer to the frame, or an error encoded pointer.
> + */
> +void *tegra_ivc_write_get_next_frame(struct tegra_ivc *ivc);

Same here.

Cheers
Jon

-- 
nvpublic
