From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Oct 2016 09:53:31 +0200
Subject: Add Allwinner Q8 tablets hardware manager
Message-ID: <20161014075337.10452-1-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Mark, et al.,

Here is a first non RFC posting of my q8 tablet hardwaremanager work,
both the bindings as well as the in kernel implementation of it.

Mark, I know that we discussed this at ELCE and you clearly indicated
that according to you this does not belong in the kernel. I was a bit
surprised by this part of the discussion.

I had posted a RFC earlier and Rob had indicated that given that the q8
tablets are a special case, as my code uses actual probing rather then some
pre-arranged id mechanism with say an eeprom, that doing this in a
non-generic manner would be ok for my special case.

So at ELCE I did not have all the arguments I had to do this in the kernel
ready. I did actually make a concious choice for the kernel before starting
work on this, thinking about this more I remembered most of the arguments I
had when making my u-boot vs kernel decision. I still believe the kernel is
the right place for this. See the list of reasons below.

Regardless of where the implementation should go, please do review the
bindings (the first patch in the set), as we need those regardless of where
the actual code dealing with this is going to live.

So on to why I believe that the kernel is the best place to do this, at least
for my special use-case:

1. Configurability

Since the q8 tablets do not have any id mechanism I'm probing i2c busses to
generate i2c client dt nodes with the right address and compatible.
Some info in these nodes (e.g. touchscreen firmware-name) is not probable at
all and gets set by heuristics. This heuristics may get things wrong.
So my current implementation offers kernel cmdline options to override this.

Although having to specify kernel cmdline options is not the plug and play
experience I want to give end-users most distros do have documentation on
how to do this and doing this is relatively easy for end-users. Moving this
to the bootloader means moving to some bootloader specific config mechanism
which is going to be quite hard (and possibly dangerous) for users to use.

This alone to me is the reason to post the kernel implentation of my work
for upstream inclusion despite of Mark's objections.

2. Upgradability

Most users treat the bootloader like they treat an x86 machine BIOS/EFI,
they will never upgrade it unless they really have to. This means that it
will be very difficult to get users to actual benefit from bug-fixes /
improvements done to the probing code. Where as the kernel on boards running
e.g. Debian or Fedora gets regular updates together with the rest of the
system.

3. Infrastructure

The kernel simply has better infrastructure for doing these kind of things.
Yes we could improve the bootloader, but the kernel is also improving and
likely at a faster rate. Besides that the purpose of the bootloader is
mostly to be simple and small, load the kernel and get out of the way, not
to be a general purpose os kernel. So it will simply always have less
infrastructure and that is a good thing, otherwise we will be writing
another general purpose os which is a waste of effort.

4. This is not a new board file

Mark, at ELCE I got the feeling that your biggest worry / objection is
that this will bring back board files, but that is not the case, if you
look at the actual code it is nothing like a board-file at all. Where a
board file was instantiating device after device after device from c-code,
with maybe a few if-s in there to deal with board revisions. This code is
all about figuring out which accelerometer and touchscreen there are,
to then add nodes to the dt for this 2 devices, almost all the code is
probing, the actual dt modifying code is tiny and no direct device
instantiation is done at all.

5. This is an exception, not the rule

Yes this is introducing board (family of boards) specific c-code into the
kernel, so in a way it is reminiscent of board files. But sometimes this is
necessary, just look at all the vendor / platform specific code in the kernel
in drivers/platform/x86, or all the places where DMI strings are used to
uniquely identify a x86 board and adjust behavior.

But this really is the exception, not the rule. I've written/upstreamed a
number of drivers for q8 tablets hardware and if you look at e.g. the
silead touchscreen driver then in linux-next this is already used for 5
ARM dts files where no board specific C-code is involved at all.

So this again is very different from the board file era, where C-code
had to be used to fill device specific platform-data structs, here all
necessary info is contained in the dt-binding and there are many users
who do not need any board specific C-code in the kernel at all.

So dt is working as it should and is avoiding board specific C-code for
the majority of the cases. But sometimes hardware is not as we ideally
would like it to be; and for those *exceptions* we are sometimes going
to need C-code in the kernel, just like there is "board" specific C-code
in the x86 code.

Regards,

Hans

p.s.

Note that the patches actually implementing the q8 hardware manager depend
on Pantelis' "of: changesets" patches which are not upstream yet, so if we
can agree on doing this in the kernel then this cannot be merged until those
are merged. If we get a concensus on doing this in kernel being ok, then
I'll post a new version of those patches unless Pantelis' beats me to it.
