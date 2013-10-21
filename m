From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Oct 2013 10:54:22 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <52644A9E.3060007@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
Message-ID: <20131021085420.GA21518@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 10:26:54PM +0100, Stephen Warren wrote:
> IIRC (and perhaps I don't; it was really slightly before my active
> involvement in kernel development) Linus triggered the whole ARM DT
> conversion in response to disliking the volume of changes, and
> conflicts, in board files. The idea of DT conversion being that all the
> board-specific details could be moved out of the kernel and into DT
> files, thus causing him not to have to see it.
> 
> Note: As part of implementing DT on ARM, we've also cleaned up and
> modularized a lot of code, and created new subsystems and APIs. I think
> this is a separate issue, and much of that could have happened
> completely independently from doard->DT conversion.

Perhaps this would even have been enough. It looks to me that we've
created much better, more rigorous processes as a side-effect. I can
easily imagine that if we had done all of that but without moving to DT,
the end result may have been equally good.

I'm not saying that DT is bad. There are a whole lot of good things
about it that I really like. On the other hand, I've recently realized
that it has become increasingly difficult to upstream even the most
trivial functionality because now everybody wants to design the perfect
DT binding with the effect of new features not going anywhere.

But I digress, and I should probably start a separate discussion about
that.

> I wonder if DT is solving the problem at the right level of abstraction?
> The kernel still needs to be aware of all the nitty-gritty details of
> how each board is hooked up different, and have explicit code to deal
> the union of all the different board designs.
> 
> For example, if some boards have a SW-controlled regulator for a device
> but others don't, the kernel still needs to have driver code to actively
> control that regulator, /plus/ the regulator subsystem needs to be able
> to substitute a dummy regulator if it's optional or simply missing from
> the DT.
> 
> Another example: MMC drivers need to support some boards detecting SD
> card presence or write-protect via arbitrary GPIOs, and others via
> dedicated logic in the MMC controller.
> 
> In general, the kernel still needs a complete driver to every last
> device on every strange board, and needs to support every strange way
> some random board hooks all the devices together.

I have some difficulty understanding what you think should've been moved
out of the kernel. There's only so much you can put into data structures
and at some point you need to start writing device specific code for the
peripherals that you want to drive.

> The only thing we've really moved out of the kernel is the exact IDs of
> which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
> simple stuff not the hard stuff. The code hasn't really been simplified
> by DT - if anything, it's more complicated since we now have to parse
> those values from DT rather than putting them into simple data-structures.
> 
> I wonder if some other solution with a higher level of abstraction
> wouldn't be a better idea? Would it make more sense to define some kind
> of firmware interface that the kernel deals with, so that all HW details
> are hidden behind that firmware interface, and the kernel just deals
> with the firmware interface, which hopefully has less variation than the
> actual HW (or even zero variation).
> 
> * Would UEFI/ACPI/similar fulfill this role?

If I recall correctly, the original OpenFirmware that introduced the DT
concept used to have something similar to UEFI/ACPI. Essentially it was
possible to not only pass the DT to the operating system but also allow
the operating system to call back into the firmware to request service.

Of course this brings up the issue about the degree to which we want to
rely on the firmware to do the right thing. If it's difficult to update
firmware (which it usually is), then we'll likely end up reimplementing
some of the functionality in the kernel because firmware might end up
being buggy and therefore we can't trust it.

On the other hand, one thing that I very much like about the concept is
that DT isn't only used as a way to describe the hardware but also uses
the notion of services provided by nodes. That means that a DT binding
not only defines the properties that characterize hardware but also a
set of operations that can be performed on a compatible node. This does
not only apply on a per-compatible basis but also depending on device
type. A PCI device for instance provides standard services to read the
configuration space.

Most of this applies to Linux already because when a device referred to
by phandle is used by some other device, the phandle needs to be
resolved to some Linux-specific object (regulator, clock, backlight...)
before it can be used and the given subsystem already defines all the
operations that can be performed. So perhaps this isn't really all that
relevant after all...

> * Perhaps a standard virtualization interface could fulfil this role?
> IIUC, there are already standard mechanisms of exposing e.g. disks, USB
> devices, PCI devices, etc. into VMs, and recent ARM HW[1] supports
> virtualization well now. A sticking point might be graphics, but it
> sounds like there's work to transport GL or Gallium command streams over
> the virtualization divide.
> 
> Downsides might be:
> 
> - Overhead, due to invoking the para-virtualized VM host for IO, and
> extra resources to run the host.
> 
> - The host SW still has to address the HW differences. Would it be more
> acceptable to run a vendor kernel as the VM host if it meant that the
> VMs could be a more standardized environment, with a more single-purpose
> upstream kernel? Would it be easier to create a simple VM host than a
> full Linux kernel with a full arbitrary Linux distro, thus allowing the
> HW differences to be addressed in a simple way?
> 
> These techniques would allow distros to target a single HW environment,
> e.g. para-virtualized KVM, rather than many many different SoCs and
> boards each with different bootloaders, bootloader configurations, IO
> peripherals, DT storage locations, etc. Perhaps a solution like this
> would allow distros to easily support a similar environment across a
> range of HW in a way that "just works" for many users, while not
> preventing people with more specific needs crafting more HW-specific
> environments?

That sounds very much like a sledgehammer solution. Also I'm not sure if
it would solve all that many problems. I guess what it could solve is to
move a whole lot of the underlying specifics of the various SoCs to some
other place (the host). It's fundamentally very similar to ACPI, and it
comes with the same set of advantages and disadvantages.

What will likely happen with such a solution is that we'll have to come
up with a standard interface that the guest OS expects. Once that has
been defined, vendors will have to implement that interface. Naturally
most of them will choose Linux as a host OS. What we'll end up with is
unlikely to be any better than the current situation.

Vendor kernels that implement the host OS will effectively become forks
of their own since there's no incentive to upstream code anymore. Linux
upstream becomes a single unified architecture because all interfaces
are now the same. Vendors are back to brewing their own. Except for the
rare occasions where something needs to be added to the guest interface
there won't be much interaction between kernel developers. We will also
need to specify stable interfaces between host and guest and I think
everyone involved with DT lately has some experience as to how painful
that can be. So instead of being able to add new features to the kernel
within a single release cycle, we'll likely end up having to wait for a
few cycles because it needs to be implemented in both guest and host,
which may or may not have the same release cycles.

The above is the worst case scenario, but the alternative would be that
Linux is still forked into host and guest, yet vendors keep working on
one upstream host Linux. In that case, we're not solving anything. All
the same problems that we have now will remain. Well, we might be able
to make it somewhat easier for distributions, but there are a whole lot
of disadvantages to it as well.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131021/91e970ac/attachment-0001.sig>
