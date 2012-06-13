From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Wed, 13 Jun 2012 16:16:34 +0800
Subject: [PATCH V2 1/5] ARM: OMAP3EVM: Add NAND flash definition
In-Reply-To: <4FD84803.2090006@compulab.co.il>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
 <1339551850-20827-2-git-send-email-zumeng.chen@gmail.com>
 <4FD84803.2090006@compulab.co.il>
Message-ID: <4FD84C62.1060206@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?06?13? 15:57, Igor Grinberg ??:
> On 06/13/12 04:44, Zumeng Chen wrote:
>> From: Zumeng Chen<zumeng.chen@windriver.com>
>>
>> Signed-off-by: Vaibhav Hiremath<hvaibhav@ti.com>
>> Tested-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>>   arch/arm/mach-omap2/board-omap3evm.c |   39 ++++++++++++++++++++++++++++++++++
>>   1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
>> index 639bd07..0b83d0e 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -24,6 +24,10 @@
>>   #include<linux/leds.h>
>>   #include<linux/interrupt.h>
>>
>> +#include<linux/mtd/mtd.h>
>> +#include<linux/mtd/partitions.h>
>> +#include<linux/mtd/nand.h>
>> +
>>   #include<linux/spi/spi.h>
>>   #include<linux/spi/ads7846.h>
>>   #include<linux/i2c/twl.h>
>> @@ -43,6 +47,7 @@
>>
>>   #include<plat/board.h>
>>   #include<plat/usb.h>
>> +#include<plat/nand.h>
>>   #include "common.h"
>>   #include<plat/mcspi.h>
>>   #include<video/omapdss.h>
>> @@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>>   	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>>   };
>>
>> +static struct mtd_partition omap3evm_nand_partitions[] = {
>> +	/* All the partition sizes are listed in terms of NAND block size */
>> +	{
>> +		.name           = "X-Loader",
>> +		.offset         = 0,
>> +		.size           = 4*(SZ_128K),
>> +		.mask_flags     = MTD_WRITEABLE
>> +	},
>> +	{
>> +		.name           = "U-Boot",
>> +		.offset         = MTDPART_OFS_APPEND,
>> +		.size           = 14*(SZ_128K),
>> +		.mask_flags     = MTD_WRITEABLE
>> +	},
>> +	{
>> +		.name           = "U-Boot Env",
>> +		.offset         = MTDPART_OFS_APPEND,
>> +		.size           = 2*(SZ_128K)
>> +	},
>> +	{
>> +		.name           = "Kernel",
>> +		.offset         = MTDPART_OFS_APPEND,
>> +		.size           = 40*(SZ_128K)
>> +	},
>> +	{
>> +		.name           = "File system",
>> +		.size           = MTDPART_SIZ_FULL,
>> +		.offset         = MTDPART_OFS_APPEND,
>> +	},
>> +};
>> +
>>   static void __init omap3_evm_init(void)
>>   {
>>   	struct omap_board_mux *obm;
>> @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
>>   	}
>>   	usb_musb_init(&musb_board_data);
>>   	usbhs_init(&usbhs_bdata);
>> +	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
>> +			     ARRAY_SIZE(omap3evm_nand_partitions));
>> +
> I think, this will interfere with Afzal's patches [1]?
Yes, Igor, thanks for your kind reminder, I have already
noticed Afzal's GPMC patches when at [PATCH v4 00/39]

But I didn't read recently, I'll check them again to see if they
have been in Tony's queue :-)

Regards,
Zumeng

>>   	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
>>   	omap3evm_init_smsc911x();
>>   	omap3_evm_display_init();
> [1] http://www.spinics.net/lists/arm-kernel/msg178664.html
>
