From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 11:01:50 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CB7DBE07-42BD-4588-AC9E-CB0BF95A811A@suse.de>
References: <20140226183454.GA14639@cbox> <6039706.L1ZWvgjHF0@wuerfel>
 <CB7DBE07-42BD-4588-AC9E-CB0BF95A811A@suse.de>
Message-ID: <7825615.Ak6TOGibTE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 February 2014 08:05:15 Alexander Graf wrote: 
> > Am 28.02.2014 um 03:56 schrieb Arnd Bergmann <arnd@arndb.de>:
> >> On Thursday 27 February 2014 22:24:13 Alexander Graf wrote:
>
> > When you have that, why do you still care about a
> > system specification? 
> 
> Because I don't want to go back to the system level definition. To me a 
> peripheral is a peripheral - regardless of whether it is on a platform 
> bus or a PCI bus. I want to leverage common ground and only add the few 
> pieces that diverge from it.

You may be missing a lot of the complexity that describing platform devices
in the general case brings then. To pass through an ethernet controller, you may 
also need to add (any subset of)

* phy device
* clock controller
* voltage regulator
* gpio controller
* LED controller
* DMA engine
* an MSI irqchip
* IOMMU

Each of the above in turn is shared with other peripherals on the host,
which brings you to three options:

* change the driver to not depend on the above, but instead support an
  abstract virtualized version of the platform device that doesn't
  need them.
* Pass through all devices this one depends on, giving up on guest
  isolation. This may work for some embedded use cases, but not
  for running untrusted guests.
* Implement virtualized versions of the other interfaces and make
  the hypervisor talk to the real hardware.

I would still argue that each of those approaches is out of scope for
this specification.

> > Going back to the previous argument, since the hypervisor has to make up the
> > description for the platform device itself, it won't matter whether the host
> > is booted using DT or ACPI: the description that the hypervisor makes up for
> > the guest has to match what the hypervisor uses to describe the rest of the
> > guest environment, which is independent of what the host uses.
> 
> I agree 100%. This spec should be completely independent of the host.
> 
> The reason I brought up the host is that if you want to migrate an OS from
> physical to virtual, you may need to pass through devices to make this work.
> If your host driver developers only ever worked with ACPI, there's a good
> chance the drivers won't work in a pure dt environment.
> 
> Brw, the same argument applies the other way around as well. I don't believe
> we will get around with generating and mandating a single machibe
> description environment.

I see those two cases as completely distinct. There are good reasons
for emulating a real machine for running a guest image that expects
certain hardware, and you can easily do this with qemu. But since you
are emulating an existing platform and run an existing OS, you don't
need a VM System Specification, you just do whatever the platform would
normally do that the guest relies on.

The VM system specification on the other hand should allow you to run
any OS that is written to support this specification on any hypervisor
that implements it.

> >> Replace Windows by "Linux with custom drivers" and you're in the same
> >> situation even when you neglect Windows. Reality will be that we will
> >> have fdt and acpi based systems.
> > 
> > We will however want to boot all sorts of guests in a standardized
> > virtual environment:
> > 
> > * 32 bit Linux (since some distros don't support biarch or multiarch
> >  on arm64) for running applications that are either binary-only
> >  or not 64-bit safe.
> > * 32-bit Android
> > * big-endian Linux for running applications that are not endian-clean
> >  (typically network stuff ported from powerpc or mipseb.
> > * OS/v guests
> > * NOMMU Linux
> > * BSD based OSs
> > * QNX
> > * random other RTOSs
> > 
> > Most of these will not work with ACPI, or at least not in 32-bit mode.
> > 64-bit Linux will obviously support both DT (always)
> 
> Unfortunately not
> 
> > and ACPI (optionally),
> > depending on the platform, but for a specification like this, I think
> > it's much easier to support fewer options, to make it easier for other
> > guest OSs to ensure they actually run on any compliant hypervisor.
> 
> You're forgetting a few pretty important cases here:
> 
> * Enterprise grade Linux distribution that only supports ACPI

You can't actually turn off DT support in the kernel, and I don't think
there is any point in patching the kernel to remove it. The only sane
thing the enterprise distros can do is turn on the "SBSA" platform
that supports all compliant machines running ACPI, but turn off all
platforms that are not SBSA compliant and boot using DT. With the way
that the VM spec is written at this point, Linux will still boot on
these guests, since the hardware support is a subset of SBSA, with the
addition of a few drivers for hypervisor specific features.

> * Maybe WinRT if we can convince MS to use it

I'd argue that would be unlikely.

> * Non-Linux with x86/ia64 heritage and thus ACPI support

That assumes that x86 ACPI support is anything like ARM64 ACPI
support, which it really isn't. In particular, you can turn off
ACPI on any x86 machine and it will still work for the most
part, while on ARM64 we will need to use ACPI to describe even
the most basic aspects of the platform.

	Arnd
