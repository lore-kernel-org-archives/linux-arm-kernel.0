From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 15 Mar 2010 18:17:20 +0100
Subject: [PATCH 7/8] i.MX31 pcm037: Add USB support
In-Reply-To: <1265295825-8705-8-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-7-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268673440.3798.4.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On gio, 2010-02-04 at 16:03 +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/Kconfig       |    1 +
>  arch/arm/mach-mx3/mach-pcm037.c |  137 +++++---
>  arch/arm/mach-mx3/pcm037.c      |  795 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-mx3/pcm043.c      |  367 ++++++++++++++++++
>  4 files changed, 1255 insertions(+), 45 deletions(-)
>  create mode 100644 arch/arm/mach-mx3/pcm037.c
>  create mode 100644 arch/arm/mach-mx3/pcm043.c
> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 2829441..2232b7b 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -34,6 +34,7 @@ config MACH_MX31ADS_WM1133_EV1
>  config MACH_PCM037
>  	bool "Support Phytec pcm037 (i.MX31) platforms"
>  	select ARCH_MX31
> +	select MXC_ULPI if USB_ULPI
>  	help
>  	  Include support for Phytec pcm037 platform. This includes
>  	  specific configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
> index 21f5481..11f5315 100644
> --- a/arch/arm/mach-mx3/mach-pcm037.c
> +++ b/arch/arm/mach-mx3/mach-pcm037.c
> @@ -33,6 +33,9 @@
>  #include <linux/irq.h>
>  #include <linux/fsl_devices.h>
>  #include <linux/can/platform/sja1000.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/ulpi.h>
> +#include <linux/fsl_devices.h>
>  
>  #include <media/soc_camera.h>
>  
> @@ -51,6 +54,8 @@
>  #include <mach/mx3_camera.h>
>  #include <mach/mx3fb.h>
>  #include <mach/mxc_nand.h>
> +#include <mach/mxc_ehci.h>
> +#include <mach/ulpi.h>
>  
>  #include "devices.h"
>  #include "pcm037.h"
> @@ -172,19 +177,7 @@ static unsigned int pcm037_pins[] = {
>  	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
>  	/* GPIO */
>  	IOMUX_MODE(MX31_PIN_ATA_DMACK, IOMUX_CONFIG_GPIO),
> -};
> -
> -static struct physmap_flash_data pcm037_flash_data = {
> -	.width  = 2,
> -};
> -
> -static struct resource pcm037_flash_resource = {
> -	.start	= 0xa0000000,
> -	.end	= 0xa1ffffff,
> -	.flags	= IORESOURCE_MEM,
> -};
> -
> -static int usbotg_pins[] = {
> +	/* OTG */
>  	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
>  	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
>  	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
> @@ -197,39 +190,29 @@ static int usbotg_pins[] = {
>  	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
>  	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
>  	MX31_PIN_USBOTG_STP__USBOTG_STP,
> +	/* USB host 2 */
> +	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_NXT, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_STP, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_DATA0, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_DATA1, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_STXD3, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_SRXD3, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_SCK3, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_SFS3, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_STXD6, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_SRXD6, IOMUX_CONFIG_FUNC),
>  };
>  
> -/* USB OTG HS port */
> -static int __init gpio_usbotg_hs_activate(void)
> -{
> -	int ret = mxc_iomux_setup_multiple_pins(usbotg_pins,
> -					ARRAY_SIZE(usbotg_pins), "usbotg");
> -
> -	if (ret < 0) {
> -		printk(KERN_ERR "Cannot set up OTG pins\n");
> -		return ret;
> -	}
> -
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
> -
> -	return 0;
> -}
> +static struct physmap_flash_data pcm037_flash_data = {
> +	.width  = 2,
> +};
>  
> -/* OTG config */
> -static struct fsl_usb2_platform_data usb_pdata = {
> -	.operating_mode	= FSL_USB2_DR_DEVICE,
> -	.phy_mode	= FSL_USB2_PHY_ULPI,
> +static struct resource pcm037_flash_resource = {
> +	.start	= 0xa0000000,
> +	.end	= 0xa1ffffff,
> +	.flags	= IORESOURCE_MEM,
>  };
>  
>  static struct platform_device pcm037_flash = {
> @@ -561,16 +544,65 @@ static struct platform_device pcm970_sja1000 = {
>  	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
>  };
>  
> +static struct mxc_usbh_platform_data otg_pdata = {
> +	.portsc	= MXC_EHCI_MODE_ULPI,
> +	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
> +};
> +
> +static struct mxc_usbh_platform_data usbh2_pdata = {
> +	.portsc	= MXC_EHCI_MODE_ULPI,
> +	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
> +};
> +
> +static struct fsl_usb2_platform_data otg_device_pdata = {
> +	.operating_mode = FSL_USB2_DR_DEVICE,
> +	.phy_mode       = FSL_USB2_PHY_ULPI,
> +};
> +
> +static int otg_mode_host;
> +
> +static int __init pcm037_otg_mode(char *options)
> +{
> +	if (!strcmp(options, "host"))
> +		otg_mode_host = 1;
> +	else if (!strcmp(options, "device"))
> +		otg_mode_host = 0;
> +	else
> +		pr_info("otg_mode neither \"host\" nor \"device\". "
> +			"Defaulting to device\n");
> +	return 0;
> +}
> +__setup("otg_mode=", pcm037_otg_mode);
> +
>  /*
>   * Board specific initialization.
>   */
>  static void __init mxc_board_init(void)
>  {
>  	int ret;
> +	u32 tmp;
> +
> +	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
>  
>  	mxc_iomux_setup_multiple_pins(pcm037_pins, ARRAY_SIZE(pcm037_pins),
>  			"pcm037");
>  
> +#define H2_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS \
> +		| PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
> +
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, H2_PAD_CFG);
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, H2_PAD_CFG);
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, H2_PAD_CFG);
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, H2_PAD_CFG);
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, H2_PAD_CFG); /* USBH2_DATA0 */
> +	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, H2_PAD_CFG); /* USBH2_DATA1 */
> +	mxc_iomux_set_pad(MX31_PIN_SRXD6, H2_PAD_CFG);	/* USBH2_DATA2 */
> +	mxc_iomux_set_pad(MX31_PIN_STXD6, H2_PAD_CFG);	/* USBH2_DATA3 */
> +	mxc_iomux_set_pad(MX31_PIN_SFS3, H2_PAD_CFG);	/* USBH2_DATA4 */
> +	mxc_iomux_set_pad(MX31_PIN_SCK3, H2_PAD_CFG);	/* USBH2_DATA5 */
> +	mxc_iomux_set_pad(MX31_PIN_SRXD3, H2_PAD_CFG);	/* USBH2_DATA6 */
> +	mxc_iomux_set_pad(MX31_PIN_STXD3, H2_PAD_CFG);	/* USBH2_DATA7 */
> +
>  	if (pcm037_variant() == PCM037_EET)
>  		mxc_iomux_setup_multiple_pins(pcm037_uart1_pins,
>  			ARRAY_SIZE(pcm037_uart1_pins), "pcm037_uart1");
> @@ -608,8 +640,6 @@ static void __init mxc_board_init(void)
>  	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
>  	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
>  	mxc_register_device(&mx3_fb, &mx3fb_pdata);
> -	if (!gpio_usbotg_hs_activate())
> -		mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
>  
>  	/* CSI */
>  	/* Camera power: default - off */
> @@ -623,6 +653,23 @@ static void __init mxc_board_init(void)
>  		mxc_register_device(&mx3_camera, &camera_pdata);
>  
>  	platform_device_register(&pcm970_sja1000);
> +
> +#if defined(CONFIG_USB_ULPI)
> +	if (otg_mode_host) {
> +		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
> +				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
> +
> +		mxc_register_device(&mxc_otg_host, &otg_pdata);
> +	}
> +
> +	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
> +				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
> +
> +	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
> +#endif
> +	if (!otg_mode_host)
> +		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
> +
>  }
>  
>  static void __init pcm037_timer_init(void)
> diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
> new file mode 100644

Sascha, maybe you do not want to reintroduce the file pcm037.c with this
patch.

Best regards,

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
