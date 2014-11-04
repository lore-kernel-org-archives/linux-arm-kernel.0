From: ahs3@redhat.com (Al Stone)
Date: Tue, 04 Nov 2014 10:33:18 -0700
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32
 bit DMA
In-Reply-To: <7145110.be3vG56Rvi@wuerfel>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel> <1415024151.3641.18.camel@deneb.redhat.com>
 <7145110.be3vG56Rvi@wuerfel>
Message-ID: <54590DDE.2040102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 10:14 AM, Arnd Bergmann wrote:
> On Monday 03 November 2014 09:15:51 Mark Salter wrote:
>> On Thu, 2014-10-30 at 22:05 +0100, Arnd Bergmann wrote:
>>> You should definitely make sure that this also works with DT, as
>>> I don't think it's possible to support X-Gene with ACPI. I know
>>> that Al Stone has experimented with it in the past, but he never
>>> came back with any results, so I assume the experiment failed.

My apologies; I am still remiss in making more patches public.  Life
interferes sometimes with my kernel development.  I make no excuses
for being farther behind in this than I have wanted.

<diversion type=whinge>

The experiment has not failed.  The assumption is completely wrong.
The git tree listed works on the X-Gene platform and it works on AMD
Seattle; I have both running on my desk.  Both DT and ACPI work, with
the proper versions of the DT or the ACPI tables.  I will post RFCs as
soon as I can, but my work in progress is basically the same as the
git tree mentioned below, based on slightly different starting points.

>>> Note that the discussions about merging ACPI support on ARM64
>>> are based on the assumption that we'd only ever support SBSA-like
>>> platforms, not something like X-Gene that looks more like an
>>> embedded SoC. Your XHCI patches still obviously make sense for
>>> other platforms, so that's not a show-stopper.
>>
>> But for some misconfiguration, the arm64 kernels in fedora arm
>> koji would boot using ACPI on Mustang, the Foundation model,
>> and AMD Seattle platforms. All very much a work in progress,
>> but the tree from which the fedora patches are taken is the
>> devel branch of:
>>
>>   git.fedorahosted.org/git/kernel-arm64.git
>>
>> The configuration will be fixed this week and then you can
>> just grab an arm64 fedora kernel and boot with acpi=force.

Please note that I work directly with Mark Salter and that I have
personally handed out this particular URL many times at either Linaro
Connect and/or to individuals directly.  It is not now nor has it ever
been secret, at any time.

> It's not as bad as I had feared, but it still does a lot of
> the things that in previous discussions were said that ACPI
> would avoid doing, and that were used as arguments against
> just using DT on all arm64 servers:
> 
> - The use of the device properties API that was introduced for
>   Intel's embedded devices for on-chip components directly
>   contradicts the "standardized firmware interfaces" argument
>   that certain people keep making. This certainly explains how
>   you plan to use the networking side, but I suspect it's not
>   what the ACPI proponents were looking for, or what the base
>   patch set is being advertised as.

I do not understand this statement at all.  One of the things
that was added to the ACPI 5.1 specification was the _DSD method
-- Device Specific Properties -- specifically so that device
properties could be standardized.  The API mentioned relies on the
existence of _DSD for ACPI.  Further, there are people from Linaro
(who happen to work in the kernel and ACPI), the Linux community,
as well as from Intel, ARM and even Microsoft working together to
figure out ways to standardize the device properties being used in
the ACPI Spec Working Group (ASWG) of the UEFI Forum; several of us
are of course paying attention to, participating in, and incorporating
the discussions on this kernel list and others.

So what is not being standardized?  From where I sit, as part of ASWG,
Linaro, Red Hat, and some-time contributor to the Linux kernel, this
whole device properties API was driven by the desire to have a
standardized firmware interface.  It even seems to be going a step
further and trying to standardize how the kernel interacts with any
firmware.

> - Using custom drivers for hardware that is required by SBSA
>   (ahci, pci, ...) means you are contradicting the 
>   Documentation/arm64/arm-acpi.txt document that is merged as
>   one of your early patches and that keeps getting posted as
>   the base of discussion for the inclusion of the base ACPI
>   support. I don't think you can have it both ways, saying that
>   SBSA is required and supporting hardware that doesn't do any
>   of it won't work.

This is where I start the serious whinging....

On the one hand, I'm told "show the patches."  Fine.  Someone other
than me happens to show patches for work in progress.  Or, perhaps I
show patches that work but are still proof of concept.  It doesn't
seem to matter which.  The response then looks to me like I'm being
told, "don't show patches that are not the absolute, final, irrefutable
and irrevocable version."  So which is it?

