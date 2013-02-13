From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 12 Feb 2013 17:32:24 -0700
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <201302122305.28467.arnd@arndb.de>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302121902.14276.arnd@arndb.de>
 <20130212193848.GE1471@obsidianresearch.com>
 <201302122305.28467.arnd@arndb.de>
Message-ID: <20130213003224.GA32535@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 11:05:28PM +0000, Arnd Bergmann wrote:
> On Tuesday 12 February 2013, Jason Gunthorpe wrote:
> > PCI-E hotplug can be supported through the generic /sys/bus/pci/rescan
> > mechanism, which forces a rediscovery/re-evaluation of all the buses
> > in the system. The PCI core is smart enough to know what it can/can
> > not reassign and can move the bridge windows around (IIRC most of the
> > issues here are resolved these days?).
> > 
> > For PCI-E, the root port bridge can be placed anywhere in the host
> > aperture, so as long as the host aperture isn't filled the core can
> > allocate a memory region for the now active port.
> > 
> > Thomas's driver should support this as the regions and windows are all
> > properly dynamic.
> 
> Ah, so you only allow hotplugging into the root ports, but not behind
> additional bridges that have active devices on them, right?
 
> I guess that is a common limitation for PCIe hotplugging.

In all the cases I've worked with, it has been a root port hot plug,
but I could imagine something like ExpressCard requiring a second
bridge.

The standard answer is to leave appropriate gaps. My *guess* on this
matter is that on x86 the gaps are left, as appropriate, by the boot
firmware. Eg an ExpressCard slot will always have a window assigned to
its bridge and Linux would typically not reassign it (or similar).

PCI core support for firmware-less embedded will someday need to do
something similar, eg via a special DT attribute on hot plug capable
ports.

Just to circle back on this whole thread - Thomas's solution is pretty
good, it covers pretty much all the use cases. I think it is a good
place to start, and as the firmware-less 'drivers/pci/host' concept
develops the right support will eventually come, as everyone is now
aware of the need to control the host bridge aperture from the core
PCI code.

Jason
