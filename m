From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 24 Aug 2016 16:13:03 +0100
Subject: [PATCH v3 04/12] firmware: tegra: Add IVC library
In-Reply-To: <20160819173233.13260-5-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-5-thierry.reding@gmail.com>
Message-ID: <85939406-a680-9d10-0a7e-1536ae841f84@nvidia.com>
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

> +static int check_ivc_params(unsigned long base1, unsigned long base2,
> +			    unsigned int num_frames, size_t frame_size)
> +{
> +	BUG_ON(offsetof(struct tegra_ivc_header, tx.count) & (TEGRA_IVC_ALIGN - 1));
> +	BUG_ON(offsetof(struct tegra_ivc_header, rx.count) & (TEGRA_IVC_ALIGN - 1));
> +	BUG_ON(sizeof(struct tegra_ivc_header) & (TEGRA_IVC_ALIGN - 1));
> +
> +	if ((uint64_t)num_frames * (uint64_t)frame_size >= 0x100000000) {
> +		pr_err("num_frames * frame_size overflows\n");
> +		return -EINVAL;
> +	}

This generates the following sparse warning ...

drivers/firmware/tegra/ivc.c:574:60: warning: constant 0x100000000 is so
big it is long

I think we need to append a UL.

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
> +
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

And these generate the sparse warnings ...

drivers/firmware/tegra/ivc.c:642:28: warning: cast removes address space
of expression
drivers/firmware/tegra/ivc.c:643:28: warning: cast removes address space
of expression

Cheers
Jon

-- 
nvpublic
