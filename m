From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 21 Jun 2013 17:43:21 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <4846131.y6OZcfhzIJ@linux-5eaq.site>
References: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
 <4558223.ViRy5S2mR9@linux-5eaq.site>
 <CACVXFVNNR-ZYsJpQXu0tUpCtEk-hhw0M8nmYMB4GcSkKyLopqw@mail.gmail.com>
 <4846131.y6OZcfhzIJ@linux-5eaq.site>
Message-ID: <CACVXFVNQLSg_hQ_h7S8uCTjTuKV6Q5gPSYFP0SLXiqdHOKGfsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 5:20 PM, Oliver Neukum <oneukum@suse.de> wrote:
>
> This is highly problematic. It is bound to cause resource leaks.
>
>> called.  The situation might happen when driver->remove() doesn't
>> kill the URBs with the patch applied.
>
> Well, there is no good way to handle this. But we have a simple rule.
> If usb_submit_urb() succeeds, complete() will be called.
> Breaking this rule is a bad idea.

The rule should be enhanced by calling complete() before
completing driver unbind.

>
> The best way is really to make sure that no URB survive.

Drivers may let usbcore to do that by not setting driver->soft_unbind.

I will fix the problem in v2, one solution I thought of is to flush
the endpoint's URBs which have been added to tasklet list
at the end of usb_hcd_flush_endpoint(). Any comments?

Thanks,
--
Ming Lei
