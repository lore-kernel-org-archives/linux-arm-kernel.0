From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Feb 2014 21:22:33 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226200537.GC16149@cbox>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226200537.GC16149@cbox>
Message-ID: <6873065.LH15I057sX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 12:05:37 Christoffer Dall wrote:
> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> 
> The most common response I've been getting so far is that people
> generally want their VMs to look close to the real thing, but not sure
> how valid an argument that is.
> 
> Some people feel strongly about this and seem to think that ARMv8
> kernels will only work with ACPI in the future...

That is certainly a misconception that has caused a lot of trouble.
We will certainly keep supporting FDT boot in ARMv8 indefinitely,
and I expect that most systems will not use ACPI at all.

The case for ACPI is really SBSA compliant servers, where ACPI serves
to abstract the hardware differences to let you boot an OS that does
not know about the system details for things like power management.

For embedded systems that are not SBSA compliant, using ACPI doesn't
gain you anything and causes a lot of headache, so we won't do that.

> Another case is that it's a good development platform.  I know nothing
> of developing and testing ACPI, so I won't judge one way or the other.

The interesting aspects of developing and testing ACPI are all related
to the hardware specific parts. Testing ACPI on a trivial virtual
machine doesn't gain you much once the basic support is there.

> > > VM Platform
> > > -----------
> > > The specification does not mandate any specific memory map.  The guest
> > > OS must be able to enumerate all processing elements, devices, and
> > > memory through HW description data (FDT, ACPI) or a bus-specific
> > > mechanism such as PCI.
> > > 
> > > The virtual platform must support at least one of the following ARM
> > > execution states:
> > >   (1) aarch32 virtual CPUs on aarch32 physical CPUs
> > >   (2) aarch32 virtual CPUs on aarch64 physical CPUs
> > >   (3) aarch64 virtual CPUs on aarch64 physical CPUs
> > > 
> > > It is recommended to support both (2) and (3) on aarch64 capable
> > > physical systems.
> > 
> > Isn't this more of a CPU capabilities question? Or maybe you
> > should just add 'if aarch32 mode supported is supported by
> > the host CPU'.
> 
> The recommendation is to tell people to actually have a -aarch32 (or
> whatever it would be called) that works in their VM implementation.
> This can certainly be reworded.

Yes, the intention is good, it just won't work on a few systems
when the CPU designers took the shortcut to implement only the
64-bit instructions. Apparently those systems will exist, but I
expect them to be the exception, and I don't know if they will
support virtualization.

> > I think you should specify exactly what you want PCIe to look like,
> > if present. Otherwise you can get wildly incompatible bus discovery.
> > 
> 
> As soon as there is more clarity on what it will actually look like,
> I'll be happy to add this.  I'm afraid my PCIe understanding is too
> piecemeal to fully grasp this, so concrete suggestions for the text
> would be much appreciated.

Will Deacon is currently prototyping a PCI model using kvmtool, trying
to make it as simple as possible, and compliant to SBSA. How about
we wait for the next version of that to see if we're happy with it,
and then figure out if all hypervisors we care about can use the
same interface.

> > > Note that this platform specification is separate from the Linux kernel
> > > concept of mach-virt, which merely specifies a machine model driven
> > > purely from device tree, but does not mandate any peripherals or have any
> > > mention of ACPI.
> > 
> > Did you notice we are removing mach-virt now? Probably no point
> > mentioning it here.
> > 
> Yes, I'm aware.  I've just heard people say "why do we need this, isn't
> mach-virt all we need", and therefore I added the note.
> 
> I can definitely can rid of this paragraph in the future if it causes
> more harm than good.

Maybe replace it with something like this:

| On both arm32 and arm64, no platform specific kernel code must be required,
| and all device detection must happen through the device description
| passed from the hypervisor or discoverable buses.

A harder question is what peripherals we should list as mandatory or
optional beyond what you have already. We could try coming up with
an exhaustive list of devices that are supported by mainline Linux-3.10
(the current longterm release) and implemented by any of the hypervisors,
but we probably want to leave open the possibility to extend it later
as we implement new virtual devices.

	Arnd
