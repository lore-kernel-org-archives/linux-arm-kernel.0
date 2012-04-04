From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Wed, 04 Apr 2012 09:47:56 +0200
Subject: [PATCH v2 1/3] PATA host controller driver for ep93xx
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409E51@AUSP01VMBX24.collaborationhost.net>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl>
 <ADE657CA350FB648AAC2C43247A983F0020698409E51@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F7BFCAC.2060300@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-04-03 20:55, H Hartley Sweeten wrote:
> 
> If the dma init fails does the driver fall back to pio mode correctly?
> 

Yes, udma_mask of ata_port is set only if we successfully requested dma
channels. Otherwise, we are limited to PIO4.

>> +	.bmdma_setup		= ep93xx_pata_dma_setup,
>> +	.bmdma_start		= ep93xx_pata_dma_start,
>> +	.bmdma_stop		= ep93xx_pata_dma_stop,
>> +	.bmdma_status		= ep93xx_pata_dma_status,
> 
> The bmdma ops pointers are still set if the dma init failed. Should they
> be set to NULL?
> 

I think it's not needed. Libata will not call them if udma_mask = 0.

> There are only two m2m dma channels on the ep93xx. They could be already in
> use by the spi driver. I just want to make sure that the ide driver will fall back to
> pio mode if they are not available.
> 

I tested this by enabling ep93xx spi in dma mode. In this case, pata driver
works in PIO4 mode.

Thanks,
RP
