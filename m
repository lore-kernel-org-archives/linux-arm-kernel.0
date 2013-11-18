From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Nov 2013 11:25:10 -0600
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
In-Reply-To: <20131118102907.GC13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
Message-ID: <20131118172510.GI16038@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 18, 2013 at 10:29:07AM +0000, Lee Jones wrote:
> > Since we still need to rely on a mix of device tree initialized
> > drivers and legacy platform data initialize drivers, let's fix
> > the passing of platform data to twl4030-gpio.
> > 
> > As the twl4030 GPIO is initialized by twl-core.c, we need to register
> > the auxdata for twl4030 GPIO in twl-core.c.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> > 
> > Samuel & Lee, I'd like to merge this fix via arm-soc tree if this looks
> > OK to you as I have other patches that depend on this.
> > 
> > ---
> >  drivers/mfd/twl-core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 29473c2..d5b3dd8 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -1133,6 +1133,11 @@ static int twl_remove(struct i2c_client *client)
> >  	return 0;
> >  }
> >  
> > +static struct of_dev_auxdata twl_auxdata_lookup[] = {
> > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > +	{ /* sentinel */ },
> > +};
> > +
> >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
> >  static int
> >  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> >  	}
> >  
> > -	if (node)
> > -		status = of_platform_populate(node, NULL, NULL, &client->dev);
> > -	else
> > +	if (node) {
> > +		if (pdata)
> > +			twl_auxdata_lookup[0].platform_data = pdata->gpio;
> > +		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
> > +					      &client->dev);
> > +	} else {
> >  		status = add_children(pdata, irq_base, id->driver_data);
> 
> Why doesn't the TWL driver use the MFD framework for this stuff?

that's reminiscent from years ago and, surely, needs to be fixed. Should
we gate $subject for that, though ? This has been in tree for quite a
few years already and Tony's patch is still a step forward, since most
omap3 platforms would break on DT-only without it.

There are quite a few folks who could volunteer to fixing that after
Tony's patch is in (me included, although there could be better choices
hehe).

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/c09d0cfa/attachment.sig>
