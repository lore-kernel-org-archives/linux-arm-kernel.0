From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Fri, 06 Nov 2009 16:36:55 +0100
Subject: [PATCH 4/6] mx31moboard: SPI and MC13783 voltage regulator support
In-Reply-To: <Pine.LNX.4.64.0911061550180.4389@axis700.grange>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-2-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-3-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-4-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-5-git-send-email-valentin.longchamp@epfl.ch>
	<Pine.LNX.4.64.0911061550180.4389@axis700.grange>
Message-ID: <4AF44297.70406@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guennadi Liakhovetski wrote:
> On Tue, 3 Nov 2009, Valentin Longchamp wrote:
> 
>> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
>> ---
>>  arch/arm/mach-mx3/mx31moboard.c |  126 ++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 125 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
>> index ff74fab..f3ab51b 100644
>> --- a/arch/arm/mach-mx3/mx31moboard.c
>> +++ b/arch/arm/mach-mx3/mx31moboard.c
>> @@ -26,6 +26,9 @@
>>  #include <linux/mtd/physmap.h>
>>  #include <linux/mtd/partitions.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/regulator/machine.h>
>> +#include <linux/mfd/mc13783.h>
>> +#include <linux/spi/spi.h>
>>  #include <linux/types.h>
>>  
>>  #include <asm/mach-types.h>
>> @@ -39,7 +42,8 @@
>>  #include <mach/iomux-mx3.h>
>>  #include <mach/i2c.h>
>>  #include <mach/mmc.h>
>> -#include <mach/mx31.h>
>> +#include <mach/mx3_camera.h>
> 
> Yes, that's what I thought it would be: you added the mx3_camera.h header 
> in a wrong patch. Don't know if this is bad enough to redo at least these 
> two patches.

Sorry for this error, git rebase had me again (I watched out for 
dma-mapping.h but this one got though).

I have a small addition for this exact patch, I will redo them.

Thanks for the comments and review.

Val

