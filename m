From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Mar 2012 11:15:31 +0000
Subject: [PATCH 4/4] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <20120321222622.GG29317@pengutronix.de>
References: <1332360082-25092-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1332360082-25092-4-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120321222622.GG29317@pengutronix.de>
Message-ID: <20120322111531.GA3091@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 11:26:22PM +0100, Sascha Hauer wrote:
> On Wed, Mar 21, 2012 at 08:01:22PM +0000, Mark Brown wrote:

> > +	if (!clk_register(&pdev->dev, "xtal", &wm831x_xtal_ops,
> > +			  &clkdata->xtal_hw, NULL, 0, CLK_IS_ROOT))
> > +		return -EINVAL;

> The clock names are unique identifiers for the clock, so clocks in
> drivers should probably have dev_name encoded into them.

No, that's not sensible.  We shouldn't be open coding this into each
individual driver that provides clocks, and we shouldn't have clock
users having to guess at what scheme the driver author used to dedupe
the clocks.  As a driver author you would assume that the reason we're
providing the struct device to the registration function in the first
place is so that the core has the information it needs to do that.

I did provide patches to do what you suggest in the core for one of the
earlier versions of the API, I have to say I didn't check to see if they
got dropped during the general lulls.

> You could also use the fixed rate generic clock here.

It doesn't really do what I want with reporting the enables - for
diagnostic purposes I wanted to always have the clock present but
non-enablable so we could actually look at the clock tree and see 
what's going on directly when there's no clock coming out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120322/c06289f3/attachment.sig>
