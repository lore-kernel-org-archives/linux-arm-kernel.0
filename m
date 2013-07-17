From: cb@sgoc.de (Christoph G. Baumann)
Date: Wed, 17 Jul 2013 23:43:12 +0200 (CEST)
Subject: [PATCH v2 3/3] mxs: added driver for OCOTP in i.MX23 and i.MX28
In-Reply-To: <20130717192627.GA12533@pengutronix.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-1-git-send-email-cb@sgoc.de>
 <1374078460-4126-4-git-send-email-cb@sgoc.de>
 <20130717192627.GA12533@pengutronix.de>
Message-ID: <1068003072.1131668.1374097392210.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

thanks for your input. I must admit that I didn't do a thorough review of the
FSL code...


> Sascha Hauer <s.hauer@pengutronix.de> hat am 17. Juli 2013 um 21:26
> geschrieben:
> [...]
> > +static DEFINE_MUTEX(otp_mutex);
> > +static struct kobject *otp_kobj;
> > +static struct attribute **attrs;
> > +static struct kobj_attribute *kattr;
> > +static struct attribute_group attr_group;
> > +static unsigned long otp_hclk_saved;
> > +static u32 otp_voltage_saved;
> > +static resource_size_t otp_base_address;
> > +struct regulator *regu;
>
> Collect your driver data in a struct and pass it around in functions
> calls. No need to limit this driver to a single instance.

The OTP device is unique in the CPU and several instances i.e. potential
concurrent access is considered harmful. So I kept this construction
from FSL.


> > +static int otp_write_prepare(void)
> > +{
> > +? ? ?struct clk *hclk;
> > +? ? ?int err = 0;
> > +
> > +? ? ?/* [1] HCLK to 24MHz. */
> > +? ? ?hclk = clk_get_sys("hbus", NULL);
>
> This is a driver, so you should use regular clk_get, not clk_get_sys.
> Besides, this has to be done during probe. clk_get takes a reference to
> the clock which has to be released.

As far as I remember testing clk_get didn't work in this place.
In the API doc I only found the warning:
"clk_get_sys should not be called from within interrupt context.".


Regards,
Christoph
