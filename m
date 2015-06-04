From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 4 Jun 2015 06:31:45 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <201506040103.09555.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <8fc4b9f5291a509c4c35782a1337bf536f1019af.1433364398.git.hramrach@gmail.com>
 <201506040103.09555.marex@denx.de>
Message-ID: <CAOMqctQeg0Sj1pGOQsK1nNB6=-H9koH_5nrXYBq_NKeVt369dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2015 at 01:03, Marek Vasut <marex@denx.de> wrote:
> On Wednesday, June 03, 2015 at 11:26:41 PM, Michal Suchanek wrote:
>> On sunxi the SPI controller currently does not have DMA support and fails
>> any transfer larger than 63 bytes.
>>
>> On Exynos the pl330 DMA controller fails any transfer larger than 64kb
>> when using slower speed like 40MHz and any transfer larger than 128bytes
>> when running at 133MHz.
>
> This smells more like some corruption of the data on the bus or something
> even more obscure.

If the data was corrupted you would get corrupted data and not
transfer failure. AFAIK there is no checksum or anything. I actually
do get corrupted data when I use wrong feedback delay setting.

>
>> The best thing is that in both cases the controller can just lock up and
>> never finish potentially leaving the hardware in unusable state.
>>
>> So it is required that the m25p80 driver actively prevents doing
>> transfers that are too large for the current driver state on a
>> particular piece of hardware.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>
>> --
>>
>> Update commit message and documentation text.
>> ---
>>  .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++++++
>>  drivers/mtd/devices/m25p80.c                       | 24
>> ++++++++++++++++++++-- 2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt index
>> 2bee681..4e63ae8 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
>> @@ -19,6 +19,12 @@ Optional properties:
>>                     all chips and support for it can not be detected at
>> runtime. Refer to your chips' datasheet to check if this is supported by
>> your chip.
>> +- linux,max_tx_len : With some SPI controller drivers possible transfer
>> size is +                     limited. This may be hardware or driver bug.
>> +                     Transfer data in chunks no larger than this value. +
>>                     Using this option may severely degrade performance and
>> +                     possibly flash memory life when max_tx_len is
>> smaller than +                     flash page size (typically 256 bytes)
>
> Will we need similar patch for all other SPI slave drivers, like SPI NAND ?

Probably. Some SPI slave drivers already do have similar option. In
general it cannot be expected that you can reliably transfer
arbitrarily large data over SPI it seems. However, if the nand driver
transfers data a page at a time it should be fine.

Thanks

Michal
