From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 24 Oct 2009 00:56:38 +0200 (CEST)
Subject: [PATCH 5/6] mx31moboard: camera support
In-Reply-To: <1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-5-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <Pine.LNX.4.64.0910222315280.4324@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Val

below are some comments to the patch, I'll also reply to your /dev/video* 
question in a separate mail.

On Thu, 15 Oct 2009, Valentin Longchamp wrote:

> We have two mt9t031 cameras that have a muxed bus on the robot.
> We can control which one we are using with gpio outputs. This
> currently is not optimal
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
> ---
>  arch/arm/mach-mx3/mx31moboard-marxbot.c |   78 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-mx3/mx31moboard.c         |   37 ++++++++++++++-
>  2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> index 49d47ab..303cbdb 100644
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
> @@ -122,6 +126,78 @@ static void dspics_resets_init(void)
>  	}
>  }
>  
> +#define TURRETCAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
> +#define BASECAM_POWER	IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
> +#define TURRETCAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
> +#define BASECAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_CSI_D4)
> +#define CAM_CHOICE	IOMUX_TO_GPIO(MX31_PIN_TXD2)
> +
> +static int marxbot_cam_power(struct device *dev, int on)
> +{
> +	gpio_set_value(BASECAM_POWER, !on);
> +	return 0;
> +}
> +
> +static int marxbot_cam_reset(struct device *dev)
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
> +static struct soc_camera_link iclink = {
> +	.bus_id		= 0,		/* Must match with the camera ID */
> +	.power		= marxbot_cam_power,
> +	.reset		= marxbot_cam_reset,
> +	.board_info	= &marxbot_i2c_devices[0],
> +	.i2c_adapter_id	= 0,
> +	.module_name	= "mt9t031",
> +};
> +
> +static struct platform_device marxbot_camera = {
> +	.name	= "soc-camera-pdrv",
> +	.id	= 0,
> +	.dev	= {
> +		.platform_data = &iclink,
> +	},
> +};
> +
> +static int __init marxbot_cam_init(void)
> +{
> +	int ret = gpio_request(CAM_CHOICE, "cam-choice");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(CAM_CHOICE, 1);
> +	gpio_export(CAM_CHOICE, false);

Why are exporting this and two more gpios below? Does this allow you to 
switch cameras from the user-space? Even if so, I wouldn't push this 
upstream, as you won't need this in the future, when you add proper 
support for the second camera into the kernel.

> +	ret = gpio_request(BASECAM_RST_B, "basecam-reset");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(BASECAM_RST_B, 1);
> +	ret = gpio_request(BASECAM_POWER, "basecam-standby");
> +	if (ret)
> +		return ret;
> +	gpio_direction_output(BASECAM_POWER, 0);
> +
> +	/*temporary part: we must use the mux better*/

Please, add spaces around text in comment.

> +	gpio_request(TURRETCAM_RST_B, "turretcam-reset");
> +	gpio_direction_output(TURRETCAM_RST_B, 1);
> +	gpio_export(TURRETCAM_RST_B, false);
> +
> +	gpio_request(TURRETCAM_POWER, "turretcam-standby");
> +	gpio_direction_output(TURRETCAM_POWER, 0);
> +	gpio_export(TURRETCAM_POWER, false);
> +
> +	return platform_device_register(&marxbot_camera);
> +}
> +
> +
>  /*
>   * system init for baseboard usage. Will be called by mx31moboard init.
>   */
> diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
> index 706a993..605c0fa 100644
> --- a/arch/arm/mach-mx3/mx31moboard.c
> +++ b/arch/arm/mach-mx3/mx31moboard.c
> @@ -40,7 +40,7 @@
>  #include <mach/ipu.h>
>  #include <mach/i2c.h>
>  #include <mach/mmc.h>
> -#include <mach/mx31.h>
> +#include <mach/mx3_camera.h>

Need

#include <linux/dma-mapping.h>

for DMA_MEMORY_MAP and DMA_MEMORY_EXCLUSIVE macros, etc.

>  
>  #include "devices.h"
>  
> @@ -287,6 +287,39 @@ static struct platform_device *devices[] __initdata = {
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
> @@ -312,6 +345,8 @@ static void __init mxc_board_init(void)
>  	mxc_register_device(&mxcsdhc_device0, &sdhc1_pdata);
>  
>  	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
> +	if (!mx31moboard_cam_alloc_dma(CAMERA_BUF_SIZE))
> +		mxc_register_device(&mx3_camera, &camera_pdata);
>  
>  	usb_xcvr_reset();
>  
> -- 
> 1.6.0.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
