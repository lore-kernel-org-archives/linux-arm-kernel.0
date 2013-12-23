From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 23 Dec 2013 09:05:22 +0800
Subject: [PATCH v7 07/14] usb: phy-mxs: change description of usb
 device speed
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B74C0@saturn3.aculab.com>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-8-git-send-email-peter.chen@freescale.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B74C0@saturn3.aculab.com>
Message-ID: <20131223010521.GA28096@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 10:40:01AM +0000, David Laight wrote:
> > From: Peter Chen
> > Sent: 20 December 2013 07:52
> > Change "high speed" to "HS"
> > Change "non-high speed" to "FS/LS"
> > 
> > Implementation of notify_suspend and notify_resume will be different
> > according to mxs_phy_data->flags.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index 0ef930a..489096f 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -166,8 +166,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
> >  static int mxs_phy_on_connect(struct usb_phy *phy,
> >  		enum usb_device_speed speed)
> >  {
> > -	dev_dbg(phy->dev, "%s speed device has connected\n",
> > -		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
> > +	dev_dbg(phy->dev, "%s device has connected\n",
> > +		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
> 
> Seems you are making these messages even more cryptic.
> With all the speeds that USB supports remembering what 'full'
> means is hard enough without having a cryptic acronym.
> 

We have "phy->dev" know it is a USB device, grep usb driver,
there are lots of similar naming:

$: find drivers/usb/ -name *.c | xargs grep -rn "FS/LS"

drivers/usb/host/fotg210-hcd.c:2901:			/* gap is f(FS/LS transfer times) */
drivers/usb/host/ehci-sched.c:257:	/* FS/LS bus bandwidth */
drivers/usb/host/xhci.c:2335:	 * this check is only valid for HS/FS/LS devices.
drivers/usb/host/fusbh200-hcd.c:2849:			/* gap is f(FS/LS transfer times) */
drivers/usb/host/ehci-q.c:832:			/* gap is f(FS/LS transfer times) */
drivers/usb/host/ehci-dbg.c:571:	/* Dump all the FS/LS tables */
drivers/usb/host/ehci-dbg.c:574:				"\nTT %s port %d  FS/LS bandwidth allocation (us per frame)\n",
drivers/usb/host/ehci-dbg.c:589:				"FS/LS budget (us per microframe)\n");
drivers/usb/host/oxu210hp-hcd.c:1414:			/* gap is f(FS/LS transfer times) */
	drivers/usb/gadget/fsl_udc_core.c:2101:				s = "FS/LS Serial"; break;
drivers/usb/core/hcd-pci.c:132:		dev_dbg(&pdev->dev, "FS/LS companion for %s\n",

-- 

Best Regards,
Peter Chen
