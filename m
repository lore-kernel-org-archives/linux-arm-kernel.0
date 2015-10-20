From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Wed, 21 Oct 2015 01:03:55 +0200
Subject: [PATCH v2 1/8] spi: imx: Fix DMA transfer
In-Reply-To: <20151008091951.GA6101@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <d61ed8cc9e13b0890e6243135c613edea1234698.1442923630.git.anton_bondarenko@mentor.com>
 <20150930082341.GB2709@shlinux2>
 <04376A3D786BD947B28569C998A374A62E280DD6@NA-MBX-02.mgc.mentorg.com>
 <20151008091951.GA6101@shlinux2>
Message-ID: <5626C85B.2090707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.2015 11:19, Robin Gong wrote:
> On Thu, Oct 01, 2015 at 12:02:41AM +0000, Bondarenko, Anton wrote:
>>>> @@ -201,9 +202,8 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>>>>   {
>>>>   	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
>>>>
>>>> -	if (spi_imx->dma_is_inited
>>>> -	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
>>>> -	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
>>>> +	if (spi_imx->dma_is_inited &&
>>>> +	    (transfer->len > spi_imx->wml * sizeof(u32)))
>>> Add Sascha in the loop. I don't think "* sizeof(u32)", since even 1 byte data
>>> will consume one position of 32bit FIFO Thus if here
>>> spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2 = 32, the threshold value
>>> which judge DMA mode used or not should be 32 not 32 * 4.
>>> Of course, it will not cause any function break since both DMA and PIO can work
>>> ,but I think we'd better correct it.
>> I agree, in case of 1 byte SPI word we do not need to multiply by 4.
>> But for 16 bit and 32 bit SPI words it's necessary. This part is
>> addressed in patch 3.
>> I could remove "* sizeof(u32)" for now.
> I still think don't need *sizeof(u32) even for 16bit and 32bit, whatever bits
> used as one spi word(<32bits), one spi word consume one position of SPI FIFO
> (32bit).
Will be removed in V3 for this patch.
>>>>   		return true;
>>>>   	return false;
>>>>   }

Regards,
Anton
