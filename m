From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 29 Nov 2017 09:09:41 +0100
Subject: [PATCH v1] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <22b57b69-3728-d879-42c6-92e87e7c7955@codeaurora.org>
References: <1511889106-9239-1-git-send-email-awallis@codeaurora.org>
 <20171128193500.GA30609@kroah.com>
 <22b57b69-3728-d879-42c6-92e87e7c7955@codeaurora.org>
Message-ID: <20171129080941.GA2319@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 03:32:29PM -0500, Adam Wallis wrote:
> On 11/28/2017 2:35 PM, Greg Kroah-Hartman wrote:
> > On Tue, Nov 28, 2017 at 12:11:46PM -0500, Adam Wallis wrote:
> >> The xHCI driver currently has the IMOD set to 160, which
> >> translates to an IMOD interval of 40,000ns (160 * 250)ns
> >>
> [..]
> >> --- a/drivers/usb/host/xhci-plat.c
> >> +++ b/drivers/usb/host/xhci-plat.c
> >> @@ -23,6 +23,7 @@
> >>  #include "xhci-plat.h"
> >>  #include "xhci-mvebu.h"
> >>  #include "xhci-rcar.h"
> >> +#include "xhci-mtk.h"
> >>  
> >>  static struct hc_driver __read_mostly xhci_plat_hc_driver;
> >>  
> >> @@ -269,6 +270,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >>  	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
> >>  		xhci->quirks |= XHCI_BROKEN_PORT_PED;
> >>  
> >> +	/* imod interval in nanoseconds */
> >> +	if (device_property_read_u32(sysdev,
> >> +		"imod-interval", &xhci->imod_interval))
> >> +		xhci->imod_interval = 40000;
> > 
> > So no matter what value you read, you set it to 40000?  Or am I reading
> > this code incorrectly?
> 
> I think you may be reading the code incorrectly. device_property_read_u32()
> returns 0 when the property is found and valid...and stored into
> xhci->imod_interval. When 0 is returned in this case, the default value of
> 40,000 is skipped over.

Yes, it is very hard to read :(

> > There's a good reason putting function calls inside if() is considered a
> > bad coding style :)
> 
> I do not disagree with you, however, I was trying to maintain style consistency
> with the device property reads with the xhci_plat_probe function.

Ok, maybe it should all be fixed :)

> If I break that consistency, a couple of ways I might write this cleaner
> 
> 1) set xhci->imod_interval to 40,000 before the call to
> device_property_read_u32. If the property exists in a firmware node, it will
> update the imod_interval value...if it does not exist, it will not update this
> value and the default will be used. In this case, I would not even check the
> return value. This method is used quite a bit in the kernel.

Sounds like a reasonable way to do it.

thanks,

greg k-h
