From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Jul 2013 15:27:02 +0100
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <20130725135645.GA17304@glitch>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
 <20130725110634.GB2546@localhost.localdomain>
 <20130725112558.GD24642@n2100.arm.linux.org.uk>
 <20130725135645.GA17304@glitch>
Message-ID: <20130725142702.GE24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:56:45PM +0200, Domenico Andreoli wrote:
> On Thu, Jul 25, 2013 at 12:25:58PM +0100, Russell King - ARM Linux wrote:
> > This is the exact problem, and if you've seen how Linus rants about
> > the ARM ecosystem breaking ABI stuff all the time, you will start to
> > appreciate why ARM is not highly valued in the Linux communities.
> > 
> > We need to stop this crap getting in.
> > 
> > We need subsystem people to refuse to merge DT stuff if it hasn't been
> > reviewed by DT people - subsystem people are _not_ qualified to accept
> > those patches, even if they're responsible for the files which they're
> > being applied to. Yes, they can review them, but they should _not_
> > accept them without them having the bindings reviewed by folk who (a)
> > know the hardware and (b) know the implications of creating a DT binding.
> > 
> > That means whoever is doing the review of DT bindings probably needs to
> > have access to documentation on the hardware - or they need to be educated
> > by the submitter.  Or, we need submitters to individually justify why
> > each and every property is required in the description.
> > 
> > As for those already there, I don't think there's anything which can be
> > done about them in the short term (short = quite a few years) - we can't
> > go removing any properties that are already there, because that will
> > break the ABI.  We're basically stuck with that crap for ever now.
> > 
> > That's the point that people have to understand: if they accept a DT
> > description into the kernel, it's basically saying at that point that
> > the DT description is the official and definitive description for that
> > hardware.  It's just the same as adding a new syscall or something like
> > that which the entire world starts to use immediately.  You can't go
> > removing or changing it after the fact.
> > 
> > And this is also why a _hell_ of a lot of thought should go into each
> > and every property _before_ it is even proposed by the patch submitter.
> 
> So this is the true price for having a nice HW agnostic kernel.

Of course it is, and if you thought otherwise, then you haven't thought
about the problem enough.

If anyone went walking into DT thinking that the DT bindings can be hacked
around any old way, then they went into DT with a blindfold on, and did
not *think*/have not thought about the consequences.

Don't go thinking that ACPI would be any different, because it isn't.
It's no different from any _other_ interface that the kernel may ever
use to the outside world, be that the boot loader interface or the user
interfaces.  All those interfaces are all part of "the ABI" to code
outside of the kernel, and those are all interfaces which must be
thought out REAL carefully, and any changes to them must be backed up
with a way for the existing interfaces to _continue_ working.

What that means is that any DT representation created for any device which
has ever appeared in a mainline kernel is part of the kernel ABI and must
remain working in that state.  You can supplement it with new ways of doing
things, but the original bindings must continue to work.

Remember the stated assertion when DT was first added to the kernel: the
DT descriptions _will_ become a separately maintained project which is
independent of the kernel.  They will _not_ be kernel version specific.

Linus wants the platform specific crap like clocks and the like _out_ of
the kernel tree.  He doesn't want the stuff merely transformed into a
different representation - he wants it out of the kernel tree and
entirely separate.

Think about that for a moment with regard to churn in DT descriptions
and you will soon realise that if you change the DT descriptions and
then have to update the kernel inline with those updates, you're on to
creating one hell of a mess.

DT done correctly with care and thought works fine.  DT done without that
is a disaster, one which I had hoped people had learnt from with the
problems that PPC has had with bad bindings.

ABI compatibility is VERY important.  If you disagree with that, send
Linus an email justifying why you think you can change the ABI with no
compatibility.
