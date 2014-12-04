From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Dec 2014 10:34:48 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <547EFC2F.1040604@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <20141203102829.GA17502@cbox> <547EEF9A.9010906@arm.com>
 <2906594.cDZcXzbGMh@wuerfel>
 <CAFEAcA9=qB9iyuvxCCjqgx3DpXqw+x2g0acfh9KwDZK7bp2ACg@mail.gmail.com>
 <547EFC2F.1040604@arm.com>
Message-ID: <20141204093448.GA4526@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 12:03:59PM +0000, Andre Przywara wrote:
> On 03/12/14 11:39, Peter Maydell wrote:
> > On 3 December 2014 at 11:28, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Wednesday 03 December 2014 11:10:18 Andre Przywara wrote:
> >>> Currently we have in QEMU:
> >>>    0 MB -  128 MB: Flash
> >>>  128 MB -  144 MB: CPU peripherals (GIC for now only)
> >>>  144 MB -  144 MB: UART (64k)
> >>>  144 MB -  144 MB: RTC (64k)
> >>>  160 MB -  256 MB: virtio (32 * 512 Bytes used)
> >>>  256 MB - 1024 MB: PCI
> >>> 1024 MB - ???? MB: DRAM
> >>>
> >>> So we waste quite some space between 144 MB and 256 MB, where we
> >>> currently use only 3 64K pages. If we would move those three pages
> >>> closer to the 256 MB region, we could extend the GIC mapping space from
> >>> 16 MB (127 VCPUs) to almost 128 MB (good for 1022 VCPUs).
> > 
> > Note that part of the reason for that gap is to give us space
> > to add more memory-mapped peripherals as they are needed.
> > For instance the fw_cfg conduit for talking to UEFI firmware
> > is going to need another 64K page in that section.
> 
> Sure, that was just to show the situation in general. We could do
> something like kvmtool and grow the CPU peripheral space and the device
> MMIO pages from different directions to not waste space needlessly.
> So UART, RTC, virtio and future devices use space from 128MB upwards,
> whereas the GIC uses as much space below 256 MB as needed.
> 
> Btw.: Is there an issue with not aligning each virtio device to a 64K
> page? Will we never need to separate access to virtio devices in a guest
> with MMU help?
> 
> >> Having a more compressed mapping sounds useful, but you could also consider
> >> carving the GIC registers out of the PCI range and make PCI memory space
> >> smaller if there are lots of CPUs.
> >>
> >> Is there also a 64-bit PCI memory space behind the DRAM?
> > 
> > The "PCI" section at the moment is purely hypothetical -- it's
> > a lump of reserved space in the memory map that I put in so
> > we had a place to put PCI later... The DRAM is just the last
> > thing in the memory map and goes up for as much DRAM as you
> > asked QEMU to provide, so in that sense there's no "behind"
> > there.
> > 
> > We could (at least at the moment) shuffle things around a bit,
> > since guests should all be looking at the DTB to figure where
> > things are. About the only thing we can't do is move the base
> > address of RAM or put the flash somewhere other than 0. If
> > we do need to make changes I'd rather we figured out the new
> > layout and switched to it rather than doing a set of piecemeal
> > tweaks, though.
> 
> Agreed. As QEMU does not support GICv3 anyway at the moment, there is no
> need to rush things.
> 
> Is there any sign of a PCI host controller emulation for QEMU on the
> horizon?
> 
Yes, we need to have this in Q1 2015 latest.  Linaro has scheduled this
work, but patches are a little while out I'm afraid.

-Christoffer
