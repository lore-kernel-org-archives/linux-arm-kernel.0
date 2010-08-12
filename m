From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Aug 2010 15:30:02 +0100
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180 v10
In-Reply-To: <AANLkTimriY-NerBUBeuPf_qX_01iZvntH3TMVdkn7wJv@mail.gmail.com>
References: <1281454328-22805-1-git-send-email-linus.walleij@stericsson.com>
	<20100811144859.GC5846@debian>
	<AANLkTimriY-NerBUBeuPf_qX_01iZvntH3TMVdkn7wJv@mail.gmail.com>
Message-ID: <20100812143002.GA31982@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 03:58:08PM +0200, Linus Walleij wrote:
> 2010/8/11 Rabin Vincent <rabin@rab.in>:
> >> + ? ? sglen = dma_map_sg(mmc_dev(host->mmc), data->sg,
> >> + ? ? ? ? ? ? ? ? ? ? ? ?data->sg_len, direction);
> >> + ? ? if (sglen != data->sg_len)
> >> + ? ? ? ? ? ? goto unmap_exit;
> >
> > sglen < data->sg_len is not an error condition.
> 
> In arch/arm/mm/dma-mapping.c
> dma_map_sg() returns 0 on a mapping error, and the same as
> passed in the third parameter on success.

Rabin is right - dma_map_sg() is allowed to return fewer entries than
was passed as it is allowed to coalesce entries together.  Please don't
use the implementation as a source of how things should behave, instead
read the documentation in Documentation/DMA-API.txt:

        int
        dma_map_sg(struct device *dev, struct scatterlist *sg,
                int nents, enum dma_data_direction direction)

Returns: the number of physical segments mapped (this may be shorter
than <nents> passed in if some elements of the scatter/gather list are
physically or virtually adjacent and an IOMMU maps them with a single
entry).
