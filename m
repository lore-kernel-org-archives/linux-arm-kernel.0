From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 18 Jul 2013 08:36:55 +0200
Subject: [PATCH v2 3/3] mxs: added driver for OCOTP in i.MX23 and i.MX28
In-Reply-To: <1068003072.1131668.1374097392210.open-xchange@email.1und1.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-4-git-send-email-cb@sgoc.de>
 <20130717192627.GA12533@pengutronix.de>
 <1068003072.1131668.1374097392210.open-xchange@email.1und1.de>
Message-ID: <20130718063655.GH10380@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 11:43:12PM +0200, Christoph G. Baumann wrote:
> Hello Sascha,
> 
> thanks for your input. I must admit that I didn't do a thorough review of the
> FSL code...
> 
> 
> > Sascha Hauer <s.hauer@pengutronix.de> hat am 17. Juli 2013 um 21:26
> > geschrieben:
> > [...]
> > > +static DEFINE_MUTEX(otp_mutex);
> > > +static struct kobject *otp_kobj;
> > > +static struct attribute **attrs;
> > > +static struct kobj_attribute *kattr;
> > > +static struct attribute_group attr_group;
> > > +static unsigned long otp_hclk_saved;
> > > +static u32 otp_voltage_saved;
> > > +static resource_size_t otp_base_address;
> > > +struct regulator *regu;
> >
> > Collect your driver data in a struct and pass it around in functions
> > calls. No need to limit this driver to a single instance.
> 
> The OTP device is unique in the CPU and several instances i.e. potential
> concurrent access is considered harmful. So I kept this construction
> from FSL.

Yes, this is single instance only in current SoCs. This is no reason
though to make the driver single instance capabable only. It's not
much work to change and it raises less eyebrows if it's properly
written.
In the end I never thought that there ever would be two instances of
the i.MX graphics subsystem (IPU). Now the i.MX6 has two of them...

> 
> 
> > > +static int otp_write_prepare(void)
> > > +{
> > > +? ? ?struct clk *hclk;
> > > +? ? ?int err = 0;
> > > +
> > > +? ? ?/* [1] HCLK to 24MHz. */
> > > +? ? ?hclk = clk_get_sys("hbus", NULL);
> >
> > This is a driver, so you should use regular clk_get, not clk_get_sys.
> > Besides, this has to be done during probe. clk_get takes a reference to
> > the clock which has to be released.
> 
> As far as I remember testing clk_get didn't work in this place.

That is because the clk_register_clkdev() in your other patch is wrong.

Look at the 'clocks' and 'clock-names' properties in the devicetree.
Also look at Documentation/devicetree/bindings/clock/imx28-clock.txt.

In short you have to add a clock to your devicetree node and then use
clk_get(). The struct device * passed to clk_get will make the bridge
between the device and the devicenode and the id argument will be the
same name as in the devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
