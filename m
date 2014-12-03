From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 14:14:21 +0100
Subject: [PATCH v4 15/19] arm/arm64: KVM: add virtual GICv3 distributor
 emulation
In-Reply-To: <547EFC2F.1040604@arm.com>
References: <1415959683-26027-1-git-send-email-andre.przywara@arm.com>
 <CAFEAcA9=qB9iyuvxCCjqgx3DpXqw+x2g0acfh9KwDZK7bp2ACg@mail.gmail.com>
 <547EFC2F.1040604@arm.com>
Message-ID: <21774833.CQS3aouKYZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 12:03:59 Andre Przywara wrote:
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

I also think that would be good. I assume 128MB of flash is required for
running UEFI, or could that be optional or variable-sized too?

A very easy method for doing this would be just allocate any devices with
a 64k spacing from the bottom (right after the end of flash) and use
whatever remains below 1GB for 32-bit PCI memory space, then have all
RAM after that, and finally do a 64-bit PCI memory space at the end
of RAM, probably at the next power-of-two aligned address.

Within the PCI area, it could look something like this:

<variable start>
* 64KB I/O space
* 1MB aligned ECAM config space, 1MB per emulated bus, possibly
  some spare to allow PCI hotplug
* prefetchable memory space, multiples of 1MB, only needed when
  doing device passthrough
* non-prefetchable memory space, all the rest up to 1GB

> Btw.: Is there an issue with not aligning each virtio device to a 64K
> page? Will we never need to separate access to virtio devices in a guest
> with MMU help?

As far as I'm concerned, none of the integrated devices need to be aligned
to 64K. The only requirement for 64K alignment is if you have a qemu
emulated machine that runs a hypervisor in it and does a passthrough of
its devices to an unprivileged guest running under the hypervisor.

I can't think of why anybody would ever do that for a uart or rtc, but
maybe my imagination is too limited.

Note that some of the older SoCs had all their peripherals within
a single 4kb page!
 

	Arnd
