From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 21 Apr 2010 19:44:34 +0800
Subject: [PATCH 3/3] PalmZ72: Add support for OV9640 camera sensor
In-Reply-To: <201004211141.22791.marek.vasut@gmail.com>
References: <200908220852.06689.marek.vasut@gmail.com>
	<201004211141.22791.marek.vasut@gmail.com>
Message-ID: <x2vf17812d71004210444t2083071bj4e9fa7da2f713cda@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 5:41 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne So 22. srpna 2009 08:52:06 Marek Vasut napsal(a):
>> From 777212ce6d3bacea76281aa3d74839a3c38b32a4 Mon Sep 17 00:00:00 2001
>> From: Marek Vasut <marek.vasut@gmail.com>
>> Date: Sat, 22 Aug 2009 05:15:10 +0200
>> Subject: [PATCH 3/3] PalmZ72: Add support for OV9640 camera sensor
>>
>
> Hi, was this ever merged ?
>

Is the required change to ov9640 merged?

> Cheers
>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
>> ---
>> ?arch/arm/mach-pxa/include/mach/palmz72.h | ? ?5 +
>> ?arch/arm/mach-pxa/palmz72.c ? ? ? ? ? ? ?| ?126
>> +++++++++++++++++++++++++++++-
>> ?2 files changed, 130 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-
>> pxa/include/mach/palmz72.h
>> index 2806ef6..745fa3c 100644
>> --- a/arch/arm/mach-pxa/include/mach/palmz72.h
>> +++ b/arch/arm/mach-pxa/include/mach/palmz72.h
>> @@ -44,6 +44,11 @@
>> ?#define GPIO_NR_PALMZ72_BT_POWER ? ? ? ? ? ? 17
>> ?#define GPIO_NR_PALMZ72_BT_RESET ? ? ? ? ? ? 83
>>
>> +/* Camera */
>> +#define GPIO_NR_PALMZ72_CAM_PWDN ? ? ? ? ? ? 56
>> +#define GPIO_NR_PALMZ72_CAM_RESET ? ? ? ? ? ?57
>> +#define GPIO_NR_PALMZ72_CAM_POWER ? ? ? ? ? ?91
>> +
>> ?/** Initial values **/
>>
>> ?/* Battery */
>> diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
>> index c3645aa..e4449ad 100644
>> --- a/arch/arm/mach-pxa/palmz72.c
>> +++ b/arch/arm/mach-pxa/palmz72.c
>> @@ -30,6 +30,7 @@
>> ?#include <linux/wm97xx_batt.h>
>> ?#include <linux/power_supply.h>
>> ?#include <linux/usb/gpio_vbus.h>
>> +#include <linux/i2c-gpio.h>
>>
>> ?#include <asm/mach-types.h>
>> ?#include <asm/mach/arch.h>
>> @@ -44,8 +45,10 @@
>> ?#include <mach/pxa27x_keypad.h>
>> ?#include <mach/udc.h>
>> ?#include <mach/palmasoc.h>
>> -
>> ?#include <mach/pm.h>
>> +#include <mach/camera.h>
>> +
>> +#include <media/soc_camera.h>
>>
>> ?#include "generic.h"
>> ?#include "devices.h"
>> @@ -120,6 +123,28 @@ static unsigned long palmz72_pin_config[] __initdata =
>> { GPIO22_GPIO, ? ? ? ?/* LCD border color */
>> ? ? ? GPIO96_GPIO, ? ?/* lcd power */
>>
>> + ? ? /* PXA Camera */
>> + ? ? GPIO81_CIF_DD_0,
>> + ? ? GPIO48_CIF_DD_5,
>> + ? ? GPIO50_CIF_DD_3,
>> + ? ? GPIO51_CIF_DD_2,
>> + ? ? GPIO52_CIF_DD_4,
>> + ? ? GPIO53_CIF_MCLK,
>> + ? ? GPIO54_CIF_PCLK,
>> + ? ? GPIO55_CIF_DD_1,
>> + ? ? GPIO84_CIF_FV,
>> + ? ? GPIO85_CIF_LV,
>> + ? ? GPIO93_CIF_DD_6,
>> + ? ? GPIO108_CIF_DD_7,
>> +
>> + ? ? GPIO56_GPIO,
>> + ? ? GPIO57_GPIO,
>> + ? ? GPIO91_GPIO,
>> +
>> + ? ? /* I2C */
>> + ? ? GPIO117_GPIO, ? /* I2C_SCL */
>> + ? ? GPIO118_GPIO, ? /* I2C_SDA */
>> +
>> ? ? ? /* Misc. */
>> ? ? ? GPIO0_GPIO ? ? ?| WAKEUP_ON_LEVEL_HIGH, /* power detect */
>> ? ? ? GPIO88_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* green led */
>> @@ -493,6 +518,70 @@ static struct pxafb_mach_info palmz72_lcd_screen = {
>> ? ? ? .lcd_conn ? ? ? = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
>> ?};
>>
>> +/*************************************************************************
>> ***** + * SoC Camera
>> +
>> ***************************************************************************
>> ***/ +struct pxacamera_platform_data palmz72_pxacamera_platform_data = {
>> + ? ? .flags ?= PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
>> + ? ? ? ? ? ? PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
>> + ? ? .mclk_10khz = 2600,
>> +};
>> +
>> +/* Board I2C devices. */
>> +static struct i2c_board_info __initdata palmz72_i2c_device = {
>> + ? ? I2C_BOARD_INFO("ov9640", 0x30),
>> +};
>> +
>> +static int palmz72_camera_power(struct device *dev, int power)
>> +{
>> + ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_PWDN, !power);
>> + ? ? mdelay(50);
>> + ? ? return 0;
>> +}
>> +
>> +static int palmz72_camera_reset(struct device *dev)
>> +{
>> + ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 1);
>> + ? ? mdelay(50);
>> + ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 0);
>> + ? ? mdelay(50);
>> + ? ? return 0;
>> +}
>> +
>> +static struct soc_camera_link palmz72_iclink = {
>> + ? ? .bus_id ? ? ? ? = 0, /* Match id in pxa27x_device_camera in device.c */
>> + ? ? .board_info ? ? = &palmz72_i2c_device,
>> + ? ? .i2c_adapter_id = 0,
>> + ? ? .module_name ? ?= "ov96xx",
>> + ? ? .power ? ? ? ? ?= &palmz72_camera_power,
>> + ? ? .reset ? ? ? ? ?= &palmz72_camera_reset,
>> + ? ? .flags ? ? ? ? ?= SOCAM_DATAWIDTH_8,
>> +};
>> +
>> +static struct i2c_gpio_platform_data palmz72_i2c_bus_data = {
>> + ? ? .sda_pin = 118,
>> + ? ? .scl_pin = 117,
>> + ? ? .udelay ?= 10,
>> + ? ? .timeout = 100,
>> +};
>> +
>> +static struct platform_device palmz72_i2c_bus_device = {
>> + ? ? .name ? ? ? ? ? = "i2c-gpio",
>> + ? ? .id ? ? ? ? ? ? = 0, /* we use this as a replacement for i2c-pxa */
>> + ? ? .dev = {
>> + ? ? ? ? ? ? .platform_data = &palmz72_i2c_bus_data,
>> + ? ? }
>> +};
>> +
>> +struct platform_device palmz72_camera = {
>> + ? ? .name ? = "soc-camera-pdrv",
>> + ? ? .id ? ? = -1,
>> + ? ? .dev ? ?= {
>> + ? ? ? ? ? ? .platform_data ?= &palmz72_iclink,
>> + ? ? },
>> +};
>> +
>> +
>> ?#ifdef CONFIG_PM
>>
>> ?/* We have some black magic here
>> @@ -576,6 +665,8 @@ static struct platform_device *devices[] __initdata = {
>> ? ? ? &palmz72_asoc,
>> ? ? ? &power_supply,
>> ? ? ? &palmz72_gpio_vbus,
>> + ? ? &palmz72_i2c_bus_device,
>> + ? ? &palmz72_camera,
>> ?};
>>
>> ?/* setup udc GPIOs initial state */
>> @@ -587,10 +678,41 @@ static void __init palmz72_udc_init(void)
>> ? ? ? }
>> ?}
>>
>> +/* Here we request the camera GPIOs and configure them. We power up the
>> camera + * module, deassert the reset pin, but put it into powerdown (low
>> to no power + * consumption) mode. This allows up later to bring the
>> module up fast. */ +static inline void __init palmz72_cam_init(void)
>> +{
>> + ? ? if (gpio_request(GPIO_NR_PALMZ72_CAM_PWDN, "Camera PWDN"))
>> + ? ? ? ? ? ? goto err1;
>> + ? ? if (gpio_request(GPIO_NR_PALMZ72_CAM_RESET, "Camera RESET"))
>> + ? ? ? ? ? ? goto err2;
>> + ? ? if (gpio_request(GPIO_NR_PALMZ72_CAM_POWER, "Camera DVDD"))
>> + ? ? ? ? ? ? goto err3;
>> + ? ? if (gpio_direction_output(GPIO_NR_PALMZ72_CAM_POWER, 1))
>> + ? ? ? ? ? ? goto err4;
>> + ? ? if (gpio_direction_output(GPIO_NR_PALMZ72_CAM_RESET, 0))
>> + ? ? ? ? ? ? goto err4;
>> + ? ? if (gpio_direction_output(GPIO_NR_PALMZ72_CAM_PWDN, 0))
>> + ? ? ? ? ? ? goto err4;
>> + ? ? return;
>> +
>> +err4:
>> + ? ? gpio_free(GPIO_NR_PALMZ72_CAM_POWER);
>> +err3:
>> + ? ? gpio_free(GPIO_NR_PALMZ72_CAM_RESET);
>> +err2:
>> + ? ? gpio_free(GPIO_NR_PALMZ72_CAM_PWDN);
>> +err1:
>> + ? ? printk(KERN_ERR "Camera GPIO init failed!\n");
>> + ? ? return;
>> +}
>> +
>> ?static void __init palmz72_init(void)
>> ?{
>> ? ? ? pxa2xx_mfp_config(ARRAY_AND_SIZE(palmz72_pin_config));
>>
>> + ? ? palmz72_cam_init();
>> ? ? ? set_pxa_fb_info(&palmz72_lcd_screen);
>> ? ? ? pxa_set_mci_info(&palmz72_mci_platform_data);
>> ? ? ? palmz72_udc_init();
>> @@ -599,6 +721,8 @@ static void __init palmz72_init(void)
>> ? ? ? pxa_set_keypad_info(&palmz72_keypad_platform_data);
>> ? ? ? wm97xx_bat_set_pdata(&wm97xx_batt_pdata);
>>
>> + ? ? pxa_set_camera_info(&palmz72_pxacamera_platform_data);
>> +
>> ? ? ? platform_add_devices(devices, ARRAY_SIZE(devices));
>> ?}
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
