From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 Nov 2011 08:52:29 +0100
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
In-Reply-To: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
References: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20111129075229.GE27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 03:09:25PM +0800, Peter Chen wrote:
> The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
> platform_device_id to distinguish the ehci differences among SoCs.
> It can be useful to imx ehci submission and device tree support later.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/mach-imx/clock-imx25.c                 |    6 +-
>  arch/arm/mach-imx/clock-imx27.c                 |   12 +-
>  arch/arm/mach-imx/clock-imx31.c                 |   12 +-
>  arch/arm/mach-imx/clock-imx35.c                 |    6 +-
>  arch/arm/mach-mx5/clock-mx51-mx53.c             |   14 ++--
>  arch/arm/plat-mxc/devices/platform-mxc-ehci.c   |   40 +++++---
>  arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
>  drivers/usb/host/ehci-mxc.c                     |  118 ++++++++++++++++++++++-
>  8 files changed, 166 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
> index b0fec74..8288b6e 100644
> --- a/arch/arm/mach-imx/clock-imx25.c
> +++ b/arch/arm/mach-imx/clock-imx25.c
> @@ -279,9 +279,9 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
>  	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
>  	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx25.0", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx25.1", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx25.2", "usb", usbotg_clk)

No. Please add a dummy ahb clock for the SoCs which do not have a real
one. Then you don't have to care about the differerences between the
SoCs in the driver at all.

