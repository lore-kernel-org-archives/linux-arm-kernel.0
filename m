From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 11:44:36 -0700
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140728183729.GG2576@leverpostej>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel> <20140728101229.GD24078@leverpostej>
 <20140728163313.GC32359@quad.lixom.net>
 <20140728183729.GG2576@leverpostej>
Message-ID: <CAOesGMh3QxA-c8wVvSLnS-Jyyb3zpOtweMGE+xmfJMb3r_ZiKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 11:37 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 28, 2014 at 05:33:13PM +0100, Olof Johansson wrote:
>> On Mon, Jul 28, 2014 at 11:12:29AM +0100, Mark Rutland wrote:
>> > On Mon, Jul 28, 2014 at 10:07:50AM +0100, Arnd Bergmann wrote:
>> > > On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
>> > > > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> > > > > +Relationship with Device Tree
>> > > > > +-----------------------------
>> > > > > +
>> > > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
>> > > > > +exclusive with DT support at compile time.
>> > > > > +
>> > > > > +At boot time the kernel will only use one description method depending on
>> > > > > +parameters passed from the bootloader.
>> > > >
>> > > > Possibly overriden by kernel bootargs. And as debated for quite a
>> > > > while earlier this year, acpi should still default to off -- if a DT
>> > > > and ACPI are both passed in, DT should at this time be given priority.
>> > >
>> > > I think this would be harder to do with the way that ACPI is passed in
>> > > to the kernel. IIRC, you always have a minimal DT information based on
>> > > the ARM64 boot protocol, but in the case of ACPI, this contains pointers
>> > > to the ACPI tables, which are then used for populating the Linux platform
>> > > devices (unless acpi=disabled is set), while the other contents of the
>> > > DTB may be present but we skip the of_platform_populate state.
>> > >
>> > > If this is correct, then replacing the firmware-generated dtb with a
>> > > user-provided on would implicitly remove the ACPI tables from visibility,
>> > > which is exactly what we want.
>> >
>> > That's not quite true.
>> >
>> > There might not be any DTB, or the user might have provided a DTB with
>> > only /chosen/bootargs. Trying to distinguish the many cases of possible
>> > DTB is broken as a concept.
>> >
>> > The EFI stub will attempt to get a DTB from somewhere (provided by
>> > filename or as a system table with a magic UUID), and if it can't find
>> > one will generate an empty stub DTB.
>> >
>> > Then it will go and perform some EFI memory setup, placing some
>> > properties in the DTB (which might be a stub) describing the EFI memory
>> > map.
>> >
>> > Then we boot the kernel proper, which sees the EFI pointers and looks
>> > for an ACPI table. If they are found, ACPI is used. Otherwise we attempt
>> > to use the DTB (which might be a stub).
>> >
>> > Unless ACPI is explcitly disabled, ACPI will be used if present.
>>
>> Ah, I saw this after I replied to Arnd's email.
>>
>> The above sounds more like how I envisioned things working, so based on that,
>> the default just needs to be flipped and we should be fine (i.e. ACPI needs to
>> be explicitly enabled).
>
> Sorry, but I don't follow your reasoning. What is the rationale for
> disabling ACPI by default?
>
> That's not going to work for ACPI-only systems which may not have any HW
> described in a DTB. I fear it will result in more pain on any systems
> which try to ship both ACPI and DT, where ACPI will not get the testing
> it requires, leading to a greater possibility of quirks/workarounds
> being required later.

We have said that we are not going to support ACPI-only systems at
this time. If vendors choose to use ACPI only then we can choose to
write a DT for them. We've been *very* clear on this.

There's no difference between quirks "now or later". Once we need a
quirk, it's around forever. So by giving them a chance to avoid some
now, we can reduce the need to ever see them. The alternative is to
pick them up now and forever carry them.

For ACPI test coverage, I suggest you get your validation test suite
work going if it hasn't been started. Beyond that, there's always
testing with acpi=on.


-Olof
