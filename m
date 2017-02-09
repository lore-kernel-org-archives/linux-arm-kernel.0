From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 9 Feb 2017 09:41:13 +0800
Subject: [PATCH v12 6/9] usb: xhci: use bus->sysdev for DMA configuration
In-Reply-To: <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
 <1486372421-29073-7-git-send-email-peter.chen@nxp.com>
 <20170208204300.GC8068@usblab-sd-06.qualcomm.com>
Message-ID: <20170209014113.GB460@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 12:43:00PM -0800, Jack Pham wrote:
> Hi Peter, Sriram, Arnd,
> 
> On Mon, Feb 06, 2017 at 05:13:38PM +0800, Peter Chen wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > For xhci-hcd platform device, all the DMA parameters are not
> > configured properly, notably dma ops for dwc3 devices. So, set
> > the dma for xhci from sysdev. sysdev is pointing to device that
> > is known to the system firmware or hardware.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Tested-by: Baolin Wang <baolin.wang@linaro.org>
> > Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> > Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > ---
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 6d33b42..7a9c860 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> 
> > -	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> > +	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
> > +			       dev_name(&pdev->dev), NULL);
> 
> As mentioned already in [1], usb_create_shared_hcd() is called to create
> the second bus, however it also needs to be converted.
> 
> Not exactly as Roger's suggestion but this worked for me:
> 
> -       xhci->shared_hcd = usb_create_shared_hcd(driver, &pdev->dev,
> +       xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
>                         dev_name(&pdev->dev), hcd);
>         if (!xhci->shared_hcd) {
>                 ret = -ENOMEM;
> 
> Without this, SuperSpeed devices fail to enumerate:
> 
>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd
>  usb 2-1: device descriptor read/8, error -11
>  <and continues...>
> 
> Thanks,
> Jack
> 

Do you work at same platform with Vivek Gautam? I see his tested-by
tag in this patch.

I have no dwc3 platform to test, I only got patches from [1], and rebase to
Greg's usb-next, the rebase has a conflict, and I made a 
change which is similar to revert below patch, but it is definitely
not your problem.

commit 488dc164914ff5ce5e913abd32048d28fc0d06b8
Author: Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Fri Jan 20 15:38:24 2017 +0200

    xhci: remove WARN_ON if dma mask is not set for platform devices


[1] http://www.spinics.net/lists/linux-usb/msg152375.html

-- 

Best Regards,
Peter Chen
