From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 14:01:13 +0200
Subject: [patch 8/9] efikamx: add spi nor support
In-Reply-To: <20101020112659.GK2562@matterhorn.lan> (Amit Kucheria's message
	of "Wed\, 20 Oct 2010 14\:26\:59 +0300")
References: <20101019204253.162641893@rtp-net.org>
	<20101019205301.326830829@rtp-net.org>
	<20101020112659.GK2562@matterhorn.lan>
Message-ID: <87wrpdax9y.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amit Kucheria <amit.kucheria@linaro.org> writes:
Hi,

> On 10 Oct 19, Arnaud Patard wrote:
>> On efikamx, uboot is stored on a nor spi flash. Add support for it
>> 
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c
>> ===================================================================
>> --- linux-2.6.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-16 14:21:24.000000000 +0200
>> +++ linux-2.6/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-10-16 15:34:12.000000000 +0200
>> @@ -24,6 +24,8 @@
>>  #include <linux/delay.h>
>>  #include <linux/io.h>
>>  #include <linux/fsl_devices.h>
>> +#include <linux/spi/flash.h>
>> +#include <linux/spi/spi.h>
>>  
>>  #include <mach/common.h>
>>  #include <mach/hardware.h>
>> @@ -52,6 +54,9 @@
>>  
>>  #define EFIKAMX_POWER_KEY	(1*32+31)
>>  
>> +#define EFIKAMX_SPI_CS0		(3*32+24)
>> +#define EFIKAMX_SPI_CS1		(3*32+25)
>
> It is just a style thing, but could you make this (3*32 + 24). Makes it
> easier on the eyes to read "4th gpio bank, 24th pin"

I've used X*32+Y without space in all patches. So, you prefer that I
change the other places too ?

>
>>  /* the pci ids pin have pull up. they're driven low according to board id */
>>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>>  #define MX51_PAD_PCBID1	IOMUX_PAD(0x51C, 0x134, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
>> @@ -99,6 +104,14 @@
>>  
>>  	/* power key */
>>  	MX51_PAD_PWRKEY,
>> +
>> +	/* spi */
>> +	MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
>> +	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
>> +	MX51_PAD_CSPI1_SS0__GPIO_4_24,
>> +	MX51_PAD_CSPI1_SS1__GPIO_4_25,
>> +	MX51_PAD_CSPI1_RDY__ECSPI1_RDY,
>> +	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
>>  };
>>  
>>  /* Serial ports */
>> @@ -252,6 +265,47 @@
>>  	},
>>  };
>>  
>> +static struct mtd_partition mx51_efikamx_spi_nor_partitions[] = {
>> +	{
>> +	 .name = "u-boot",
>
> "bootloader" ?

I don't really mind if it's "u-boot" or "bootloader". It's just a name
after all. Will change to bootloader and if someone disagree, he'll have
to send a new patch imho.

Arnaud
