From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 20 Jun 2013 10:59:28 -0400 (EDT)
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVOMYA9e2qiJoFCx+v7=fSWpjwpha5hKdcxX+4s5qAT83w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306201046440.2063-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Jun 2013, Ming Lei wrote:

> >> Looks not always synchronous, control transfer is synchronous, and
> >> interrupt transfer is still asynchronous. No drivers(hub, usbfs) depend
> >> on that,  and IMO, treating root hub same as hub will simplify HCD core,
> >> and finally we can remove all the above lock releasing & acquiring if
> >> all HCDs set HCD_BH.
> >>
> >> Also there is very less roothub transfers and always letting tasklet
> >> handle URB giveback of roothub won't have performance problem, so
> >> how about keeping the above tests?
> >
> > If you want to use the tasklets for root-hub URBs, okay.  There's no
> > reason to check the HCD_BH flag, though, because HCDs have only minimal
> > involvement in root-hub URBs.  In particular, HCD's don't call
> > usb_hcd_giveback_urb() for them.
> 
> Looks both root hub's control and interrupt transfer call usb_hcd_giveback_urb()
> to complete URBs, don't they?

They do.  But those calls come from within usbcore, not from within the 
HCD.  Which means it doesn't matter whether the HCD_BH flag is set.

When working with URBs sent to a root hub, it many ways it's as though 
usbcore acts as its own HCD.  It takes care of all the locking and 
giving back the URBs.

> > So you can use the tasklets for _all_ root-hub URBs.  Then the tests
> > above aren't necessary, and neither are the spinlock operations.
> 
> Yes, that is what I am going to do.

Okay.

By the way, did you consider the race that Oliver pointed out?  When an
HCD is removed, all the outstanding URBs for all devices on its bus get
cancelled.  The core waits until the urb_list for each endpoint is
empty.

In the past this was good enough.  But now it looks like we will also
need to wait until the tasklet lists are empty and the tasklets aren't
running before they get killed.  Your __exit_giveback_urb_bh() routine 
doesn't seem to do that.

(Probably it's sufficient to wait until the tasklet lists are empty.  I 
assume tasklet_kill() won't stop a tasklet that's currently running.)

Alan Stern