The git tree mentioned is a work in progress.  No one has ever claimed
it was otherwise.  This is exactly the same case as with the Linaro
ACPI and kernel development trees.

What I find incredibly frustrating is that I feel I am being told to
submit the final form of patches for ACPI drivers, but those can ONLY
be a work a progress until the ACPI core patches that we have been
trying to get into the kernel are accepted.  Until those core patches
are in the kernel, all I can really do is experiment with drivers and
show work in progress; there's no foundation to rely on.

I get further frustrated when I fold in basic, practical considerations.
Regardless of whether one thinks the APM or AMD hardware is an actual
arm64 server or not, it is what we have.  I cannot change that.  Some
of the hardware is not server-like; some of it just does strange and
goofy things.  These are first generation boxes; I always expect such
things to be weird.  It's just in their nature.

So, I write (or ask someone else to write, or bodge something borrowed
from someone else) a driver to experiment with, that tries to get odd
hardware working.  Or, in the case of the SBSA UART, what's available
doesn't actually work on some hardware.  Or, in some cases, the driver
based on DT is not right.  Or, the firmware (DT *or* ACPI) is not yet
complete.  My goal is just to see if I can get *something* working so
I can see what's really going on with the hardware.  Then, the patches
that work, even if ugly, are shared as work in progress.  The result
of that sharing seems to be more "go away until absolute final perfect
versions are ready."

If what I am really being told is that ACPI for arm64 will never be
accepted in the Linux kernel, then just say so.  I have other things
to do with my life than go in circles like this.

If instead there is some constructive criticism that helps improve
either the ACPI core patches or the driver patches, or better yet
allows us to make forward progress, that would be wonderful.  As far
as I know, everyone is doing the best they can with the resources
available, and making as much progress as they can without everything
being settled.

> - Adding a generalized method to support arbitrary PCI host
>   controllers indicates that you expect this practice to not
>   just be a special exception for APM but that others would
>   require the same hack to work around firmware or hardware that
>   is not compliant with ACPI. At the same time you introduce a
>   significant of driver code in arch/arm64/kernel/pci.c. Some
>   of that code is probably just an oversight and can be moved into
>   the PCI core later, but it doesn't even seem you tried that
>   hard.

APM *is* a special case because of what they do in their hardware;
perhaps that should have been stated explicitly.  By the same token,
writing kernel code that is flexible in the face of unknown future
hardware seemed reasonable at face value, but perhaps we should not
do that.  But again, this is a work in progress.  The fact that we
are having to fix x86-specific code and refactor it so that it works
on multiple architectures is quite blindingly obvious and is indeed
something that is already being worked on; perhaps that should also
have been said explicitly.  But again, we chose to share code that we
know is an early version instead of waiting until a final refactored
version is available, or instead of keeping it "secret."  Assuming we
haven't even tried or are completely unaware of the problem without
even asking I find kind of insulting.

>From where I sit, I feel I'm being told that I'm doing all the work in
secret and getting dinged for that.  So, work in progress is shared,
even though it's early and we explicitly says it's work in progress,
and now I'm getting dinged for that.

What it looks like to me is that I'm damned if I do and I'm damned if
I don't.  And in the meantime, I need to fix all the x86-isms that are
present, that probably shouldn't be there, and I didn't actually create
in the first place.

> All of the above are probably things we can discuss, but by working on
> this in secret until now, you have really made it hard for the Linaro
> team whose work you are basing on. They have tried hard for a long
> time to get basic ACPI support into a mergeable state, and have been
> working on incorrect base assumptions the whole time because they
> didn't have a platform implementation to show and to verify their
> assumptions.

The git tree that Mark mentions is one that has been public for a
few months (I don't recall how many -- well before the last Linaro
Connect).  This has never been secret; I personally have shared the
URL with people at ARM, APM, AMD, Cavium and Linaro.  This git tree
is also being used as a basis for Fedora on ARMv8, and I really don't
think of Fedora as being secretive.

And as the de facto leader of the Linaro ACPI team, I can honestly say
that there is absolutely nothing in this tree that damages any of the
work the ACPI team at Linaro has done.  Nothing.  It is the current
iteration towards a full implementation, that is all.  What's more, it
is work that is shared with Linaro through me.  I just don't find it
necessary to broadcast everything I do on a daily basis.

The primary focus of the Linaro ACPI team is on getting the ACPI core
work upstream; everything else is experimentation and finding the
problem areas -- in the kernel, in the spec, in the firmware, in the
hardware, in the development process -- so we can try to fix them
before we submit drivers that build on that core, and so we can make
progress towards a long term, supportable solution.

</diversion>

So, back to the original topic: are these USB patches ack'd or not?
I can verify that they behave on Mustang; they have been tested with
both DT and ACPI.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
