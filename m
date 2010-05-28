From: eric@eukrea.com (=?ISO-8859-15?Q?Eric_B=E9nard?=)
Date: Fri, 28 May 2010 11:17:22 +0200
Subject: [PATCH v2 3/4] eukrea_mbimx27: add audio codec
In-Reply-To: <20100528065840.GF23664@pengutronix.de>
References: <1274950737-26498-1-git-send-email-eric@eukrea.com>
	<1274950737-26498-2-git-send-email-eric@eukrea.com>
	<1274950737-26498-3-git-send-email-eric@eukrea.com>
	<20100528065840.GF23664@pengutronix.de>
Message-ID: <4BFF8A22.40704@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Le 28/05/2010 08:58, Sascha Hauer a ?crit :
> Hi Eric,
>
> The patch does not apply on current master. Can you please rebase it?
> It's better we delay the defconfig patch until the code is merged, so
> give me a ping when it's done.
>
in fact it's based on top of my patchset which updates our board's support :
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-May/thread.html#15821

I can rebase it but maybe you can also get most of the patches of this 
thread ?

>
> On Thu, May 27, 2010 at 10:58:56AM +0200, Eric B?nard wrote:
>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>> Cc: Sascha Hauer<s.hauer@pengutronix.de>
>> Cc: Mark Brown<broonie@opensource.wolfsonmicro.com>
>> Cc: Liam Girdwood<lrg@slimlogic.co.uk>
>> ---
>>   arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   44 +++++++++++++++++++++++++-
>>   1 files changed, 43 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
>> index 9038e1f..e7fd65a 100644
>> --- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
>> +++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (C) 2009 Eric Benard - eric at eukrea.com
>> + * Copyright (C) 2009-2010 Eric Benard - eric at eukrea.com
>>    *
>>    * Based on pcm970-baseboard.c which is :
>>    * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
>> @@ -37,6 +37,8 @@
>>   #include<mach/mmc.h>
>>   #include<mach/imx-uart.h>
>>   #include<mach/spi.h>
>> +#include<mach/ssi.h>
>> +#include<mach/audmux.h>
>>
>>   #include "devices.h"
>>
>> @@ -93,6 +95,13 @@ static int eukrea_mbimx27_pins[] = {
>>   	PD29_PF_CSPI1_SCLK,
>>   	PD30_PF_CSPI1_MISO,
>>   	PD31_PF_CSPI1_MOSI,
>> +	/* SSI4 */
>> +#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
>> +	PC16_PF_SSI4_FS,
>> +	PC17_PF_SSI4_RXD | GPIO_PUEN,
>> +	PC18_PF_SSI4_TXD | GPIO_PUEN,
>> +	PC19_PF_SSI4_CLK,
>> +#endif
>
> You should remove the ifdefs. The pin muxer should not depend on compile
> time options.
>
well on this kind of board yes as the IO can be used as plain GPIO if 
the codec is not mounted.

>>   };
>>
>>   static const uint32_t eukrea_mbimx27_keymap[] = {
>> @@ -292,6 +301,12 @@ static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
>>   	},
>>   };
>>
>> +static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
>> +	{
>> +		I2C_BOARD_INFO("tlv320aic23", 0x1a),
>> +	},
>> +};
>> +
>>   static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
>>
>>   static struct spi_imx_master eukrea_mbimx27_spi_0_data = {
>> @@ -308,6 +323,10 @@ static struct imxmmc_platform_data sdhc_pdata = {
>>   	.dat3_card_detect = 1,
>>   };
>>
>> +struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata = {
>> +	.flags = IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
>> +};
>> +
>>   /*
>>    * system init for baseboard usage. Will be called by cpuimx27 init.
>>    *
>> @@ -319,6 +338,24 @@ void __init eukrea_mbimx27_baseboard_init(void)
>>   	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
>>   		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
>>
>> +#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
>> +	/* SSI unit master I2S codec connected to SSI_PINS_4*/
>> +	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
>> +			MXC_AUDMUX_V1_PCR_SYN |
>> +			MXC_AUDMUX_V1_PCR_TFSDIR |
>> +			MXC_AUDMUX_V1_PCR_TCLKDIR |
>> +			MXC_AUDMUX_V1_PCR_RFSDIR |
>> +			MXC_AUDMUX_V1_PCR_RCLKDIR |
>> +			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
>> +			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
>> +			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
>> +	);
>> +	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
>> +			MXC_AUDMUX_V1_PCR_SYN |
>> +			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
>> +	);
>> +#endif
>
> Does it hurt to go without the ifdefs?
>
same thing as for the IOMUX.

Thanks,
Eric
