From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 27 Nov 2013 14:16:34 +0000
Subject: ACPI
In-Reply-To: <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org> <
 CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com> <
 CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com> <
 CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com> <
 CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com> <
 20131125154110.GB3243@srcf.ucam.org> <
 CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com> <
 CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com> <
 20131126183344.GA16074@srcf.ucam.org> <
 CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
Message-ID: <20131127141634.A45F3C404EC@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013 17:11:23 -0600, Matt Sealey <neko@bakuhatsu.net> wrote:
> On Tue, Nov 26, 2013 at 12:33 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Tue, Nov 26, 2013 at 12:55:10PM +0000, Grant Likely wrote:
> >> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
> >> <linus.walleij@linaro.org> wrote:
> >> > I have a feeling we should not recommend ARM implementers
> >> > to go and do things like this.
> >>
> >> ACPI5 defines a binding for serial busses (i2c & spi) which allows
> >> real device drivers to drive the bus and allows ACPI and the kernel to
> >> share the bus safely. Using that binding means some i2c devices can be
> >> 'owned' by ACPI and others owned by the kernel.
> >
> > Right, we shouldn't see a problem in this specific case. But it does
> > leave a wider philosophical concern - there are still components that
> > can't be exposed to the OS via ACPI in standardised ways, and the
> > traditional way of dealing with that on x86 is to just add the
> > functionality via ASL. It seems that we have three basic options:
> >
> > 1) Encourage vendors to add functionality to their DSDTs
> > 2) Encourage vendors to use existing kernel functionality, exposing
> > information via either DT-in-ACPI or some other custom method
> 
> I have a real problem with the concept of putting device trees inside
> ACPI, while still relying on this consensus that the preferred boot
> method will also be UEFI.

ACPI and UEFI are completely separate things. UEFI happily passes a DT
to the Linux kernel today, and the code to do so is in the UEFI
Tianocore project. (search for LinuxLoader).

There are changes that need to be made here such as storing the DT
pointer in the UEFI system table so that firmware can directly provide a
DT which either GRUB or the Linux UEFI stub can pick up, but that is a
relatively uncontroversial detail.

> Until Linux boots from UEFI on ARM without being a consumer of the
> services that UEFI actually offers. Every platform in the Linaro tree
> boots uImages and zImages and does not pass any UEFI System Table or
> any other services to Linux, so it has no clue it booted from UEFI or
> U-Boot - just that it was handed a device tree and everything works
> because the device tree implementation works. UEFI is basically gone.

Again, runtime services works and has no bearing on ACPI. Runtime
services allows Linux to do three things: query/adjust system time,
query/adjust boot variables, provide UEFI with a "capsule" which is
mostly used for updating firmware. That's it. It's there so that an
operating system can manipulate what the system does on the next boot.
The patches to support runtime services are pretty much complete and are
out for review.[1]

[1] http://lwn.net/Articles/569665/

If you're not comfortable with keeping the runtime portion of UEFI
around, no problem; it can be turned off. For some users (general
purpose machines running general purpose distributions in particular) it
is important.

> Before stabbing around adding ACPI and then having DT-in-ACPI isn't
> there a use case for an an ARM Linux kernel actually being a good
> citizen of UEFI?
> 
> How are they planning to get the ACPI tables in the first place
> without going through UEFI to get it? I may not have been paying close
> enough attention, I am certainly not invited to the secret meetings of
> SPECTRE where this has already been implemented and tested properly,
> but I don't see any evidence of it.. not even an inkling of it.

All of the implementation is going on in the open and has nothing to do
with the vendor meetings that Jon and I have been involved with. Al
Stone is leading the Linaro ACPI team, and Leif Leidholm is leading the
UEFI team. Both teams are posting patches publically.

ACPI is obtained from UEFI by reading the UEFI system table. This is a
memory mapped block of UUID/Pointer pairs available right at OS entry
time. The kernel obtains the ACPI pointer by searching for the ACPI UUID
in the system table.

> Having UEFI pass along the DT as a configuration table as well as ACPI
> tables should be the first order of business. It needn't be
> DT-specific either - there's no reason that specific configuration
> table can't define a thousand ways to boot Linux on ARM. But one or
> two might be better for the sanity of the Linux kernel guys. In fact,
> because UEFI hands information in the early boot process to the
> 'application' (being the kernel), and has a very well defined API, it
> would remove the need for weird out of band stuff like /memreserve/
> entries in the DT and simplify and make the Linux early boot process
> more robust and debuggable.

No problem here. DT and ACPI can actually coexist in the system table,
but in all the technical conversations I've had with Leif, Al, and
others we've pretty much agreed that an OS should use the data from one
or the other, but not try to parse both.

