From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 22 Jun 2011 11:02:27 -0400 (EDT)
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <20110622143216.GE27654@legolas.emea.dhcp.ti.com>
Message-ID: <Pine.LNX.4.44L0.1106221055030.1977-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jun 2011, Felipe Balbi wrote:

> > In fact, something like this is _necessary_ for all UDC/PHY drivers
> > unless the device can guarantee that it will automatically wake up from
> > suspend in time to service a USB packet (note that the window for
> > responding to a packet is only a few microseconds).  Otherwise the
> > device would appear to the host to be unresponsive and broken -- better
> > to do a clean disconnect.
> > 
> > If suspending the device while it is in use would cause problems ...  
> > then don't suspend it when it is in use!
> 
> I second your thoughts, but today we don't have enough infrastructure to
> communicate between PHY and Link, so a clean solution isn't possible,
> right ?
> 
> Should we block this patch due to that ?

No, the patch is appropriate.

We don't need better communication.  If g_mass_storage (for example)  
knows that the device is in use, it can block suspends by returning
-EBUSY from its own suspend callback.  The UDC driver doesn't need to
worry about these matters; it should assume that such things have
already been handled elsewhere.  That's what Dmitry meant when he was
talking about a "higher level driver" -- maybe "lower level" would have
been a better choice of words.  :-)

Until recently, ordering of the suspend callbacks didn't present any 
problem.  The gadget device was a child of the UDC device and therefore 
its suspend callback would always be invoked first.

With the new UDC framework, I don't know if this is true any more.  
It's something to consider.

Alan Stern
