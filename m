From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 24 Nov 2010 10:51:28 +0530
Subject: [patch 1/1] iMX51: introduce MX51_GPIO_NR
In-Reply-To: <20101122224526.987309475@rtp-net.org>
References: <20101122224526.987309475@rtp-net.org>
Message-ID: <20101124052128.GA15971@sahyadri-mini10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Nov 22, Arnaud Patard wrote:
> Currently, to define a GPIO number, we're using something like :
> 
> #define EFIKAMX_PCBID0         (2*32 + 16)
> 
> to define GPIO 3 16.
> 
> This is not really readable and it's error prone imho (note the 3 vs 2).
> So, I'm introducing a new macro to define this in a better way. Now, the
> code sample become :
> 
> #define EFIKAMX_PCBID0         MX51_GPIO_NR(3, 16)
>

I have been unhappy over the readability of the existing gpios definitions.
So this patch is welcome. A couple of commments below.

> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Eric B?nard <eric@eukrea.com>
> 
> Index: gpionr/arch/arm/mach-mx5/board-cpuimx51sd.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/board-cpuimx51sd.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/board-cpuimx51sd.c	2010-11-22 23:04:25.000000000 +0100
> @@ -43,19 +43,19 @@
>  #include "devices-imx51.h"
>  #include "devices.h"
>  
> -#define USBH1_RST		(1*32 + 28)
> -#define ETH_RST			(1*32 + 31)
> -#define TSC2007_IRQGPIO		(2*32 + 12)
> -#define CAN_IRQGPIO		(0*32 + 1)
> -#define CAN_RST			(3*32 + 15)
> -#define CAN_NCS			(3*32 + 24)
> -#define CAN_RXOBF		(0*32 + 4)
> -#define CAN_RX1BF		(0*32 + 6)
> -#define CAN_TXORTS		(0*32 + 7)
> -#define CAN_TX1RTS		(0*32 + 8)
> -#define CAN_TX2RTS		(0*32 + 9)
> -#define I2C_SCL			(3*32 + 16)
> -#define I2C_SDA			(3*32 + 17)
> +#define USBH1_RST		MX51_GPIO_NR(2, 28)
> +#define ETH_RST			MX51_GPIO_NR(2, 31)
> +#define TSC2007_IRQGPIO		MX51_GPIO_NR(3, 12)
> +#define CAN_IRQGPIO		MX51_GPIO_NR(1, 1)
> +#define CAN_RST			MX51_GPIO_NR(4, 15)
> +#define CAN_NCS			MX51_GPIO_NR(4, 24)
> +#define CAN_RXOBF		MX51_GPIO_NR(1, 4)
> +#define CAN_RX1BF		MX51_GPIO_NR(1, 6)
> +#define CAN_TXORTS		MX51_GPIO_NR(1, 7)
> +#define CAN_TX1RTS		MX51_GPIO_NR(1, 8)
> +#define CAN_TX2RTS		MX51_GPIO_NR(1, 9)
> +#define I2C_SCL			MX51_GPIO_NR(4, 16)
> +#define I2C_SDA			MX51_GPIO_NR(4, 17)
>  
>  /* USB_CTRL_1 */
>  #define MX51_USB_CTRL_1_OFFSET		0x10
> @@ -243,7 +243,7 @@
>  		.mode		= SPI_MODE_0,
>  		.chip_select     = 0,
>  		.platform_data   = &mcp251x_info,
> -		.irq             = gpio_to_irq(0 * 32 + 1)
> +		.irq             = gpio_to_irq(CAN_IRQGPIO)
>  	},
>  };
>  
> Index: gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> ===================================================================
> --- gpionr.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:25.000000000 +0100
> @@ -15,6 +15,8 @@
>  
>  #include <mach/iomux-v3.h>
>  

Please add a comment here that bank numbers start from 1 to make it explicit

> +#define MX51_GPIO_NR(bank, nr)		((bank-1)*32+nr)
> +
                                                 ^^^^^^^^^ whitespace fixes

