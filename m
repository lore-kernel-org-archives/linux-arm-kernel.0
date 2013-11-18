From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Nov 2013 12:40:29 -0600
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
In-Reply-To: <20131118174638.GQ13640@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
Message-ID: <20131118184029.GA10676@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 18, 2013 at 05:46:38PM +0000, Lee Jones wrote:
> > > > +static struct of_dev_auxdata twl_auxdata_lookup[] = {
> > > > +	OF_DEV_AUXDATA("ti,twl4030-gpio", 0, "twl4030-gpio", NULL),
> > > > +	{ /* sentinel */ },
> > > > +};
> > > > +
> > > >  /* NOTE: This driver only handles a single twl4030/tps659x0 chip */
> > > >  static int
> > > >  twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > > > @@ -1271,10 +1276,14 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
> > > >  		twl_i2c_write_u8(TWL4030_MODULE_INTBR, temp, REG_GPPUPDCTR1);
> > > >  	}
> > > >  
> > > > -	if (node)
> > > > -		status = of_platform_populate(node, NULL, NULL, &client->dev);
> > > > -	else
> > > > +	if (node) {
> > > > +		if (pdata)
> > > > +			twl_auxdata_lookup[0].platform_data = pdata->gpio;
> > > > +		status = of_platform_populate(node, NULL, twl_auxdata_lookup,
> > > > +					      &client->dev);
> > > > +	} else {
> > > >  		status = add_children(pdata, irq_base, id->driver_data);
> > > 
> > > Why doesn't the TWL driver use the MFD framework for this stuff?
> > 
> > that's reminiscent from years ago and, surely, needs to be fixed. Should
> > we gate $subject for that, though ? This has been in tree for quite a
> > few years already and Tony's patch is still a step forward, since most
> > omap3 platforms would break on DT-only without it.
> 
> I didn't say that I would reject the patch. I was just surprised to
> see so much hand-rolling, as the MFD core code does much of it
> automatically. This is the first time I've taken a look at this and it
> seems to be quite the relic.

alright, thanks for confirming.

> > There are quite a few folks who could volunteer to fixing that after
> > Tony's patch is in (me included, although there could be better choices
> > hehe).
> 
> Well it's not doing any harm. I'll make a note to fix it myself if a)
> no one has done so already and b) I manage to find some spare
> time. The latter issue is less likely to be resolved. :)
> 
> Are you Acking this patch by the way?

sure:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/db765769/attachment-0001.sig>
