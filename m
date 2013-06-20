From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 12:52:31 -0400 (EDT)
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306201242110.2063-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Ming Lei wrote:

> On Thu, Jun 20, 2013 at 10:59 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > By the way, did you consider the race that Oliver pointed out?  When an
> > HCD is removed, all the outstanding URBs for all devices on its bus get
> > cancelled.  The core waits until the urb_list for each endpoint is
> > empty.
> 
> This should be enough since during remove path usbcore will wait for all
> URBs' completion which is only triggered by tasklet, so once all URBs are
> finished, the tasklet list has been empty already.

No, usbcore only waits until the urb_list for each endpoint is empty.  
It doesn't keep track of the individual URB completions.  Look at
usb_hcd_flush_endpoint() and you'll see.

> > (Probably it's sufficient to wait until the tasklet lists are empty.  I
> > assume tasklet_kill() won't stop a tasklet that's currently running.)
> 
> From the implementation of tasklet_kill(), it will wait for the completion
> of the tasklet.
> 
> Actually the tasklet_kill() should not be necessary, I think.

You're probably right.  But we should wait until the tasklet's list is 
empty; we don't want to deallocate an hcd structure until all the URBs 
are taken off.

Alan Stern
