From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 15:53:41 +0000
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <Pine.LNX.4.44L0.1202280951440.1456-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1202280951440.1456-100000@iolanthe.rowland.org>
Message-ID: <201202281553.41332.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 February 2012, Alan Stern wrote:
> It's heading in the intended direction, although the details might not 
> all be quite right -- I didn't check them very closely.
> 
> One big thing about it is wrong: Many or most of the functions you
> exported don't really need to be.  Instead, ohci-hcd.c should define
> ohci_driver (a bus-agnostic hc_driver structure) and export that.  
> Then the bus-glue files can copy the structure for their own use during
> initialization (rather than duplicating the definition all over the
> place) and override individual methods as needed.
> 
> It's a more "object-oriented" approach.  :-)

Yes, that makes sense. I did not try to actually understand how the
driver works internally, just tried the mechanical conversion in a way
that did not require changing any code besides the sb800_prefetch
function that had to be moved.

There are still a few symbols that are used by most or all hw specific
drivers and that will have to remain exported:

ohci_init, ohci_run, ohci_stop, ohci_finish_controller_resume, and
ohci_hcd_init

And then there are a few symbols that are only used by one or two
drivers, possibly correctly or not:

ohci_dump (spear)
ohci_usb_reset (at91, pci)
ohci_shutdown (ps3)
ohci_restart (pci)
ohci_hub_control (da8xx)

These ones do not need to get exported following your suggestion:

ohci_urb_enqueue, ohci_urb_dequeue, ohci_endpoint_disable,
ohci_get_frame, ohci_irq, ohci_bus_suspend, ohci_bus_resume,
ohci_hub_status_data, and ohci_start_port_reset

I would do implementation the other way round and let the bus specific
driver provide a sparsely populated version of struct hc_driver
that is completed by a function in the common ohci parts. That would
keep the logicto combine the two in one place rather than duplicating
it everywhere, but it's a bit more overhead in the case where you
build only a single bus glue.

Certainly either way is possible, whichever you prefer.

	Arnd
