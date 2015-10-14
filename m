From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Oct 2015 16:46:15 +0530
Subject: [PATCH v2 2/4] dmaengine: Add STM32 DMA driver
In-Reply-To: <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
References: <1444745127-1105-1-git-send-email-cedric.madianga@gmail.com>
 <1444745127-1105-3-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20151014111615.GR27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 04:05:25PM +0200, M'boumba Cedric Madianga wrote:
> +#define STM32_DMA_LISR			0x0000 /* DMA Low Int Status Reg */
> +#define STM32_DMA_HISR			0x0004 /* DMA High Int Status Reg */
> +#define STM32_DMA_LIFCR			0x0008 /* DMA Low Int Flag Clear Reg */
> +#define STM32_DMA_HIFCR			0x000c /* DMA High Int Flag Clear Reg */
> +#define STM32_DMA_TCI			BIT(5) /* Transfer Complete Interrupt */
> +#define STM32_DMA_HTI			BIT(4) /* Half Transfer Interrupt */
> +#define STM32_DMA_TEI			BIT(3) /* Transfer Error Interrupt */
> +#define STM32_DMA_DMEI			BIT(2) /* Direct Mode Error Interrupt */
> +#define STM32_DMA_FEI			BIT(0) /* FIFO Error Interrupt */

Why not use BIT() for everything here and make it consistent

Also where ever possible stick to 80 char limit like above you can

> +
> +/* DMA Stream x Configuration Register */
> +#define STM32_DMA_SCR(x)		(0x0010 + 0x18 * (x)) /* x = 0..7 */
> +#define STM32_DMA_SCR_REQ(n)		((n & 0x7) << 25)

this and below looks ugly and hard to maintain, are you sure spec doesn't
have a formulae for these?

> +static inline uint32_t stm32_dma_read(struct stm32_dma_device *dmadev, u32 reg)

this and few other could be made more readable

> +static struct stm32_dma_desc *stm32_dma_alloc_desc(unsigned int num_sgs)
> +{
> +	return kzalloc(sizeof(struct stm32_dma_desc) +
> +		       sizeof(struct stm32_dma_sg_req) * num_sgs, GFP_ATOMIC);

Not GFP_NOWAIT ?

> +static enum stm32_dma_width stm32_get_dma_width(struct stm32_dma_chan *chan,
> +						enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		return STM32_DMA_BYTE;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		return STM32_DMA_HALF_WORD;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return STM32_DMA_WORD;
> +	default:
> +		dev_warn(chan2dev(chan),
> +			 "Dma bus width not supported, using 32bits\n");
> +		return STM32_DMA_WORD;

pls return error here
Assuming wrong parameter can cause havoc of transfer, so is not advisable

> +static enum stm32_dma_burst_size stm32_get_dma_burst(
> +		struct stm32_dma_chan *chan, u32 maxburst)
> +{
> +	switch (maxburst) {
> +	case 0:
> +	case 1:
> +		return STM32_DMA_BURST_SINGLE;
> +	case 4:
> +		return STM32_DMA_BURST_INCR4;
> +	case 8:
> +		return STM32_DMA_BURST_INCR8;
> +	case 16:
> +		return STM32_DMA_BURST_INCR16;
> +	default:
> +		dev_warn(chan2dev(chan),
> +			 "Dma burst size not supported, using single\n");
> +		return STM32_DMA_BURST_SINGLE;

here too

> +	}
> +}
> +
> +static int stm32_dma_slave_config(struct dma_chan *c,
> +				  struct dma_slave_config *config)
> +{
> +	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
> +
> +	if (chan->busy) {
> +		dev_err(chan2dev(chan), "Configuration not allowed\n");
> +		return -EBUSY;
> +	}

That is false condition. This configuration should be used for next
descriptor prepare

> +static int stm32_dma_disable_chan(struct stm32_dma_chan *chan)
> +{
> +	struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
> +	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> +	u32 dma_scr;
> +
> +	dma_scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
> +	if (dma_scr & STM32_DMA_SCR_EN) {
> +		dma_scr &= ~STM32_DMA_SCR_EN;
> +		stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
> +
> +		do {
> +			dma_scr = stm32_dma_read(dmadev,
> +						 STM32_DMA_SCR(chan->id));
> +			dma_scr &= STM32_DMA_SCR_EN;
> +			if (!dma_scr)
> +				break;

empty line here would improve readability

> +static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
> +{
> +	struct stm32_dma_chan *chan = devid;
> +	struct stm32_dma_device *dmadev = stm32_dma_chan_get_dev(chan);
> +	u32 status, scr, sfcr;
> +
> +	spin_lock(&chan->vchan.lock);
> +
> +	status = stm32_dma_irq_status(chan);
> +	scr = stm32_dma_read(dmadev, STM32_DMA_SCR(chan->id));
> +	sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
> +
> +	if ((status & STM32_DMA_HTI) && (scr & STM32_DMA_SCR_HTIE)) {
> +		stm32_dma_irq_clear(chan, STM32_DMA_HTI);
> +		vchan_cyclic_callback(&chan->desc->vdesc);
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;

line here please and below

> +	} else if ((status & STM32_DMA_TCI) && (scr & STM32_DMA_SCR_TCIE)) {
> +		stm32_dma_irq_clear(chan, STM32_DMA_TCI);
> +		stm32_dma_handle_chan_done(chan);
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;
> +	} else if ((status & STM32_DMA_TEI) && (scr & STM32_DMA_SCR_TEIE)) {
> +		dev_err(chan2dev(chan), "DMA error: received TEI event\n");
> +		stm32_dma_irq_clear(chan, STM32_DMA_TEI);
> +		chan->status = DMA_ERROR;
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;
> +	} else if ((status & STM32_DMA_FEI) && (sfcr & STM32_DMA_SFCR_FEIE)) {
> +		dev_err(chan2dev(chan), "DMA error: received FEI event\n");
> +		stm32_dma_irq_clear(chan, STM32_DMA_FEI);
> +		chan->status = DMA_ERROR;
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;

this is repeat of above apart from err print!!

> +	} else if ((status & STM32_DMA_DMEI) && (scr & STM32_DMA_SCR_DMEIE)) {
> +		dev_err(chan2dev(chan), "DMA error: received DMEI event\n");
> +		stm32_dma_irq_clear(chan, STM32_DMA_DMEI);
> +		chan->status = DMA_ERROR;
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;

same here :(

> +static enum dma_status stm32_dma_tx_status(struct dma_chan *c,
> +					   dma_cookie_t cookie,
> +					   struct dma_tx_state *state)
> +{
> +	struct stm32_dma_chan *chan = to_stm32_dma_chan(c);
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +	unsigned long flags;
> +	unsigned int residue;
> +
> +	status = dma_cookie_status(c, cookie, state);
> +	if (status == DMA_COMPLETE)
> +		return status;
> +
> +	if (!state)
> +		return chan->status;
why channel status and not status from dma_cookie_status()?

> +static int stm32_dma_remove(struct platform_device *pdev)
> +{
> +	struct stm32_dma_device *dmadev = platform_get_drvdata(pdev);
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +
> +	dma_async_device_unregister(&dmadev->ddev);
> +
> +	clk_disable_unprepare(dmadev->clk);

and your irq is enabled and you can still receive interrupts and schedule
tasklets :(

-- 
~Vinod