> 
> Thanks
> Guennadi
> 
>> +#include <mach/spi.h>
>>  
>>  #include "devices.h"
>>  
>> @@ -79,6 +83,16 @@ static unsigned int moboard_pins[] = {
>>  	/* SEL */
>>  	MX31_PIN_DTR_DCE1__GPIO2_8, MX31_PIN_DSR_DCE1__GPIO2_9,
>>  	MX31_PIN_RI_DCE1__GPIO2_10, MX31_PIN_DCD_DCE1__GPIO2_11,
>> +	/* SPI1 */
>> +	MX31_PIN_CSPI2_MOSI__MOSI, MX31_PIN_CSPI2_MISO__MISO,
>> +	MX31_PIN_CSPI2_SCLK__SCLK, MX31_PIN_CSPI2_SPI_RDY__SPI_RDY,
>> +	MX31_PIN_CSPI2_SS0__SS0, MX31_PIN_CSPI2_SS2__SS2,
>> +	/* Atlas IRQ */
>> +	MX31_PIN_GPIO1_3__GPIO1_3,
>> +	/* SPI2 */
>> +	MX31_PIN_CSPI3_MOSI__MOSI, MX31_PIN_CSPI3_MISO__MISO,
>> +	MX31_PIN_CSPI3_SCLK__SCLK, MX31_PIN_CSPI3_SPI_RDY__SPI_RDY,
>> +	MX31_PIN_CSPI2_SS1__CSPI3_SS1,
>>  };
>>  
>>  static struct physmap_flash_data mx31moboard_flash_data = {
>> @@ -124,6 +138,108 @@ static struct imxi2c_platform_data moboard_i2c1_pdata = {
>>  	.bitrate = 100000,
>>  };
>>  
>> +static int moboard_spi1_cs[] = {
>> +	MXC_SPI_CS(0),
>> +	MXC_SPI_CS(2),
>> +};
>> +
>> +static struct spi_imx_master moboard_spi1_master = {
>> +	.chipselect	= moboard_spi1_cs,
>> +	.num_chipselect	= ARRAY_SIZE(moboard_spi1_cs),
>> +};
>> +
>> +static struct regulator_consumer_supply sdhc_consumers[] = {
>> +	{
>> +		.dev	= &mxcsdhc_device0.dev,
>> +		.supply	= "sdhc0_vcc",
>> +	},
>> +	{
>> +		.dev	= &mxcsdhc_device1.dev,
>> +		.supply	= "sdhc1_vcc",
>> +	},
>> +};
>> +
>> +static struct regulator_init_data sdhc_vreg_data = {
>> +	.constraints = {
>> +		.min_uV = 2700000,
>> +		.max_uV = 3000000,
>> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
>> +			REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
>> +		.valid_modes_mask = REGULATOR_MODE_NORMAL |
>> +			REGULATOR_MODE_FAST,
>> +		.always_on = 0,
>> +		.boot_on = 1,
>> +	},
>> +	.num_consumer_supplies = ARRAY_SIZE(sdhc_consumers),
>> +	.consumer_supplies = sdhc_consumers,
>> +};
>> +
>> +static struct regulator_consumer_supply cam_consumers[] = {
>> +	{
>> +		.dev	= &mx3_camera.dev,
>> +		.supply	= "cam_vcc",
>> +	},
>> +};
>> +
>> +static struct regulator_init_data cam_vreg_data = {
>> +	.constraints = {
>> +		.min_uV = 2700000,
>> +		.max_uV = 3000000,
>> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
>> +			REGULATOR_CHANGE_MODE | REGULATOR_CHANGE_STATUS,
>> +		.valid_modes_mask = REGULATOR_MODE_NORMAL |
>> +			REGULATOR_MODE_FAST,
>> +		.always_on = 0,
>> +		.boot_on = 1,
>> +	},
>> +	.num_consumer_supplies = ARRAY_SIZE(cam_consumers),
>> +	.consumer_supplies = cam_consumers,
>> +};
>> +
>> +static struct mc13783_regulator_init_data moboard_regulators[] = {
>> +	{
>> +		.id = MC13783_REGU_VMMC1,
>> +		.init_data = &sdhc_vreg_data,
>> +	},
>> +	{
>> +		.id = MC13783_REGU_VCAM,
>> +		.init_data = &cam_vreg_data,
>> +	},
>> +};
>> +
>> +static struct mc13783_platform_data moboard_pmic = {
>> +	.regulators = moboard_regulators,
>> +	.num_regulators = ARRAY_SIZE(moboard_regulators),
>> +	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC,
>> +};
>> +
>> +static struct spi_board_info moboard_spi_board_info[] __initdata = {
>> +	{
>> +		.modalias = "mc13783",
>> +		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO1_3),
>> +		.max_speed_hz = 300000,
>> +		.bus_num = 1,
>> +		.chip_select = 0,
>> +		.platform_data = &moboard_pmic,
>> +		.mode = SPI_CS_HIGH,
>> +	},
>> +	{
>> +		.modalias = "spidev",
>> +		.max_speed_hz = 300000,
>> +		.bus_num = 1,
>> +		.chip_select = 1, /* according spi1_cs[] ! */
>> +	},
>> +};
>> +
>> +static int moboard_spi2_cs[] = {
>> +	MXC_SPI_CS(1),
>> +};
>> +
>> +static struct spi_imx_master moboard_spi2_master = {
>> +	.chipselect	= moboard_spi2_cs,
>> +	.num_chipselect	= ARRAY_SIZE(moboard_spi2_cs),
>> +};
>> +
>>  #define SDHC1_CD IOMUX_TO_GPIO(MX31_PIN_ATA_CS0)
>>  #define SDHC1_WP IOMUX_TO_GPIO(MX31_PIN_ATA_CS1)
>>  
>> @@ -304,6 +420,14 @@ static void __init mxc_board_init(void)
>>  	mxc_register_device(&mxc_i2c_device0, &moboard_i2c0_pdata);
>>  	mxc_register_device(&mxc_i2c_device1, &moboard_i2c1_pdata);
>>  
>> +	mxc_register_device(&mxc_spi_device1, &moboard_spi1_master);
>> +	mxc_register_device(&mxc_spi_device2, &moboard_spi2_master);
>> +
>> +	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3), "pmic-irq");
>> +	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_3));
>> +	spi_register_board_info(moboard_spi_board_info,
>> +		ARRAY_SIZE(moboard_spi_board_info));
>> +
>>  	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
>>  
>>  	usb_xcvr_reset();
>> -- 
>> 1.6.3.3
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
