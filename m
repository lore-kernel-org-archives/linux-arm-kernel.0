From: Anton_Bondarenko@mentor.com (Bondarenko, Anton)
Date: Thu, 1 Oct 2015 00:08:59 +0000
Subject: [PATCH v2 2/8] spi: imx: replace fixed timeout with calculated one
In-Reply-To: <20150930083135.GC2709@shlinux2>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <43a7e93d4d29253215a5590b09baeb11a7e6f6d8.1442923630.git.anton_bondarenko@mentor.com>
 <20150930083135.GC2709@shlinux2>
Message-ID: <04376A3D786BD947B28569C998A374A62E280DF4@NA-MBX-02.mgc.mentorg.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.09.2015 10:31, Robin Gong wrote:
> On Fri, Sep 25, 2015 at 07:57:09PM +0200, Anton Bondarenko wrote:
>> @@ -957,8 +988,10 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
>>  		dmaengine_terminate_all(master->dma_tx);
>>  		dmaengine_terminate_all(master->dma_rx);
>>  	} else {
>> +		transfer_timeout = spi_imx_calculate_timeout(spi_imx,
>> +							     spi_imx->wml * 2);
> *2 again here? Although spi_imx_calculate_timeout has double it.
WIll be fixed in V3
>>  		timeout = wait_for_completion_timeout(
>> -				&spi_imx->dma_rx_completion, IMX_DMA_TIMEOUT);
>> +				&spi_imx->dma_rx_completion, transfer_timeout);
>>  		if (!timeout) {
>>  			pr_warn("%s %s: I/O Error in DMA RX\n",
>>  				dev_driver_string(&master->dev),
