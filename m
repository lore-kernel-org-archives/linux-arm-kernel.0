From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 20 Dec 2014 16:48:50 +0100
Subject: bluetooth: Add hci_h4p driver
In-Reply-To: <7DC7F8DF-CBC7-47CE-8B6F-5BA19ADBB3B6@holtmann.org>
References: <20141213223727.GA13894@amd>
 <97C706D6-765B-446A-8180-600F5FB6C68B@holtmann.org>
 <20141219095000.GA24703@amd>
 <7DC7F8DF-CBC7-47CE-8B6F-5BA19ADBB3B6@holtmann.org>
Message-ID: <20141220154850.GA28390@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I have trouble understanding... h4p_hci_open() seems to be called as
> > soon as I insmod the driver. Who does that? Is it some kind of udev
> > magic?
> 
> As soon as you do hci_register_dev, it will bring up the device and run the basic initialization. That is needed to get the address, version information and features. Otherwise the mgmt interface can not work. We need basic information about the device.
> 
> So what the kernel will do internally when you find a device is bring it up, get the basics and then bring it back down (in case nobody uses it). See hci_power_on work.
>

Aha, slightly unexpected, but it matches observations. Good.

> > To use __hci_cmd_sync()
> > 
> >>> +
> >>> +	SET_HCIDEV_DEV(hdev, info->dev);
> >>> +
> >>> +	if (hci_register_dev(hdev) >= 0)
> >>> +		return 0;
> >>> +
> >>> +	dev_err(info->dev, "hci_register failed %s.\n", hdev->name);
> >>> +	hci_free_dev(info->hdev);
> >>> +	return -ENODEV;
> >>> +}
> >> 
> >> And normally this is folded into the probe handling and not in a
> >> separate function.
> > 
> > The probe function is too long, already...
> 
> Have you compared it to other functions. Normally probe() functions in general are all pretty long since they have to do tons of stuff. Having all in one function means you can read through it at once.
>

Ok.

> >>> +#include "hci_h4p.h"
> >> 
> >> Why is this a separate file? And if so, why not all UART specific details are in this file. Including bunch of the defines you have in the header.
> >> 
> > 
> > Well, you wanted less global functions, so I moved some as inlines to
> > headers. I guess I can merge nokia_core and nokia_uart if really wanted.
> 
> Would this become easier when some of the OMAP specific stuff is moved out of this driver? If that is possible.
> 

Yes, I can investigate further cleanups. But original plan was to
merge it and then clean up the rest. Could we do that, please?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
