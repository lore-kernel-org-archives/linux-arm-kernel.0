From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 24 Mar 2010 14:25:35 -0700
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <e9c3a7c21003241425m595f983fg520c9cace7ddce91@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 8, 2010 at 6:52 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This patch extends the DMA engine with a PrimeCell superset with
> three functions: configure DMA channel, stop channel, and one for
> getting the number of bytes pending on a channel. These have been
> identified as the basic extensions needed to drive DMA on top of
> the PL011 and PL180 PrimeCells.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?include/linux/amba/dma.h | ? 44 ++++++++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 44 insertions(+), 0 deletions(-)
> ?create mode 100644 include/linux/amba/dma.h
>
> diff --git a/include/linux/amba/dma.h b/include/linux/amba/dma.h
> new file mode 100644
> index 0000000..13196af
> --- /dev/null
> +++ b/include/linux/amba/dma.h
> @@ -0,0 +1,44 @@
> +/*
> + * ?linux/include/amba/dma.h
> + *
> + * ?Copyright (C) 2010 ST-Ericsson AB
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#if !defined(AMBA_DMA_H) && defined(CONFIG_DMADEVICES)
> +#define AMBA_DMA_H
> +
> +/**
> + * struct amba_dma_channel_request - this struct is passed in as
> + * configuration data to a DMA engine in order to set up a certain
> + * channel for DMA transport. Anything the DMA engine needs to
> + * know about the PrimeCell shall be passed through this struct.
> + * The DMA engine has to provide an additional function:
> + * dma_set_ambaconfig() in order for it to work with PrimeCells.
> + * @addr: this is the physical address where DMA data should be
> + * read (RX) or written (TX)
> + * @addr_width: this is the width of the source (RX) or target
> + * (TX) register where DMA data shall be read/written, in bytes.
> + * legal values: 1, 2, 4, 8.
> + */
> +struct amba_dma_channel_config {
> + ? ? ? dma_addr_t addr;
> + ? ? ? u8 addr_width:4;
> +};

The usages of this seem to be constant data based off something that
comes from the platform data or 'slave' device.  Could this constant
data just be munged/merged into the platform data and we can look it
up at runtime via chan->private.  Or am I oversimplifying?

None the of the usages seem to justify forking from core dmaengine at
this point (I reserve the right to be proven wrong later).

--
Dan
