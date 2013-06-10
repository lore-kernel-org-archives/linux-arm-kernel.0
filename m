From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 10 Jun 2013 16:51:57 -0400 (EDT)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306101316020.1133-100000@iolanthe.rowland.org>
Message-ID: <Pine.LNX.4.44L0.1306101647290.1133-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Alan Stern wrote:

> > Tasklet doesn't disable local interrupts.
> 
> It is documented that interrupts will be disabled while the completion 
> handler runs.  Therefore the tasklet _must_ disable local interrupts.

You know, it may be that you can get most of the advantages you want by 
enabling local interrupts around the call to unmap_urb_for_dma() in 
usb_hcd_giveback_urb().

This may be a little dangerous, though, because it is possible for an
URB to be given back at the time it is submitted.  Drivers may not 
expect interrupts to get enabled temporarily when they call 
usb_submit_urb().

Alan Stern
