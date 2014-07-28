From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 11:27:52 -0700
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140728170041.GB2576@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel>
 <20140728162750.GB32359@quad.lixom.net>
 <20140728170041.GB2576@leverpostej>
Message-ID: <CAOesGMjs1dM37ZoFA-xs7tYYaXP-XC3NjJsj291bCNoDwAXwiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 10:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 28, 2014 at 05:27:50PM +0100, Olof Johansson wrote:
>> On Mon, Jul 28, 2014 at 11:07:50AM +0200, Arnd Bergmann wrote:
>> > On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
>> > > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> > > > +Relationship with Device Tree
>> > > > +-----------------------------
>> > > > +
>> > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
>> > > > +exclusive with DT support at compile time.
>> > > > +
>> > > > +At boot time the kernel will only use one description method depending on
>> > > > +parameters passed from the bootloader.
>> > >
>> > > Possibly overriden by kernel bootargs. And as debated for quite a
>> > > while earlier this year, acpi should still default to off -- if a DT
>> > > and ACPI are both passed in, DT should at this time be given priority.
>> >
>> > I think this would be harder to do with the way that ACPI is passed in
>> > to the kernel. IIRC, you always have a minimal DT information based on
>> > the ARM64 boot protocol, but in the case of ACPI, this contains pointers
>> > to the ACPI tables, which are then used for populating the Linux platform
>> > devices (unless acpi=disabled is set), while the other contents of the
>> > DTB may be present but we skip the of_platform_populate state.
>>
>> How can it be harder to do? If you support acpi=off, then you should support
>> acpi=on.
>>
>> Another alternative would be to have an early fixup that stubs out
>> the acpi properties from the DTB unless there's an 'acpi' or 'acpi=on'
>> argument on the cmdline. Not quite as tidy a solution, though.
>
> I don't follow:
>
> If you want to disable ACPI, you can pass acpi=off. This is your
> workaround for broken ACPI (and only if you happen to have wrirten your
> own DTB, because many/most ACPI systems WILL NOT have a DTB to begin
> with).

All ACPI should be assumed broken at this time, so acpi=off _must_ be
the default.

> If you have ACPI, for what technical reason would you not attempt to use
> it by default?

Because it will be broken, or the company you bought the machine from
implemented it wrong because they're still learning how to do this
too. The original doc even mentioned that there are parts of the
binding that aren't even sorted out. The _DSD stuff, too. Overall,
it's not yet ready to be the default boot method.

> There will be systems which _DO NOT_ have any sort of DTB to begin with.

Listen, we've been really clear about this: DT is the default that
everybody has to use for mainline kernel for the near term. If you
have an ACPI-only system, then you either have to write a DT for it,
or you won't be booting mainline on it.

If people have not been listening to the advice we've been giving, and
that sucks for them. Even worse, I suspect there are players out there
who have taken bad advice from certain players. At the end of the day,
it is not our problem. We were quite clear, and Grant even wrote a
long and good blog post about this.

If they really want to, they can boot with acpi=on instead. It's not
like it's hard to add.

> For VMs, both may be provided. By the necessity of a DTB being present
> for bootargs, ACPI _MUST_ take precedence. If you don't want it, you
> pass acpi=off, or configure your VM software to not pass an ACPI
> configuration table.
>
> Why avoid ACPI by default? So that we can later enable it and discover
> it's completely broken? Then we need short-sighted hacks to work around
> short-sighted decisions.

We have answered this multiple times in the past already. Please go
read the archives.

It is highly unlikely that we will retroactively enable it in the
future for the first-generation devices either. Chances are there'll
be a rev or two more of ACPI before then, so we can do something such
as "only automatically accept ACPI 5.4 or higher" or whatever. That
can all be sorted when the time comes.

> The best thing to do is to try and use things, be as strict as possible,
> stress the implementation, and blow up early and loudly so that said
> systems must be fixed.

