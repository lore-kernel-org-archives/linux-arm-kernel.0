From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 21 Apr 2010 14:12:56 +0200
Subject: SPI trouble on Colibri 270 (PXA)...
In-Reply-To: <j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>
References: <4BCD96F0.5010506@viketoft.se>
	<201004211144.41781.marek.vasut@gmail.com>
	<j2tf17812d71004210347gd9ad8530w409b8d6e3a732c1c@mail.gmail.com>
Message-ID: <201004211412.56609.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 21. dubna 2010 12:47:29 Eric Miao napsal(a):
> On Wed, Apr 21, 2010 at 5:44 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne ?t 20. dubna 2010 17:20:37 Jakob Viketoft napsal(a):
> >> Eric Miao wrote:
> >> > On Tue, Apr 20, 2010 at 7:58 PM, Jakob Viketoft <jakob@viketoft.se> 
wrote:
> >> <...>
> >> 
> >> >> I haven't seen any other board using the same combination (the m25p80
> >> >> and the pxa2xx), but I'm still opting for an error on my part
> >> >> somewhere. I've attached my SPI configuration (board setup) in the
> >> >> end of the mail.
> >> > 
> >> > Not looked into m25p80 code, but CS is normally asserted before a
> >> > transfer begins and deasserted after a transfer is done. I doubt there
> >> > are some cases where the transfer is not set up correctly.
> >> 
> >> Well, in this case when doing a read you must set up a write transfer to
> >> write the read command + address and then a read transfer to actually
> >> read back the data. In this case the cs musn't be deasserted between
> >> transfers because this means the operation is terminated.
> >> 
> >> > Actually, cs_assert() and cs_deassert() are there in pxa2xx_spi.c as
> >> > two very good debugging point to print out the transfer information
> >> > to see if they are setup correctly.
> >> 
> >> When I look at how these two are used I get a an serie of assert,
> >> assert, deassert for each read operation (which should be correct
> >> behaviour). This suggests that something else is deasserting the cs or
> >> that the CPU is doing something on it's own accord. Hmmm...
> >> 
> >> Regards,
> >> 
> >>       /Jakob
> > 
> > You can try using gpio-spi driver as used in palmz72.c ... I had issues
> > with pxa2xx-spi interfacing the OV96xx camera, but it worked well for me
> > with gpio- spi.
> > 
> > Looking at it now, it seems the patch was never merged, here's a
> > shortened version, try something similar:
> > 
> > From 777212ce6d3bacea76281aa3d74839a3c38b32a4 Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Sat, 22 Aug 2009 05:15:10 +0200
> > Subject: [PATCH 3/3] PalmZ72: Add support for OV9640 camera sensor
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > ---
> >  arch/arm/mach-pxa/include/mach/palmz72.h |    5 +
> >  arch/arm/mach-pxa/palmz72.c              |  126
> > +++++++++++++++++++++++++++++-
> >  2 files changed, 130 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
> > index c3645aa..e4449ad 100644
> > --- a/arch/arm/mach-pxa/palmz72.c
> > +++ b/arch/arm/mach-pxa/palmz72.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/wm97xx_batt.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/usb/gpio_vbus.h>
> > +#include <linux/i2c-gpio.h>
> > 
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > @@ -120,6 +123,28 @@ static unsigned long palmz72_pin_config[] __initdata
> > = { GPIO22_GPIO,    /* LCD border color */
> >        GPIO96_GPIO,    /* lcd power */
> > 
> > +       /* I2C */
> > +       GPIO117_GPIO,   /* I2C_SCL */
> > +       GPIO118_GPIO,   /* I2C_SDA */
> > 
> > +static struct i2c_gpio_platform_data palmz72_i2c_bus_data = {
> > +       .sda_pin = 118,
> > +       .scl_pin = 117,
> > +       .udelay  = 10,
> > +       .timeout = 100,
> > +};
> > +
> > +static struct platform_device palmz72_i2c_bus_device = {
> > +       .name           = "i2c-gpio",
> > +       .id             = 0, /* we use this as a replacement for i2c-pxa
> > */ +       .dev = {
> > +               .platform_data = &palmz72_i2c_bus_data,
> > +       }
> > +};
> 
> I thought we were talking about SPI?

Argh, yes sorry, I was in a hurry when I was replying. Ignore this.
