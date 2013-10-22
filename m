From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 22 Oct 2013 16:44:07 -0500
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <52644A9E.3060007@wwwdotorg.org>
References: <52644A9E.3060007@wwwdotorg.org>
Message-ID: <CAHCPf3uKp-aEavjrEbHGBc_Ga-JgJoEDF+io4kOuvtL6H05eRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 4:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>
> I wonder if DT is solving the problem at the right level of abstraction?
> The kernel still needs to be aware of all the nitty-gritty details of
> how each board is hooked up different, and have explicit code to deal
> the union of all the different board designs.

Indeed, but it's relatively generic and defined, as you discussed later.

The original method was define some custom platform data structure,
pass it to the platform device on init, have that platform device
parse that custom platform data - for each SDHC controller (in your
example) there was a separate and somewhat uniquely typed and named
structure (and sometimes, ridiculously, content-identical to some
other platform).

Now if you want to know the GPIOs for CD/WP or if they're even in use,
you test for the property, use it's value.. and that property and
value is well defined (to some degree). Every driver duplicates this
code, but then it can be cleaned up and made a support call somewhere
(parsing things like dr_mode for USB ports is, as a good example,
already support code, as are properties for Ethernet PHYs)

> For example, if some boards have a SW-controlled regulator for a device
> but others don't, the kernel still needs to have driver code to actively
> control that regulator, /plus/ the regulator subsystem needs to be able
> to substitute a dummy regulator if it's optional or simply missing from
> the DT.

No. The correct way when a device does not have a controllable
regulator is to NOT SPECIFY a regulator. That way the driver should
never attempt control of it.

If the regulator is optional it follows quite nicely that the property
is optional. Any driver that fails probing for an optional property is
broken and needs fixing.

> In general, the kernel still needs a complete driver to every last
> device on every strange board

Pardon my being frank, but.. no shit! Of course you need drivers. The
point of DT isn't to implement drivers, or at least it WAS the point
(to give a structured way to access those drivers) but with a
flattened, non-programmatic model there's nothing to access. What it
does is shore up the other side of the equation - if you wanted a
block device under OpenFirmware, it was there with device_type =
"block" and then you opened a standard block package on it, and then
read data from it through the package calls. You had to instruct it
WHICH block device to use if you wanted specific data from a specific
block device...

The DT here is simply a way to find which block device (by path into
the tree) you want to open.

In the flattened model, it describes where that device exists so a
driver can attach to it and provide it's own standardized block layer.

The reason OF wasn't an option for the people lauding FDT, is because
you needed two drivers - one for firmware, one for the OS. FDT lets
you get one driver, in the OS. Of course, this is based on the
assumption that your OS kernel is almost directly bootstrapped from
bare metal, which is fairly difficult to achieve on most systems, on
power-on. You will need a dynamic, driver-full bootloader to get the
most flexible Linux boot and for a desktop system where there may be
many boot sources this is the way to do it. Of course, there are ways
around it, but they make for very, very expensive systems in
comparison. Most ARM SoCs have external pins to strap on boot to
direct it to a special bootable media process, but most users are not
going to flip DIP switches..

> and needs to support every strange way some random board hooks all the devices together.

Most of them are not strange, but very well defined. Electrically
there are only so many ways.. there are only so many pads on the
bottom of your SoC packaging. There are only so many peripheral
controllers to attach, most of them following very well defined
standards and buses and protocols.

> by DT - if anything, it's more complicated since we now have to parse
> those values from DT rather than putting them into simple data-structures.

As above, where this code is duplicated it can be moved into support code.

> * Would UEFI/ACPI/similar fulfill this role?

In the sense that it would require, yet again, a two-driver-model
implementation.. no, not for the FDT guys. That said, there's no
reason you couldn't use FDT to control the EFI driver binding protocol
Supported() function, or supply Device Paths. Nothing in the EFI spec
says those paths need to be ACPI paths or Windows-like filesystem
paths (except the odd expectation of backslashes).

ACPI would be a good fix, but you'd have to spend a year ratifying the
same kinds of bindings through the ACPI-CA. Which may come out wrong.
ACPI isn't as stable as it seems, and it's just as easy to get your
DSDT wrong as an FDT, or do something super-screwy in your AML for a
device.

