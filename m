From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Nov 2016 14:07:53 +0530
Subject: [PATCH] spi: davinci: Allow device tree devices to use DMA
In-Reply-To: <946d60bc-ac14-7934-c1b3-e2de03831459@lechnology.com>
References: <1479530464-12538-1-git-send-email-david@lechnology.com>
 <79f186b5-ac71-189f-c19f-977670395043@ti.com>
 <946d60bc-ac14-7934-c1b3-e2de03831459@lechnology.com>
Message-ID: <fd697f3b-dba1-1e5f-c12c-45f71c0c07a1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 November 2016 10:31 PM, David Lechner wrote:

> On 11/20/2016 06:59 AM, Sekhar Nori wrote:

>> On Saturday 19 November 2016 10:11 AM, David Lechner wrote:

>>> @@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device
>>> *spi)
>>>          if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
>>>              spicfg->wdelay = (u8)prop;
>>>          spi->controller_data = spicfg;
>>> +        /* Use DMA for device if master supports it */
>>> +        if (dspi->dma_rx)
>>
>> This should be
>>
>>         if (!(IS_ERR(dpsi->dma_rx) || IS_ERR(dspi->dma_tx))
> 
> 
> There is the following code in davinci_spi_probe():
> 
>     ret = davinci_spi_request_dma(dspi);
>     if (ret == -EPROBE_DEFER) {
>         goto free_clk;
>     } else if (ret) {
>         dev_info(&pdev->dev, "DMA is not supported (%d)\n", ret);
>         dspi->dma_rx = NULL;
>         dspi->dma_tx = NULL;
>     }
> 
> So, I does not look like it is possible to get anything other than NULL
> or a valid pointer for dpsi->dma_rx and that checking dpsi->dma_tx is
> not necessary.
> 
> So, I think if (dspi->dma_rx) is sufficient. In fact the same check is
> used during unwinding if the probe function fails.

You are right, I see it now. Setting dma_rx to NULL overriding the error
value is confusing since dma_request_chan() itself does not use NULL as
an error value.

I think it is better to fix the existing code to remove the NULL
overwrite and use IS_ERR() instead. You should probably wait for some
feedback from the SPI maintainer though.

Thanks,
Sekhar
