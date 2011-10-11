From: gwenhael.goavec-merou@armadeus.com (gwenhael.goavec)
Date: Tue, 11 Oct 2011 17:26:53 +0200
Subject: [PATCH 2/2] [ARM] MX1:apf9328: Add i2c support
In-Reply-To: <20111008192730.GB28049@pengutronix.de>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<1318087189-22977-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192730.GB28049@pengutronix.de>
Message-ID: <20111011172653.54366ab6@trabucayre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, 8 Oct 2011 21:27:30 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> On Sat, Oct 08, 2011 at 05:19:49PM +0200, Gwenhael Goavec-Merou wrote:
> > 
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> 
> Out of curiosity, no devices on the bus?
>
Devices present on this modules's I2C bus don't have mailined kernel drivers or
don't need one (in that case /dev/i2c-xx is used). This module can be plugged
on a baseboard adding some stuff on I2C but this will be part of another patch
adding the baseboard description. 

Gwenhael
>
> Other than that, looks OK to me:
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> > ---
> >  arch/arm/mach-imx/Kconfig        |    1 +
> >  arch/arm/mach-imx/mach-apf9328.c |   10 ++++++++++
> >  2 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > index 4792fd5..0e89395 100644
> > --- a/arch/arm/mach-imx/Kconfig
> > +++ b/arch/arm/mach-imx/Kconfig
> > @@ -99,6 +99,7 @@ config MACH_SCB9328
> >  config MACH_APF9328
> >  	bool "APF9328"
> >  	select SOC_IMX1
> > +	select IMX_HAVE_PLATFORM_IMX_I2C
> >  	select IMX_HAVE_PLATFORM_IMX_UART
> >  	help
> >  	  Say Yes here if you are using the Armadeus APF9328 development board
> > diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
> > index a404c89..f60e2b4 100644
> > --- a/arch/arm/mach-imx/mach-apf9328.c
> > +++ b/arch/arm/mach-imx/mach-apf9328.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/dm9000.h>
> > +#include <linux/i2c.h>
> >  
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -41,6 +42,9 @@ static const int apf9328_pins[] __initconst = {
> >  	PB29_PF_UART2_RTS,
> >  	PB30_PF_UART2_TXD,
> >  	PB31_PF_UART2_RXD,
> > +	/* I2C */
> > +	PA15_PF_I2C_SDA,
> > +	PA16_PF_I2C_SCL,
> >  };
> >  
> >  /*
> > @@ -103,6 +107,10 @@ static const struct imxuart_platform_data uart1_pdata __initconst = {
> >  	.flags = IMXUART_HAVE_RTSCTS,
> >  };
> >  
> > +static const struct imxi2c_platform_data apf9328_i2c_data __initconst = {
> > +	.bitrate = 100000,
> > +};
> > +
> >  static struct platform_device *devices[] __initdata = {
> >  	&apf9328_flash_device,
> >  	&dm9000x_device,
> > @@ -119,6 +127,8 @@ static void __init apf9328_init(void)
> >  	imx1_add_imx_uart0(NULL);
> >  	imx1_add_imx_uart1(&uart1_pdata);
> >  
> > +	imx1_add_imx_i2c(&apf9328_i2c_data);
> > +
> >  	platform_add_devices(devices, ARRAY_SIZE(devices));
> >  }
> >  
> > -- 
> > 1.7.3.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