>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
>  	/* i.mx25 has the i.mx35 type cspi */
> diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
> index 88fe00a..fcbf0ec 100644
> --- a/arch/arm/mach-imx/clock-imx27.c
> +++ b/arch/arm/mach-imx/clock-imx27.c
> @@ -648,12 +648,12 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx27.0", "usb", usb_clk)
> +	_REGISTER_CLOCK("ehci-imx27.0", "usb_ahb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx27.1", "usb", usb_clk)
> +	_REGISTER_CLOCK("ehci-imx27.1", "usb_ahb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx27.2", "usb", usb_clk)
> +	_REGISTER_CLOCK("ehci-imx27.2", "usb_ahb", usb_clk1)
>  	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
>  	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
>  	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
> diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
> index 988a281..cae39b1 100644
> --- a/arch/arm/mach-imx/clock-imx31.c
> +++ b/arch/arm/mach-imx/clock-imx31.c
> @@ -538,12 +538,12 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
>  	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
>  	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk2)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk2)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk2)
> +	_REGISTER_CLOCK("ehci-imx31.0", "usb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx31.0", "usb_ahb", usb_clk2)
> +	_REGISTER_CLOCK("ehci-imx31.1", "usb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx31.1", "usb_ahb", usb_clk2)
> +	_REGISTER_CLOCK("ehci-imx31.2", "usb", usb_clk1)
> +	_REGISTER_CLOCK("ehci-imx31.2", "usb_ahb", usb_clk2)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk1)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk2)
>  	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
> diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
> index 8116f11..661b884 100644
> --- a/arch/arm/mach-imx/clock-imx35.c
> +++ b/arch/arm/mach-imx/clock-imx35.c
> @@ -491,9 +491,9 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
>  	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
>  	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx35.0", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx35.1", "usb", usbotg_clk)
> +	_REGISTER_CLOCK("ehci-imx35.2", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
>  	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 4cb2769..56dc34b 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1459,13 +1459,13 @@ static struct clk_lookup mx51_lookups[] = {
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
>  	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
>  	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_ahb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_ahb_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
> -	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_ahb_clk)
> +	_REGISTER_CLOCK("ehci-imx51.0", "usb", usboh3_clk)
> +	_REGISTER_CLOCK("ehci-imx51.0", "usb_ahb", usb_ahb_clk)
> +	_REGISTER_CLOCK("ehci-imx51.0", "usb_phy1", usb_phy1_clk)

The real solution for the phy clock is to handle the phy completely
outside the ehci driver. The phy is a resource shared between the
ehci and the corresponding gadget driver.
I suggest to handle the phy clock in mx51_initialize_usb_hw instead
since we have all phy related code in this function. This is a good
place until we finally have a real phy driver.

> +	_REGISTER_CLOCK("ehci-imx51.1", "usb", usboh3_clk)
> +	_REGISTER_CLOCK("ehci-imx51.1", "usb_ahb", usb_ahb_clk)
> +	_REGISTER_CLOCK("ehci-imx51.2", "usb", usboh3_clk)
> +	_REGISTER_CLOCK("ehci-imx51.2", "usb_ahb", usb_ahb_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>  	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
> index 35851d8..d339887 100644

[...]

> diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
> index def9ba5..15b68e8 100644
> --- a/arch/arm/plat-mxc/include/mach/devices-common.h
> +++ b/arch/arm/plat-mxc/include/mach/devices-common.h
> @@ -226,6 +226,7 @@ struct platform_device *__init imx_add_mx2_camera(
>  
>  #include <mach/mxc_ehci.h>
>  struct imx_mxc_ehci_data {
> +	const char *devid;
>  	int id;
>  	resource_size_t iobase;
>  	resource_size_t irq;
> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
> index 55978fc..6f6b00a 100644
> --- a/drivers/usb/host/ehci-mxc.c
> +++ b/drivers/usb/host/ehci-mxc.c
> @@ -23,6 +23,7 @@
>  #include <linux/usb/otg.h>
>  #include <linux/usb/ulpi.h>
>  #include <linux/slab.h>
> +#include <linux/of_device.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/mxc_ehci.h>
> @@ -31,10 +32,116 @@
>  
>  #define ULPI_VIEWPORT_OFFSET	0x170
>  
> +enum mxc_ehci_type {
> +	IMX23_EHCI,
> +	IMX25_EHCI,
> +	IMX28_EHCI,
> +	IMX31_EHCI,
> +	IMX35_EHCI,
> +	IMX50_EHCI,
> +	IMX51_EHCI,
> +	IMX53_EHCI,
> +	IMX6Q_EHCI,
> +};

Instead of adding this enum you should introduce a SoC specific driver
data struct and add fields to this where you describe the differences
between the SoCs.
All the if(mxc_*_ehci()) need fixes for each new SoC revision. Do a
if(soc_data->has_ahb_clk) instead.
Only a hint for next time since I think there are no differences to
be handled in the driver once we have dummy ahb clocks.

> +
>  struct ehci_mxc_priv {
>  	struct clk *usbclk, *ahbclk, *phy1clk;
>  	struct usb_hcd *hcd;
> +	enum mxc_ehci_type devtype;
> +};
> +
> +static struct platform_device_id mxc_ehci_devtype[] = {
> +	{
> +		.name = "ehci-imx23",
> +		.driver_data = IMX25_EHCI,
> +	}, {
> +		.name = "ehci-imx25",
> +		.driver_data = IMX35_EHCI,
> +	}, {
> +		.name = "ehci-imx28",
> +		.driver_data = IMX35_EHCI,
> +	}, {
> +		.name = "ehci-imx31",
> +		.driver_data = IMX35_EHCI,
> +	}, {
> +		.name = "ehci-imx35",
> +		.driver_data = IMX35_EHCI,
> +	}, {
> +		.name = "ehci-imx50",
> +		.driver_data = IMX51_EHCI,
> +	}, {
> +		.name = "ehci-imx51",
> +		.driver_data = IMX51_EHCI,
> +	}, {
> +		.name = "ehci-imx53",
> +		.driver_data = IMX53_EHCI,
> +	}, {
> +		.name = "ehci-imx6q",
> +		.driver_data = IMX6Q_EHCI,
> +	}, {
> +		/* sentinel */
> +	}
>  };
> +MODULE_DEVICE_TABLE(platform, mxc_ehci_devtype);
> +
> +static const struct of_device_id imx_ehci_dt_ids[] = {
> +	{ .compatible = "fsl,imx23-ehci", .data = &mxc_ehci_devtype[IMX23_EHCI], },
> +	{ .compatible = "fsl,imx25-ehci", .data = &mxc_ehci_devtype[IMX25_EHCI], },
> +	{ .compatible = "fsl,imx28-ehci", .data = &mxc_ehci_devtype[IMX28_EHCI], },
> +	{ .compatible = "fsl,imx31-ehci", .data = &mxc_ehci_devtype[IMX31_EHCI], },
> +	{ .compatible = "fsl,imx35-ehci", .data = &mxc_ehci_devtype[IMX35_EHCI], },
> +	{ .compatible = "fsl,imx50-ehci", .data = &mxc_ehci_devtype[IMX50_EHCI], },
> +	{ .compatible = "fsl,imx51-ehci", .data = &mxc_ehci_devtype[IMX51_EHCI], },
> +	{ .compatible = "fsl,imx53-ehci", .data = &mxc_ehci_devtype[IMX53_EHCI], },
> +	{ .compatible = "fsl,imx6q-ehci", .data = &mxc_ehci_devtype[IMX6Q_EHCI], },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_ehci_dt_ids);
> +

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
