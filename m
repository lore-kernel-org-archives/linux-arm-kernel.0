From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 13:54:21 +0000
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180
In-Reply-To: <20101219195959.GA28157@n2100.arm.linux.org.uk>
References: <1286358159-6994-1-git-send-email-linus.walleij@stericsson.com>
	<20101219163240.GA27929@n2100.arm.linux.org.uk>
	<20101219195959.GA28157@n2100.arm.linux.org.uk>
Message-ID: <20101221135421.GS28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 07:59:59PM +0000, Russell King - ARM Linux wrote:
> +static void mmci_dma_data_end(struct mmci_host *host)
> +{
> +	struct mmc_data *data = host->data;
> +
> +	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,

Note that when using a separate DMA agent to the targetted device, the
struct device appropriate for performing the mapping is the DMA agent
itself, not the targetted device.

That's because the memory which is addressible by DMA is determined by
the DMA agent rather than the device.  It's much the same idea as a USB
bus device submitting buffers needs to map them using the USB _host_
device, rather than its own struct device.

IOW, dma_chan->device->dev, not mmc_dev(host->mmc).

Same goes for other primecell drivers.  I'll update this patch later today
for that.
