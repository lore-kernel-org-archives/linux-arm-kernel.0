From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Jan 2013 21:33:08 +0100
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <201301292015.21478.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301291645.08040.arnd@arndb.de> <20130129180936.3737e550@skate>
 <201301292015.21478.arnd@arndb.de>
Message-ID: <20130129213308.7e845064@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 29 Jan 2013 20:15:21 +0000, Arnd Bergmann wrote:

> I mean you could make each root port look like a separate host
> bridge that is not related to the others, and not have any
> emulated PCI-to-PCI bridges at all.

Ok.

> > Remember that the very reason to use emulated PCI-to-PCI bridges is
> > that we want to assign a global range of addresses of I/O regions
> > and a global range of addresses of memory regions, and let the
> > Linux PCI core allocate from those two ranges to the different
> > devices connected downstream of the PCI-to-PCI bridges. This gives
> > us for free the rather complex allocation of addresses we need to
> > set up our address decoding windows.
> > 
> > If we have have separate domains for each of our hardware PCIe
> > interface, can we still benefit from this allocation of resources
> > from a globally defined range of I/O addresses and memory addresses?
> 
> My interpretation of what you told me in the previous mail is that
> each root port has 
> 
> * A separate configuration space
> * A separate 64KB I/O window that is not shared with the other ports,
>   or potentially multiple 64KB windows, which we would not want to use
> * A configurable range of the memory space that does not overlap
>   with the other ports
> 
> Is the above a correct description?
> 
> If so, I think it would be most sensible to not try to put all ports
> into the same domain, but give each port the full view of its own
> 256 buses, and 64KB I/O space. The memory space can still be directly
> mapped, if you only set up the physical address window for that after
> the bus scan is complete.

Does this still allows me to give the Linux PCI *one* global range of
addresses for I/O space, and *one* global range of addresses for memory
space, and the the Linux PCI core assign ranges, within those global
ranges, to each host bridge?

This is absolutely essential for me, as I then read those allocated
ranges to configure the address decoding windows.

Basically, I have currently two suggestions:

 * From Jason Gunthorpe, to not use any host bridge, and instead use
   only PCI-to-PCI bridges, one per PCIe interface.

 * From you, to not use any PCI-to-PCI bridge, and use only host
   bridges, one per PCIe interface.

Would it be possible to get some consensus on this? In the review of
RFCv1, I was already told to use one global host bridge, and then one
PCI-to-PCI bridge per PCIe interface, and now we're talking about doing
something different. I'd like to avoid having to try gazillions of
different possible implementations :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
