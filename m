From: greg@kroah.com (Greg KH)
Date: Thu, 9 Nov 2017 15:08:33 +0100
Subject: next/master boot: 264 boots: 62 failed, 199 passed with 3
 conflicts (next-20171109)
In-Reply-To: <20171109134713.fjw7wlflu4dj45xm@sirena.co.uk>
References: <5a0446a2.85a8500a.55819.1c58@mx.google.com>
 <20171109134502.wyxxcstplybe4ed4@sirena.co.uk>
 <20171109134713.fjw7wlflu4dj45xm@sirena.co.uk>
Message-ID: <20171109140833.GJ6545@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 01:47:13PM +0000, Mark Brown wrote:
> On Thu, Nov 09, 2017 at 01:45:02PM +0000, Mark Brown wrote:
> > On Thu, Nov 09, 2017 at 04:14:26AM -0800, kernelci.org bot wrote:
> > 
> > Today's -next fails to boot a bcm2836-rpi-2-b on any config in kernelci,
> > it was working yesterday:
> > 
> > >     bcm2835_defconfig:
> > >         bcm2836-rpi-2-b:
> > >             lab-collabora: new failure (last pass: next-20171107)
> > 
> > The boot log looks like something went badly wrong with USB:
> > 
> > [    1.643488] dwc2 3f980000.usb: DWC OTG Controller
> > [    1.648225] dwc2 3f980000.usb: new USB bus registered, assigned bus number 1
> > [    1.655328] dwc2 3f980000.usb: irq 39, io mem 0x3f980000
> > [    1.661495] hub 1-0:1.0: USB hub found
> > [    1.665301] hub 1-0:1.0: 1 port detected
> > [    1.669239] hub 1-0:1.0: config failed, can't get hub status (err 2)
> > [    1.676763] hub 1-0:1.0: activate --> -22
> > [    1.680806] hub 1-0:1.0: activate --> -22
> > [    1.684855] hub 1-0:1.0: activate --> -22
> > 
> > and so on until the tester gets bored.  There's nothing obvious changed
> > in arch/arm or drivers/usb though.
> > 
> > More info and full log here:
> > 
> >    https://kernelci.org/boot/id/5a04231159b514cb291cdd1a/
> 
> There's similar issues reported for Odroid c1 with the same DesignWare
> controller so it's unlikely to be something Raspberry Pi related:
> 
>     https://kernelci.org/boot/id/5a0416c059b514c4931cdd1b/

Fix is already diagnosed and is in my tree now.

I've put it below if you need/want it now.

thanks,

greg k-h
-------------

>From d656fa32b13424701bb85f6b5183ea869b363799 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@linux.intel.com>
Date: Thu, 9 Nov 2017 12:59:58 +0200
Subject: usb: core: message: remember to reset 'ret' to 0 when necessary

usb_control_msg() will return the amount of bytes transferred, if that
amount matches what we wanted to transfer, we need to reset 'ret' to 0
from usb_get_status().

Fixes: 2e43f0fe379c ("usb: core: add a 'type' parameter to usb_get_status()")
Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/message.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index ebaea514161f..77001bcfc504 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -975,6 +975,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
 		}
 
 		*(u32 *) data = le32_to_cpu(*(__le32 *) status);
+		ret = 0;
 		break;
 	case 2:
 		if (type != USB_STATUS_TYPE_STANDARD) {
@@ -983,6 +984,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
 		}
 
 		*(u16 *) data = le16_to_cpu(*(__le16 *) status);
+		ret = 0;
 		break;
 	default:
 		ret = -EIO;
-- 
2.15.0
