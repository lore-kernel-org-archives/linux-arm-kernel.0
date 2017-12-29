From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 29 Dec 2017 15:12:25 +0100
Subject: [PATCH 27/67] dma-direct: add dma address sanity checks
In-Reply-To: <20171229081911.2802-28-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-28-hch@lst.de>
Message-ID: <CAMuHMdWg3PnTXezMCcr3oGf-83-cjvcj4wGiPk7j2pY1Tgzo9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> Roughly based on the x86 pci-nommu implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/lib/dma-direct.c
> +++ b/lib/dma-direct.c
> @@ -9,6 +9,24 @@
>  #include <linux/scatterlist.h>
>  #include <linux/pfn.h>
>
> +#define DIRECT_MAPPING_ERROR           0
> +
> +static bool
> +check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> +               const char *caller)
> +{
> +       if (unlikely(dev && !dma_capable(dev, dma_addr, size))) {
> +               if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
> +                       dev_err(dev,
> +                               "%s: overflow %llx+%zu of device mask %llx\n",

Please use "%pad" to format dma_addr_t ...

> +                               caller, (long long)dma_addr, size,

... and use &dma_addr.

> +                               (long long)*dev->dma_mask);

This cast is not needed, as u64 is unsigned long long in kernelspace on
all architectures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
