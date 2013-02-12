From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 12 Feb 2013 12:38:48 -0700
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <201302121902.14276.arnd@arndb.de>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302121600.08434.arnd@arndb.de>
 <20130212184127.GA1471@obsidianresearch.com>
 <201302121902.14276.arnd@arndb.de>
Message-ID: <20130212193848.GE1471@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 07:02:14PM +0000, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> > > My feeling is that an easier solution would be to keep separate
> > > root buses for each port, which then behaves completely PCIe
> > > compliant, but add a hook in the procedure above to set up the
> > > address translation windows between the pci_bus_size_bridges()
> > > and the pci_bus_assign_resources() calls.
> > 
> > This process is only done during driver initialization. How would you
> > support PCI-E device hotplug (my systems rely on this)? Hotplug works
> > today with the existing Marvell driver, however that relies on
> > pre-allocated windows.
> 
> I did not expect hotplug to work with either approach. How does
> it work with the existing driver? From my understanding, you still
> assign all the top-level P2P bridge resources at bootup, and only
> if that happens to have some space left before the next bridge,
> it would be possible to fit in a hotplug device.

PCI-E hotplug can be supported through the generic /sys/bus/pci/rescan
mechanism, which forces a rediscovery/re-evaluation of all the buses
in the system. The PCI core is smart enough to know what it can/can
not reassign and can move the bridge windows around (IIRC most of the
issues here are resolved these days?).

For PCI-E, the root port bridge can be placed anywhere in the host
aperture, so as long as the host aperture isn't filled the core can
allocate a memory region for the now active port.

Thomas's driver should support this as the regions and windows are all
properly dynamic.

This is one reason why re-using the PCI core code is so desirable, it
handles all these complexities.

Jason
