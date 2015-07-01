From: pawelo@king.net.pl (Paul Osmialowski)
Date: Wed, 1 Jul 2015 08:54:56 +0200 (CEST)
Subject: [PATCH v2 7/9] arm: twr-k70f120m: use Freescale eDMA driver with
 Kinetis SoC
In-Reply-To: <1650263.FfdEQKm1Bu@wuerfel>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-8-git-send-email-pawelo@king.net.pl>
 <1650263.FfdEQKm1Bu@wuerfel>
Message-ID: <alpine.LNX.2.00.1507010849390.8255@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for pointing this - dma-ranges seem to work properly. This makes 
the patch much simpler. To be included to the next iteration.

I also removed DMA_OF from Kconfig and CONFIG_DMA_OF from my defconfig and 
it was automatically added during preparation of .cofing for build.

On Tue, 30 Jun 2015, Arnd Bergmann wrote:

> On Tuesday 30 June 2015 14:27:28 Paul Osmialowski wrote:
>> Note that <mach/memory.h> is needed (which is denoted by
>> CONFIG_NEED_MACH_MEMORY_H) as it provides macros required for proper
>> operation of DMA allocation functions.
>
> You can't do this, it breaks compilation when multiple platforms
> are enabled.
>
>> Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
>> ---
>>  arch/arm/Kconfig                            |  4 ++
>>  arch/arm/boot/dts/kinetis.dtsi              | 34 ++++++++++++++++
>>  arch/arm/mach-kinetis/include/mach/memory.h | 61 +++++++++++++++++++++++++++++
>>  3 files changed, 99 insertions(+)
>>  create mode 100644 arch/arm/mach-kinetis/include/mach/memory.h
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index b21592b..8ccffee 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -971,6 +971,10 @@ config ARCH_KINETIS
>>  	select CLKSRC_KINETIS
>>  	select PINCTRL
>>  	select PINCTRL_KINETIS
>> +	select DMADEVICES
>> +	select FSL_EDMA
>> +	select DMA_OF
>> +	select NEED_MACH_MEMORY_H
>
> I think DMA_OF is implied by dmaengine support in combination with CONFIG_OF
>
>> +
>> +#ifndef _MACH_KINETIS_MEMORY_H
>> +#define _MACH_KINETIS_MEMORY_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +/*
>> + * On Kinetis K70, consistent DMA memory resides in a special
>> + * DDRAM alias region (non-cacheable DDRAM at 0x80000000).
>> + *
>> + */
>> +#define KINETIS_PHYS_DMA_OFFSET UL(0x80000000)
>> +
>> +/*
>> + * Mask of the field used to distinguish DDRAM aliases
>> + */
>> +#define KINETIS_DRAM_ALIAS_MASK UL(0xf8000000)
>
> This should be expressed using the 'dma-ranges' properties in the
> bus nodes above any DMA master, the normal DMA mapping code will
> then do the right thing.
>
> 	Arnd
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0007-arm-twr-k70f120m-use-Freescale-eDMA-driver-with-Kine.patch
Type: text/x-diff
Size: 2182 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150701/b3e0ff39/attachment.bin>
