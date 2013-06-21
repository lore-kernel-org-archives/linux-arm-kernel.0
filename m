From: ming.lei@canonical.com (Ming Lei)
Date: Sat, 22 Jun 2013 00:12:23 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <Pine.LNX.4.44L0.1306211040420.1020-100000@iolanthe.rowland.org>
References: <CACVXFVNQLSg_hQ_h7S8uCTjTuKV6Q5gPSYFP0SLXiqdHOKGfsw@mail.gmail.com>
 <Pine.LNX.4.44L0.1306211040420.1020-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVOKM_SvSmiktBoCHfmx-pMWjFkNOTDWc08m+MVkd=2-PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 10:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Come to think of it, this shouldn't be a problem.  Drivers _must_
> insure that all their URBs have completed before their disconnect
> routine returns; otherwise the completion handler could get called
> after the driver has been unloaded from memory.
>
> Currently we have no way to enforce this in usbcore, although with the
> tasklets we could enforce it.  But I don't think it is necessary.  It

One way of enforcing this I thought of is to wait for completions of all
unlinking URBs at the end of usb_hcd_flush_endpoint().

But as you said, it may not be necessary.

> would be sufficient to log a warning if the tasklet's URB list isn't
> empty when exit_giveback_urb_bh() runs.  It won't happen unless there's
> a buggy driver.
>
> Besides, even if you try to flush all the URBs on the tasklet's list at
> the end of usb_hcd_flush_endpoint(), you'll still miss the URBs which
> have been moved to the local_list in usb_giveback_urb_bh().  You'd have
> to wait until the tasklet wasn't running, and it would most likely be a
> waste of time.


Thanks,
--
Ming Lei
