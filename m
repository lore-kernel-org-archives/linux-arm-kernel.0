From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 18:39:01 +0100
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <20161014075337.10452-1-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
Message-ID: <20161024173900.GP15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 09:53:31AM +0200, Hans de Goede wrote:
> Hi Rob, Mark, et al.,

Hi Hans,

Apologies for the delay in replying to this.

I'd like to be clear that I do understand that there is a problem that
needs to be addressed here. However, I do not believe that the *current*
in-kernel approach is correct. More on that below.

> Mark, I know that we discussed this at ELCE and you clearly indicated
> that according to you this does not belong in the kernel. I was a bit
> surprised by this part of the discussion.
> 
> I had posted a RFC earlier and Rob had indicated that given that the q8
> tablets are a special case, as my code uses actual probing rather then some
> pre-arranged id mechanism with say an eeprom, that doing this in a
> non-generic manner would be ok for my special case.

To some extent, Rob and I may have differing views here; I'm not
entirely sure what Rob's view is, and I cannot talk on his behalf. I
certainly must apologise for having not commented on said RFC, however.

> So on to why I believe that the kernel is the best place to do this, at least
> for my special use-case:
> 
> 1. Configurability
> 
> Since the q8 tablets do not have any id mechanism I'm probing i2c busses to
> generate i2c client dt nodes with the right address and compatible.
> Some info in these nodes (e.g. touchscreen firmware-name) is not probable at
> all and gets set by heuristics. This heuristics may get things wrong.
> So my current implementation offers kernel cmdline options to override this.

As I mentioned at ELCE, one major concern I have with this approach is
this probing, which in part relies on a collection of heuristics.

I'm worried that this is very fragile, and sets us up for having to
maintain a much larger collection of heuristics and/or a database of
particular boards in future. This is fragile, defeats much of the gain
from DT.

Worse, this could be completely incompatible with some arbitrary board
that comes by in future, because the kernel assumed something that was
not true, which it would not have done if things were explicitly
described to the kernel.

As I mentioned at ELCE, I'm not opposed to the concept of the kernel
applying overlays or fixups based on a well-defined set of criteria;
having some of that embedded in the DT itself would be remarkably
helpful. However, I am very much not keen on loosely defined criteria as
with here, as it couples the DT and kernel, and creates problems longer
term, as described above.

> Although having to specify kernel cmdline options is not the plug and play
> experience I want to give end-users most distros do have documentation on
> how to do this and doing this is relatively easy for end-users. Moving this
> to the bootloader means moving to some bootloader specific config mechanism
> which is going to be quite hard (and possibly dangerous) for users to use.

I have to ask, why is it more dangerous?

Perhaps more difficult, but that can be solved, if the manual
corrections are simply a set of options to be passed to the kernel, I
don't see why the bootloader cannot pick this up.

> 2. Upgradability
> 
> Most users treat the bootloader like they treat an x86 machine BIOS/EFI,
> they will never upgrade it unless they really have to. This means that it
> will be very difficult to get users to actual benefit from bug-fixes /
> improvements done to the probing code. Where as the kernel on boards running
> e.g. Debian or Fedora gets regular updates together with the rest of the
> system.

Given that DTBs are supposed to remain supported, users should find
themselves with a system that continues to work, but may not have all
the bells and whistles it could, much like elsewhere.

While it's true that we have issues in this area, I don't think that's
an argument for putting things into the kernel for this specific set of
boards.

> 3. Infrastructure
> 
> The kernel simply has better infrastructure for doing these kind of things.

At least on the DT front, a lot of work has gone into improving the
infrastructure, e.g. the work that Free Electrons have done [1]. I
appreciate that the infrastructure for things like poking SPI may not be
as advanced.

Which bits of infrastructure do you find lacking today?

> Yes we could improve the bootloader, but the kernel is also improving
> and likely at a faster rate. Besides that the purpose of the
> bootloader is mostly to be simple and small, load the kernel and get
> out of the way, not to be a general purpose os kernel. So it will
> simply always have less infrastructure and that is a good thing,
> otherwise we will be writing another general purpose os which is a
> waste of effort.

I think this conflates a number of details. Yes, we'd like firmware and
bootloaders to be small, and yes, their infrastructure and feature
support will be smaller than a general purpose OS.

That doesn't imply that they cannot have features necessary to boostrap
an OS.

It's also not strictly necessary that the firmware or bootloader have
the capability to do all this probing, as that could be contained in
another part (e.g. a U-Boot application which is run once to detect the
board details, logging this into a file).

It's also possible to ship an intermediary stage (e.g. like the
impedance matcher) which can be upgradeable independently of the kernel.

> 4. This is not a new board file
> 
> Mark, at ELCE I got the feeling that your biggest worry / objection is
> that this will bring back board files, but that is not the case, if you
> look at the actual code it is nothing like a board-file at all. Where a
> board file was instantiating device after device after device from c-code,
> with maybe a few if-s in there to deal with board revisions. This code is
> all about figuring out which accelerometer and touchscreen there are,
> to then add nodes to the dt for this 2 devices, almost all the code is
> probing, the actual dt modifying code is tiny and no direct device
> instantiation is done at all.

Sorry, but I must disagree. This code:

(a) identifies a set of boards based on a top-level compatible string.
    i.e. it's sole purpose is to handle those boards.

(b) assumes non-general properties of those boards (e.g. that poking
    certain SPI endpoints is safe).

(c) applies arbitrary properties to the DT, applying in-built knowledge
    of those boards (in addition to deep structural knowledge of the
    DTB in question).

To me, given the implicit knowledge, that qualifies as a "board file".

As I mentioned at ELCE, if this had no knowledge of the boards in
question, I would be less concerned. e.g. if there was a well-defined
identification mechanism, describe in the DT, with fixups also defined
in the DT.

> 5. This is an exception, not the rule
> 
> Yes this is introducing board (family of boards) specific c-code into the
> kernel, so in a way it is reminiscent of board files. But sometimes this is
> necessary, just look at all the vendor / platform specific code in the kernel
> in drivers/platform/x86, or all the places where DMI strings are used to
> uniquely identify a x86 board and adjust behavior.
> 
> But this really is the exception, not the rule. I've written/upstreamed a
> number of drivers for q8 tablets hardware and if you look at e.g. the
> silead touchscreen driver then in linux-next this is already used for 5
> ARM dts files where no board specific C-code is involved at all.
> 
> So this again is very different from the board file era, where C-code
> had to be used to fill device specific platform-data structs, here all
> necessary info is contained in the dt-binding and there are many users
> who do not need any board specific C-code in the kernel at all.
> 
> So dt is working as it should and is avoiding board specific C-code for
> the majority of the cases. But sometimes hardware is not as we ideally
> would like it to be; and for those *exceptions* we are sometimes going
> to need C-code in the kernel, just like there is "board" specific C-code
> in the x86 code.

Your talk convinced me that we're both going to see more variation
within this family of boards, and that we'll see more families of boards
following a similar patter. Given that, I think that we need a more
general solution, as I commented on the RFC.

That doesn't necessarily mean that this can't happen in the kernel, but
it certainly needs to be more strictly defined, e.g. with match criteria
and fixups explicit in the DTB.

Thanks,
Mark.

[1] http://free-electrons.com/blog/dt-overlay-uboot-libfdt/
[2] https://github.com/zonque/pxa-impedance-matcher
