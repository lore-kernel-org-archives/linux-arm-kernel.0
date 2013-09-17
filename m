From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Sep 2013 10:45:09 -0500
Subject: [PATCH 1/7] usb: dwc3: get "usb_phy" only if the platform
 indicates the presence of PHY
In-Reply-To: <CAFp+6iE+xbSWWp2bNc5MRSUrA4Fi6qVU4vhR4+mtZHZGidkMGg@mail.gmail.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-2-git-send-email-kishon@ti.com>
 <52319912.8030203@ti.com>
 <CAFp+6iE+xbSWWp2bNc5MRSUrA4Fi6qVU4vhR4+mtZHZGidkMGg@mail.gmail.com>
Message-ID: <20130917154509.GJ15645@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 12, 2013 at 04:17:08PM +0530, Vivek Gautam wrote:
> On Thu, Sep 12, 2013 at 4:06 PM, Roger Quadros <rogerq@ti.com> wrote:
> > Hi Kishon,
> >
> > On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:
> >> There can be systems which does not have a external usb_phy, so get
> >> usb_phy only if usb-phy property is added in the case of dt boot or if
> >> platform_data indicates the presence of PHY. Also remove checking if
> >> return value is -ENXIO since it's now changed to always enable usb_phy layer.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/usb/dwc3/Kconfig         |    1 +
> >>  drivers/usb/dwc3/core.c          |   60 +++++++++++++++++---------------------
> >>  drivers/usb/dwc3/platform_data.h |    1 +
> >>  3 files changed, 28 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >> index f969ea2..cfc16dd 100644
> >> --- a/drivers/usb/dwc3/Kconfig
> >> +++ b/drivers/usb/dwc3/Kconfig
> >> @@ -2,6 +2,7 @@ config USB_DWC3
> >>       tristate "DesignWare USB3 DRD Core Support"
> >>       depends on (USB || USB_GADGET) && GENERIC_HARDIRQS && HAS_DMA
> >>       depends on EXTCON
> >> +     select USB_PHY
> >>       select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
> >>       help
> >>         Say Y or M here if your system has a Dual Role SuperSpeed
> >> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >> index 474162e..428c29e 100644
> >> --- a/drivers/usb/dwc3/core.c
> >> +++ b/drivers/usb/dwc3/core.c
> >> @@ -387,16 +387,38 @@ static int dwc3_probe(struct platform_device *pdev)
> >>       if (node) {
> >>               dwc->maximum_speed = of_usb_get_maximum_speed(node);
> >>
> >> -             dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> >> -             dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> >> +             if (of_property_read_bool(node, "usb-phy")) {
> >> +                     dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev,
> >> +                             "usb-phy", 0);
> >> +                     if (IS_ERR(dwc->usb2_phy))
> >> +                             return PTR_ERR(dwc->usb2_phy);
> >> +                     dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev,
> >> +                             "usb-phy", 1);
> >> +                     if (IS_ERR(dwc->usb3_phy))
> >> +                             return PTR_ERR(dwc->usb3_phy);
> >
> > Some DWC3 instances use only usb2_phy. e.g. on DRA7 the 2nd dwc3 instance doesn't use usb3_phy.
> > This needs to be a valid case and driver shouldn't error out.
> 
> So, i think adding flexibility to DWC3 to have either
> usb2-phy/usb3-phy or both of them seems to be valid point.
> Any suggestions ?

I've gone through that. There's no easy way to make USB3 PHY optional.

For platforms which actually have the USB3 side of things, not
initializing the PHY kills dwc3.

I've been trying to understand what it is that the USB3 PHY generates
and gets backfed into dwc3, but so far no luck.

I even have a patch for that, which I have dropped when I found out
about this problem.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/3eb5cfa8/attachment.sig>
