From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 25 Feb 2010 09:02:59 +0100
Subject: [PATCH] MXC: mach_armadillo5x0: Add USB Host support.
In-Reply-To: <1267054032.3870.47.camel@realization>
References: <1267054032.3870.47.camel@realization>
Message-ID: <20100225080259.GA13295@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Thu, Feb 25, 2010 at 12:27:12AM +0100, Alberto Panizzo wrote:
> This add USB Host capability. The Armadillo 500 board is supplied
> with two USB Host connectors driven by the USB OTG and USB Host 2
> ports, through two NXP isp 1504 transceivers.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
> 
> Sascha, if there aren't problems, can you add this for 2.6.34?
> 
>  arch/arm/mach-mx3/Kconfig             |    1 +
>  arch/arm/mach-mx3/mach-armadillo5x0.c |  128 +++++++++++++++++++++++++++++++++
>  2 files changed, 129 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
> index 3872af1..96069a4 100644
> --- a/arch/arm/mach-mx3/Kconfig
> +++ b/arch/arm/mach-mx3/Kconfig
> @@ -95,6 +95,7 @@ config MACH_PCM043
>  config MACH_ARMADILLO5X0
>  	bool "Support Atmark Armadillo-500 Development Base Board"
>  	select ARCH_MX31
> +	select MXC_ULPI if USB_ULPI
>  	help
>  	  Include support for Atmark Armadillo-500 platform. This includes
>  	  specific configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-mx3/mach-armadillo5x0.c b/arch/arm/mach-mx3/mach-armadillo5x0.c
> index 3d72b0b..a29f8ef 100644
> --- a/arch/arm/mach-mx3/mach-armadillo5x0.c
> +++ b/arch/arm/mach-mx3/mach-armadillo5x0.c
> @@ -36,6 +36,9 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/i2c.h>
> +#include <linux/usb/otg.h>
> +#include <linux/usb/ulpi.h>
> +#include <linux/delay.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -52,6 +55,8 @@
>  #include <mach/ipu.h>
>  #include <mach/mx3fb.h>
>  #include <mach/mxc_nand.h>
> +#include <mach/mxc_ehci.h>
> +#include <mach/ulpi.h>
>  
>  #include "devices.h"
>  #include "crm_regs.h"
> @@ -103,6 +108,118 @@ static int armadillo5x0_pins[] = {
>  	/* I2C2 */
>  	MX31_PIN_CSPI2_MOSI__SCL,
>  	MX31_PIN_CSPI2_MISO__SDA,
> +	/* OTG */
> +	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
> +	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
> +	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
> +	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
> +	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
> +	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
> +	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
> +	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
> +	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
> +	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
> +	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
> +	MX31_PIN_USBOTG_STP__USBOTG_STP,
> +	/* USB host 2 */
> +	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
> ...
I think you need to protect all hunks by
#ifdef CONFIG_USB_ULPI

For the pin-setup it's not important, but you must not call
otg_ulpi_create if USB_ULPI isn't configured.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
