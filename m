From: fisaksen@baylibre.com (Frode Isaksen)
Date: Tue, 14 Feb 2017 12:27:03 +0100
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
 <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
Message-ID: <e7ea60b0-1088-3535-efcf-d6c595fb31d6@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/02/2017 06:59, Sekhar Nori wrote:
> + Peter
>
> On Friday 10 February 2017 08:59 PM, Frode Isaksen wrote:
>> Limit the transfer size to 20 scatter/gather pages if
>> DMA is enabled.
>> The eDMA DMA engine is limited to 20 SG entries in one DMA
>> transaction. If this number is exceeded, DMA receive fails.
>> This error occurs with large vmalloc'ed buffers.
> This needs more explanation because there is support available in edma
> driver for long SG lists by breaking them down into transfers using 20
> PaRAM entries at a time. If thats not working for you, that needs
> further debug.
The SPI controller has a FIFO of only 1 word, so at 1Mbps, filling the 
FIFO will take only 8us. Handling the DMA interrupt and re-programming 
the PaRAM entries takes much longer than that. At 1Mbps, about 50 bytes 
is lost on Rx, @ 2Mbps 100 bytes and @ 5Mbps about 260 bytes hinting 
towards a time setting up a new DMA transfer > 400us. If the Tx and Rx 
buffers are identically aligned there are no errors, because the 
re-programming of the Tx and Rx PaRAM entries happens at the same time.
I have also verified this with a scope. In the Tx direction, there is a 
pause in the transfer of 600us after the 20th SG entrey (when setting up 
new PaRAM entries). Since setting up Rx PaRAM is identical, this shows 
that breaking down the transfer is not working in the Rx direction for 
SPI caused by the relative high bit rate and small FIFO.

Thanks,
Frode
>> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
> Thanks,
> Sekhar
>
>> ---
>>   drivers/spi/spi-davinci.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>> index b7b2da1..f1b46f6 100644
>> --- a/drivers/spi/spi-davinci.c
>> +++ b/drivers/spi/spi-davinci.c
>> @@ -485,6 +485,16 @@ static bool davinci_spi_can_dma(struct spi_master *master,
>>   	return __davinci_spi_can_dma(spi);
>>   }
>>   
>> +static size_t davinci_spi_max_transfer_size(struct spi_device *spi)
>> +{
>> +	/*
>> +	 * The eDMA DMA engine is limited to 20 SG entries in one DMA
>> +	 * transaction. If this number is exceeded, DMA receive fails.
>> +	 * An extra SG entry is needed when the buffer is not page aligned.
>> +	 */
>> +	return (__davinci_spi_can_dma(spi)) ? 19 * PAGE_SIZE : SIZE_MAX;
>> +}
>> +
>>   static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
>>   {
>>   	struct device *sdev = dspi->bitbang.master->dev.parent;
>> @@ -1010,6 +1020,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
>>   	master->setup = davinci_spi_setup;
>>   	master->cleanup = davinci_spi_cleanup;
>>   	master->can_dma = davinci_spi_can_dma;
>> +	master->max_transfer_size = davinci_spi_max_transfer_size;
>>   
>>   	dspi->bitbang.chipselect = davinci_spi_chipselect;
>>   	dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
>>
