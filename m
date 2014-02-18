From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Feb 2014 19:57:32 +0000
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140218193654.GK2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <20140218185947.GA22340@obsidianresearch.com>
 <20140218190929.GF2010@mudshark.cambridge.arm.com>
 <1411925.bMiMyFpUnW@wuerfel>
 <20140218193654.GK2010@mudshark.cambridge.arm.com>
Message-ID: <20140218195732.GL2010@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 07:36:54PM +0000, Will Deacon wrote:
> On Tue, Feb 18, 2014 at 07:32:33PM +0000, Arnd Bergmann wrote:
> > On Tuesday 18 February 2014 19:09:29 Will Deacon wrote:
> > > 
> > > > Regarding the 0x6200.. There are two conflicting issues there 
> > > >  - You really don't want to let the PCI core assign resources to that
> > > >    range, it probably won't work.
> > > 
> > > Right, with kvmtool we don't support resource assignment (the BARs are fixed)
> > > so everything is PCI_PROBE_ONLY.
> > 
> > Ok, I looked at the source now and can confirm:
> > 
> > * 0x0-0x1000 are used for lots of legacy ISA devices.
> > * PCI devices get assigned IO addresses in 0x400 steps starting at 0x6200.
> > * There are three PCI drivers doing this: VESA, PCI-SHMEM and virtio-pci.
> > 
> > Regarding the PCI_PROBE_ONLY flag, how do you set that? Should we
> > have a standard DT property for that? On PowerPC we already specified
> > "linux,pci-probe-only" and "linux,pci-assign-all-buses", which seems
> > reasonable to use in architecture independent code as well.
> 
> For arch/arm/ it's done on the command line (pci=firmware) but yes, for the
> generic driver it sounds like a good idea to put this in the device-tree.
> I'll look at adding the ppc properties in the next version.

Damn, I spoke too soon. PowerPC puts this information in the /chosen node, so
it applies to all PCI host controllers in the system. That then maps nicely
to pci_{add,clear}_flags which are global properties in Linux.

It sounds like this should really be per-controller. What do you think?

Will
