From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue, 11 May 2010 10:47:50 +0200
Subject: [PATCH 3/3] mx31moboard: OTG host support for smartbot board
In-Reply-To: <1273513795-28247-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1273513795-28247-1-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-2-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-3-git-send-email-philippe.retornaz@epfl.ch>
	<1273513795-28247-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <4BE919B6.8060201@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2010 07:49 PM, Philippe R?tornaz wrote:
> The Eyebot robot need the OTG port in host mode on the smartbot.

s/need/needs/

You have forgotten all the 's at the end of the verbs in all your 
patches (also in the previous series). Not so important, but change the 
commit message if some have to be resent.

>
> Add a new board definition so we can select the usb host/device
> mode at boot with the mx31moboard_baseboard boot parameter.

Ok, one small thing still below.

>
> Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
> ---
>   arch/arm/mach-mx3/mach-mx31moboard.c               |    3 +-
>   arch/arm/mach-mx3/mx31moboard-smartbot.c           |   36 ++++++++++++++++++-
>   arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    3 +-
>   3 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
> index 4bb011a..33a8d35 100644
> --- a/arch/arm/mach-mx3/mach-mx31moboard.c
> +++ b/arch/arm/mach-mx3/mach-mx31moboard.c
> @@ -491,7 +491,8 @@ static void __init mxc_board_init(void)
>   		mx31moboard_marxbot_init();
>   		break;
>   	case MX31SMARTBOT:
> -		mx31moboard_smartbot_init();
> +	case MX31EYEBOT:
> +		mx31moboard_smartbot_init(mx31moboard_baseboard);
>   		break;
>   	default:
>   		printk(KERN_ERR "Illegal mx31moboard_baseboard type %d\n",
> diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
> index ac1a163..aee0a14 100644
> --- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
> +++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
> @@ -25,10 +25,16 @@
>   #include<linux/types.h>
>   #include<linux/fsl_devices.h>
>
> +#include<linux/usb/otg.h>
> +#include<linux/usb/ulpi.h>
> +
>   #include<mach/common.h>
>   #include<mach/hardware.h>
>   #include<mach/imx-uart.h>
>   #include<mach/iomux-mx3.h>
> +#include<mach/board-mx31moboard.h>
> +#include<mach/mxc_ehci.h>
> +#include<mach/ulpi.h>
>
>   #include<media/soc_camera.h>
>
> @@ -122,6 +128,24 @@ static struct fsl_usb2_platform_data usb_pdata = {
>   	.phy_mode	= FSL_USB2_PHY_ULPI,
>   };
>
> +#if defined(CONFIG_USB_ULPI)
> +
> +static struct mxc_usbh_platform_data otg_host_pdata = {
> +	.portsc = MXC_EHCI_MODE_ULPI | MXC_EHCI_UTMI_8BIT,
> +	.flags	= MXC_EHCI_POWER_PINS_ENABLED,
> +};
> +
> +static int __init smartbot_otg_host_init(void)
> +{
> +	otg_host_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
> +			USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
> +
> +	return mxc_register_device(&mxc_otg_host,&otg_host_pdata);
> +}
> +#else
> +static inline int smartbot_otg_host_init(void) { return 0; }
> +#endif
> +
>   #define POWER_EN IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
>   #define DSPIC_RST_B IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
>   #define TRSLAT_RST_B IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
> @@ -152,7 +176,7 @@ static void smartbot_resets_init(void)
>   /*
>    * system init for baseboard usage. Will be called by mx31moboard init.
>    */
> -void __init mx31moboard_smartbot_init(void)
> +void __init mx31moboard_smartbot_init(int board)
>   {
>   	printk(KERN_INFO "Initializing mx31smartbot peripherals\n");
>
> @@ -161,7 +185,15 @@ void __init mx31moboard_smartbot_init(void)
>
>   	mxc_register_device(&mxc_uart_device1,&uart_pdata);
>
> -	mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
> +
> +	switch (board) {
> +	case MX31SMARTBOT:
> +		mxc_register_device(&mxc_otg_udc_device,&usb_pdata);
> +		break;
> +	case MX31EYEBOT:
> +		smartbot_otg_host_init();
> +		break;

I know it's never going to be called with anything different thant 
MX31SMARTBOT or MX31EYEBOT, but a default clause here with a message 
saying that we did not initialize anything (or to which of the two 
configuration it was default) wouldn't hurt.

> +	}
>
>   	smartbot_resets_init();
>
> diff --git a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
> index fc5fec9..36ff3ce 100644
> --- a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
> +++ b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
> @@ -26,6 +26,7 @@ enum mx31moboard_boards {
>   	MX31DEVBOARD	= 1,
>   	MX31MARXBOT	= 2,
>   	MX31SMARTBOT	= 3,
> +	MX31EYEBOT	= 4,
>   };
>
>   /*
> @@ -35,7 +36,7 @@ enum mx31moboard_boards {
>
>   extern void mx31moboard_devboard_init(void);
>   extern void mx31moboard_marxbot_init(void);
> -extern void mx31moboard_smartbot_init(void);
> +extern void mx31moboard_smartbot_init(int board);
>
>   #endif
>


-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEB3494, Station 9, CH-1015 Lausanne
