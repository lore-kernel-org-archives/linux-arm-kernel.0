From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 May 2014 11:40:38 +0200
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <536806F4.1090904@ti.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <CAL_Jsq+nh26NZXx-9Y5FTxWZdVrG7aLTOBhC4j9P8mPPvUu2ag@mail.gmail.com>
 <536806F4.1090904@ti.com>
Message-ID: <7182186.5Q53eQg77F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 May 2014 17:47:32 Santosh Shilimkar wrote:

> +       dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +       if (!dev->dma_mask)
> +               dev->dma_mask = &dev->coherent_dma_mask;
> +
> +       /*
> +        * if dma-ranges property doesn't exist - just return else
> +        * setup the dma offset
> +        */
> +       ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> +       if (ret < 0) {
> +               dev_dbg(dev, "no dma range information to setup\n");
> +               return;
> +       }
> +
> +       /* DMA ranges found. Calculate and set dma_pfn_offset */
> +       dev->dma_pfn_offset = PFN_DOWN(paddr - dma_addr);
> +       dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> +}

I think there should at least be a comment about why we are computing
the correct DMA mask here and then ignore that and just use DMA_BIT_MASK(32)
instead. I understand that Russell and Rob prefer it that way and I'm not
going to argue, but I find it counterintuitive and I think it deserves
an explanation in the source code for anybody who is trying to figure
out how things fit together.

	Arnd
