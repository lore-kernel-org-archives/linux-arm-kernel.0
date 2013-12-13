From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 13 Dec 2013 17:02:58 +0100
Subject: [PATCH v14] dmaengine: Add MOXA ART DMA engine driver
In-Reply-To: <1386851534-11288-1-git-send-email-jonas.jensen@gmail.com>
References: <1386774824-1638-1-git-send-email-jonas.jensen@gmail.com>
 <1386851534-11288-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <52AB2FB2.7000009@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 01:32 PM, Jonas Jensen wrote:
> The MOXA ART SoC has a DMA controller capable of offloading expensive
> memory operations, such as large copies. This patch adds support for
> the controller including four channels. Two of these are used to
> handle MMC copy on the UC-7112-LX hardware. The remaining two can be
> used in a future audio driver or client application.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
> ---
[...]
> +static size_t moxart_dma_desc_size_in_flight(struct moxart_chan *ch)
> +{
> +	size_t size;
> +	unsigned int completed_cycles, cycles, i;
> +
> +	for (size = i = 0; i <= ch->sgidx; i++)
> +		size += ch->desc->sg[i].len;

This still does not look right. The residue is the amount of data that still
needs to be transferred, so you need to count the the segments that have not
been completed yet. Just like I wrote in the last mail loop from ch->sgidx
to ch->desc->sglen.

> +	cycles = readl(ch->base + REG_OFF_CYCLES);
> +	completed_cycles = (ch->desc->dma_cycles - cycles);
> +	size -= completed_cycles << es_bytes[ch->desc->es];
> +
> +	dev_dbg(chan2dev(&ch->vc.chan), "%s: size=%zu\n", __func__, size);
> +
> +	return size;
> +}
[...]
