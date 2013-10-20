From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 20 Oct 2013 22:26:54 +0100
Subject: ARM topic: Is DT on ARM the solution, or is there something better?
Message-ID: <52644A9E.3060007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IIRC (and perhaps I don't; it was really slightly before my active
involvement in kernel development) Linus triggered the whole ARM DT
conversion in response to disliking the volume of changes, and
conflicts, in board files. The idea of DT conversion being that all the
board-specific details could be moved out of the kernel and into DT
files, thus causing him not to have to see it.

Note: As part of implementing DT on ARM, we've also cleaned up and
modularized a lot of code, and created new subsystems and APIs. I think
this is a separate issue, and much of that could have happened
completely independently from doard->DT conversion.

I wonder if DT is solving the problem at the right level of abstraction?
The kernel still needs to be aware of all the nitty-gritty details of
how each board is hooked up different, and have explicit code to deal
the union of all the different board designs.

For example, if some boards have a SW-controlled regulator for a device
but others don't, the kernel still needs to have driver code to actively
control that regulator, /plus/ the regulator subsystem needs to be able
to substitute a dummy regulator if it's optional or simply missing from
the DT.

Another example: MMC drivers need to support some boards detecting SD
card presence or write-protect via arbitrary GPIOs, and others via
dedicated logic in the MMC controller.

In general, the kernel still needs a complete driver to every last
device on every strange board, and needs to support every strange way
some random board hooks all the devices together.

The only thing we've really moved out of the kernel is the exact IDs of
which GPIOS, interrupts, I2C/SPI ports the devices are connected to; the
simple stuff not the hard stuff. The code hasn't really been simplified
by DT - if anything, it's more complicated since we now have to parse
those values from DT rather than putting them into simple data-structures.

I wonder if some other solution with a higher level of abstraction
wouldn't be a better idea? Would it make more sense to define some kind
of firmware interface that the kernel deals with, so that all HW details
are hidden behind that firmware interface, and the kernel just deals
with the firmware interface, which hopefully has less variation than the
actual HW (or even zero variation).

* Would UEFI/ACPI/similar fulfill this role?

* Perhaps a standard virtualization interface could fulfil this role?
IIUC, there are already standard mechanisms of exposing e.g. disks, USB
devices, PCI devices, etc. into VMs, and recent ARM HW[1] supports
virtualization well now. A sticking point might be graphics, but it
sounds like there's work to transport GL or Gallium command streams over
the virtualization divide.

Downsides might be:

- Overhead, due to invoking the para-virtualized VM host for IO, and
extra resources to run the host.

- The host SW still has to address the HW differences. Would it be more
acceptable to run a vendor kernel as the VM host if it meant that the
VMs could be a more standardized environment, with a more single-purpose
upstream kernel? Would it be easier to create a simple VM host than a
full Linux kernel with a full arbitrary Linux distro, thus allowing the
HW differences to be addressed in a simple way?

These techniques would allow distros to target a single HW environment,
e.g. para-virtualized KVM, rather than many many different SoCs and
boards each with different bootloaders, bootloader configurations, IO
peripherals, DT storage locations, etc. Perhaps a solution like this
would allow distros to easily support a similar environment across a
range of HW in a way that "just works" for many users, while not
preventing people with more specific needs crafting more HW-specific
environments?

Note: This is all just slightly random thinking that came to me while I
couldn't sleep last night, so apologies if it isn't fully coherent. It's
certainly not a proposal, just perhaps something to mull over.

[1] All /recent/ consumer-grade ARM laptop or desktop HW that I'm aware
of that's shipped has Cortex A15 cores that support virtualization.
