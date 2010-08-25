From: konkers@android.com (Erik Gilling)
Date: Wed, 25 Aug 2010 14:22:53 -0700
Subject: [PATCH v2] spi: add spi_tegra driver
In-Reply-To: <AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
	<AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
Message-ID: <AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 12:54 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Missing patch description. ?Give reviewers and future readers some
> more details about what hardware this patch adds support for.

I'll add one

>> +#undef DEBUG
>
> Still need to trim this #undef

Done.

> It's a good idea to prefix all these register #defines with something
> driver specific to avoid the possibility of collisions with the global
> namespace.

I'll add SLINK_ to all the bit definitions.

>> +static inline unsigned bytes_per_word(u8 bits)
>> +{
>> + ? ? ? WARN_ON((bits < 1) || bits > 32);
>> + ? ? ? if (bits <= 8)
>> + ? ? ? ? ? ? ? return 1;
>> + ? ? ? else if (bits <= 16)
>> + ? ? ? ? ? ? ? return 2;
>> + ? ? ? else if (bits <= 24)
>> + ? ? ? ? ? ? ? return 3;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? return 4;
>> +}
>
> No longer used, can be removed.

done

>> +static unsigned long spi_tegra_readl(struct spi_tegra_data *tspi,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long reg)
>> +{
>> + ? ? ? return readl(tspi->base + reg);
>> +}
>
> static inline

done

>> +
>> +static void spi_tegra_writel(struct spi_tegra_data *tspi, unsigned long val,
>> + ? ? ? ? ? ? ? ? ? ? ?unsigned long reg)
>> +{
>> + ? ? ? writel(val, tspi->base + reg);
>> +}
>
> ditto

done

>> + ? ? ? val = spi_tegra_readl(tspi, SLINK_COMMAND2);
>> + ? ? ? if (t->rx_buf)
>> + ? ? ? ? ? ? ? val |= RXEN;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? val &= ~RXEN;
>> +
>> + ? ? ? if (t->tx_buf)
>> + ? ? ? ? ? ? ? val |= TXEN;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? val &= ~TXEN;
>> +
>> + ? ? ? val &= ~SS_EN_CS(~0);
>> + ? ? ? val |= SS_EN_CS(spi->chip_select);
>> + ? ? ? val |= SPIE;
>
> Nit: This would be more concise:
>
> + ? ? ? val &= ~(SS_EN_CS(~0) | RXEN | TXEN);
> + ? ? ? if (t->rx_buf)
> + ? ? ? ? ? ? ? val |= RXEN;
> + ? ? ? if (t->tx_buf)
> + ? ? ? ? ? ? ? val |= TXEN;
> + ? ? ? val |= SS_EN_CS(spi->chip_select);
> + ? ? ? val |= SPIE;

done

>> + ? ? ? if (spi->mode & SPI_CPOL)
>> + ? ? ? ? ? ? ? val |= IDLE_SCLK_DRIVE_HIGH;
>> + ? ? ? else
>> + ? ? ? ? ? ? ? val |= IDLE_SCLK_DRIVE_LOW;
>
> nit: IDLE_SCLK_DRIVE_LOW == 0. ?The driver will be more concise if the
> above 2 lines are dropped.

I did it this way because it's not obvious from this code which sets
the bit and which does not without decoding the #defines.  I expect
the complier optimizes this out.

>> +
>> + ? ? ? val |= M_S;
>> +
>> + ? ? ? spi_tegra_writel(tspi, val, SLINK_COMMAND);
>
> The read/modify/write register blocks are quite common. ?Would it be
> clearer and more concise to have a spi_tegra_clrsetbits() static
> inline?

More concise, yes.  Clearer?  I don't think so.  It seems that
clrsetbits is mostly used in ppc code.

>> + ? ? ? /* the SPI controller may come back with both the BSY and RDY bits
>> + ? ? ? ?* set. ?In this case we need to wait for the BSY bit to clear so
>> + ? ? ? ?* that we are sure the DMA is finished. ?1000 reads was empirically
>> + ? ? ? ?* determined to be long enough.
>> + ? ? ? ?*/
>> + ? ? ? while (timeout++ < 1000) {
>> + ? ? ? ? ? ? ? if (!(spi_tegra_readl(tspi, SLINK_STATUS) & BSY))
>> + ? ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? }
>
> What happens if the BSY bit is still set when the loop exits?

Given how I've seen the hardware act, I don't think it's possible for
BSY to still be set after 1000 reads.  I forget the average number of
loops but 1000 was very conservative.  Worst case some of the data
might be corrupt.  I'll put an error message in and set status to
-EIO.

