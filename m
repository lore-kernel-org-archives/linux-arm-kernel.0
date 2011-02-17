From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Feb 2011 15:38:30 +0100
Subject: [PATCH v2 1/3] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1297650228-12762-2-git-send-email-shawn.guo@freescale.com>
References: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
	<1297650228-12762-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <201102171538.31061.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011, Shawn Guo wrote:
> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
> including apbh-dma and apbx-dma.
> 
> * apbh-dma and apbx-dma are supported in the driver as two instances,
>   and have to be filtered by dma clients via device id.  It becomes
>   the convention that apbh-dma always gets registered prior to
>   apbx-dma.
> 
> * apbh-dma is different between mx23 and mx28, hardware version
>   register is used to handle the differences.
> 
> * mxs-dma supports pio function besides data transfer.  The driver
>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>   steals sgl and sg_len to get pio words and numbers from clients.
> 
> * mxs dmaengine has some very specific features, like sense function
>   and the special NAND support (nand_lock, nand_wait4ready).  These
>   are too specific to implemented in generic dmaengine driver.
> 
> * The driver refers to imx-sdma and only a single descriptor is
>   statically assigned to each channel.

Hi Shawn,

I took a look at this after our discussion about the MMC driver locking
problem. My feeling is that you still need to get a better understanding
of the locking interfaces in Linux.

> +struct mxs_dma_ccw {
> +	u32		next;
> +	u16		bits;
> +	u16		xfer_bytes;
> +#define MAX_XFER_BYTES	0xff00
> +	dma_addr_t	bufaddr;
> +#define MXS_PIO_WORDS	16
> +	u32		pio_words[MXS_PIO_WORDS];
> +};

Unrelated, but should bufaddr really be dma_addr_t? If this is a hardware
structure, you should make it u32, because dma_addr_t may be either 32 or
64 bit in the future, as we get to multiplatform kernels.

> +struct mxs_dma_chan {
> +	struct mxs_dma_engine		*mxs_dma;
> +	struct dma_chan			chan;
> +	struct dma_async_tx_descriptor	desc;
> +	struct tasklet_struct		tasklet;
> +	spinlock_t			lock;
> +	int				chan_irq;
> +	struct mxs_dma_ccw		*ccw;
> +	dma_addr_t			ccw_phys;
> +	dma_cookie_t			last_completed;
> +	enum dma_status			status;
> +	unsigned int			flags;
> +#define MXS_DMA_SG_LOOP			(1 << 0)
> +};
> +
> +struct mxs_dma_engine {
> +	int				dev_id;
> +	unsigned int			version;
> +	void __iomem			*base;
> +	struct clk			*clk;
> +	struct dma_device		dma_device;
> +	struct device_dma_parameters	dma_parms;
> +#define MXS_DMA_CHANNELS		16
> +	struct mxs_dma_chan		mxs_chans[MXS_DMA_CHANNELS];
> +};

So you have locking per channel, but there is no lock in the dma engine
structure locking the global fields. This is probably fine.

