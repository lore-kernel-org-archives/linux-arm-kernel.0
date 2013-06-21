From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 21 Jun 2013 10:48:38 -0400 (EDT)
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVNQLSg_hQ_h7S8uCTjTuKV6Q5gPSYFP0SLXiqdHOKGfsw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306211040420.1020-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jun 2013, Ming Lei wrote:

> On Fri, Jun 21, 2013 at 5:20 PM, Oliver Neukum <oneukum@suse.de> wrote:
> >
> > This is highly problematic. It is bound to cause resource leaks.
> >
> >> called.  The situation might happen when driver->remove() doesn't
> >> kill the URBs with the patch applied.
> >
> > Well, there is no good way to handle this. But we have a simple rule.
> > If usb_submit_urb() succeeds, complete() will be called.
> > Breaking this rule is a bad idea.
> 
> The rule should be enhanced by calling complete() before
> completing driver unbind.
> 
> >
> > The best way is really to make sure that no URB survive.
> 
> Drivers may let usbcore to do that by not setting driver->soft_unbind.
> 
> I will fix the problem in v2, one solution I thought of is to flush
> the endpoint's URBs which have been added to tasklet list
> at the end of usb_hcd_flush_endpoint(). Any comments?

Come to think of it, this shouldn't be a problem.  Drivers _must_
insure that all their URBs have completed before their disconnect
routine returns; otherwise the completion handler could get called
after the driver has been unloaded from memory.

Currently we have no way to enforce this in usbcore, although with the
tasklets we could enforce it.  But I don't think it is necessary.  It
would be sufficient to log a warning if the tasklet's URB list isn't
empty when exit_giveback_urb_bh() runs.  It won't happen unless there's
a buggy driver.

Besides, even if you try to flush all the URBs on the tasklet's list at 
the end of usb_hcd_flush_endpoint(), you'll still miss the URBs which 
have been moved to the local_list in usb_giveback_urb_bh().  You'd have 
to wait until the tasklet wasn't running, and it would most likely be a 
waste of time.

Alan Stern
