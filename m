From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Aug 2014 19:23:47 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAOesGMjs1dM37ZoFA-xs7tYYaXP-XC3NjJsj291bCNoDwAXwiw@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <5014834.k6eecMddPC@wuerfel>
 <20140728162750.GB32359@quad.lixom.net>
 <20140728170041.GB2576@leverpostej>
 <CAOesGMjs1dM37ZoFA-xs7tYYaXP-XC3NjJsj291bCNoDwAXwiw@mail.gmail.com>
Message-ID: <20140812182347.GA4100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 07:27:52PM +0100, Olof Johansson wrote:
> On Mon, Jul 28, 2014 at 10:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 28, 2014 at 05:27:50PM +0100, Olof Johansson wrote:
> >> On Mon, Jul 28, 2014 at 11:07:50AM +0200, Arnd Bergmann wrote:
> >> > On Saturday 26 July 2014 19:34:48 Olof Johansson wrote:
> >> > > On Thu, Jul 24, 2014 at 6:00 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> >> > > > +Relationship with Device Tree
> >> > > > +-----------------------------
> >> > > > +
> >> > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> >> > > > +exclusive with DT support at compile time.
> >> > > > +
> >> > > > +At boot time the kernel will only use one description method depending on
> >> > > > +parameters passed from the bootloader.
> >> > >
> >> > > Possibly overriden by kernel bootargs. And as debated for quite a
> >> > > while earlier this year, acpi should still default to off -- if a DT
> >> > > and ACPI are both passed in, DT should at this time be given priority.
> >> >
> >> > I think this would be harder to do with the way that ACPI is passed in
> >> > to the kernel. IIRC, you always have a minimal DT information based on
> >> > the ARM64 boot protocol, but in the case of ACPI, this contains pointers
> >> > to the ACPI tables, which are then used for populating the Linux platform
> >> > devices (unless acpi=disabled is set), while the other contents of the
> >> > DTB may be present but we skip the of_platform_populate state.
> >>
> >> How can it be harder to do? If you support acpi=off, then you should support
> >> acpi=on.
> >>
> >> Another alternative would be to have an early fixup that stubs out
> >> the acpi properties from the DTB unless there's an 'acpi' or 'acpi=on'
> >> argument on the cmdline. Not quite as tidy a solution, though.
> >
> > I don't follow:
> >
> > If you want to disable ACPI, you can pass acpi=off. This is your
> > workaround for broken ACPI (and only if you happen to have wrirten your
> > own DTB, because many/most ACPI systems WILL NOT have a DTB to begin
> > with).
> 
> All ACPI should be assumed broken at this time, so acpi=off _must_ be
> the default.

(catching up with emails after holiday and I may have missed some of
your arguments)

If we consider ACPI unusable on ARM but we still want to start merging
patches, we should rather make the config option depend on BROKEN
(though if it is that unusable that no real platform can use it, I would
rather not merge it at all at this stage).

I don't really see what requiring acpi=on explicitly would buy us as
vendors firmware providing only ACPI tables would simply always set this
command line option. Defaulting to off is not really a way for mandating
valid DT to be provided by firmware (rather a statement we try to make
that ACPI is not a first class citizen yet).

I would also expect platforms to be ACPI only and handle for example
D-states via AML. If they work fine, do we really need to bother adding
DT support for them, potentially with additional drivers? IOW, do we
want to mandate all ARM(v8) platforms to work with "acpi=off" out of
firmware?

> > If you have ACPI, for what technical reason would you not attempt to use
> > it by default?
> 
> Because it will be broken, or the company you bought the machine from
> implemented it wrong because they're still learning how to do this
> too. The original doc even mentioned that there are parts of the
> binding that aren't even sorted out. The _DSD stuff, too.

I assume with the current patches, a (sane) platform could still boot
and run without the missing features listed in the document, though it
may not be optimal. We should definitely be strict and not accept quirks
in the kernel to work around missing features until the UEFI forum
accepted the specification.

> Overall, it's not yet ready to be the default boot method.

Then make CONFIG_ACPI default off and depend on EXPERT as a better
statement (but as with acpi=on, it's still just a statement we try to
make). Once the concerns are addressed, we make it an equal citizen.

> > There will be systems which _DO NOT_ have any sort of DTB to begin with.
> 
> Listen, we've been really clear about this: DT is the default that
> everybody has to use for mainline kernel for the near term. If you
> have an ACPI-only system, then you either have to write a DT for it,
> or you won't be booting mainline on it.

OK, this answers one of my questions above (I may have forgotten the old
threads but at the time we were primarily talking about ACPI 5.0 which
wasn't of much use on ARM).

So you want to mandate DT for all platforms, even if some choose
ACPI only longer term. I'm not arguing against this (especially for the
first generation of devices), but how would default acpi=off enforce it?
The firmware would simply pass acpi=on by default and run mainline just
fine (as well as it can based on the implemented features).

We should also not accepted any ACPI features in drivers without a DT
counterpart.

> If they really want to, they can boot with acpi=on instead. It's not
> like it's hard to add.

And this would be the default argument passed by their firmware.

As I said, it's rather just a statement the kernel people want to make,
nothing more. If you want to make the DT requirement stricter, what
about adding code for checking the validity of the DT passed even though
it's booting with ACPI? IMO, it's not worth it, we should rather be
very strict with what ACPI code we accept in the kernel (primarily
drivers, avoid random clock descriptors etc). If a platform cannot work
(optimally) with the strict ACPI set, the vendor either provides DT or
shouldn't bother us with upstreaming at all.

-- 
Catalin
