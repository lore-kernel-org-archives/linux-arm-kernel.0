From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 22 Mar 2013 12:33:20 -0600
Subject: Integrator PCI base dilemma
In-Reply-To: <201303221234.59289.arnd@arndb.de>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303221152.07569.arnd@arndb.de>
 <20130322121218.GD4977@n2100.arm.linux.org.uk>
 <201303221234.59289.arnd@arndb.de>
Message-ID: <20130322183320.GB10230@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 12:34:59PM +0000, Arnd Bergmann wrote:

> > So that leaves cns3xxx, tegra and ks8695 being the non-plat ones which
> > are "different" from the majority on ARM.
> 
> Well, those and all the ones that chose to set up their windows in the
> same way like the plat-orion based ones.

The orion stuff can create a second mapping into PCI address space
that can remap and generate VGA compatible bus addresses. That
techinque would duplicate how x86 handles this stuff these days.

Things are more complex on PCI-E. There is no subtractive decode in
PCI-E so you either need the magic window like x86 uses, or the bridge
windows and apertures have to be set 'just so'.

Further, there is danger with using an aperture offset. At the PCI bus
level there is only one address space. Creating an overlap of system
DRAM addresses and PCI device BARs within the PCI bus address space
could corrupt DMAs to the overlapped region in some cases - eg systems
that support peer-peer PCI-E.

For these reasons it is probably a good guideline that PCI-E systems
should strive to have a 1:1 mapping of their MMIO aperture..

Cheers,
Jason