> * Perhaps a standard virtualization interface could fulfil this role?
> IIUC, there are already standard mechanisms of exposing e.g. disks, USB
> devices, PCI devices, etc. into VMs, and recent ARM HW[1] supports
> virtualization well now. A sticking point might be graphics, but it
> sounds like there's work to transport GL or Gallium command streams over
> the virtualization divide.

For power state, there's ARM PSCI - this abstracts bringing cores up
and down, and possibly in the future some voltage and frequency
scaling, since this can get EXTREMELY hairy in multi-core,
multi-cluster environments. Depending on the myriad cluster
configurations, core implementations possible and the buses wiring
them together - and that is just the ARM part of it, frequency scaling
and power regulation is vendor-implementation-specific - it would end
up with the kernel having to know EXTREMELY nitty gritty details about
the underlying hardware and configuration which ends up being far too
dynamic to put into a binding that makes any sense (essentially, doing
it the DT way means having a special processor binding for every
IMPLEMENTATION of a standard ARM core).

For everything else, there's the SMC calling convention PSCI is based
on, and while this allows exactly what you're asking for, it requires
someone to code it on the platform.

So there are the following things to keep in mind:

* You can easily abstract, say, an SD controller which has a very well
defined card register set and protocol (that is the important bit),
and a very well defined physical layer, and you would hide the
implementation details. There are standard voltage levels, standard IO
practices, and very few real implementation differences, otherwise no
one SD card would work with every SD card controller.

* You can do the same for SATA or USB where the controller is very
well defined host register set and behavior on the device side. This
is the "perfect storm" of abstraction, and it's why libata works.

* You can abstract serial ports - up to a point - and byte-transfer
buses in general, and byte-transfer buses with addressing (i2c and
spi, i2c uses protocol and spi uses chipselects which is almost
addressing) and those that support block transfers (multiplexing large
amounts of data through a narrower bus) and hide most of the details
here without even knowing it's i2c or spi or qspi or sdio - but every
device would have to support every possible implementation detail of
every kind, meaning the abstraction grows to an enormous size. An
abstraction for an SPI bus with a single device (no chaining or
bypass) and a single chipselect is easy to conceptualize. But it
doesn't do parity, flow control.. etc. Every SPI abstraction would
need to implement these though. Alternatively, you abstract buses per
protocol/transfer mechanism but that means 100 abstractions, and more
to come.

* You can somewhat abstract regulators. Up to a point. You can
guarantee there will be a voltage value somewhere, and a lot of things
like the kind of regulation, it's input, current limits can be hidden
or abstracted, and then new technology comes along and the abstraction
needs to be updated. The same problem hits with batteries - go read
the Smart Battery Specification (SBS) for a great way of abstracting
batteries, but this kind of abstraction of the data means some data is
never filled by certain controllers (since it has no ability to set or
measure, or report this information even if it does allow it) and the
software abstraction then ALSO needs significant hardware
modifications and choices. That, and it's already defined as a spec
(ACPI also has a battery abstraction, and SBS is a well-used variant
of it).

* If you are going this far, why not abstract CPU maintenance
operations? Here's one technological foible - using SMC or HVC, you
enter a whole other exception level where the page tables, caches may
not actually be the same as where you came from. Flushing the "normal"
world cache from "secure" world isn't fun.. secure world in TZ can
even have a completely separate physical address space.

Linux already abstracts all of these pretty well - page tables are
essentially handled via abstraction both in structure and in
maintenance (both in handling TLBs and in setting mapping memory
properties). Defining another abstraction means Linux abstracts an
abstraction to provide a usable interface. This is a lot of overhead.

> - Overhead, due to invoking the para-virtualized VM host for IO, and
> extra resources to run the host.

As before, Linux already does abstract and 'virtualize' certain
functionality so you would be doing it twice.

Actually *invoking* the secure monitor or hypervisor call interface is
pretty cheap, all told. You don't need to turn off caches or MMU or
anything, which is a HUGE benefit compared to the OF CIF or UEFI
Runtime, which specifies this expensive behavior as a capitulation to
code re-use from clumsy, old, non-reentrant, unsafe crap.

