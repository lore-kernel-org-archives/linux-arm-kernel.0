From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 6 Nov 2009 15:53:10 +0100 (CET)
Subject: [PATCH 6/6] mx31moboard: camera support
In-Reply-To: <1257268191-19075-7-git-send-email-valentin.longchamp@epfl.ch>
References: <1257268191-19075-1-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-2-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-3-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-4-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-5-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-6-git-send-email-valentin.longchamp@epfl.ch>
	<1257268191-19075-7-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <Pine.LNX.4.64.0911061551400.4389@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Nov 2009, Valentin Longchamp wrote:

> We have two mt9t031 cameras that have a muxed bus on the robot.
> Only one is currently initialized because of limitations in
> soc_camera that should be removed later.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>

As mentioned in my reply to another patch (4/6) in this series, now this 
patch is missing the header include. But if Sascha is ready to get them 
with this small inaccuracy

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> ---
>  arch/arm/mach-mx3/mx31moboard-marxbot.c |   86 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-mx3/mx31moboard.c         |   36 +++++++++++++
>  2 files changed, 121 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> index 6b06faf..e4e344e 100644
> --- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
> +++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> @@ -16,9 +16,11 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> +#include <linux/i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> @@ -28,6 +30,8 @@
>  #include <mach/iomux-mx3.h>
>  #include <mach/mmc.h>
>  
> +#include <media/soc_camera.h>
> +
>  #include "devices.h"
>  
>  static unsigned int marxbot_pins[] = {
> @@ -37,7 +41,6 @@ static unsigned int marxbot_pins[] = {
>  	MX31_PIN_PC_CD2_B__SD2_CLK, MX31_PIN_PC_CD1_B__SD2_CMD,
>  	MX31_PIN_ATA_DIOR__GPIO3_28, MX31_PIN_ATA_DIOW__GPIO3_29,
>  	/* CSI */
> -	MX31_PIN_CSI_D4__CSI_D4, MX31_PIN_CSI_D5__CSI_D5,
>  	MX31_PIN_CSI_D6__CSI_D6, MX31_PIN_CSI_D7__CSI_D7,
>  	MX31_PIN_CSI_D8__CSI_D8, MX31_PIN_CSI_D9__CSI_D9,
>  	MX31_PIN_CSI_D10__CSI_D10, MX31_PIN_CSI_D11__CSI_D11,
> @@ -45,6 +48,7 @@ static unsigned int marxbot_pins[] = {
>  	MX31_PIN_CSI_D14__CSI_D14, MX31_PIN_CSI_D15__CSI_D15,
>  	MX31_PIN_CSI_HSYNC__CSI_HSYNC, MX31_PIN_CSI_MCLK__CSI_MCLK,
>  	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK, MX31_PIN_CSI_VSYNC__CSI_VSYNC,
> +	MX31_PIN_CSI_D4__GPIO3_4, MX31_PIN_CSI_D5__GPIO3_5,
>  	MX31_PIN_GPIO3_0__GPIO3_0, MX31_PIN_GPIO3_1__GPIO3_1,
>  	MX31_PIN_TXD2__GPIO1_28,
>  	/* dsPIC resets */
> @@ -122,6 +126,83 @@ static void dspics_resets_init(void)
>  	}
>  }
>  
> +#define TURRETCAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
> +#define BASECAM_POWER	IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
> +#define TURRETCAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
> +#define BASECAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_CSI_D4)
> +#define CAM_CHOICE	IOMUX_TO_GPIO(MX31_PIN_TXD2)
> +
> +static int marxbot_basecam_power(struct device *dev, int on)
> +{
> +	gpio_set_value(BASECAM_POWER, !on);
> +	return 0;
> +}
> +
> +static int marxbot_basecam_reset(struct device *dev)
> +{
> +	gpio_set_value(BASECAM_RST_B, 0);
> +	udelay(100);
> +	gpio_set_value(BASECAM_RST_B, 1);
> +	return 0;
> +}
> +
> +static struct i2c_board_info marxbot_i2c_devices[] = {
> +	{
> +		I2C_BOARD_INFO("mt9t031", 0x5d),
> +	},
> +};
> +
> +static struct soc_camera_link base_iclink = {
> +	.bus_id		= 0,		/* Must match with the camera ID */
> +	.power		= marxbot_basecam_power,
> +	.reset		= marxbot_basecam_reset,
> +	.board_info	= &marxbot_i2c_devices[0],
> +	.i2c_adapter_id	= 0,
> +	.module_name	= "mt9t031",
> +};
> +
> +static struct platform_device marxbot_camera[] = {
> +	{
> +		.name	= "soc-camera-pdrv",
> +		.id	= 0,
> +		.dev	= {
> +			.platform_data = &base_iclink,
> +		},
> +	},
> +};
> +
> +static struct platform_device *marxbot_cameras[] __initdata = {
> +	&marxbot_camera[0],
> +};
> +
> +static int __init marxbot_cam_init(void)
> +{
> +	int ret = gpio_request(CAM_CHOICE, "cam-choice");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(CAM_CHOICE, 1);
> +
> +	ret = gpio_request(BASECAM_RST_B, "basecam-reset");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(BASECAM_RST_B, 1);
> +	ret = gpio_request(BASECAM_POWER, "basecam-standby");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(BASECAM_POWER, 0);
> +
> +	ret = gpio_request(TURRETCAM_RST_B, "turretcam-reset");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(TURRETCAM_RST_B, 1);
> +	ret = gpio_request(TURRETCAM_POWER, "turretcam-standby");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(TURRETCAM_POWER, 0);
> +
> +	return 0;
> +}
> +
>  /*
>   * system init for baseboard usage. Will be called by mx31moboard init.
>   */
> @@ -136,6 +217,9 @@ void __init mx31moboard_marxbot_init(void)
>  
>  	mxc_register_device(&mxcsdhc_device1, &sdhc2_pdata);
>  
> +	marxbot_cam_init();
> +	platform_add_devices(marxbot_cameras, ARRAY_SIZE(marxbot_cameras));
> +
>  	/* battery present pin */
>  	gpio_request(IOMUX_TO_GPIO(MX31_PIN_LCS0), "bat-present");
>  	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
> diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
> index 2f95dcd..b167f13 100644
> --- a/arch/arm/mach-mx3/mx31moboard.c
> +++ b/arch/arm/mach-mx3/mx31moboard.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
> @@ -403,6 +404,39 @@ static struct platform_device *devices[] __initdata = {
>  	&mx31moboard_leds_device,
>  };
>  
> +static struct mx3_camera_pdata camera_pdata = {
> +	.dma_dev	= &mx3_ipu.dev,
> +	.flags		= MX3_CAMERA_DATAWIDTH_8 | MX3_CAMERA_DATAWIDTH_10,
> +	.mclk_10khz	= 4800,
> +};
> +
> +#define CAMERA_BUF_SIZE	(4*1024*1024)
> +
> +static int __init mx31moboard_cam_alloc_dma(const size_t buf_size)
> +{
> +	dma_addr_t dma_handle;
> +	void *buf;
> +	int dma;
> +
> +	if (buf_size < 2 * 1024 * 1024)
> +		return -EINVAL;
> +
> +	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
> +	if (!buf) {
> +		pr_err("%s: cannot allocate camera buffer-memory\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	memset(buf, 0, buf_size);
> +
> +	dma = dma_declare_coherent_memory(&mx3_camera.dev,
> +					dma_handle, dma_handle, buf_size,
> +					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
> +
> +	/* The way we call dma_declare_coherent_memory only a malloc can fail */
> +	return dma & DMA_MEMORY_MAP ? 0 : -ENOMEM;
> +}
> +
>  static int mx31moboard_baseboard;
>  core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
>  
> @@ -436,6 +470,8 @@ static void __init mxc_board_init(void)
>  	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
>  
>  	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
> +	if (!mx31moboard_cam_alloc_dma(CAMERA_BUF_SIZE))
> +		mxc_register_device(&mx3_camera, &camera_pdata);
>  
>  	usb_xcvr_reset();
>  
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
