From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 8 Feb 2011 15:41:55 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <19793.22067.960689.669543@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
>> This patch adds dma support for Freescale MXS-based SoC i.MX23/28,
>> including apbh-dma and apbx-dma.
>> 
>> * apbh-dma and apbx-dma are supported in the driver as two instances,
>>   and have to be filtered by dma clients via device id.  It becomes
>>   the convention that apbh-dma always gets registered prior to
>>   apbx-dma.
>> 
>> * apbh-dma is different between mx23 and mx28, hardware version
>>   register is used to handle the differences.
>> 
>> * Every the mxs dma channel is statically assigned to client device
>>   by soc design with fixed irq.  The irq number is being passed by
>>   alloc_chan function with mxs_dma_data, and client driver has to
>>   filter the correct channel by its channel id.
>> 
>> * mxs-dma supports pio function besides data transfer.  The driver
>>   uses dma_data_direction DMA_NONE to identify the pio mode, and
>>   steals sgl and sg_len to get pio words and numbers from clients.
>> 
>> * mxs dmaengine has some very specific features, like sense function
>>   and the special NAND support (nand_lock, nand_wait4ready).  These
>>   are too specific to implemented in generic dmaengine driver.
>> 
>> * The parameter "flags" of prep functions is currently being used to
>>   pass wait4end flag from clients.
>> 
>> * The driver refers to imx-sdma and only a single descriptor is
>>   statically assigned to each channel.
>> 
>> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> ---
>>  arch/arm/mach-mxs/include/mach/dma.h |   16 +
>>  drivers/dma/Kconfig                  |    8 +
>>  drivers/dma/Makefile                 |    1 +
>>  drivers/dma/mxs-dma.c                |  702 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 727 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-mxs/include/mach/dma.h
>>  create mode 100644 drivers/dma/mxs-dma.c
>> 
>> diff --git a/arch/arm/mach-mxs/include/mach/dma.h b/arch/arm/mach-mxs/include/mach/dma.h
>> new file mode 100644
>> index 0000000..429f431
>> --- /dev/null
>> +++ b/arch/arm/mach-mxs/include/mach/dma.h
>> +
>> +static struct dma_async_tx_descriptor *mxs_dma_prep_slave_sg(
>> +		struct dma_chan *chan, struct scatterlist *sgl,
>> +		unsigned int sg_len, enum dma_data_direction direction,
>> +		unsigned long flags)
>> +{
>> +	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
>> +	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
>> +	struct mxs_dma_ccw *ccw;
>> +	struct scatterlist *sg;
>> +	int ret, i, j;
>> +	u32 *pio;
>> +
>> +	dev_dbg(mxs_dma->dev, "%s: channel %d\n", __func__, chan->chan_id);
>> +
>> +	if (mxs_chan->status == DMA_IN_PROGRESS)
>> +		return NULL;
>> +
>> +	mxs_chan->status = DMA_IN_PROGRESS;
>> +	mxs_chan->flags = 0;
>> +
>> +	dev_dbg(mxs_dma->dev, "%s: setting up %d entries\n", __func__, sg_len);
>> +
>> +	if (sg_len > ((direction == DMA_NONE) ? MXS_PIO_WORDS : NUM_CCW)) {
>> +		dev_err(mxs_dma->dev, "maximum number of sg exceeded: %d > %d\n",
>> +				sg_len, NUM_CCW);
>> +		ret = -EINVAL;
>> +		goto err_out;
>> +	}
>> +
>> +	if (direction == DMA_NONE) {
>> +		ccw = &mxs_chan->ccw[0];
>> +		pio = (u32 *) sgl;
>> +
>> +		for (j = 0; j < sg_len;)
>> +			ccw->pio_words[j++] = *pio++;
>> +
>> +		ccw->next = 0;
>> +		ccw->bits.chain = 0;
>> +		ccw->bits.irq = 1;
>> +		ccw->bits.dec_sem = 1;
>> +		ccw->bits.wait4end = flags;
>> +		ccw->bits.halt_on_terminate = 1;
>> +		ccw->bits.terminate_flush = 1;
>> +		ccw->bits.pio_num = sg_len;
>> +		ccw->bits.command = MXS_DMA_NO_XFER;
>
> Does this have a valid usecase? I would just return some error code
> here. pio_num and pio_words are unused in the driver and I don't think
> a dmaengine driver should have some kind of PIO fallback.
>
Actually 'PIO' is a misnomer here. It's the free scaled way of
implementing a simple feature (chained DMA with mixed transfer modes)
in a complicated and obfuscated way.

What's behinde the 'PIO' transfers is programming controller registers
via DMA along with the actual DMA data transfer. DMA_NONE simply
means, that the DMA transfer does only the register programming but
does not transfer any payload. The 'pio_words' are the values that are
being written to consecutive locations of e.g. the SPI controller
register address space.
The programming is actually done by DMA, in any case.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
