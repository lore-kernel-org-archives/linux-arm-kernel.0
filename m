From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Jun 2013 15:17:49 +0300
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <CADApbej+qcvV2EmcB9g_k=DGp7R-1H_dEaA7StimMoR+G6z0Cg@mail.gmail.com>
References: <1371609080-30595-1-git-send-email-chao.xie@marvell.com>
 <51C162F9.9020705@ti.com>
 <CADApbej+qcvV2EmcB9g_k=DGp7R-1H_dEaA7StimMoR+G6z0Cg@mail.gmail.com>
Message-ID: <20130620121749.GF9817@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 20, 2013 at 08:53:05AM +0800, Chao Xie wrote:
> >> @@ -2674,6 +2693,9 @@ void usb_remove_hcd(struct usb_hcd *hcd)
> >>                       free_irq(hcd->irq, hcd);
> >>       }
> >>
> >> +     if (hcd->phy)
> >> +             usb_phy_shutdown(hcd->phy);
> >> +
> >>       usb_put_dev(hcd->self.root_hub);
> >>       usb_deregister_bus(&hcd->self);
> >>       hcd_buffer_destroy(hcd);
> >>
> >
> > I still think that we shouldn't do this because it adds more confusion and is not
> > still a generic enough solution.
> >
> > 1) It is better for the piece of code that does usb_phy_get() to do usb_phy_init/shutdown,
> > else there will be lot of confusion. (Felipe pointed this out earlier).
> >
> > 2) There is no standard way of getting phy for different controllers. It is mostly platform
> > dependent and it is best to leave this to the controller drivers. (Pointed out by Alan).
> >
> > 3) Controllers can have multiple PHYs. e.g. ehci-omap has one PHY per port and it supports
> > 3 ports. This is also platform specific and difficult to handle generically.
> >
> > 4) Controllers can have specific timing requirements as to when the PHY is initialized relative
> > to the controller being initialized. I've pointed OMAP specific stuff in the earlier patch.
> >
> > Considering all these points, I think we should leave things as they are. It isn't that hard
> > for controllers to manage phy_init() and phy_shutdown(), and there is not much code space saved
> > when compared to the complexity it creates if we move them to HCD layer.
> >
> In fact, the PHY setting and handling is related to platform or SOC,
> and for different SOC they can
> have same EHCI HCD but they PHY handling can be different.
> Omap'a case is the example, and i think some other vendors may have
> silimar cases.
> From above point, It is better to leave the PHY initialization and
> shutdown to be done by each echi-xxx driver.
> 
> So Alan and Felipe
> What are your ideas about it?

If we have so many exceptions, then sure. But eventually, the common
case should be added generically with a flag so that non-generic cases
(like OMAP) can request to handle the PHY by themselves.

Alan ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/00677a79/attachment.sig>
