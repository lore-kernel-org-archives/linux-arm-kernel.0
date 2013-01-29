From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 22:54:00 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129213308.7e845064@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292015.21478.arnd@arndb.de> <20130129213308.7e845064@skate>
Message-ID: <201301292254.01069.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> Does this still allows me to give the Linux PCI one global range of
> addresses for I/O space, and one global range of addresses for memory
> space, and the the Linux PCI core assign ranges, within those global
> ranges, to each host bridge?
> 
> This is absolutely essential for me, as I then read those allocated
> ranges to configure the address decoding windows.
> 
> Basically, I have currently two suggestions:
> 
>  * From Jason Gunthorpe, to not use any host bridge, and instead use
>    only PCI-to-PCI bridges, one per PCIe interface.
> 
>  * From you, to not use any PCI-to-PCI bridge, and use only host
>    bridges, one per PCIe interface.
> 
> Would it be possible to get some consensus on this? In the review of
> RFCv1, I was already told to use one global host bridge, and then one
> PCI-to-PCI bridge per PCIe interface, and now we're talking about doing
> something different. I'd like to avoid having to try gazillions of
> different possible implementations :-)

I'm actually fine with either of the two suggestions you mentioned above,
whichever is easier to implement and/or more closely matches what the
hardware actually implements is better IMHO.

The part that I did not like about having emulated PCI-to-PCI bridges
is that it seems to just work around a (percieved or real) limitation
in the Linux kernel by adding a piece of infrastructure, rather than
lifting that limitation by making the kernel deal with what the
hardware provides. That reminded me of the original mach-vt8500
PCI implementation that faked a complete PCI host bridge and a
bunch of PCI devices on it, in order to use the via-velocity
ethernet controller, instead of adding a simple 'platform_driver'
struct to that driver.

	Arnd
