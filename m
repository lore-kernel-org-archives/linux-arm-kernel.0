From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 10 Feb 2014 16:16:27 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gdmlkZW86IGlteGZiOiBVc2UgcmVndWxhdG9yIEFQSSB3?=
 =?UTF-8?B?aXRoIExDRCBjbGFzcyBmb3IgcG93ZXJpbmc=?=
In-Reply-To: <52F8C091.50704@ti.com>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <52F8C091.50704@ti.com>
Message-ID: <1392034587.333931582@f419.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 10 ??????? 2014, 14:05 +02:00 ?? Tomi Valkeinen <tomi.valkeinen@ti.com>:
> On 21/12/13 13:08, Alexander Shiyan wrote:
> > This patch replaces custom lcd_power() callback with
> > regulator API over LCD class.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  .../devicetree/bindings/video/fsl,imx-fb.txt       |  1 +
> >  arch/arm/mach-imx/mach-mx27ads.c                   | 55 +++++++++++++++--
> >  drivers/video/imxfb.c                              | 71
> +++++++++++++++++++---
> >  include/linux/platform_data/video-imxfb.h          |  1 -
> >  4 files changed, 114 insertions(+), 14 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > index 46da08d..e6b1ee9 100644
> > --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> > @@ -15,6 +15,7 @@ Required nodes:
> >  	- fsl,pcr: LCDC PCR value
> >  
> >  Optional properties:
> > +- lcd-supply: Regulator for LCD supply voltage.
> >  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
> >  	register is not modified as recommended by the datasheet.
> >  - fsl,lscr1: LCDC Sharp Configuration Register value.
> > diff --git a/arch/arm/mach-imx/mach-mx27ads.c
...
> > +static void __init mx27ads_regulator_init(void)
> > +{
> > +	struct gpio_chip *vchip;
> > +
> > +	vchip = kzalloc(sizeof(*vchip), GFP_KERNEL);
> > +	vchip->owner		= THIS_MODULE;
> > +	vchip->label		= "LCD";
> > +	vchip->base		= MX27ADS_LCD_GPIO;
> > +	vchip->ngpio		= 1;
> > +	vchip->direction_output	= vgpio_dir_out;
> > +	vchip->set		= vgpio_set;
> > +	gpiochip_add(vchip);
> > +
> > +	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
> > +				      PLATFORM_DEVID_AUTO,
> > +				      &mx27ads_lcd_regulator_pdata,
> > +				      sizeof(mx27ads_lcd_regulator_pdata));
> > +}
> > +
> 
> Hmm, isn't all this something that should be in the board's .dts?

There are no DT support for this board yet.

---
