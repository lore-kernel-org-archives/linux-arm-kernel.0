From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue, 11 May 2010 10:53:55 +0200
Subject: [PATCH 2/3] mx31moboard: Move usb OTG device registration
In-Reply-To: <1273513795-28247-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1273513795-28247-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-2-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <4BE91B23.5090404@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2010 07:49 PM, Philippe R?tornaz wrote:
> In preparation for a new robot which need the
> OTG port as host.

s/need/needs/

>
> This move the OTG device registration into board
> initialisation.

s/move/moves

Othewise,

Acked-by: Valentin Longchamp<valentin.longchamp@epfl.ch>

>
> Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
> ---
>   arch/arm/mach-mx3/mach-mx31moboard.c     |    7 -------
>   arch/arm/mach-mx3/mx31moboard-devboard.c |    9 +++++++++
>   arch/arm/mach-mx3/mx31moboard-marxbot.c  |    8 ++++++++
>   arch/arm/mach-mx3/mx31moboard-smartbot.c |    8 ++++++++
>   4 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
> index 5c44489..4bb011a 100644
> --- a/arch/arm/mach-mx3/mach-mx31moboard.c
> +++ b/arch/arm/mach-mx3/mach-mx31moboard.c
> @@ -18,7 +18,6 @@
>
>   #include<linux/delay.h>
>   #include<linux/dma-mapping.h>
> -#include<linux/fsl_devices.h>
>   #include<linux/gfp.h>
>   #include<linux/gpio.h>
>   #include<linux/init.h>
> @@ -353,11 +352,6 @@ static void usb_xcvr_reset(void)
>   	mdelay(1);
>   }
>
> -static struct fsl_usb2_platform_data usb_pdata = {
> -	.operating_mode	= FSL_USB2_DR_DEVICE,
> -	.phy_mode	= FSL_USB2_PHY_ULPI,
> -};
> -
>   #if defined(CONFIG_USB_ULPI)
>
>   static struct mxc_usbh_platform_data usbh2_pdata = {
> @@ -485,7 +479,6 @@ static void __init mxc_board_init(void)
>
>   	usb_xcvr_reset();
>
> -	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
>   	moboard_usbh2_init();
>
>   	switch (mx31moboard_baseboard) {
> diff --git a/arch/arm/mach-mx3/mx31moboard-devboard.c b/arch/arm/mach-mx3/mx31moboard-devboard.c
> index 11b906c..582299c 100644
> --- a/arch/arm/mach-mx3/mx31moboard-devboard.c
> +++ b/arch/arm/mach-mx3/mx31moboard-devboard.c
> @@ -22,6 +22,7 @@
>   #include<linux/platform_device.h>
>   #include<linux/slab.h>
>   #include<linux/types.h>
> +#include<linux/fsl_devices.h>
>
>   #include<linux/usb/otg.h>
>
> @@ -213,6 +214,12 @@ static int __init devboard_usbh1_init(void)
>   	return mxc_register_device(&mxc_usbh1,&usbh1_pdata);
>   }
>
> +
> +static struct fsl_usb2_platform_data usb_pdata = {
> +	.operating_mode	= FSL_USB2_DR_DEVICE,
> +	.phy_mode	= FSL_USB2_PHY_ULPI,
> +};
> +
>   /*
>    * system init for baseboard usage. Will be called by mx31moboard init.
>    */
> @@ -229,5 +236,7 @@ void __init mx31moboard_devboard_init(void)
>
>   	devboard_init_sel_gpios();
>
> +	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
> +
>   	devboard_usbh1_init();
>   }
> diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> index 8cf3ad2..a1dffcb 100644
> --- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
> +++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
> @@ -25,6 +25,7 @@
>   #include<linux/slab.h>
>   #include<linux/platform_device.h>
>   #include<linux/types.h>
> +#include<linux/fsl_devices.h>
>
>   #include<linux/usb/otg.h>
>
> @@ -331,6 +332,11 @@ static int __init marxbot_usbh1_init(void)
>   	return mxc_register_device(&mxc_usbh1,&usbh1_pdata);
>   }
>
> +static struct fsl_usb2_platform_data usb_pdata = {
> +	.operating_mode	= FSL_USB2_DR_DEVICE,
> +	.phy_mode	= FSL_USB2_PHY_ULPI,
> +};
> +
>   /*
>    * system init for baseboard usage. Will be called by mx31moboard init.
>    */
> @@ -358,5 +364,7 @@ void __init mx31moboard_marxbot_init(void)
>   	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_LCS0));
>   	gpio_export(IOMUX_TO_GPIO(MX31_PIN_LCS0), false);
>
> +	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
> +
>   	marxbot_usbh1_init();
>   }
> diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
> index 83d2b9f..ac1a163 100644
> --- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
> +++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
> @@ -23,6 +23,7 @@
>   #include<linux/i2c.h>
>   #include<linux/platform_device.h>
>   #include<linux/types.h>
> +#include<linux/fsl_devices.h>
>
>   #include<mach/common.h>
>   #include<mach/hardware.h>
> @@ -116,6 +117,11 @@ static int __init smartbot_cam_init(void)
>   	return 0;
>   }
>
> +static struct fsl_usb2_platform_data usb_pdata = {
> +	.operating_mode	= FSL_USB2_DR_DEVICE,
> +	.phy_mode	= FSL_USB2_PHY_ULPI,
> +};
> +
>   #define POWER_EN IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
>   #define DSPIC_RST_B IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
>   #define TRSLAT_RST_B IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
> @@ -155,6 +161,8 @@ void __init mx31moboard_smartbot_init(void)
>
>   	mxc_register_device(&mxc_uart_device1,&uart_pdata);
>
> +	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
> +
>   	smartbot_resets_init();
>
>   	smartbot_cam_init();


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