> +static void mxs_dma_reset_chan(struct mxs_dma_chan *mxs_chan)
> +{
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_id = mxs_chan->chan.chan_id;
> +
> +	if (dma_is_apbh() && apbh_is_old())
> +		__mxs_setl(1 << (chan_id + BP_APBH_CTRL0_RESET_CHANNEL),
> +				mxs_dma->base + HW_APBHX_CTRL0);
> +	else
> +		__mxs_setl(1 << (chan_id + BP_APBHX_CHANNEL_CTRL_RESET_CHANNEL),
> +				mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
> +}
> +
> +static void mxs_dma_enable_chan(struct mxs_dma_chan *mxs_chan)
> +{
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_id = mxs_chan->chan.chan_id;
> +
> +	/* set cmd_addr up */
> +	__raw_writel(mxs_chan->ccw_phys,
> +			mxs_dma->base + HW_APBHX_CHn_NXTCMDAR(chan_id));
> +
> +	/* enable apbh channel clock */
> +	if (dma_is_apbh()) {
> +		if (apbh_is_old())
> +			__mxs_clrl(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
> +						mxs_dma->base + HW_APBHX_CTRL0);
> +		else
> +			__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
> +	}
> +
> +	/* write 1 to SEMA to kick off the channel */
> +	__raw_writel(1, mxs_dma->base + HW_APBHX_CHn_SEMA(chan_id));
> +}

Just like the MMC driver, you also use __raw_writel(). If you have to do
that, please encapsulate the access into a wrapper function that adds
all the necessary serialization and add a comment explaining why you
cannot use writel()/writel_relaxed().

Or just use writel().

> +static void mxs_dma_disable_chan(struct mxs_dma_chan *mxs_chan)
> +{
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_id = mxs_chan->chan.chan_id;
> +
> +	/* disable apbh channel clock */
> +	if (dma_is_apbh()) {
> +		if (apbh_is_old())
> +			__mxs_setl(1 << (chan_id + BP_APBH_CTRL0_CLKGATE_CHANNEL),
> +						mxs_dma->base + HW_APBHX_CTRL0);
> +		else
> +			__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
> +	}
> +
> +	mxs_chan->status = DMA_SUCCESS;
> +}
> +
> +static void mxs_dma_pause_chan(struct mxs_dma_chan *mxs_chan)
> +{
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_id = mxs_chan->chan.chan_id;
> +
> +	/* freeze the channel */
> +	if (dma_is_apbh() && apbh_is_old())
> +		__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
> +	else
> +		__mxs_setl(1 << chan_id, mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
> +
> +	mxs_chan->status = DMA_PAUSED;
> +}
> +
> +static void mxs_dma_resume_chan(struct mxs_dma_chan *mxs_chan)
> +{
> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
> +	int chan_id = mxs_chan->chan.chan_id;
> +
> +	/* unfreeze the channel */
> +	if (dma_is_apbh() && apbh_is_old())
> +		__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CTRL0);
> +	else
> +		__mxs_clrl(1 << chan_id, mxs_dma->base + HW_APBHX_CHANNEL_CTRL);
> +
> +	mxs_chan->status = DMA_IN_PROGRESS;
> +}

Should these take the spinlock? What if they are called simultaneously on
multiple CPUs, or while the interrupt handler is running on another CPU?

Without a lock, another thread might see an incorrect value of mxs_chan->status.

> +static dma_cookie_t mxs_dma_assign_cookie(struct mxs_dma_chan *mxs_chan)
> +{
> +	dma_cookie_t cookie = mxs_chan->chan.cookie;
> +
> +	if (++cookie < 0)
> +		cookie = 1;
> +
> +	mxs_chan->chan.cookie = cookie;
> +	mxs_chan->desc.cookie = cookie;
> +
> +	return cookie;
> +}
> +
> +static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct mxs_dma_chan, chan);
> +}
> +
> +static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> +{
> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mxs_chan->lock, flags);
> +
> +	cookie = mxs_dma_assign_cookie(mxs_chan);
> +
> +	mxs_dma_enable_chan(mxs_chan);
> +
> +	spin_unlock_irqrestore(&mxs_chan->lock, flags);
> +
> +	return cookie;
> +}

Just like the MMC driver, you use spin_lock_irqsave() in the functions that
are called by other drivers, but then don't actually lock in the interrupt
handler. This is clearly wrong, as I explained before:

The interrupt handler may already be running on another CPU, so it
is not at all serialized with this code.

> +static void mxs_dma_tasklet(unsigned long data)
> +{
> +	struct mxs_dma_chan *mxs_chan = (struct mxs_dma_chan *) data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mxs_chan->lock, flags);
> +
> +	if (mxs_chan->desc.callback)
> +		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
> +
> +	if (mxs_chan->status == DMA_SUCCESS)
> +		mxs_chan->last_completed = mxs_chan->desc.cookie;
> +
> +	spin_unlock_irqrestore(&mxs_chan->lock, flags);
> +}

Here is a different problem. The entire tasklet has interrupts
disabled and holds the spinlock that the interrupt handler does
not hold.

This actually makes the tasklet a stricter context than the
actual interrupt handler, defeating the purpose of tasklets
(i.e. that you can run code without disabling interrupts).

I don't know what the rules for dmaengine callbacks are regarding
the context in which they are called, but it seems you should
either get rid of the spin_lock_irqsave here or do everything
from the interrupt handler.

That leaves the last_completed variable. This apparently
needs to be protected using a spinlock, because
it can be read from other tasks calling mxs_dma_tx_status,
which in turn does not take the lock, so that is broken, too.

	Arnd
