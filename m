From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 22 Oct 2013 12:25:27 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <52658C49.80400@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131021085420.GA21518@ulmo.nvidia.com>
 <52658C49.80400@wwwdotorg.org>
Message-ID: <20131022102526.GE15640@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 09:19:21PM +0100, Stephen Warren wrote:
> On 10/21/2013 09:54 AM, Thierry Reding wrote:
> > On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> ...
> >> I wonder if DT is solving the problem at the right level of
> >> abstraction? The kernel still needs to be aware of all the
> >> nitty-gritty details of how each board is hooked up different,
> >> and have explicit code to deal the union of all the different
> >> board designs.
> >> 
> >> For example, if some boards have a SW-controlled regulator for a
> >> device but others don't, the kernel still needs to have driver
> >> code to actively control that regulator, /plus/ the regulator
> >> subsystem needs to be able to substitute a dummy regulator if
> >> it's optional or simply missing from the DT.
> >> 
> >> Another example: MMC drivers need to support some boards
> >> detecting SD card presence or write-protect via arbitrary GPIOs,
> >> and others via dedicated logic in the MMC controller.
> >> 
> >> In general, the kernel still needs a complete driver to every
> >> last device on every strange board, and needs to support every
> >> strange way some random board hooks all the devices together.
> > 
> > I have some difficulty understanding what you think should've been
> > moved out of the kernel. There's only so much you can put into data
> > structures and at some point you need to start writing device
> > specific code for the peripherals that you want to drive.
> 
> My point was that (part of) the intent of adding DT support to the
> kernel was to get rid of all the board-specific code/churn in the
> kernel. That's not really possible, since DT is just representing the
> data about the HW (e.g. which GPIO/IRQ numbers) and not the behaviour.
> In order to really remove signifcant board-specific code from the
> kernel, you need to move behaviour out of the kernel too, i.e. hide it
> behind some kind of firmware or virtualization interface, and hence
> have simpler drivers that don't know all the details.

I think we've done a pretty good job at extracting board-specific code,
though. The majority of drivers has moved to appropriate subsystems and
therefore isn't board-specific at all anymore.

Doesn't anything beyond that involve abstracting away the differences
between SoCs? If I understand correctly what you envision is something
that would abstract the hardware differences of various SoCs and provide
a standard interface to access peripherals. For example, instead of
implementing a kernel driver for an MMC controller per SoC, the firmware
would instead implement a well-defined set of operations that can be
performed on an MMC controller and a generic "firmware" driver within
the Linux kernel would call into the firmware and register the services
with the kernel, so that it could be exposed to userspace in the usual
way.

But in that case we'd just be moving code from kernel to firmware. At
the same time we'd loose all the advantages that come with keeping code
in the kernel.

The kernel already provides a generic interface for devices to implement
by means of the subsystem APIs.

Even on x86 where standardization has been going on for decades I don't
think firmware actually abstracts away at that level. I think I've seen
something similar done for backlight devices that could be controlled
via ACPI, but anything beyond that level of complexity probably becomes
impractical to standardize without loosing much of the hardware
capabilities.

> ...
> >> * Would UEFI/ACPI/similar fulfill this role?
> > 
> > If I recall correctly, the original OpenFirmware that introduced
> > the DT concept used to have something similar to UEFI/ACPI.
> > Essentially it was possible to not only pass the DT to the
> > operating system but also allow the operating system to call back
> > into the firmware to request service.
> 
> Yes, OpenFirmware might be another possible firmware interface. I
> don't know anything about it...

I think it has about the same scope as the virtualization solution that
you propose. It will work fairly well with exposing things such as PCI
configuration space access for each PCI-type device. Where I don't see
it perform very well is for things such as GPUs where it isn't trivial
to find an exhaustive, yet unified, set of services that devices have to
provide.

> >> * Perhaps a standard virtualization interface could fulfil this
> >> role?
> ...
> > What will likely happen with such a solution is that we'll have to
> > come up with a standard interface that the guest OS expects.
> 
> I think much of that is already defined for a paravirt KVM guest
> though, right?

Possibly. I have no complete understanding of how exactly KVM achieves
this.

> ...
> > Vendor kernels that implement the host OS will effectively become
> > forks of their own since there's no incentive to upstream code
> > anymore. Linux upstream becomes a single unified architecture
> > because all interfaces are now the same. Vendors are back to
> > brewing their own.
> 
> True. Many/most(?) vendors work like that for most *products* though
> already...

I agree. But we're having this discussion because that's something we
want to change, right? Eventually I'd like for upstream Linux to become
what vendors use to develop on primarily, while downstream kernels are
merely the (hopefully small) delta of what's not considered good enough
quality for upstream.

> > ...
> 
> (Yes, I fully acknowledge there are many issues with
> firmware/virtualization as a platform...)

Probably the most important issue wouldn't exist with such a solution.
The firmware/host OS would likely be open-source and therefore easy to
fix when broken. At the same time it adds another dependency that we
need to carefully manage, thereby further complicating matters.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/60de1293/attachment.sig>
