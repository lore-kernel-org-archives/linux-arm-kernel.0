From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 23:20:07 +0200
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device tree
 nodes
In-Reply-To: <20130618190223.GA6578@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306182022.08927.arnd@arndb.de>
 <20130618190223.GA6578@obsidianresearch.com>
Message-ID: <201306182320.07351.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2013 at 08:22:08PM +0200, Arnd Bergmann wrote:
> 
> > > > > Arnd, we've discussed this at length with you while getting the PCIe
> > > > > driver merged, and we've explained this to you numerous times. Could
> > > > > you please understand that any of your proposal that suggests writing
> > > > > down static windows for PCIe devices will not work?
> > > > 
> > > > Where did I suggest static windows for PCIe devices?
> > > 
> > > Where does your new proposal buys us anything useful compared to the
> > > existing PCIe DT binding that has been discussed at length with you?
> > 
> > I'm pretty sure I explained the idea above originally and was ignored.
> > Jason Gunthorpe might remember better, but I think he liked it when I
> > originally proposed doing it this way.
> 
> I remember it took a bit to understand your proposal, but I thought it
> could work, but I admit I forget all the little details now :(
> 
> Ah, if I can just rephrase simply - the notion was to move the
> determination of the aperture to use dynmic allocation and then
> restructure the ranges around the mbus target, since they no longer
> need to encode the aperture.

Right.

> My concern: dynamically sizing the aperture is hard. There are three
> apertures that need to be picked, and the PCI core code has no support
> for dynamic apertures. Getting the aperture from the DT is a
> functional compromise.

After some discussion on IRC with Ezequiel, I think it's best to leave
the aperture listed in DT but say in the binding that the OS may
override it.

I would still want to see the actual MBUS IDs in the ranges property
of the pci-controller nodes. Right now, the pcie driver has to call
into the mbus driver passing a hardcoded string for setting up the
mapping, which is then used to look up the MBUS ID. This is rather
inconsistent and we should have all that information in DT. Ideally
we should also use it, to ensure it's correct but for 3.11 it would
be enough to get the DT representation right. We can replace the
string passing in 3.12.

> > * Since the host physical address for the PCIe memory space window
> >   is set up dynamically anyway, there is no reason to hardcode it in
> >   DT. We want it to be as large as possible, and this way the mbus
> >   driver can just pick the largest free area itself after setting up
> >   all the other mappings from the ranges property.
> 
> This seems to get really complicated if the mbus driver is ever
> required to support dynamic mappings.. If PCI-E claims all memory and
> then you modprobe something it could fail.

Yes, good point. However that is something we can figure out if it
comes to that. With my suggestion of setting up the mbus windows
in the of_bus xlate function, we would already create them at boot
time when of_platform_populate gets called, so that wouldn't be a
problem.

> IMHO, I go back to my original thoughts. There is no real need for any
> of this to be dynamic, we can use the values in the DT, presumably set
> by the bootloader and things will work well.
> 
> The added complexity and failure modes for dynamic is simply not worth
> it..

I don't think it's too hard to be prepared for fully dynamic operation.
As Grant said in his comment on v2, the real complexity comes from the
fact that we are mixing dynamic and static configuration here, and
the PCIe configuration is inherently dynamic.

The change I'm proposing would just mean the DT representation reflects
the dynamic nature of the PCIe windows.

	Arnd
