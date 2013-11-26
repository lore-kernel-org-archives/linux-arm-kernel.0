From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 26 Nov 2013 17:11:23 -0600
Subject: ACPI
In-Reply-To: <20131126183344.GA16074@srcf.ucam.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
Message-ID: <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 12:33 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Nov 26, 2013 at 12:55:10PM +0000, Grant Likely wrote:
>> On Tue, Nov 26, 2013 at 12:43 PM, Linus Walleij
>> <linus.walleij@linaro.org> wrote:
>> > I have a feeling we should not recommend ARM implementers
>> > to go and do things like this.
>>
>> ACPI5 defines a binding for serial busses (i2c & spi) which allows
>> real device drivers to drive the bus and allows ACPI and the kernel to
>> share the bus safely. Using that binding means some i2c devices can be
>> 'owned' by ACPI and others owned by the kernel.
>
> Right, we shouldn't see a problem in this specific case. But it does
> leave a wider philosophical concern - there are still components that
> can't be exposed to the OS via ACPI in standardised ways, and the
> traditional way of dealing with that on x86 is to just add the
> functionality via ASL. It seems that we have three basic options:
>
> 1) Encourage vendors to add functionality to their DSDTs
> 2) Encourage vendors to use existing kernel functionality, exposing
> information via either DT-in-ACPI or some other custom method

I have a real problem with the concept of putting device trees inside
ACPI, while still relying on this consensus that the preferred boot
method will also be UEFI.

Until Linux boots from UEFI on ARM without being a consumer of the
services that UEFI actually offers. Every platform in the Linaro tree
boots uImages and zImages and does not pass any UEFI System Table or
any other services to Linux, so it has no clue it booted from UEFI or
U-Boot - just that it was handed a device tree and everything works
because the device tree implementation works. UEFI is basically gone.

Before stabbing around adding ACPI and then having DT-in-ACPI isn't
there a use case for an an ARM Linux kernel actually being a good
citizen of UEFI?

How are they planning to get the ACPI tables in the first place
without going through UEFI to get it? I may not have been paying close
enough attention, I am certainly not invited to the secret meetings of
SPECTRE where this has already been implemented and tested properly,
but I don't see any evidence of it.. not even an inkling of it.

Having UEFI pass along the DT as a configuration table as well as ACPI
tables should be the first order of business. It needn't be
DT-specific either - there's no reason that specific configuration
table can't define a thousand ways to boot Linux on ARM. But one or
two might be better for the sanity of the Linux kernel guys. In fact,
because UEFI hands information in the early boot process to the
'application' (being the kernel), and has a very well defined API, it
would remove the need for weird out of band stuff like /memreserve/
entries in the DT and simplify and make the Linux early boot process
more robust and debuggable.

> 3) Encourage vendors to continue using DT until this functionality is
> standardised

I would attempt to encourage vendors to use DT by making UEFI actually
give a crap about DT if possible. Right now ACPI seems to be posited
for three reasons;

1) Existing code is around that drives certain logic common on a bunch
of server boards and nobody wants to write drivers for them *again*,
especially since there is a distinct advantage to hidin^H^H^H^H^H
abstracting the actual implementation from Linux (fan controllers etc.
could be done in hundreds of different ways) in terms of product
safety, product reliability, and kernel stability for companies like
Red Hat.

2) Because you can do fancy 'scripting' as well as bus and device
configuration abstraction on top of description.

3) Because there seems to be an absolutely moronic assumption that the
best way to get an ARMv8 server box on the market is take an existing
server design and just drop an ARM SoC into it and the above existing
code should "drop in" in that case.

Reasons one and two are *good enough reason to use ACPI* - but only if
there's a worthwhile application for it, as previously stated by
others. The one thing that got thrown in the weeds going Flattened
Device Tree (that didn't make sense because of the ABI, but.. could
have been solved) was some kind of standardized firmware interface you
could call - and packages/protocols and some standardized way of
accessing fixed function or otherwise needfully abstracted hardware
components that have a life of their own and cannot be statically
described.

But I can't think of a reason why an extension or companion to PSCI
couldn't do it, and why you WOULDN'T want to do this as an API
implemented via a secure monitor interface which is architecturally
defined on ARM where security extensions are present. I can't imagine
a reason why it couldn't be done over IPMI to some microcontroller or
dedicated external component, for the case of fans and chassis
components and tedious other stuff.

I keep hearing people talk about reason 3, and I gotta say.. if that's
the reason ACPI is being pushed out by the secret cabal.. May Glob
help them, if it's true, because they obviously have whacked-out
poo-brain.

> Being consistent about our recommendations here would probably be
> helpful, but it seems like we don't have any kind of thought out story
> yet. That seems like a problem.

+100.

I want to know how they're expecting to get hold of the magic they
need to have ACPI support work, first, and why that isn't solved in
other ways, and at least one use case where secure firmware and a
device tree can't do it in the same - or better and more secure - way.
It's all well and good looking to write a spec.. what should be going
on is designing a server platform, identifying the use cases as you go
through the design, and not just placing arbitrary stuff on a list
because that's how it's already implemented over there. ACPI exists
because it needed to solve a very specific x86-related problem.

Does it solve any ARM-related problems that aren't already solved or
capable of being solved with current methodologies?

How did IBM and Freescale get by for the past 6 years without ACPI on
POWER? Doesn't that inform anyone of any reasons why ACPI isn't
strictly necessary?

-- 
Matt Sealey <neko@bakuhatsu.net>