> - The host SW still has to address the HW differences. Would it be more
> acceptable to run a vendor kernel as the VM host if it meant that the
> VMs could be a more standardized environment, with a more single-purpose
> upstream kernel? Would it be easier to create a simple VM host than a
> full Linux kernel with a full arbitrary Linux distro, thus allowing the
> HW differences to be addressed in a simple way?

No. I can't really articulate why that is an awful idea, but it is.
There are security concerns - the vendor kernel, while still Linux,
could be particularly old. It may do things that have bugs, and need
updating. You'd be doing things twice again... that's the main reason.

> Note: This is all just slightly random thinking that came to me while I
> couldn't sleep last night, so apologies if it isn't fully coherent. It's
> certainly not a proposal, just perhaps something to mull over.

Your mail and the discussion it caused did the same thing, I didn't
sleep a lot because I have a lot of DT foibles on my mind and you've
stirred up a hornet's nest ;)

> [1] All /recent/ consumer-grade ARM laptop or desktop HW that I'm aware
> of that's shipped has Cortex A15 cores that support virtualization.

As above, any ARM core with security extensions can implement much the
same thing, so there's no restriction.. but even said, that doesn't
make it a great idea.

What we really need here is less of an incremental development model
where device drivers are written, then bindings are engineered to try
and push the weird differences to a DT, then bindings are changed over
and over as drivers change to make up for the initial flaws in the
original bindings.

What made OF work - and what makes UEFI work in industry - is multiple
implementations all satisfying a core specification requirement. OF
had the IEEE ratify the standard, and there was a Working Group of
interested, affected industry players looking to make sure that they
would not end up with a lackluster solution. Of course, they let the
standard lapse, but they did a lot of the ground work, which ended up
in things like CHRP and RTAS (which did quite well apart from the fact
that barely anyone but Apple used it, and then turned around and
destroyed the concept by not allowing cloning), PAPR (successor to OF,
for Power Architecture, spec seems kind of private but there aren't
that many differences), FDT which got codified into ePAPR.. there are
at least 5 'good' OF implementations in the wild (Firmworks, Codegen,
Apple, Sun, IBM SLOF) and ePAPR tried to bridge the gap without
requiring significant firmware development. However, it did not turn
out so well because it WAS based on FDT which WASN'T such a mature
idea at the time.

