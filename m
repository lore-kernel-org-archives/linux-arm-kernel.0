From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 09:48:42 -0800
Subject: [PATCH 1/2] i2c: s3c2410: move mach/regs-iic.h into i2c-s3c2410
 device driver
References: <201302080057.00664.heiko@sntech.de>
Message-ID: <1d4a01ce0949$343c4230$9cb4c690$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Heiko St?bner wrote:
> >
> > The register definitions are only used in the driver itself.
> > This also removes the last dependency on plat/ includes from the i2c
> > driver.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm/mach-s3c24xx/mach-rx1950.c           |    1 -
> >  arch/arm/plat-samsung/devs.c                  |    1 -
> >  arch/arm/plat-samsung/include/plat/regs-iic.h |   56 -------------------------
> >  drivers/i2c/busses/i2c-s3c2410.c              |   41 ++++++++++++++++++-
> >  4 files changed, 40 insertions(+), 59 deletions(-)  delete mode
> > 100644 arch/arm/plat-samsung/include/plat/regs-iic.h
> >
> > diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-
> > s3c24xx/mach-rx1950.c index 799af43..64b52a9 100644
> > --- a/arch/arm/mach-s3c24xx/mach-rx1950.c
> > +++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
> > @@ -56,7 +56,6 @@
> >  #include <plat/cpu.h>
> >  #include <plat/devs.h>
> >  #include <plat/pm.h>
> > -#include <plat/regs-iic.h>
> >  #include <plat/regs-serial.h>
> >  #include <plat/samsung-time.h>
> >
> > diff --git a/arch/arm/plat-samsung/devs.c
> > b/arch/arm/plat-samsung/devs.c index e1124d9..6317a9e 100644
> > --- a/arch/arm/plat-samsung/devs.c
> > +++ b/arch/arm/plat-samsung/devs.c
> > @@ -62,7 +62,6 @@
> >  #include <linux/platform_data/usb-s3c2410_udc.h>
> >  #include <linux/platform_data/usb-ohci-s3c2410.h>
> >  #include <plat/usb-phy.h>
> > -#include <plat/regs-iic.h>
> >  #include <plat/regs-serial.h>
> >  #include <plat/regs-spi.h>
> >  #include <linux/platform_data/spi-s3c64xx.h>
> > diff --git a/arch/arm/plat-samsung/include/plat/regs-iic.h
> > b/arch/arm/plat- samsung/include/plat/regs-iic.h deleted file mode
> > 100644 index 2f7c17d..0000000
> > --- a/arch/arm/plat-samsung/include/plat/regs-iic.h
> > +++ /dev/null
> > @@ -1,56 +0,0 @@
> > -/* arch/arm/mach-s3c2410/include/mach/regs-iic.h
> > - *
> > - * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
> > - *		http://www.simtec.co.uk/products/SWLINUX/
> > - *
> > - * This program is free software; you can redistribute it and/or
> > modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> > - * S3C2410 I2C Controller
> > -*/
> > -
> > -#ifndef __ASM_ARCH_REGS_IIC_H
> > -#define __ASM_ARCH_REGS_IIC_H __FILE__
> > -
> > -/* see s3c2410x user guide, v1.1, section 9 (p447) for more info */
> > -
> > -#define S3C2410_IICREG(x) (x)
> > -
> > -#define S3C2410_IICCON    S3C2410_IICREG(0x00)
> > -#define S3C2410_IICSTAT   S3C2410_IICREG(0x04)
> > -#define S3C2410_IICADD    S3C2410_IICREG(0x08)
> > -#define S3C2410_IICDS     S3C2410_IICREG(0x0C)
> > -#define S3C2440_IICLC	  S3C2410_IICREG(0x10)
> > -
> > -#define S3C2410_IICCON_ACKEN		(1<<7)
> > -#define S3C2410_IICCON_TXDIV_16		(0<<6)
> > -#define S3C2410_IICCON_TXDIV_512	(1<<6)
> > -#define S3C2410_IICCON_IRQEN		(1<<5)
> > -#define S3C2410_IICCON_IRQPEND		(1<<4)
> > -#define S3C2410_IICCON_SCALE(x)		((x)&15)
> > -#define S3C2410_IICCON_SCALEMASK	(0xf)
> > -
> > -#define S3C2410_IICSTAT_MASTER_RX	(2<<6)
> > -#define S3C2410_IICSTAT_MASTER_TX	(3<<6)
> > -#define S3C2410_IICSTAT_SLAVE_RX	(0<<6)
> > -#define S3C2410_IICSTAT_SLAVE_TX	(1<<6)
> > -#define S3C2410_IICSTAT_MODEMASK	(3<<6)
> > -
> > -#define S3C2410_IICSTAT_START		(1<<5)
> > -#define S3C2410_IICSTAT_BUSBUSY		(1<<5)
> > -#define S3C2410_IICSTAT_TXRXEN		(1<<4)
> > -#define S3C2410_IICSTAT_ARBITR		(1<<3)
> > -#define S3C2410_IICSTAT_ASSLAVE		(1<<2)
> > -#define S3C2410_IICSTAT_ADDR0		(1<<1)
> > -#define S3C2410_IICSTAT_LASTBIT		(1<<0)
> > -
> > -#define S3C2410_IICLC_SDA_DELAY0	(0 << 0)
> > -#define S3C2410_IICLC_SDA_DELAY5	(1 << 0)
> > -#define S3C2410_IICLC_SDA_DELAY10	(2 << 0)
> > -#define S3C2410_IICLC_SDA_DELAY15	(3 << 0)
> > -#define S3C2410_IICLC_SDA_DELAY_MASK	(3 << 0)
> > -
> > -#define S3C2410_IICLC_FILTER_ON		(1<<2)
> > -
> > -#endif /* __ASM_ARCH_REGS_IIC_H */
> > diff --git a/drivers/i2c/busses/i2c-s3c2410.c
> > b/drivers/i2c/busses/i2c- s3c2410.c index a290d08..5cc4f71 100644
> > --- a/drivers/i2c/busses/i2c-s3c2410.c
> > +++ b/drivers/i2c/busses/i2c-s3c2410.c
> > @@ -42,9 +42,48 @@
> >
> >  #include <asm/irq.h>
> >
> > -#include <plat/regs-iic.h>
> >  #include <linux/platform_data/i2c-s3c2410.h>
> >
> > +/* see s3c2410x user guide, v1.1, section 9 (p447) for more info */
> > +
> > +#define S3C2410_IICREG(x) (x)
> > +
> > +#define S3C2410_IICCON    S3C2410_IICREG(0x00)
> > +#define S3C2410_IICSTAT   S3C2410_IICREG(0x04)
> > +#define S3C2410_IICADD    S3C2410_IICREG(0x08)
> > +#define S3C2410_IICDS     S3C2410_IICREG(0x0C)
> > +#define S3C2440_IICLC	  S3C2410_IICREG(0x10)
> > +
> > +#define S3C2410_IICCON_ACKEN		(1<<7)
> > +#define S3C2410_IICCON_TXDIV_16		(0<<6)
> > +#define S3C2410_IICCON_TXDIV_512	(1<<6)
> > +#define S3C2410_IICCON_IRQEN		(1<<5)
> > +#define S3C2410_IICCON_IRQPEND		(1<<4)
> > +#define S3C2410_IICCON_SCALE(x)		((x)&15)
> > +#define S3C2410_IICCON_SCALEMASK	(0xf)
> > +
> > +#define S3C2410_IICSTAT_MASTER_RX	(2<<6)
> > +#define S3C2410_IICSTAT_MASTER_TX	(3<<6)
> > +#define S3C2410_IICSTAT_SLAVE_RX	(0<<6)
> > +#define S3C2410_IICSTAT_SLAVE_TX	(1<<6)
> > +#define S3C2410_IICSTAT_MODEMASK	(3<<6)
> > +
> > +#define S3C2410_IICSTAT_START		(1<<5)
> > +#define S3C2410_IICSTAT_BUSBUSY		(1<<5)
> > +#define S3C2410_IICSTAT_TXRXEN		(1<<4)
> > +#define S3C2410_IICSTAT_ARBITR		(1<<3)
> > +#define S3C2410_IICSTAT_ASSLAVE		(1<<2)
> > +#define S3C2410_IICSTAT_ADDR0		(1<<1)
> > +#define S3C2410_IICSTAT_LASTBIT		(1<<0)
> > +
> > +#define S3C2410_IICLC_SDA_DELAY0	(0 << 0)
> > +#define S3C2410_IICLC_SDA_DELAY5	(1 << 0)
> > +#define S3C2410_IICLC_SDA_DELAY10	(2 << 0)
> > +#define S3C2410_IICLC_SDA_DELAY15	(3 << 0)
> > +#define S3C2410_IICLC_SDA_DELAY_MASK	(3 << 0)
> > +
> > +#define S3C2410_IICLC_FILTER_ON		(1<<2)
> > +
> >  /* Treat S3C2410 as baseline hardware, anything else is supported via
> > quirks */
> >  #define QUIRK_S3C2440		(1 << 0)
> >  #define QUIRK_HDMIPHY		(1 << 1)
> > --
> > 1.7.2.3
> 
> Looks good to me on this series:
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> Hi Wolfram, if you're ok on this, please pick up into your tree with my ack.
> 

Re-sending due to changing of Wolfram's e-mail address.

Thanks.

- Kukjin
