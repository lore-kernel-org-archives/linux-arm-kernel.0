From: stern@rowland.harvard.edu (Alan Stern)
Date: Sun, 9 Jun 2013 11:48:09 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1306091136450.13202-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Jun 2013, Ming Lei wrote:

> Hi,
> 
> The patchset supports to run giveback of URB in tasklet context, so that
> DMA unmapping/mapping on transfer buffer and compelte() callback can be
> run with interrupt enabled, then time of HCD interrupt handler can be
> saved much. Also this approach may simplify HCD since HCD lock needn't
> be released any more before calling usb_hcd_giveback_urb().

That's a lot of material.  However, you haven't specifically said
_what_ you want to accomplish.  It sounds like you're trying to
minimize the amount of time spent in hardirq context, but I can't be
sure that is really what you want.

If it is, this is not a good way to do it.  A better way to minimize
the time spent in hardirq context is to use a threaded interrupt
handler.  But why do you want to minimize this time in the first place?  
The CPU will be still have to use at least as much time as before; the
only difference is that it will be in softirq or in a high-priority
thread instead of in hardirq.

Also, I don't see how you can avoid releasing the HCD's private lock
before calling usb_hcd_giveback_urb().  When the completion handler
tries to resubmit the URB, the HCD's enqueue routine will try to
reacquire the private lock.  If it didn't release the lock earlier, it
will hang.

Alan Stern
