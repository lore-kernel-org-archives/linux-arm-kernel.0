From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 1 Sep 2011 11:57:36 +0200
Subject: [PATCH 1/3] add dma_coherent_write_sync to DMA API
In-Reply-To: <1314826214-22428-2-git-send-email-msalter@redhat.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-2-git-send-email-msalter@redhat.com>
Message-ID: <CAHXqBFJ6tEkn+iW3ZBAiWu5Sx9y9MQdnJt5Gfnv5Xc3UB78uLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/31 Mark Salter <msalter@redhat.com>:
> On ARMv6/7 DMA-coherent memory is bufferable which means that CPU writes to
> coherent memory may still be held in a write buffer for a significant amount
> of time. This is largely mitigated by having the MMIO write functions force
> a write buffer flush before doing the actual write to the MMIO register. This
> forces out previous CPU writes to coherent memory for drivers which write to
> a register to inform the device that something was written to memory. However,
> this does not mitigate the problem for devices which poll the DMA memory for
> changes written by the CPU. One such case was found by ming.lei at canonical.com
> in the USB EHCI driver. The EHCI host controller relies at least partly on
> polling DMA coherent memory for information from the driver.
>
> This patch adds a dma_coherent_write_sync() function to the DMA API which
> drivers can use to explicitly force out data which may otherwise be held up
> in a write buffer. It is a no-op unless and architecture provides its own
> version or the function and sets ARCH_HAS_DMA_COHERENT_WRITE_SYNC.
[...]
> --- a/Documentation/DMA-API.txt
> +++ b/Documentation/DMA-API.txt
> @@ -418,6 +418,18 @@ void whizco_dma_map_sg_attrs(struct device *dev, dma_addr_t dma_addr,
> ? ? ? ?....
>
>
> +Part Ie - Write buffering to dma-coherent memory
> +------------------------------------------------
> +
> +Some architectures supporting DMA coherent memory may have write
> +buffering between the CPU and DMA memory. This buffering may delay
> +CPU writes from reaching coherent memory in a timely manner.
> +
> + ? ?void
> + ? ?dma_coherent_write_sync()
> +
> +Force any outstanding coherent writes to memory.

This should be merged or referenced in part Ia.

BTW, if there's no time limit on write buffers flushing, or if write
buffers can cause reordering of the writes, then the memory accesses
need to be managed just like non-DMA-coherent memory. So what differs
then in DMA-coherent vs non-DMA-coherent mappings then?

Best Regards,
Micha? Miros?aw
