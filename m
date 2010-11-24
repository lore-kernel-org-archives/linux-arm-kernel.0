From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 24 Nov 2010 08:46:57 +0100
Subject: [patch 1/1] iMX51: introduce MX51_GPIO_NR
In-Reply-To: <20101124052128.GA15971@sahyadri-mini10>
References: <20101122224526.987309475@rtp-net.org>
	<20101124052128.GA15971@sahyadri-mini10>
Message-ID: <19692.49905.342605.548745@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Amit Kucheria writes:
> On 10 Nov 22, Arnaud Patard wrote:
> > Currently, to define a GPIO number, we're using something like :
> > 
> > #define EFIKAMX_PCBID0         (2*32 + 16)
> > 
> > to define GPIO 3 16.
> > 
> > This is not really readable and it's error prone imho (note the 3 vs 2).
> > So, I'm introducing a new macro to define this in a better way. Now, the
> > code sample become :
> > 
> > #define EFIKAMX_PCBID0         MX51_GPIO_NR(3, 16)
> >
> 
> I have been unhappy over the readability of the existing gpios definitions.
> So this patch is welcome. A couple of commments below.
> 
> > 
> > Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> > Cc: Amit Kucheria <amit.kucheria@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Eric B?nard <eric@eukrea.com>
> > 
> > Index: gpionr/arch/arm/mach-mx5/board-cpuimx51sd.c
> > ===================================================================
> > --- gpionr.orig/arch/arm/mach-mx5/board-cpuimx51sd.c	2010-11-22 23:04:23.000000000 +0100
> > +++ gpionr/arch/arm/mach-mx5/board-cpuimx51sd.c	2010-11-22 23:04:25.000000000 +0100
> > @@ -43,19 +43,19 @@
> >  #include "devices-imx51.h"
> >  #include "devices.h"
> >  
> > -#define USBH1_RST		(1*32 + 28)
> > -#define ETH_RST			(1*32 + 31)
> > -#define TSC2007_IRQGPIO		(2*32 + 12)
> > -#define CAN_IRQGPIO		(0*32 + 1)
> > -#define CAN_RST			(3*32 + 15)
> > -#define CAN_NCS			(3*32 + 24)
> > -#define CAN_RXOBF		(0*32 + 4)
> > -#define CAN_RX1BF		(0*32 + 6)
> > -#define CAN_TXORTS		(0*32 + 7)
> > -#define CAN_TX1RTS		(0*32 + 8)
> > -#define CAN_TX2RTS		(0*32 + 9)
> > -#define I2C_SCL			(3*32 + 16)
> > -#define I2C_SDA			(3*32 + 17)
> > +#define USBH1_RST		MX51_GPIO_NR(2, 28)
> > +#define ETH_RST			MX51_GPIO_NR(2, 31)
> > +#define TSC2007_IRQGPIO		MX51_GPIO_NR(3, 12)
> > +#define CAN_IRQGPIO		MX51_GPIO_NR(1, 1)
> > +#define CAN_RST			MX51_GPIO_NR(4, 15)
> > +#define CAN_NCS			MX51_GPIO_NR(4, 24)
> > +#define CAN_RXOBF		MX51_GPIO_NR(1, 4)
> > +#define CAN_RX1BF		MX51_GPIO_NR(1, 6)
> > +#define CAN_TXORTS		MX51_GPIO_NR(1, 7)
> > +#define CAN_TX1RTS		MX51_GPIO_NR(1, 8)
> > +#define CAN_TX2RTS		MX51_GPIO_NR(1, 9)
> > +#define I2C_SCL			MX51_GPIO_NR(4, 16)
> > +#define I2C_SDA			MX51_GPIO_NR(4, 17)
> >  
> >  /* USB_CTRL_1 */
> >  #define MX51_USB_CTRL_1_OFFSET		0x10
> > @@ -243,7 +243,7 @@
> >  		.mode		= SPI_MODE_0,
> >  		.chip_select     = 0,
> >  		.platform_data   = &mcp251x_info,
> > -		.irq             = gpio_to_irq(0 * 32 + 1)
> > +		.irq             = gpio_to_irq(CAN_IRQGPIO)
> >  	},
> >  };
> >  
> > Index: gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> > ===================================================================
> > --- gpionr.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:23.000000000 +0100
> > +++ gpionr/arch/arm/plat-mxc/include/mach/iomux-mx51.h	2010-11-22 23:04:25.000000000 +0100
> > @@ -15,6 +15,8 @@
> >  
> >  #include <mach/iomux-v3.h>
> >  
> 
> Please add a comment here that bank numbers start from 1 to make it explicit
> 
> > +#define MX51_GPIO_NR(bank, nr)		((bank-1)*32+nr)
> > +
>                                                  ^^^^^^^^^ whitespace fixes
> 
there should be parens around the macro parameters: (((bank) - 1) * 32 + (nr))


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
