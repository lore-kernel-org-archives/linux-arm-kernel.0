From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 5 Jan 2017 12:24:01 +0000
Subject: [RFC PATCH] usb: dwc3: host: add support for OTG in DWC3 host
 driver
In-Reply-To: <87o9znvtl3.fsf@linux.intel.com>
References: <1483536181-22356-1-git-send-email-mnarani@xilinx.com>
 <1483536181-22356-5-git-send-email-mnarani@xilinx.com>
 <87o9znvtl3.fsf@linux.intel.com>
Message-ID: <B2EF86ADE403CA4A85AF1BE1D3A22A06DB2FC0@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi at kernel.org]
> Sent: Wednesday, January 04, 2017 7:03 PM
> 
> Hi,
> 
> Manish Narani <manish.narani@xilinx.com> writes:
> > This patch adds support for OTG host mode initialization in DWC3 host
> > driver. Before the host initialization sequence begins. The driver has
> > to make sure the no OTG peripheral mode is enabled.
> >
> > Signed-off-by: Manish Narani <mnarani@xilinx.com>
> > ---
> >  drivers/usb/dwc3/host.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c index
> > 487f0ff..4caa3fe 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -16,6 +16,8 @@
> >   */
> >
> >  #include <linux/platform_device.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> >
> >  #include "core.h"
> >
> > @@ -111,6 +113,18 @@ int dwc3_host_init(struct dwc3 *dwc)
> >  	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
> >  			  dev_name(dwc->dev));
> >
> > +	if (dwc->dr_mode == USB_DR_MODE_OTG) {
> > +		struct usb_phy *phy;
> > +		/* Switch otg to host mode */
> > +		phy = usb_get_phy(USB_PHY_TYPE_USB3);
> > +		if (!IS_ERR(phy)) {
> > +			if (phy && phy->otg)
> > +				otg_set_host(phy->otg,
> > +						(struct usb_bus *)(long)1);
> > +			usb_put_phy(phy);
> > +		}
> > +	}
> 
> NAK. Don't change default mode for everybody. Default mode should actually
> be peripheral, but let's not touch whatever HW designer has set; at least for
> now.

Yes, The default mode is Peripheral. The above is to initialize the host related stuff in OTG driver before sensing the OTG ID and get to the respective mode.

- Manish