"Try", sure. Make it the default and blow up and make a system
unbootable when it's wrong? No, absolutely not. Not while bindings are
still being hashed out and vendors are still figuring things out.

> People are using Linux for bringup; it is the closest thing to a
> validation suite. Being lazy and hacking around things for now will only
> make things worse in the long run.

Who's hacking around what?

And holy shit, there is no validation suite? Then ACPI is doomed.
Literally. Linux can't be a validation suite for it. It means that
potentially every single code change to anything related to ACPI
(drivers or core) on Linux means that it's now using completely
untested pieces of firmware. Fodder for nightmares.

> We _CANNOT_ place our fingers in our ears and blind ourselves with the
> DT banner. ACPI is ugly, sure, but so is DT. Neither is fundamentally
> better than the other. The best thing we can do is make it as easy as
> possible to highlight bugs in ACPI implementations and barf such that
> people are forced to fix their ACPI implementations.

It's not about what's better than the other. They both suck. But one
is already here and we've learned by now most of the ways in which it
sucks and we have a good idea of how to avoid the worst of it. On the
other, we have all of that in front of us still. Guess which one it
makes sense to stick to?

> No other OS supports ACPI on 64-bit arm systems. Being strict should
> force implementors to try harder.

Thanks for _finally_ stating what we've all known for a very long time
but everybody's been pretending isn't the case.

>> > If this is correct, then replacing the firmware-generated dtb with a
>> > user-provided on would implicitly remove the ACPI tables from visibility,
>> > which is exactly what we want.
>>
>> I was of the impression that firmware patches in the ACPI entries into either
>> device-tree before launching the kernel. Is that not the case?
>
> 1) The ACPI tables will be registered as UEFI configuration tables,
>    within platform-specific UEFI code. Nothing outside of UEFI is
>    involved.
>
> 1a) A loader (e.g. GRUB, the EFI stub) COULD override the loaded tables.
>    This is a workaround, and should never be the standard way of doing
>    things. It defeats the point, much like appended DTB.
>
> 2) The EFI stub will patch UEFI memory map properties into the DTB. The
>    firmware is not involved.
>
> 3) The kernel will detect whether EFI is present by the presence of the
>    memory map, and try to use it if so. The memory map comes from UEFI,
>    and memory nodes (and memreserves) are ignored. Only select
>    properties under /chosen (e.g. bootargs) will be used.
>
> 4) If booted via EFI, the kernel will look for known UEFI configuration
>    tables by (G|U)UID, and set up some pointers.
>
> 5) The ACPI code will go and look to see if the ACPI table pointers have
>    been initialised. If so, the kernel will attempt to use the ACPI
>    tables unlesss instructed otherwise. If using ACPI, the DTB will be
>    ignored outside of /chosen.
>
> The ACPI tables or pointers to them are not directly patched into the
> DTB at any stage. The choice of using ACPI is left with the kernel.

Thanks, excellent summary.

>> And what if some bootloader chooses to do it that way in the future?
>> It's better to not assume that they get it right.
>
> For the firmware/loader to do so it would have to work around the kernel
> version parameter the stub places in the DTB and the kernel verifies. If
> it does so, I would argue said firmware is actively malicious.

Ok.

>> > It's possible that I'm misremembering it though, and it should be
>> > documented better.
>>
>> Yes, definitely needs to be documented to not leave room for random
>> interpretation later on.
>
> We should definitely make the documentation as strict as possible on
> what's allowed, and have the kernel barf early on if requirements are
> not met.

It should definitely complain when it finds bad entries, but making
the kernel unusable for end-users because someone is still under
development is the wrong answer. While the ACPI bindings are sorted
out, we'll ship platforms using DT support in the kernel. This must
not change just because some piece of the ACPI work is starting to
land in-tree while other pieces are still being worked out.

And again: The kernel is not a compliance suite for ACPI, and if the
vendors doing bringup is treating it that way then I'm quite scared of
the whole endeavor.



-Olof