UEFI had Intel and partners work together and then a standards
organization to design and implement the technology. There are at
least 4 UEFI implementations in the real world, some based on Intel's
BSD code (TianoCore/EDK/whatever, that's one) - Intel have their
proprietary spin that EDK is based on, Phoenix have one, Insyde have
one, Apple have one.

How many vendors "implement" flattened device trees? None (actually
Altera do in their SoC modelling tools, but that's umm.. different.
Their hard SoC core and IP blocks are pretty fixed and writing an FPGA
block means writing a binding and a snippet for that block and
including it in the tree magically when you build your FPGA payload.
What they do is ship a device tree that works with their hard SoC
core..)

But they won't do this as a whole if there's no solidification or
standardization - billion dollar companies have billion dollar
customers, real release cycles and standardized (as in, accepted)
project management, which do not lend well to the Linux development
model where the world can change between commits and merge windows.
You can't pull the rug from under a chip designer on a deadline by
making him update his software over and over and over.

There's a reason, for instance, SPI/SDHC controllers have GPIO
specifications in the DT, and that is because either the IP blocks are
buggy and a driver or a binding was defined to cover the normal use
case (controller works, can control it's own pins or successfully poll
for the cd and wp pins, or toggle it's chipselects correctly) and then
essentially, it doesn't work, so there's a workaround. That workaround
- since it is implemented at a board level - has to go in the DT. If
it involves doing something that MAY require some special work (maybe
different use of a bit in a register, or a different sequence of code
to avoid the erratum) then to cover the fact that it may be fixed in
future, broadly compatible IP, the quirk is listed as a property in
the DT (or predicated on the compatible property, which should be the
real way of doing it). I'm not sure what is so bad about this.

I can think of several reasons using FDT sucks right now, all of them
i.MX related (since that's what I gave a crap about until recently);

* Pinmuxing is done in the kernel, which is not only anywhere between
a few milliseconds and a few seconds way too late for some electrical
connections (potentially driving output on a line which a peripheral
is driving too), but also redundant since the bootloader does this
anyway for the vast majority of board designs. At some point it was
deemed necessary to enforce passing pinmux data with every driver - it
is NOT an optional property. This is "wah the bootloader may not do
the right thing" paranoia that has to stop. Pin multiplexing should be
*OPTIONAL*, as above, same as regulators. If you do not pass a
regulator, or ways to pinmux, don't fail! If the peripheral doesn't
work, then this is totally bootloader error on the part of the people
who wrote the support.

* Overuse of global SoC includes (imx51.dtsi for example) means a lot
of SoC peripherals - and their generic, multi-use pinmux data - is
dragged into every device tree. "status = disabled" does nothing to
DTC output. That entry stays in the DT. For an example, putting in
ONLY the required pinmuxing not done by the bootloader (which should
be *Z E R O*)  and ONLY the devices possible to be muxed out or even
used on the board reduces a device tree from 19KiB to 8Kib. That's
11KiB  of stuff that *isn't even used*. If the node you're looking for
is deeply nested at the bottom of the tree, that's extra parsing
time..

* The very fact that "status = disabled" in a node still includes it
in the tree!

* Some bindings (pinmuxing again) have been changed multiple times.

* The most recent bindings are written with the new preprocessor
support in the DT compile process in mind, and are therefore - as
output data - completely unintuitive and mind-boggling. They are
defined as - and always have been since vendor kernels - a register
location and a value pair. The current binding is

    <register1> <register2> <register3> <value1> <value3> <value2>

Just so that it can be written as

    VERY_EASY_MNEMONIC_DESCRIPTION  some_setting_commonly_changed

Russell bitched about this, I *wholeheartedly* agree with him on it.
Here are the problems with it:

- It is entirely obvious that the order of the register/value pairs
has been contrived SOLELY to make writing a dumb preprocessor
definition easier to implement.

- Bits from value1 are stuffed into value2 in the binding such that
they are easier to modify as per preprocessor support above. The
driver takes them out and puts them in the right place if they exist.

- There is a magic bit for "don't touch this register" which is better
done by not specifying it at all

- Not to mention none of this was documented properly..

- Half the easy mnemonics are taken from an old Linux driver, which
was based on RTL descriptions, and hasn't matched a public release
manual *ever*. It didn't even match the pre-release manuals sent to
alpha customers to go with their early access silicon.. so looking at
the manuals to cross-reference ends up in searching a 3500-page PDF
for something that does not exist. Poo to that.

* Don't get me <expletive> started on clock providers, using an array
index inside the OS (ARGH) was the main flaw of the original pinmux
binding for i.MX. It's being used on *EVERY* ARM platform right now. I
don't understand why.. or why...

- Clocks are all registered at once in Linux init code, with special
hacks to get around parents that won't exist if done in device tree
order rather than clock tree order. Check out
mach-imx/clk-imx51-imx53.c or clk-imx6q.c and prepare for your brain
to explode.

- Why clocks are registered at all if they are never referenced or
used by the DT or drivers... every driver has to call "clk_get" with a
clock name, why can't it go off, parse the tree, find the parents,
register them in top down order at runtime?

- Why, given an inherent tree structure to clock subsystems, they are
defined as arbitrary numbers, as peers with each other, with explicit
parentage by PHANDLE, and not *as a <deity>-loving tree*. Most clocks
are very simply defined as dividers or gates or muxes, which can be
very easily implemented in a device tree. Here's a hint to DT binding
authors and people writing drivers - "flattened device tree" does not
mean "everything is a peer" - every node can have child nodes. We
already do something like

clocks {


}

In the root of the tree. So we know the start point. So, parse the
children of clocks.. now you know all the children. Now, parse the
children of the first child. Keep going down the tree.. now you have
all the clocks. Now you also *don't ever need to give a phandle to the
clock's parent inside the child*.

There is so much crap here, and to comply with Linus' "OMG CHURN"
complaints, maintainers are reluctant to change what's broken for the
sake of easier device tree authorship or even existing specifications
(OF, CHRP, PAPR, ePAPR, even UEFI protocol bindings would be a good
reference..)

Ta,
Matt Sealey <neko@bakuhatsu.net>