>> +
>> + ? ? ? val = spi_tegra_readl(tspi, SLINK_STATUS);
>> + ? ? ? val |= RDY;
>> + ? ? ? spi_tegra_writel(tspi, val, SLINK_STATUS);
>
> The spin lock isn't held at this point. ?Will that make this
> read-modify-write operation risky?

move spinlock up.

>> +
>> + ? ? ? spin_lock_irqsave(&tspi->lock, flags);
>
> Is there any condition/event which could cause the spi controller to
> go busy before obtaining the spinlock?

No.  The controller only goes busy when a transaction is started by
calling spi_tegra_go().

>> +
>> + ? ? ? m = list_first_entry(&tspi->queue, struct spi_message, queue);
>> + ? ? ? spi = m->state;
>> +
>> + ? ? ? tspi->cur_pos += spi_tegra_drain_rx_fifo(tspi, tspi->cur);
>> + ? ? ? m->actual_length += tspi->cur_pos;
>> +
>> + ? ? ? if (tspi->cur_pos < tspi->cur->len) {
>> + ? ? ? ? ? ? ? tspi->cur_len = spi_tegra_fill_tx_fifo(tspi, tspi->cur);
>> + ? ? ? ? ? ? ? spi_tegra_go(tspi);
>> + ? ? ? } else if (!list_is_last(&tspi->cur->transfer_list,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?&m->transfers)) {
>> + ? ? ? ? ? ? ? tspi->cur = ?list_first_entry(&tspi->cur->transfer_list,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct spi_transfer,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? transfer_list);
>> + ? ? ? ? ? ? ? spi_tegra_start_transfer(spi, tspi->cur);
>> + ? ? ? } else {
>> + ? ? ? ? ? ? ? complete = 1;
>> + ? ? ? }
>> +
>> + ? ? ? if (complete) {
>
> Looks like the above else clause is the only thing that can set
> complete. ?You could delete the above three lines to get the same
> behaviour.

deleted

>> + ? ? ? ? ? ? ? list_del(&m->queue);
>> +
>> + ? ? ? ? ? ? ? m->status = 0;
>> + ? ? ? ? ? ? ? m->complete(m->context);


>> + ? ? ? switch (spi->chip_select) {
>> + ? ? ? case 0:
>> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY;
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? case 1:
>> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY1;
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? case 2:
>> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY2;
>> + ? ? ? ? ? ? ? break;
>> +
>> + ? ? ? case 4:
>> + ? ? ? ? ? ? ? cs_bit = CS_POLARITY3;
>> + ? ? ? ? ? ? ? break;
>
> CS_POLARITY is named a little oddly as it seems to indicate the bit,
> not the polarity of the bit. ?Would this better be named
> CS_BIT0..CS_BIT3?

That's how Nvidia named them in the TRM.


>> + ? ? ? tspi->rx_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
>> + ? ? ? if (IS_ERR(tspi->rx_dma)) {
>
> As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
> pattern in the tegra_dma_allocate_channel() return really a good idea
> here? ?Personally I find that pattern isn't very useful, especially
> when the results is either "yes, allocated" or "no, not-alocated", and
> it is very easy to write code that tests the wrong thing on the return
> value because the compiler cannot catch it. ?In other words, if it
> isn't vital to return a specific error code, the using the PTR_ERR()
> pattern adds unnecessary risk to the code because developers are used
> to seeing and writing this pattern:
>
> tspi->rx_dma = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
> if (!tspi->rx_dma)
> ? ? ? ?return -ENOMEM;
>
> The compiler won't catch it if the return value is an PTR_ERR.
>
> (I know that some subsystems make heavy use of it, particularly
> filesystems and the block layer which do need to return specific error
> codes to userspace. ?My argument is that the specific error code is
> probably irrelevant when allocating DMA channels)

I don't have a strong opinion either way but that's the way Colin's
code is written.  I'll let him speak to that.

>> +static int __init spi_tegra_init(void)
>> +{
>> + ? ? ? return platform_driver_probe(&spi_tegra_driver, spi_tegra_probe);
>> +}
>> +subsys_initcall(spi_tegra_init);
>
> Unless there is a specific reason that this driver needs to be
> initialized earlier, it should use the module_init() call. ?In which
> case the reason it is initialized early should be documented with a
> comment. ?(for reference: 4 of the mainlined spi bus drivers use
> subsys_initcall() whereas 30 of them use module_init().. ?1 uses
> device_initcall() which is the same as module_init. ?None of the ones
> using subsys_initcall() give a reason why.)

heh.. I missed the module_inits because i grepped for initcall.
changed to module_init.

patch incoming.

-Erik
