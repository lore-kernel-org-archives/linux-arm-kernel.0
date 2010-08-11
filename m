From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 11 Aug 2010 22:10:38 +0200 (CEST)
Subject: [PATCH v2] ARM: i.MX27 pcm970: Add camera support
In-Reply-To: <1281512303-14303-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1280827245-5762-2-git-send-email-m.grzeschik@pengutronix.de>
	<1281512303-14303-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1008112201510.32197@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Aug 2010, Michael Grzeschik wrote:

> Adds the glue code for the pcm970 baseboard. It has a power regulator
> which is registered first and instrumented in the power hook of
> soc_camera_link to turn on the power for the camera device.

Ok, this looks better now, with this you don't have to patch the driver 
any more. But - are you sure you really need both - the power callback and 
the lateinitcall doing the same - requesting the regulator and enabling 
it. I think, just the power callback should suffice.

Thanks
Guennadi

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/mach-imx/pcm970-baseboard.c |  184 ++++++++++++++++++++++++++++++++++
>  1 files changed, 184 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/pcm970-baseboard.c b/arch/arm/mach-imx/pcm970-baseboard.c
> index f490a40..1034c92 100644
> --- a/arch/arm/mach-imx/pcm970-baseboard.c
> +++ b/arch/arm/mach-imx/pcm970-baseboard.c
> @@ -20,15 +20,23 @@
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/can/platform/sja1000.h>
> +#include <linux/i2c/pca953x.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <asm/mach/arch.h>
> +#include <asm/mach-types.h>
> +
> +#include <media/soc_camera.h>
>  
>  #include <mach/common.h>
>  #include <mach/iomux-mx27.h>
>  #include <mach/imxfb.h>
>  #include <mach/hardware.h>
>  #include <mach/mmc.h>
> +#include <mach/mx2_cam.h>
> +#include <mach/i2c.h>
>  
> +#include "devices-imx27.h"
>  #include "devices.h"
>  
>  static int pcm970_pins[] = {
> @@ -215,6 +223,130 @@ static struct platform_device pcm970_sja1000 = {
>  	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
>  };
>  
> +/* count of GPIOs that are occupied by the CPU itself */
> +#define MAX_INTERNAL_GPIO 192
> +
> +static unsigned long pcm970_camera_query_bus_param(struct soc_camera_link *icl)
> +{
> +	return SOCAM_DATAWIDTH_8;
> +}
> +
> +static int pcm970_camera_set_bus_param(struct soc_camera_link *icl,
> +		unsigned long flags)
> +{
> +	return 0;
> +}
> +
> +static int pcm970_camera_power_bus(struct device *dev, int toggle)
> +{
> +	struct regulator *regulator;
> +
> +	regulator = regulator_get(NULL, "imx_cam_vcc");
> +	if (IS_ERR(regulator)) {
> +		pr_err("unable to get regulator: %ld\n", PTR_ERR(regulator));
> +		return -ENODEV;
> +	} else {
> +		if (toggle)
> +			regulator_enable(regulator);
> +		else
> +			regulator_disable(regulator);
> +	}
> +	return 0;
> +}
> +
> +static struct pca953x_platform_data pca9536_data = {
> +	.gpio_base      = MAX_INTERNAL_GPIO,
> +};
> +
> +/* Board I2C devices. */
> +static struct i2c_board_info __initdata pcm970_i2c_devices[] = {
> +	{
> +		/* Must initialize before the camera(s) */
> +		I2C_BOARD_INFO("pca953x", 0x41),
> +		.type = "pca9536",
> +		.platform_data = &pca9536_data,
> +	},
> +};
> +
> +static struct i2c_board_info __initdata pcm970_camera_mt9m001 = {
> +		I2C_BOARD_INFO("mt9m001", 0x5d),
> +		.type = "mt9m001",
> +};
> +
> +static struct i2c_board_info __initdata pcm970_camera_mt9v022 = {
> +		I2C_BOARD_INFO("mt9v022", 0x48),
> +		.type = "mt9v022",
> +};
> +
> +static struct i2c_board_info __initdata pcm970_camera_mt9m131 = {
> +		I2C_BOARD_INFO("mt9m111", 0x48),
> +		.type = "mt9m111",
> +};
> +
> +static struct soc_camera_link iclink_mt9m001 = {
> +	.bus_id		= 0,		/* Must match with the camera ID */
> +	.board_info	= &pcm970_camera_mt9m001,
> +	.i2c_adapter_id	= 0,
> +	.module_name	= "mt9m001",
> +	.power		= pcm970_camera_power_bus,
> +	.query_bus_param = pcm970_camera_query_bus_param,
> +	.set_bus_param	= pcm970_camera_set_bus_param,
> +};
> +
> +static struct soc_camera_link iclink_mt9v022 = {
> +	.bus_id		= 0,		/* Must match with the camera ID */
> +	.board_info	= &pcm970_camera_mt9v022,
> +	.i2c_adapter_id	= 0,
> +	.module_name	= "mt9v022",
> +	.power		= pcm970_camera_power_bus,
> +	.query_bus_param = pcm970_camera_query_bus_param,
> +	.set_bus_param	= pcm970_camera_set_bus_param,
> +};
> +
> +static struct soc_camera_link iclink_mt9m131 = {
> +	.bus_id		= 0,		/* Must match with the camera ID */
> +	.board_info	= &pcm970_camera_mt9m131,
> +	.i2c_adapter_id	= 0,
> +	.module_name	= "mt9m111",
> +	.power		= pcm970_camera_power_bus,
> +	.query_bus_param = pcm970_camera_query_bus_param,
> +	.set_bus_param	= pcm970_camera_set_bus_param,
> +};
> +
> +static struct imxi2c_platform_data pcm038_i2c_0_data = {
> +	.bitrate = 10000,
> +};
> +
> +static struct platform_device pcm970_mt9m001 = {
> +	.name	= "soc-camera-pdrv",
> +	.id	= 0,
> +	.dev	= {
> +		.platform_data = &iclink_mt9m001,
> +	},
> +};
> +
> +static struct platform_device pcm970_mt9v022 = {
> +	.name	= "soc-camera-pdrv",
> +	.id	= 1,
> +	.dev	= {
> +		.platform_data = &iclink_mt9v022,
> +	},
> +};
> +
> +static struct platform_device pcm970_mt9m131 = {
> +	.name	= "soc-camera-pdrv",
> +	.id	= 2,
> +	.dev	= {
> +		.platform_data = &iclink_mt9m131,
> +	},
> +};
> +
> +struct mx2_camera_platform_data pcm970_camera = {
> +	.clk  = 26600000,
> +	.flags = MX2_CAMERA_HSYNC_HIGH | MX2_CAMERA_GATED_CLOCK |
> +		MX2_CAMERA_PACK_DIR_MSB,
> +};
> +
>  /*
>   * system init for baseboard usage. Will be called by pcm038 init.
>   *
> @@ -230,4 +362,56 @@ void __init pcm970_baseboard_init(void)
>  	mxc_gpio_mode(GPIO_PORTC | 28 | GPIO_GPIO | GPIO_IN);
>  	mxc_register_device(&mxc_sdhc_device1, &sdhc_pdata);
>  	platform_device_register(&pcm970_sja1000);
> +
> +	i2c_register_board_info(0, pcm970_i2c_devices,
> +		ARRAY_SIZE(pcm970_i2c_devices));
> +
> +	platform_device_register(&pcm970_mt9m001);
> +	platform_device_register(&pcm970_mt9v022);
> +	platform_device_register(&pcm970_mt9m131);
> +
> +	/* the first i2c master is used for devices on the baseboard */
> +	imx27_add_i2c_imx0(&pcm038_i2c_0_data);
> +
> +	mxc_register_device(&mx27_camera_device, &pcm970_camera);
>  }
> +
> +/*
> + * Ok, we have to deal with several situations here. We connect
> + * 10bit image sensors to a 8bit interface and we must make sure
> + * that the upper 8bit from the sensor are connected to the image
> + * interface. Some sensors have a i2c GPIO expander which controls
> + * a bus switch to fixup the routing. Mapper boards >= 1285.2 do
> + * the fixup without the need of a gpio switch.
> + * Set this parameter to '1' to use a camera with gpio switch on a
> + * newer mapper board to prevent the fixup being done twice.
> + */
> +static int use_camera_gpio;
> +core_param(use_camera_gpio, use_camera_gpio, int, 0444);
> +
> +static int __init pcm970_baseboard_init_late(void)
> +{
> +	int ret;
> +	struct regulator *regulator;
> +
> +	if (!machine_is_pcm038())
> +		return 0;
> +
> +	regulator = regulator_get(NULL, "imx_cam_vcc");
> +	if (IS_ERR(regulator))
> +		pr_err("unable to get regulator: %ld\n", PTR_ERR(regulator));
> +	else
> +		regulator_enable(regulator);
> +
> +	ret = gpio_request(MAX_INTERNAL_GPIO, "camera");
> +	if (!ret) {
> +		printk(KERN_INFO "pcm970 camera: Found GPIO expander on camera, %susing it\n",
> +				use_camera_gpio ? "" : "not ");
> +		gpio_direction_output(MAX_INTERNAL_GPIO, !!use_camera_gpio);
> +	} else
> +		printk(KERN_INFO "pcm970 camera: No GPIO expander on camera found\n");
> +
> +	return 0;
> +}
> +late_initcall(pcm970_baseboard_init_late);
> +
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
