From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jun 2011 11:23:59 +0200
Subject: Dynamic patching in discarded sections
Message-ID: <201106081123.59414.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been playing with randconfig builds and found an interesting problem
with the combination of:

CONFIG_ARM_PATCH_PHYS_VIRT=y
CONFIG_HOTPLUG=n
CONFIG_DMABOUNCE=n
CONFIG_MMC_SPI=y

The problem is shown with this code:

static int __devexit mmc_spi_remove(struct spi_device *spi)
{
	...   
                        dma_unmap_single(host->dma_dev, host->ones_dma,
                                MMC_SPI_BLOCKSIZE, DMA_TO_DEVICE);
                        dma_unmap_single(host->dma_dev, host->data_dma,
                                sizeof(*host->data), DMA_BIDIRECTIONAL);
	...
}

and the error message (in case someone looks for this using google) is

`.devexit.text' referenced in section `.pv_table' of drivers/built-in.o: defined in discarded section `.devexit.text' of drivers/built-in.o
`.devexit.text' referenced in section `.pv_table' of drivers/built-in.o: defined in discarded section `.devexit.text' of drivers/built-in.o

What happens is that dma_unmap_single() calls
 __dma_single_dev_to_cpu(dma_to_virt(dev, handle), size, dir), which requires
patching in the caller. However, due to CONFIG_HOTPLUG being disabled, the
__devexit section gets discarded, and the linker cannot create an entry in the
.pvtable section for the mmc_spi_remove function.

I don't know if the same problem exists in other places in the code, but it's
entirely possible. I also couldn't think of a good solution for this, short of
moving the definition of dma_unmap_single() to out of line code.

	Arnd
