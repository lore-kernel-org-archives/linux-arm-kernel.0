From: fisaksen@baylibre.com (Frode Isaksen)
Date: Wed, 22 Mar 2017 12:11:20 +0100
Subject: [PATCH 3/8] spi: davinci: limit the transfer size if DMA enabled
In-Reply-To: <b4d8bd90-cd33-560f-5102-20c2375dac70@ti.com>
References: <1486740584-17875-1-git-send-email-fisaksen@baylibre.com>
 <1486740584-17875-4-git-send-email-fisaksen@baylibre.com>
 <a17cca3a-d029-a2cd-583c-2672287d191c@ti.com>
 <b4d8bd90-cd33-560f-5102-20c2375dac70@ti.com>
Message-ID: <44a615b6-97ab-0ab8-c2ba-013fdd40ffd7@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/03/2017 23:02, Peter Ujfalusi wrote:
>
>
> On 02/13/2017 07:59 AM, Sekhar Nori wrote:
>> + Peter
>>
>> On Friday 10 February 2017 08:59 PM, Frode Isaksen wrote:
>>> Limit the transfer size to 20 scatter/gather pages if
>>> DMA is enabled.
>>> The eDMA DMA engine is limited to 20 SG entries in one DMA
>>> transaction. If this number is exceeded, DMA receive fails.
>>> This error occurs with large vmalloc'ed buffers.
>>
>> This needs more explanation because there is support available in edma
>> driver for long SG lists by breaking them down into transfers using 20
>> PaRAM entries at a time. If thats not working for you, that needs
>> further debug.
>
> While breaking down long SG list works in the eDMA driver, it is not w/o it's
> limitation. It might take (to) long to re-configure the paRAM slots for the
> next batch. We see missed events with MMC/SD in case of long SG list, so I
> would not be surprised if this is not causing issues in other places...
>
I checked the time to re-configure the paRAM slots with an oscillo and it takes
about 160uS. Since the slave is still transmitting, the number of bytes lost is
about 160/8=20. With the spi-loopback-test I saw about 30bytes lost when
re-configuring.

Thanks,
Frode
>>
>>>
>>> Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
>>
>> Thanks,
>> Sekhar
>>
>>> ---
>>>  drivers/spi/spi-davinci.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
>>> index b7b2da1..f1b46f6 100644
>>> --- a/drivers/spi/spi-davinci.c
>>> +++ b/drivers/spi/spi-davinci.c
>>> @@ -485,6 +485,16 @@ static bool davinci_spi_can_dma(struct spi_master *master,
>>>      return __davinci_spi_can_dma(spi);
>>>  }
>>>
>>> +static size_t davinci_spi_max_transfer_size(struct spi_device *spi)
>>> +{
>>> +    /*
>>> +     * The eDMA DMA engine is limited to 20 SG entries in one DMA
>>> +     * transaction. If this number is exceeded, DMA receive fails.
>>> +     * An extra SG entry is needed when the buffer is not page aligned.
>>> +     */
>>> +    return (__davinci_spi_can_dma(spi)) ? 19 * PAGE_SIZE : SIZE_MAX;
>>> +}
>>> +
>>>  static int davinci_spi_check_error(struct davinci_spi *dspi, int int_status)
>>>  {
>>>      struct device *sdev = dspi->bitbang.master->dev.parent;
>>> @@ -1010,6 +1020,7 @@ static int davinci_spi_probe(struct platform_device
>>> *pdev)
>>>      master->setup = davinci_spi_setup;
>>>      master->cleanup = davinci_spi_cleanup;
>>>      master->can_dma = davinci_spi_can_dma;
>>> +    master->max_transfer_size = davinci_spi_max_transfer_size;
>>>
>>>      dspi->bitbang.chipselect = davinci_spi_chipselect;
>>>      dspi->bitbang.setup_transfer = davinci_spi_setup_transfer;
>>>
>>
>
> - P?ter
