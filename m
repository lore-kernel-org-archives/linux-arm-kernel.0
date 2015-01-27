From: balbi@ti.com (Felipe Balbi)
Date: Tue, 27 Jan 2015 13:14:28 -0600
Subject: [PATCH] usb: phy-generic: Don't fail on missing gpio reset
In-Reply-To: <19e48726b36942cfb0430fc625b41e1b@BY2FFO11FD043.protection.gbl>
References: <1422323129-20969-1-git-send-email-soren.brinkmann@xilinx.com>
 <20150127152047.GA13776@saruman.tx.rr.com>
 <19e48726b36942cfb0430fc625b41e1b@BY2FFO11FD043.protection.gbl>
Message-ID: <20150127191427.GN14878@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:13:08AM -0800, S?ren Brinkmann wrote:
> On Tue, 2015-01-27 at 09:20AM -0600, Felipe Balbi wrote:
> > On Mon, Jan 26, 2015 at 05:45:29PM -0800, Soren Brinkmann wrote:
> > > A reset through a GPIO is optional. Don't fail probing when it is
> > > missing.
> > > 
> > > Reported-by: Andreas F?rber <afaerber@suse.de>
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > > Hi Andreas,
> > > 
> > > does this do the trick?
> > > 
> > > 	Thanks,
> > > 	S?ren
> > > 
> > >  drivers/usb/phy/phy-generic.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
> > > index dd05254241fb..a73d4c738f0b 100644
> > > --- a/drivers/usb/phy/phy-generic.c
> > > +++ b/drivers/usb/phy/phy-generic.c
> > > @@ -241,10 +241,8 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop,
> > >  
> > >  	if (err == -EPROBE_DEFER)
> > >  		return -EPROBE_DEFER;
> > > -	if (err) {
> > > -		dev_err(dev, "Error requesting RESET GPIO\n");
> > > -		return err;
> > > -	}
> > > +	if (err)
> > > +		nop->gpiod_reset = NULL;
> > 
> > there's a better patch to use gpiod_get_optional(), instead.
> 
> Great, apparently that wasn't in linux-next yesterday. I'll give it a
> shot once it arrives there.

It's still under discussion ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/caea0929/attachment.sig>
