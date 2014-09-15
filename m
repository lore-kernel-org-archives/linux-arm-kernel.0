From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Sep 2014 18:47:22 +0200
Subject: [PATCH v4 1/2] dma: at_xdmac: creation of the atmel eXtended DMA
 Controller driver
In-Reply-To: <1410792622-22621-2-git-send-email-ludovic.desroches@atmel.com>
References: <1410792622-22621-1-git-send-email-ludovic.desroches@atmel.com>
 <1410792622-22621-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <201409151847.22686.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 September 2014, Ludovic Desroches wrote:
>  
> +config AT_XDMAC
> +	tristate "Atmel XDMA support"
> +	depends on ARCH_AT91
> +	select DMA_ENGINE
> +	help
> +	  Support the Atmel XDMA controller.

This should depend on (ARCH_AT91 || COMPILE_TEST) and built on x86 to
get into the usual automated build checkers.

> +static struct dma_chan *at_xdmac_xlate(struct of_phandle_args *dma_spec,
> +				       struct of_dma *of_dma)
> +{
> +	struct at_xdmac		*atxdmac = of_dma->of_dma_data;
> +	struct at_xdmac_chan	*atchan;
> +	struct dma_chan		*chan;
> +	struct device		*dev = atxdmac->dma.dev;
> +	dma_cap_mask_t 		mask;
> +
> +	if (dma_spec->args_count != 2) {
> +		dev_err(dev, "dma phandler args: bad number of args\n");
> +		return NULL;
> +	}
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);

The mask is unused, just remove it.

> +	chan = dma_get_any_slave_channel(&atxdmac->dma);
> +	if (!chan) {
> +		dev_err(dev, "can't get a dma channel\n");
> +		return NULL;
> +	}
> +
> +	atchan = to_at_xdmac_chan(chan);
> +	atchan->memif = AT91_XDMAC_DT_GET_MEM_IF(dma_spec->args[0]);
> +	atchan->perif = AT91_XDMAC_DT_GET_PER_IF(dma_spec->args[0]);
> +	atchan->perid = AT91_XDMAC_DT_GET_PERID(dma_spec->args[1]);
> +	dev_info(dev, "chan dt cfg: memif=%u perif=%u perid=%u\n",
> +		 atchan->memif, atchan->perif, atchan->perid);

Maybe dev_dbg instead of dev_info?

I think having three cells would be nicer here, so you can get rid of the
macros.
> diff --git a/drivers/dma/at_xdmac.h b/drivers/dma/at_xdmac.h
> new file mode 100644
> index 0000000..5f4d898
> --- /dev/null
> +++ b/drivers/dma/at_xdmac.h

The header is only used in one file, so just move the contents into that file.

> +
> +static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
> +{
> +	return (void __iomem *)(atxdmac->regs + (AT_XDMAC_CHAN_REG_BASE + chan_nb * 0x40));
> +}

That type cast should not be needed. Is atxdmac->regs not already a void __iomem *

> +#define at_xdmac_read(atxdmac, reg) readl_relaxed((atxdmac)->regs + (reg))
> +#define at_xdmac_write(atxdmac, reg, value) \
> +	writel_relaxed((value), (atxdmac)->regs + (reg))
> +
> +#define at_xdmac_chan_read(atchan, reg) readl_relaxed((atchan)->ch_regs + (reg))
> +#define at_xdmac_chan_write(atchan, reg, value) writel_relaxed((value), (atchan)->ch_regs + (reg))

Is writel_relaxed the right accessor here? I haven't reviewed all uses of this,
but you have to ensure that every use that needs synchronization against the
actual DMA has explicit barriers here.
(0x2 << AT91_DMA_CFG_FIFOCFG_OFFSET)	/* single AHB access */
>  
> +
> +/* ---------- XDMAC ---------- */
> +#define AT91_XDMAC_DT_MEM_IF_MASK	(0x1)
> +#define AT91_XDMAC_DT_MEM_IF_OFFSET	(16)
> +#define AT91_XDMAC_DT_MEM_IF(mem_if)	(((mem_if) & AT91_XDMAC_DT_MEM_IF_MASK) \
> +					<< AT91_XDMAC_DT_MEM_IF_OFFSET)
> +#define AT91_XDMAC_DT_GET_MEM_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_MEM_IF_OFFSET) \
> +					& AT91_XDMAC_DT_MEM_IF_MASK)
> +
> +#define AT91_XDMAC_DT_PER_IF_MASK	(0x1)
> +#define AT91_XDMAC_DT_PER_IF_OFFSET	(0)
> +#define AT91_XDMAC_DT_PER_IF(per_if)	(((per_if) & AT91_XDMAC_DT_PER_IF_MASK) \
> +					<< AT91_XDMAC_DT_PER_IF_OFFSET)
> +#define AT91_XDMAC_DT_GET_PER_IF(cfg)	(((cfg) >> AT91_XDMAC_DT_PER_IF_OFFSET) \
> +					& AT91_XDMAC_DT_PER_IF_MASK)
> +
> +#define AT91_XDMAC_DT_PERID_MASK	(0x7f)
> +#define AT91_XDMAC_DT_PERID_OFFSET	(24)
> +#define AT91_XDMAC_DT_PERID(perid)	(((perid) & AT91_XDMAC_DT_PERID_MASK) \
> +					<< AT91_XDMAC_DT_PERID_OFFSET)
> +#define AT91_XDMAC_DT_GET_PERID(cfg)	(((cfg) >> AT91_XDMAC_DT_PERID_OFFSET) \
> +					& AT91_XDMAC_DT_PERID_MASK)

As mentioned, I think it would be much better to keep the macros inside of the
driver and not visible to the binding, so you can use simple numbers in DT.

	Arnd
