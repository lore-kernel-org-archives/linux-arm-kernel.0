From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Wed, 4 Nov 2015 22:03:47 +0100
Subject: [PATCH v3 1/7] spi: imx: Fix DMA transfer
In-Reply-To: <20151103070837.GA15428@shlinux2>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
 <1446388901-6073-2-git-send-email-anton.bondarenko.sama@gmail.com>
 <20151103070837.GA15428@shlinux2>
Message-ID: <563A72B3.9010105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03.11.2015 08:08, Robin Gong wrote:
> On Sun, Nov 01, 2015 at 03:41:35PM +0100, Anton Bondarenko wrote:
>> From: Anton Bondarenko <anton_bondarenko@mentor.com>
>>
>> RX DMA tail data handling doesn't work correctly in many cases with
>> current implementation. It happens because SPI core was setup
>> to generates both RX watermark level and RX DATA TAIL events
>> incorrectly. SPI transfer triggering for DMA also done in wrong way.
>>
>> SPI client wants to transfer 70 words for example. The old DMA
>> implementation setup RX DATA TAIL equal 6 words. In this case
>> RX DMA event will be generated after 6 words read from RX FIFO.
>> The garbage can be read out from RX FIFO because SPI HW does
>> not receive all required words to trigger RX watermark event.
>>
>> New implementation change handling of RX data tail. DMA is used to process
>> all TX data and only full chunks of RX data with size aligned to FIFO/2.
>> Driver is waiting until both TX and RX DMA transaction done and all
>> TX data are pushed out. At that moment there is only RX data tail in
>> the RX FIFO. This data read out using PIO.
>>
>> Transfer triggering changed to avoid RX data loss.
>>
>> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
>> ---
>>   drivers/spi/spi-imx.c | 115 +++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 76 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>> @@ -967,10 +974,40 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>   				dev_name(&master->dev));
>>   			spi_imx->devtype_data->reset(spi_imx);
>>   			dmaengine_terminate_all(master->dma_rx);
>> +		} else if (left) {
>> +			void *pio_buffer = transfer->rx_buf
>> +						+ (transfer->len - left);
>> +
>> +			dma_sync_sg_for_cpu(master->dma_rx->device->dev,
>> +					    &rx->sgl[rx->nents - 1], 1,
>> +					    DMA_FROM_DEVICE);
>> +
>> +			spi_imx->rx_buf = pio_buffer;
>> +			spi_imx->txfifo = left;
>> +			reinit_completion(&spi_imx->xfer_done);
>> +
>> +			spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TCEN);
>> +
>> +			timeout = wait_for_completion_timeout(
>> +					&spi_imx->xfer_done, IMX_DMA_TIMEOUT);
>> +			if (!timeout) {
>> +				pr_warn("%s %s: I/O Error in RX tail\n",
>> +					dev_driver_string(&master->dev),
>> +					dev_name(&master->dev));
>> +			}
>> +
>> +			/*
>> +			 * WARNING: this call will cause DMA debug complains
>> +			 * about wrong combination of DMA direction and sync
>> +			 * function. But we must use it to make sure the data
>> +			 * read by PIO mode will be cleared from CPU cache.
>> +			 * Otherwise SPI core will invalidate it during unmap of
>> +			 * SG buffers.
>> +			 */
>> +			dma_sync_sg_for_device(master->dma_rx->device->dev,
>> +					       &rx->sgl[rx->nents - 1], 1,
>> +					       DMA_TO_DEVICE);
> I think the above dma_sync_sg_for_cpu for reading the last sgl by PIO mode is
> enough, that move the right data into rx_buf which map by SPI core. And why
> 'DMA_TO_DEVICE' for rx here?
Actually this is described in comments above the call. So after writing 
data tail by CPU we must ensure cache content is flushed to RAM. 
Otherwise SPI core during dma_unmap will invalidate data in the CPU 
cache and we loose our data tail. I'm able to reproduce this very fast 
during 20-30 SPI transactions.
Hope this make things clearer.

>>   		}
>> -		writel(dma |
>> -		       spi_imx->rxt_wml << MX51_ECSPI_DMA_RXT_WML_OFFSET,
>> -		       spi_imx->base + MX51_ECSPI_DMA);
>>   	}
>>
>>   	spi_imx->dma_finished = 1;
>> --
>> 2.6.2
>>
