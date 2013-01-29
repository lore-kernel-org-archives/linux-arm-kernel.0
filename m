From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 29 Jan 2013 10:40:08 -0700
Subject: [PATCH v2 18/27] arm: plat-orion: add more flexible PCI
 configuration space read/write functions
In-Reply-To: <20130129094003.0ca7be89@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-19-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130128195111.GC17722@obsidianresearch.com>
 <20130129094003.0ca7be89@skate>
Message-ID: <20130129174008.GC25646@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 09:40:03AM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Mon, 28 Jan 2013 12:51:11 -0700, Jason Gunthorpe wrote:
> > On Mon, Jan 28, 2013 at 07:56:27PM +0100, Thomas Petazzoni wrote:
> > 
> > > However, with the usage of the emulated PCI host bridge and emulated
> > > PCI-to-PCI bridges, this is not the case: bus number 0 is the emulated
> > > bus on which the emulated PCI-to-PCI bridges sit, so from the Linux
> > > point of view, the real busses start at bus 1, but from a hardware
> > > point of view, they start at bus 0.
> > 
> > Hum.. This is a bit funny sounding, can you confirm..
> 
> Might be yes, but IIRC, when I try to enumerate the devices in the PCIe
> interface 0 (from a hardware point of view), passing a bus number of 1
> in the PCI configuration space access registers, then it simply doesn't
> work.

Hurm. The trick is you need the chip to issue a type 0 request. The
Marvell docs say this happens automatically basd on the 'internal bus
number'

The only other reference to bus number is in the PCI Express Status
Register (41A04), so that probably needs to be set to the subordinate
bus number of the bridge.

> > The bus number programmed into all the end points must match the Linux
> > number. Ie the PCI-E Link Description register of end point devices
> 
> What is this PCI-E Link Description register ? Where is it located ?

Hum, looks like this is only for root complex links not end devices -
PCI-X had a register for this but it seems to have been removed in
PCI-E.

Jason
