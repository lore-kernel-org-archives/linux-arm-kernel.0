From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Jun 2013 18:00:50 +0300
Subject: [PATCH] USB: initialize or shutdown PHY when add or remove host
 controller
In-Reply-To: <Pine.LNX.4.44L0.1306181046180.1157-100000@iolanthe.rowland.org>
References: <20130618082428.GF5461@arwen.pp.htv.fi>
 <Pine.LNX.4.44L0.1306181046180.1157-100000@iolanthe.rowland.org>
Message-ID: <20130618150050.GD10318@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 10:53:26AM -0400, Alan Stern wrote:
> > > If the controllers don't want HCD core to manage the PHY they can just set it
> > > to some error code.
> > 
> > they shouldn't have the choice, otherwise it'll be a bit of a PITA to
> > maintain the code. ehci core tries to grab the PHY, if it's not there,
> > try to continue anyway. Assume it's not needed.
> 
> Felipe, are all these issues straightened out to your satisfaction?  I
> can't tell from the email thread.
> 
> Looking through the EHCI glue source files, there appears to be a 
> variety of different ways of getting the PHY.  It's not at all clear 
> that they can be moved into the ehci-hcd core (or even better, the USB 
> core -- which is what Chao is trying to do).

yeah, Roger brought up a big problem with OMAP's EHCI depending on the
mode so, at least for now, we should keep phy_get and, in case of EHCI
OMAP, phy_init in the glue :-(

Roger has all the details, and they're also in the list archives, but
basically, depending on the mode, PHY *must* be initialized at a
particular point.

> Given that the glue module has to be responsible for getting the PHY,
> it should also be responsible for error checking.  So the code added to
> hcd.c doesn't need to apply an IS_ERR check; it can simply assume that
> if hcd->phy is NULL then either there is no software-controllable PHY
> or else the HCD doesn't want the core to manage it.

makes sense to me, add the requirement to:

if (IS_ERR(hcd->phy))
	hcd->phy = NULL;

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130618/fa95cad7/attachment-0001.sig>
