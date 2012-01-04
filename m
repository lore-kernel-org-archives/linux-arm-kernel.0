From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 4 Jan 2012 14:08:35 -0800
Subject: [PATCH 2/9] arm/tegra: use APB DMA for accessing APB devices
In-Reply-To: <1324599468-12845-3-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
 <1324599468-12845-3-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17761F14F6@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, December 22, 2011 5:18 PM:
> Tegra2 hangs if APB registers are accessed from the cpu during an
> apb dma operation. The workaround is to use apb dma to read/write the
> registers instead.
...
> diff --git a/arch/arm/mach-tegra/apbio.c b/arch/arm/mach-tegra/apbio.c
...
> +bool tegra_apb_init(void)
> +{
...
> +out:
> +	mutex_unlock(&tegra_apb_dma_lock);
> +	return true;
> +
> +out_fail:
> +	mutex_unlock(&tegra_apb_dma_lock);
> +	return true;

Presumably that should be "return false".

> +u32 tegra_apb_readl(unsigned long offset)
> +{
> +	struct tegra_dma_req req;
> +	int ret;
> +
> +	if (!tegra_apb_dma && !tegra_apb_init())
> +		return readl(IO_TO_VIRT(offset));
> +
> +	mutex_lock(&tegra_apb_dma_lock);
> +	req.complete = apb_dma_complete;
> +	req.to_memory = 1;
> +	req.dest_addr = tegra_apb_bb_phys;
> +	req.dest_bus_width = 32;
> +	req.dest_wrap = 1;
> +	req.source_addr = offset;
> +	req.source_bus_width = 32;
> +	req.source_wrap = 4;
> +	req.req_sel = 0;

Should that be TEGRA_DMA_REQ_SEL_CNTR instead of 0? Although I'm not
sure what "CNTR" means, and the documentation doesn't seem to say.

> +	req.size = 4;
> +
> +	INIT_COMPLETION(tegra_apb_wait);
> +
> +	tegra_dma_enqueue_req(tegra_apb_dma, &req);
> +
> +	ret = wait_for_completion_timeout(&tegra_apb_wait,
> +		msecs_to_jiffies(50));
> +
> +	if (WARN(ret == 0, "apb read dma timed out"))
> +		*(u32 *)tegra_apb_bb = 0;

On failure, you should probably call tegra_dma_dequeue_req() to cancel
the DMA request, otherwise (a) it'll wake up and trash some future
transfer, or (b) it'll be in the queue forever, and prevent any future
DMA requests from being programmed into HW.

Those two comments repeated from tegra_apb_writel().

-- 
nvpublic
