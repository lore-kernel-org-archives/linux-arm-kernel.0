From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Sep 2013 20:49:42 -0500
Subject: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
In-Reply-To: <201309172128.42514@pali>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309171805.15460@pali> <20130917160835.GS15645@radagast>
 <201309172128.42514@pali>
Message-ID: <20130918014942.GD19817@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 09:28:42PM +0200, Pali Roh?r wrote:
> On Tuesday 17 September 2013 18:08:35 Felipe Balbi wrote:
> > On Tue, Sep 17, 2013 at 06:05:15PM +0200, Pali Roh?r wrote:
> > > On Tuesday 17 September 2013 17:48:59 you wrote:
> > > > On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh?r wrote:
> > > > > More power supply drivers depends on vbus events and
> > > > > without it they not working. Power supply drivers using
> > > > > usb_register_notifier, so to deliver events it is
> > > > > needed to call atomic_notifier_call_chain.
> > > > > 
> > > > > So without atomic notifier power supply driver isp1704
> > > > > not retrieving vbus status and reporting bogus values
> > > > > to userspace and also to board platform data functions.
> > > > > Without proper data charger drivers trying to charge
> > > > > battery also when charger is disconnected or do not
> > > > > start charging when wallcharger connects.
> > > > > 
> > > > > Atomic notifier in musb driver was used before v3.5 and
> > > > > was replaced with omap mailbox. This patch adding
> > > > > atomic_notifier_call_chain call from function
> > > > > omap_musb_set_mailbox.
> > > > > 
> > > > > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/usb/musb/omap2430.c       |    3 +++
> > > > >  drivers/usb/phy/phy-twl4030-usb.c |    2 ++
> > > > >  2 files changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/usb/musb/omap2430.c
> > > > > b/drivers/usb/musb/omap2430.c index f44e8b5..5c40252
> > > > > 100644 --- a/drivers/usb/musb/omap2430.c
> > > > > +++ b/drivers/usb/musb/omap2430.c
> > > > > @@ -305,6 +305,9 @@ static void
> > > > > omap_musb_set_mailbox(struct omap2430_glue *glue)
> > > > > 
> > > > >  	default:
> > > > >  		dev_dbg(dev, "ID float\n");
> > > > >  	
> > > > >  	}
> > > > > 
> > > > > +
> > > > > +	atomic_notifier_call_chain(&musb->xceiv->notifier,
> > > > > +			musb->xceiv->last_event, NULL);
> > > > 
> > > > let's add a wrapper for this:
> > > > 
> > > > static inline int usb_phy_notify(struct usb phy *x,
> > > > unsigned val, void *v) {
> > > > 
> > > > 	return atomic_notifier_call_chain(&x->notifier, val, v);
> > > > 
> > > > }
> > > 
> > > Where to add this wrapper? To omap2430.c? or some include
> > > file?
> > 
> > <linux/usb/phy.h>
> > 
> > > On Tuesday 17 September 2013 17:49:17 Felipe Balbi wrote:
> > > > On Sun, Sep 08, 2013 at 10:50:36AM +0200, Pali Roh?r wrote:
> > > > > diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> > > > > b/drivers/usb/phy/phy-twl4030-usb.c index
> > > > > 8f78d2d..efe6155 100644
> > > > > --- a/drivers/usb/phy/phy-twl4030-usb.c
> > > > > +++ b/drivers/usb/phy/phy-twl4030-usb.c
> > > > > @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> > > > > platform_device *pdev)
> > > > > 
> > > > >  	if (device_create_file(&pdev->dev, &dev_attr_vbus))
> > > > >  	
> > > > >  		dev_warn(&pdev->dev, "could not create sysfs
> > > > >  		file\n");
> > > > > 
> > > > > +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> > > > 
> > > > BTW, this is a bugfix, send separately.
> > > 
> > > What to send separately?
> > > 
> > > This full patch 1/4 is bugfix. And I did not understand what
> > > you want. Maybe it could be easier for you to apply this
> > > small 3+2 lines patch how you need.
> > 
> > This hunk here (initializaing notifier head) is a separate bug
> > fix and needs its own patch.
> 
> So will you do that? Or it is needed to resend this one line hunk 
> again in new email again?

new patch, new email

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/c6cd20bc/attachment.sig>