> 
> > 3) Encourage vendors to continue using DT until this functionality is
> > standardised
> 
> I would attempt to encourage vendors to use DT by making UEFI actually
> give a crap about DT if possible. Right now ACPI seems to be posited
> for three reasons;

Should be no problem. DT support with libfdt is already in tianocore
(though not part of the standard) and Leif is going to be publishing a
whitepaper with a specific UUID for providing a DT via the system
table (which doesn't need to be part of the standard).

> 1) Existing code is around that drives certain logic common on a bunch
> of server boards and nobody wants to write drivers for them *again*,
> especially since there is a distinct advantage to hidin^H^H^H^H^H
> abstracting the actual implementation from Linux (fan controllers etc.
> could be done in hundreds of different ways) in terms of product
> safety, product reliability, and kernel stability for companies like
> Red Hat.
>
> 2) Because you can do fancy 'scripting' as well as bus and device
> configuration abstraction on top of description.
> 
> 3) Because there seems to be an absolutely moronic assumption that the
> best way to get an ARMv8 server box on the market is take an existing
> server design and just drop an ARM SoC into it and the above existing
> code should "drop in" in that case.

To be honest, none of the three above arguments have come up in any of
the discussions I've been a party to. Instead, I've heard the following
concerns from vendors:

1) The embedded AML methods are useful for getting an existing OS
release to boot on new hardware that does things differently. (note:
this is about booting to a usable state, not necessarily fully
supported; there is still the assumption that 3rd party device drivers
may need to be installed after boot).

2) Existing tooling and management interfaces. This is almost like
reasons 1 & 3 above, but rather than being about describing hardware, it
is about being able to use the same development, testing and remote
management software on both x86 and ARM platforms. They are already up
and running based on a UEFI/ACPI stack and would like to continue to do
exactly the same thing on ARM.

3) Windows. They want one interface that works for both Windows and
Linux. Microsoft certainly haven't made any comments about whether or
not they will have an ARM server product, but if they do then the
requirement will be ACPI. They don't want to rule out a market segments
if they don't have to.

> 
> Reasons one and two are *good enough reason to use ACPI* - but only if
> there's a worthwhile application for it, as previously stated by
> others. The one thing that got thrown in the weeds going Flattened
> Device Tree (that didn't make sense because of the ABI, but.. could
> have been solved) was some kind of standardized firmware interface you
> could call - and packages/protocols and some standardized way of
> accessing fixed function or otherwise needfully abstracted hardware
> components that have a life of their own and cannot be statically
> described.

In FDT land the direction has been anything weird needs a device driver.
We're not going to try and abstract hardware interfaces. That's why I've
been resistant to adding any kind of bytecode language to FDT. This is
the big difference between ACPI and FDT for the kernel.

> But I can't think of a reason why an extension or companion to PSCI
> couldn't do it, and why you WOULDN'T want to do this as an API
> implemented via a secure monitor interface which is architecturally
> defined on ARM where security extensions are present. I can't imagine
> a reason why it couldn't be done over IPMI to some microcontroller or
> dedicated external component, for the case of fans and chassis
> components and tedious other stuff.

The problem here is that it becomes even further out of Linux's control.
At least with ACPI the bytecode runs at the pleasure of the kernel and
it can trace what is going on. At least with IPMI to a BMC it is on a
separate processor, but encouraging PM to be stuffed into TrustZone is a
bad precidence. It starts to look a lot like the bad old days of APM
before ACPI.

> I keep hearing people talk about reason 3, and I gotta say.. if that's
> the reason ACPI is being pushed out by the secret cabal.. May Glob
> help them, if it's true, because they obviously have whacked-out
> poo-brain.

Regarding the "secret cabal", they (myself included) don't actually have
any power over the Linux development process. They are representatives
of vendors who intend to produce products. Those products are intended
to run Linux. If they don't work with us to get good support for their
platform in mainline then it is going to affect how well their hardware
works. They have made the decision to persue an ACPI solution, mostly
for the reasons I listed above. Some have joined Linaro and are working
things out there (and therefore in public). Some have internal engineers
working on it. Some have done both.

Regardless, they *still* need to work with upstream to get their
hardware supported. The most important thing that we can do right now is
make that message clear. ACPI not ready for merging? Then we recommend
using FDT until we figure out what ACPI should look like. They want to
work on ACPI? Then we recommend posting draft patches and not lock down
their ACPI implementation until support is mainlined.

> > Being consistent about our recommendations here would probably be
> > helpful, but it seems like we don't have any kind of thought out story
> > yet. That seems like a problem.
> 
> +100.

yup

g.
