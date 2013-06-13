From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Jun 2013 19:08:27 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <1371162260.9844.315.camel@gandalf.local.home>
Message-ID: <Pine.LNX.4.44L0.1306131855530.11870-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Steven Rostedt wrote:

> I only took a quick look at the second patch. I'm now looking at both
> patches applied to the code. I didn't realize this was called from the
> top half.
> 
> Usually the top half for threaded interrupts is used just to quite the
> interrupt line. Either by acknowledging the interrupt or by disabling
> the device from sending more interrupts till the bottom half (thread)
> can run. This looks to be doing a bit more than that.

Yes, it does.  Ming left all the host controller processing in the top 
half.  The bottom half merely handles the completion callbacks.

One of the things we discussed during this email thread was the
possibility of moving _all_ the work into the threaded handler.  
That's not as easy to do, though; it requires significant modification
of the host controller driver.  And each controller driver would need
its own modifications, whereas with Ming's approach only the core needs
to be changed.

> I'll look a bit deeper at the patch, but this still doesn't look like a
> typical threaded interrupt usage.

I'll agree with that; it isn't typical.  Ming claims that the work
remaining in the top half often takes less than 20 us on average in his
tests.  Depending on the particular device, the work in the bottom half
can be very quick (little more than waking up a thread in the case of
usb-storage) or quite slow (perhaps on the order of a ms or more for
the UVC video driver on some ARM platforms).

Alan Stern
