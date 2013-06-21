From: oneukum@suse.de (Oliver Neukum)
Date: Fri, 21 Jun 2013 11:20:14 +0200
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVNNR-ZYsJpQXu0tUpCtEk-hhw0M8nmYMB4GcSkKyLopqw@mail.gmail.com>
References: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
 <4558223.ViRy5S2mR9@linux-5eaq.site>
 <CACVXFVNNR-ZYsJpQXu0tUpCtEk-hhw0M8nmYMB4GcSkKyLopqw@mail.gmail.com>
Message-ID: <4846131.y6OZcfhzIJ@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013 17:13:48 Ming Lei wrote:
> On Fri, Jun 21, 2013 at 4:33 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > On Friday 21 June 2013 09:12:38 Ming Lei wrote:
> >> >> This should be enough since during remove path usbcore will wait for all
> >> >> URBs' completion which is only triggered by tasklet, so once all URBs are
> >> >> finished, the tasklet list has been empty already.
> >> >
> >> > No, usbcore only waits until the urb_list for each endpoint is empty.
> >> > It doesn't keep track of the individual URB completions.  Look at
> >> > usb_hcd_flush_endpoint() and you'll see.
> >>
> >> But, if URBs still aren't completed after usb_disconnect(), it should be
> >> bug of usbcore or driver, shouldn't it?
> >
> > A driver cannot know what caused the call to disconnect(). That includes
> > driver unbind. Doing IO to a device that another driver may be bound to
> > is certainly a bug.
> > Nevertheless it usually works and it is desirable to keep that behavior.
> 
> I mean once driver is unbound, URB's complete() in that driver shouldn't be

This is highly problematic. It is bound to cause resource leaks.

> called.  The situation might happen when driver->remove() doesn't
> kill the URBs with the patch applied.

Well, there is no good way to handle this. But we have a simple rule.
If usb_submit_urb() succeeds, complete() will be called.
Breaking this rule is a bad idea.

The best way is really to make sure that no URB survive.

	Regards
		Oliver