Also, why is this in iomux-mx51.h? It might be better to introduce a gpio.h

>  /*
>   * various IOMUX alternate output functions (1-7)
>   */
> Index: gpionr/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c	2010-11-22 23:04:25.000000000 +0100
> @@ -33,12 +33,12 @@
>  #include "devices-imx51.h"
>  #include "devices.h"
>  
> -#define MBIMX51_TSC2007_GPIO	(2*32 + 30)
> +#define MBIMX51_TSC2007_GPIO	MX51_GPIO_NR(3, 30)
>  #define MBIMX51_TSC2007_IRQ	(MXC_INTERNAL_IRQS + MBIMX51_TSC2007_GPIO)
> -#define MBIMX51_LED0		(2*32 + 5)
> -#define MBIMX51_LED1		(2*32 + 6)
> -#define MBIMX51_LED2		(2*32 + 7)
> -#define MBIMX51_LED3		(2*32 + 8)
> +#define MBIMX51_LED0		MX51_GPIO_NR(3, 5)
> +#define MBIMX51_LED1		MX51_GPIO_NR(3, 6)
> +#define MBIMX51_LED2		MX51_GPIO_NR(3, 7)
> +#define MBIMX51_LED3		MX51_GPIO_NR(3, 8)
>  
>  static struct gpio_led mbimx51_leds[] = {
>  	{
> Index: gpionr/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c	2010-11-22 23:04:25.000000000 +0100
> @@ -70,8 +70,8 @@
>  	MX51_PAD_SD1_DATA3__SD1_DATA3,
>  };
>  
> -#define GPIO_LED1	(2 * 32 + 30)
> -#define GPIO_SWITCH1	(2 * 32 + 31)
> +#define GPIO_LED1	MX51_GPIO_NR(3, 30)
> +#define GPIO_SWITCH1	MX51_GPIO_NR(3, 31)
>  
>  static struct gpio_led eukrea_mbimxsd_leds[] = {
>  	{
> Index: gpionr/arch/arm/mach-mx5/board-cpuimx51.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/board-cpuimx51.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/board-cpuimx51.c	2010-11-22 23:04:25.000000000 +0100
> @@ -40,11 +40,11 @@
>  #include "devices-imx51.h"
>  #include "devices.h"
>  
> -#define CPUIMX51_USBH1_STP	(0*32 + 27)
> -#define CPUIMX51_QUARTA_GPIO	(2*32 + 28)
> -#define CPUIMX51_QUARTB_GPIO	(2*32 + 25)
> -#define CPUIMX51_QUARTC_GPIO	(2*32 + 26)
> -#define CPUIMX51_QUARTD_GPIO	(2*32 + 27)
> +#define CPUIMX51_USBH1_STP	MX51_GPIO_NR(1, 27)
> +#define CPUIMX51_QUARTA_GPIO	MX51_GPIO_NR(3, 28)
> +#define CPUIMX51_QUARTB_GPIO	MX51_GPIO_NR(3, 25)
> +#define CPUIMX51_QUARTC_GPIO	MX51_GPIO_NR(3, 26)
> +#define CPUIMX51_QUARTD_GPIO	MX51_GPIO_NR(3, 27)
>  #define CPUIMX51_QUARTA_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTA_GPIO)
>  #define CPUIMX51_QUARTB_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTB_GPIO)
>  #define CPUIMX51_QUARTC_IRQ	(MXC_INTERNAL_IRQS + CPUIMX51_QUARTC_GPIO)
> Index: gpionr/arch/arm/mach-mx5/board-mx51_efikamx.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/board-mx51_efikamx.c	2010-11-22 23:04:25.000000000 +0100
> @@ -43,22 +43,22 @@
>  
>  #define	MX51_USB_PLL_DIV_24_MHZ	0x01
>  
> -#define EFIKAMX_PCBID0		(2*32 + 16)
> -#define EFIKAMX_PCBID1		(2*32 + 17)
> -#define EFIKAMX_PCBID2		(2*32 + 11)
> -
> -#define EFIKAMX_BLUE_LED	(2*32 + 13)
> -#define EFIKAMX_GREEN_LED	(2*32 + 14)
> -#define EFIKAMX_RED_LED		(2*32 + 15)
> +#define EFIKAMX_PCBID0		MX51_GPIO_NR(3, 16)
> +#define EFIKAMX_PCBID1		MX51_GPIO_NR(3, 17)
> +#define EFIKAMX_PCBID2		MX51_GPIO_NR(3, 11)
> +
> +#define EFIKAMX_BLUE_LED	MX51_GPIO_NR(3, 13)
> +#define EFIKAMX_GREEN_LED	MX51_GPIO_NR(3, 14)
> +#define EFIKAMX_RED_LED		MX51_GPIO_NR(3, 15)
>  
> -#define EFIKAMX_POWER_KEY	(1*32 + 31)
> +#define EFIKAMX_POWER_KEY	MX51_GPIO_NR(2, 31)
>  
> -#define EFIKAMX_SPI_CS0		(3*32 + 24)
> -#define EFIKAMX_SPI_CS1		(3*32 + 25)
> +#define EFIKAMX_SPI_CS0		MX51_GPIO_NR(4, 24)
> +#define EFIKAMX_SPI_CS1		MX51_GPIO_NR(4, 25)
>  
>  /* board 1.1 doesn't have same reset gpio */
> -#define EFIKAMX_RESET1_1	(2*32 + 2)
> -#define EFIKAMX_RESET		(0*32 + 4)
> +#define EFIKAMX_RESET1_1	MX51_GPIO_NR(3, 2)
> +#define EFIKAMX_RESET		MX51_GPIO_NR(1, 4)
>  
>  /* the pci ids pin have pull up. they're driven low according to board id */
>  #define MX51_PAD_PCBID0	IOMUX_PAD(0x518, 0x130, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
> Index: gpionr/arch/arm/mach-mx5/board-mx51_babbage.c
> ===================================================================
> --- gpionr.orig/arch/arm/mach-mx5/board-mx51_babbage.c	2010-11-22 23:04:23.000000000 +0100
> +++ gpionr/arch/arm/mach-mx5/board-mx51_babbage.c	2010-11-22 23:04:25.000000000 +0100
> @@ -38,13 +38,13 @@
>  #include "devices.h"
>  #include "cpu_op-mx51.h"
>  
> -#define BABBAGE_USB_HUB_RESET	(0*32 + 7)	/* GPIO_1_7 */
> -#define BABBAGE_USBH1_STP	(0*32 + 27)	/* GPIO_1_27 */
> -#define BABBAGE_PHY_RESET	(1*32 + 5)	/* GPIO_2_5 */
> -#define BABBAGE_FEC_PHY_RESET	(1*32 + 14)	/* GPIO_2_14 */
> -#define BABBAGE_POWER_KEY	(1*32 + 21)	/* GPIO_2_21 */
> -#define BABBAGE_ECSPI1_CS0	(3*32 + 24)	/* GPIO_4_24 */
> -#define BABBAGE_ECSPI1_CS1	(3*32 + 25)	/* GPIO_4_25 */
> +#define BABBAGE_USB_HUB_RESET	MX51_GPIO_NR(1, 7)
> +#define BABBAGE_USBH1_STP	MX51_GPIO_NR(1, 27)
> +#define BABBAGE_PHY_RESET	MX51_GPIO_NR(2, 5)
> +#define BABBAGE_FEC_PHY_RESET	MX51_GPIO_NR(2, 14)
> +#define BABBAGE_POWER_KEY	MX51_GPIO_NR(2, 21)
> +#define BABBAGE_ECSPI1_CS0	MX51_GPIO_NR(4, 24)
> +#define BABBAGE_ECSPI1_CS1	MX51_GPIO_NR(4, 25)
>  
>  /* USB_CTRL_1 */
>  #define MX51_USB_CTRL_1_OFFSET			0x10
> 
> 
